import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/gold_rate_pojo.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/events/gold_rate_event.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/database_objects/realm/model/realm_models.dart';
import 'package:mobile_poss_gp01/repositories/gold_rate_repository.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';
import 'package:mobile_poss_gp01/states/gold_rate_state.dart';
import 'package:mobile_poss_gp01/util/logger/logger.dart';
import 'package:realm/realm.dart';

class GoldRateBloc extends AbstractBloc<GoldRateEvent, GoldRateState> {
  final GoldRateRepository goldRateRepository;

  GoldRateBloc({required this.goldRateRepository}) : super(GoldRateLoadInProgress()) {
    // on<GoldRateInitialed>(_init);
    on<GoldPriceDataFetched>(_dataFetched);

    goldRateRepository.bindGoldRateResultsStreamListen((event) {
      Logger.debug(message: "GoldRateBloc _init bindGoldRateResultsStreamListen callback");
      add(GoldPriceDataFetched());
    });
  }

  Future<void> _dataFetched(GoldRateEvent event, Emitter<GoldRateState> emit) async {
    List<GoldRatePOJO> list = goldRateRepository.goldRateData;
    emit(GoldRateLoadSuccess(list: list));
    // goldRateRepository.bindGoldRateResultsStreamListen(() {
    //   Logger.debug(message: "GoldRateBloc _init bindGoldRateResultsStreamListen callback");
    // });
  }
}
