class ResponseCodes {
  ResponseCodes._();
  static const success = 200;

  static const tokenExpired = 11;
  static const tokenInvalid = 10;
  static const invalidArguments = 30;
  static const badRequestParams = 31;

  static const unknown = 1000;
  static const systemError = 1001;
  static const timeout = 1002;
  static const noPermission = 1003;

  static Map<int, String> errorMessageMap = {};
}
