import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AbstractBloc<T, U> extends Bloc<T, U>  {
  AbstractBloc(super.initialState);
}