// ignore_for_file: prefer_typing_uninitialized_variables

class ApiException implements Exception {
  final _message;
  final _prefix;

  ApiException([this._message, this._prefix = ""]);

  @override
  String toString() {
    return "$_prefix$_message";
  }
}

class FetchDataException extends ApiException {
  FetchDataException([String? message])
      : super(message, "Error During Communication: ");
}

class BadRequestException extends ApiException {
  BadRequestException([message]) : super(message, "Invalid Request: ");
}

class UnauthorisedException extends ApiException {
  UnauthorisedException([message]) : super(message['message'].toString());
}

class InvalidInputException extends ApiException {
  InvalidInputException([String? message]) : super(message, "Invalid Input: ");
}

class ClientException extends ApiException {
  ClientException([String? super.message]);
}

class ServerException extends ApiException {
  ServerException([String? super.message]);
}

class NetworkException extends ApiException {
  NetworkException([String? super.message]);
}

class GeneralException extends ApiException {
  GeneralException([String? super.message]);
}
