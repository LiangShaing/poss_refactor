import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';

class DefaultBlocObserver implements BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    log("DefaultBlocObserver onChange : ${bloc.runtimeType} ${change.toString()}");
  }

  @override
  void onClose(BlocBase bloc) {
    log("DefaultBlocObserver onClose : ${bloc.runtimeType}");
  }

  @override
  void onCreate(BlocBase bloc) {
    log("DefaultBlocObserver onCreate : ${bloc.runtimeType}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log("DefaultBlocObserver onError : ${bloc.runtimeType} ${error.toString()} ${stackTrace.toString()}");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log("DefaultBlocObserver onEvent : ${bloc.runtimeType} ${event.toString()}");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log("DefaultBlocObserver onTransition : ${bloc.runtimeType} ${transition.toString()}");
  }
}
