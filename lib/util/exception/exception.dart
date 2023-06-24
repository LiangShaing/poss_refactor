class BadRouteException implements Exception {
  final String message;
  final int code;
  final String errorTextCode;

  BadRouteException(this.message, {this.code = 404, this.errorTextCode = "exception.msg.badRoute"});

  @override
  String toString() {
    return message;
  }

  int get getCode => code;

  String get getErrorTextCode => errorTextCode;
}

class BiometricLockedOutException implements Exception {
  final String message;
  final int code;

  BiometricLockedOutException(this.message, {this.code = 400});

  @override
  String toString() {
    return message;
  }

  int get getCode => code;
}

class PermissionDeniedException implements Exception {
  final String message;
  final int code;
  final String errorDescription;

  PermissionDeniedException(this.message, {this.code = 0, this.errorDescription = ''});

  @override
  String toString() {
    return message;
  }

  int get getCode {
    return code;
  }
}

class ViewIllegalArgumentException implements Exception {
  final String message;
  final int code;
  final String errorTextCode;
  final List<String> errorTextCodeParameters;
  final String errorDescription;

  ViewIllegalArgumentException(this.message,
      {this.code = 0,
        this.errorTextCode = 'exception.msg.illegalArgumentError',
        this.errorTextCodeParameters = const [],
        this.errorDescription = ''});

  @override
  String toString() {
    return message;
  }

  int get getCode => code;

  String get getErrorTextCode => errorTextCode;

  List<String> get getErrorTextCodeParameters => errorTextCodeParameters;

  String get getErrorDescription => errorDescription;

}

class RealmLoginFailedException implements Exception {
  final String message;
  final int code;
  final String errorDescription;

  RealmLoginFailedException(this.message, {this.code = 0, this.errorDescription = ''});

  @override
  String toString() {
    return message;
  }

  int get getCode {
    return code;
  }
}
