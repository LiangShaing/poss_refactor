import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:realm/realm.dart';

class CustomerSessionBloc extends AbstractBloc<CustomerSessionEvent, CustomerSessionState> {
  final CustomerSessionRepository customerSessionRepository;

  CustomerSessionBloc({required this.customerSessionRepository}) : super(CustomerSessionLoadInitial()) {
    on<CustomerSessionInitialed>(_initialCustomerSession);
    on<CustomerSessionStarted>(_createCustomerSession);
  }

  Future<void> _createCustomerSession(CustomerSessionEvent event, Emitter<CustomerSessionState> emit) async {
    //todo use repository
    //todo emit here
    emit(CustomerSessionInProgress());
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('HHmmss');
    final String formatted = formatter.format(now);
    CustomerSession customerSession = CustomerSession(ObjectId(), true, DateTime.now().toUtc(), "689", "221470", "梁小翔",
        code: "221470-$formatted", currentProgress: "SELLING");
    await customerSessionRepository.createCustomerSession(customerSession);
    CustomerSession? currentCustomerSession = customerSessionRepository.currentCustomerSession;
    add(CustomerSessionInitialed());
  }

  Future<void> _initialCustomerSession(CustomerSessionEvent event, Emitter<CustomerSessionState> emit) async {
    log("_searchCustomerSession");
    emit(CustomerSessionInProgress());
    CustomerSession? currentCustomerSession = customerSessionRepository.currentCustomerSession;
    log("_searchCustomerSession [${currentCustomerSession?.id}]");
    emit(CustomerSessionLoadSuccess(customerSession: currentCustomerSession));
  }
}
