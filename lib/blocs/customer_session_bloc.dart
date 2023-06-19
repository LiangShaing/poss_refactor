import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_poss_gp01/blocs/realm_bloc.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';

class CustomerSessionBloc extends RealmBloc<CustomerSessionEvent, CustomerSessionState> {
  CustomerSessionBloc(super.initialState) {
    on<CustomerSessionStarted>(){
      _createCustomerSession();
    }
  }

  void _createCustomerSession() {
    //todo use repository
    //todo emit here
  }

}