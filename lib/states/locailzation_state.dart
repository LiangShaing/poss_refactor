import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class LocalizationState extends Equatable {
  const LocalizationState({
    Locale? locale,
  }) : locale = locale ?? const Locale('zh', 'CN');

  final Locale locale;

  @override
  List<Object?> get props => [locale];

  LocalizationState copyWith({Locale? locale}) {
    return LocalizationState(
      locale: locale ?? this.locale,
    );
  }
}


