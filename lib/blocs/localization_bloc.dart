// import 'package:bloc/bloc.dart';
//
// import 'package:mobile_poss_gp01/events/localization_event.dart';
// import 'package:mobile_poss_gp01/states/locailzation_state.dart';
//
// class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
//   LocalizationBloc() : super(const LocalizationState()) {
//     on<LocalizationChanged>(onChangeLanguage);
//   }
//   onChangeLanguage(LocalizationChanged event, Emitter<LocalizationState> emit) async {
//     emit(state.copyWith(locale: event.locale));
//   }
// }
