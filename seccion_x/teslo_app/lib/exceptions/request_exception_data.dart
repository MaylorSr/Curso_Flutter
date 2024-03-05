abstract class RequestExceptionData {
  final int statusCode;
  final String errMessage;

  RequestExceptionData({required this.statusCode, required this.errMessage});
}

class BadRequestException extends RequestExceptionData implements Exception {
  BadRequestException({required super.statusCode, required super.errMessage});
}

class NotFoundException extends RequestExceptionData implements Exception {
  NotFoundException({required super.statusCode, required super.errMessage});
}

class GenericException extends RequestExceptionData implements Exception {
  GenericException({required super.statusCode, required super.errMessage});
}

class ExpireToken extends RequestExceptionData implements Exception {
  ExpireToken({required super.statusCode, required super.errMessage});
}

class ConnectionTimeOut extends RequestExceptionData implements Exception {
  ConnectionTimeOut({required super.statusCode, required super.errMessage});
}
