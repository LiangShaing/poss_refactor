
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_poss_gp01/blocs/customer_session_bloc.dart';
import 'package:mobile_poss_gp01/events/customer_session_event.dart';
import 'package:mobile_poss_gp01/repositories/customer_session_repository.dart';
import 'package:mobile_poss_gp01/states/customer_session_state.dart';

class IndexScreen extends StatelessWidget {
  const IndexScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CustomerSessionBloc>(
      create: (BuildContext context) =>
      CustomerSessionBloc(customerSessionRepository: CustomerSessionRepository())..add(CustomerSessionInitialed()),
      child: BlocBuilder<CustomerSessionBloc, CustomerSessionState>(
          bloc: CustomerSessionBloc(customerSessionRepository: CustomerSessionRepository()), builder: _builder),
    );
  }

  Widget _builder(BuildContext context, CustomerSessionState state) {
    Widget widget;


    switch (state.runtimeType) {
      case CustomerSessionLoadInitial:
        widget = const Text('--');
        break;
      case CustomerSessionInProgress:
        widget = const CircularProgressIndicator();
        break;
      case CustomerSessionLoadFailure:
        widget = const Text('Something went wrong!');
        break;
      case CustomerSessionLoadSuccess:
        CustomerSessionLoadSuccess data = state as CustomerSessionLoadSuccess;
        widget = Text(data.customerSession?.code ?? "");
        break;
      default:
        widget = Container();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[widget],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<CustomerSessionBloc>().add(CustomerSessionStarted());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}