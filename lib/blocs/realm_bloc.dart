import 'package:flutter_bloc/flutter_bloc.dart';

abstract class RealmBloc<T, U> extends Bloc<T, U>  {
  RealmBloc(super.initialState);
}