import 'package:equatable/equatable.dart';
import 'package:mobile_poss_gp01/database_objects/realm/pojo/gold_rate_pojo.dart';

abstract class GoldRateState<T> extends Equatable {
  const GoldRateState();
}

class GoldRateLoadInProgress extends GoldRateState {
  @override
  List<Object> get props => [];
}

class GoldRateLoadSuccess extends GoldRateState {
  const GoldRateLoadSuccess({required this.list});

  final List<GoldRatePOJO> list;

  @override
  List<Object?> get props => [list];
}

class GoldRateLoadFailure extends GoldRateState {
  @override
  List<Object> get props => [];
}
