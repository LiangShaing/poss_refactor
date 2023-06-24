import 'package:equatable/equatable.dart';

abstract class GoldStateState<T> extends Equatable {
  const GoldStateState();
}

class GoldRateLoadInProgress extends GoldStateState {
  @override
  List<Object> get props => [];
}

class GoldRateLoadSuccess extends GoldStateState {
  const GoldRateLoadSuccess();

  @override
  List<Object?> get props => [];
}

class GoldRateLoadFailure extends GoldStateState {
  @override
  List<Object> get props => [];
}
