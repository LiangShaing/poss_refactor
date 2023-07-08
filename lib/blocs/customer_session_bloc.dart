import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/user/pojo/employee_pojo.dart';
import 'package:mobile_poss_gp01/enum/customer_session_progress_status.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/repositories/authentication_repository.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class CustomerSessionBloc extends AbstractBloc<CustomerSessionEvent, CustomerSessionState> {
  final CustomerSessionRepository customerSessionRepository;
  final AuthenticationRepository authenticationRepository;

  CustomerSessionBloc({required this.customerSessionRepository, required this.authenticationRepository})
      : super(CustomerSessionLoadInitial()) {
    on<CustomerSessionInitialed>(_initialCustomerSession);
    on<CustomerSessionStarted>(_createCustomerSession);
    on<CustomerSessionTerminated>(_closeCustomerSession);

    Future(() async {
      Map<String, dynamic> userInfo = await authenticationRepository.getTokenInfo();
      List<String> displayName = userInfo['displayName'].toString().split(" ");

      customerSessionRepository.bindCustomerSessionResultsStreamListen(
          Employee(displayName.elementAt(1), userInfo['uid'][0], displayName.elementAt(0), []), (event) {
        Logger.debug(message: "CustomerSessionBloc bindCustomerSessionResultsStreamListen");
        add(CustomerSessionInitialed());
      });
    });
  }

  Future<void> _createCustomerSession(CustomerSessionStarted event, Emitter<CustomerSessionState> emit) async {
    Logger.info(className: "CustomerSessionBloc", event: "_createCustomerSession", message: "started");
    /* 當前已有會客序號: 關閉當前會客 */
    emit(CustomerSessionLoadInProgress());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HHmmss');
    final String formatted = formatter.format(now);
    Map<String, dynamic> userInfo = await authenticationRepository.getTokenInfo();
    List<String> displayName = userInfo['displayName'].toString().split(" ");
    Logger.debug(
        message:
            "_createCustomerSession user : ${displayName.elementAt(0)} ${userInfo['uid'][0]} ${displayName.elementAt(1)}");

    CustomerSession customerSession = CustomerSession(ObjectId(), true, DateTime.now().toUtc(),
        displayName.elementAt(0), userInfo['uid'][0], displayName.elementAt(1),
        code: "${userInfo['uid'][0]}-$formatted", currentProgress: "SELLING");
    await customerSessionRepository.createCustomerSession(customerSession);
    add(CustomerSessionInitialed());
  }

  Future<void> _initialCustomerSession(CustomerSessionInitialed event, Emitter<CustomerSessionState> emit) async {
    Logger.info(className: "CustomerSessionBloc", event: "_initialCustomerSession", message: "started");
    emit(CustomerSessionLoadInProgress());
    Map<String, dynamic> userInfo = await authenticationRepository.getTokenInfo();
    List<String> displayName = userInfo['displayName'].toString().split(" ");

    CustomerSession? currentCustomerSession = customerSessionRepository
        .currentCustomerSession(Employee(displayName.elementAt(1), userInfo['uid'][0], displayName.elementAt(0), []));
    Logger.info(
        className: "CustomerSessionBloc",
        event: "_initialCustomerSession",
        message: "currentCustomerSession [${currentCustomerSession?.id}]");
    if (currentCustomerSession == null) {
      emit(CustomerSessionLoadInitial());
    } else {
      emit(CustomerSessionLoadSuccess(customerSession: currentCustomerSession));
    }
  }

  Future<void> _closeCustomerSession(CustomerSessionEvent event, Emitter<CustomerSessionState> emit) async {
    Logger.info(className: "CustomerSessionBloc", event: "_closeCustomerSession", message: "started");
    emit(CustomerSessionLoadInProgress());
    Map<String, dynamic> userInfo = await authenticationRepository.getTokenInfo();
    List<String> displayName = userInfo['displayName'].toString().split(" ");

    CustomerSession? currentCustomerSession = customerSessionRepository
        .currentCustomerSession(Employee(displayName.elementAt(1), userInfo['uid'][0], displayName.elementAt(0), []));

    if (currentCustomerSession != null) {
      // bool _hasCtId = ['', null].contains(_ctId);
      // ProgressStatus _progressStatus = _hasCtId ? ProgressStatus.settlement : ProgressStatus.closed;
      ProgressStatus progressStatus = ProgressStatus.closed;

      try {
        // if (_hasCtId) {
        //   /* 未成立CT 要unEarmark */
        //   List<String> _inventoryIds = query?.firstOrNull?.shoppingBag?.items
        //           .where((e) => e.inventoryId != null && e.inventoryId!.isNotEmpty)
        //           .map((ShoppingBagItem e) => e.inventoryId!)
        //           .toList() ??
        //       [];
        //   if (_inventoryIds.isNotEmpty) await apiService.postInventoryUnearmark(_inventoryIds);
        // }
        // currentCustomerSession.currentProgress = progressStatus.value;
        await customerSessionRepository.closeCustomerSession(currentCustomerSession);
        // realmService.realm.write(() {
        //   query?.firstOrNull?.currentProgress = _progressStatus.value;
        //   /* 所有 checkInIndicator false */
        //   query?.where((e) => e.employeeId == realmService.possEmployees!.employeeId).forEach((e) {
        //     e.checkInIndicator = false;
        //   });
        // });
      } catch (error) {
        Logger.error(className: "CustomerSessionBloc", event: "_closeCustomerSession", message: "${error.toString()}");
        rethrow;
      }
    }
  }
}
