import 'package:flutter_struture/constants/response_code.dart';

enum ServiceStatus { loading, completed, error }

class ServiceResponse<T> {
  ServiceStatus status;
  T? data;
  int? responseCode;
  String? message;
  double? progress;
  int? errorCode;
  String? debugMessage;

  ServiceResponse.loading([this.progress]) : status = ServiceStatus.loading;

  ServiceResponse.completed(this.data) : status = ServiceStatus.completed;

  ServiceResponse.error(this.errorCode, this.message)
      : status = ServiceStatus.error,
        debugMessage = message;

  ServiceResponse.timeout()
      : status = ServiceStatus.error,
        errorCode = ResponseCodes.timeout,
        message = ResponseCodes.errorMessageMap[ResponseCodes.timeout],
        debugMessage = ResponseCodes.errorMessageMap[ResponseCodes.timeout];

  ServiceResponse.systemError(this.debugMessage)
      : status = ServiceStatus.error,
        errorCode = ResponseCodes.systemError,
        message = ResponseCodes.errorMessageMap[ResponseCodes.systemError];

  @override
  String toString() {
    return "Status : $status \n Message : $message \n Data : $data";
  }
}
