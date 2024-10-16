class AppException implements Exception {
  final message;
  final prefix;
  AppException(this.message, this.prefix);

  @override
  String toString() {
    return "$prefix : $message";
  }
}

class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, "Error during communication");
}

class UnAuthorizedException extends AppException {
  UnAuthorizedException([String? message])
      : super(message, "Unauthorized Request");
}

class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid Request');
}
