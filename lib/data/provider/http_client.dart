import "package:dio/dio.dart";
import "package:flutter/foundation.dart";

import '../../config/flavor/env.dart';
import '../model/remote/response/service_response.dart';
import '../model/remote/response/base_api_response.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  factory HttpClient() => _instance;

  late Dio _dio;
  late Interceptor _interceptor;

  HttpClient._internal() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: Env.instance.environmentValues!.baseUrl,
      connectTimeout: 10000,
      receiveTimeout: 10000,
      headers: {
        "Accept": "application/json",
      },
      contentType: 'application/json; charset=utf-8',
      responseType: ResponseType.json,
    );

    _dio = Dio(baseOptions);

    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        logPrint: print,
      ));
    }

    _interceptor =
        InterceptorsWrapper(onError: (DioError error, handler) async {
      if (error.response == null || error.response!.data == null) {
        return handler.next(error);
      }
      // #region Error handler
      // final response =
      //     BaseApiResponse.fromJson(error.response!.data, (response) {});
      // if (response.errorCode == ResponseCodes.tokenExpired) {
      //   try {
      //     final response = await _tokenInvalidHandler(error.requestOptions);
      //     if (response != null) {
      //       return handler.resolve(response);
      //     }
      //     return handler.reject(DioError(requestOptions: error.requestOptions));
      //   } on DioError catch (e) {
      //     return handler.reject(e);
      //   }
      // } else if (response.errorCode == ResponseCodes.tokenInvalid &&
      //     await UserPreferences.instance.iSLogin()) {
      //   Get.offAllNamed(RouteNames.login);
      //   return;
      // }
      // return handler.next(error);
      // #endregion
    });
    _dio.interceptors.add(_interceptor);
  }

  Future<ServiceResponse<TData>>
      requestGet<TData, TResponse extends BaseApiResponse<TData>>(
    String path,
    Map<String, dynamic>? queryParams,
    InitGeneric<TResponse> responseFactory,
  ) async {
    return _request(
      'GET',
      path,
      responseFactory,
      queryParameters: queryParams,
    );
  }

  Future<ServiceResponse<TData>>
      requestPost<TData, TResponse extends BaseApiResponse<TData>>(
    String path,
    dynamic body,
    InitGeneric<TResponse> responseFactory,
  ) async {
    return _request(
      'POST',
      path,
      responseFactory,
      data: body,
    );
  }

  Future<ServiceResponse<TData>>
      requestPut<TData, TResponse extends BaseApiResponse<TData>>(
    String path,
    dynamic body,
    InitGeneric<TResponse> responseFactory,
  ) async {
    return _request(
      'PUT',
      path,
      responseFactory,
      data: body,
    );
  }

  Future<ServiceResponse<TData>>
      requestDelete<TData, TResponse extends BaseApiResponse<TData>>(
    String path,
    dynamic body,
    InitGeneric<TResponse> responseFactory,
  ) async {
    return _request(
      'DELETE',
      path,
      responseFactory,
      data: body,
    );
  }

  Future<ServiceResponse<TData>>
      _request<TData, TResponse extends BaseApiResponse<TData>>(
    String method,
    String path,
    InitGeneric<TResponse> responseFactory, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final responseData = await _dio.request(
        path,
        data: data,
        options: await _header(method),
        queryParameters: queryParameters,
      );
      final response = responseFactory(responseData.data);
      if (response.isSuccess) {
        return ServiceResponse.completed(response.data);
      } else {
        return ServiceResponse.error(response.status, response.message);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data != null) {
          try {
            final response = responseFactory(e.response!.data);
            return ServiceResponse.error(response.status, response.message);
          } catch (e) {
            return ServiceResponse.systemError(e.toString());
          }
        } else {
          return ServiceResponse.systemError(e.toString());
        }
      } else {
        switch (e.type) {
          case DioErrorType.connectTimeout:
          case DioErrorType.receiveTimeout:
          case DioErrorType.sendTimeout:
            return ServiceResponse.timeout();
          default:
            return ServiceResponse.systemError(e.toString());
        }
      }
    } catch (e) {
      return ServiceResponse.systemError(e.toString());
    }
  }

  Future<Options> _header(String method) async {
    var headers = _dio.options.headers;
    // E.g.: token
    // headers[Keys.authorization] =
    //     '${Constants.authenTokenPrefix} ${await UserPreferences.instance.getToken()}';

    return Options(method: method, headers: headers);
  }

  // #region Refresh Token
  // Future<Response<T>?> _tokenInvalidHandler<T>(
  //   RequestOptions requestOptions,
  // ) async {
  //   final authenData = await _refreshToken();
  //   print('authenData $authenData');
  //   if (authenData == null) {
  //     Get.offAllNamed(RouteNames.login);
  //     return null;
  //   }

  //   UserPreferences.instance.saveToken(authenData.token!);
  //   UserPreferences.instance.saveRefreshToken(authenData.refreshToken!);

  //   requestOptions.headers[Keys.authorization] =
  //       '${Constants.authenTokenPrefix} ${authenData.token!}';

  //   final options = new Options(
  //     method: requestOptions.method,
  //     headers: requestOptions.headers,
  //   );

  //   return _dio.request(
  //     requestOptions.path,
  //     data: requestOptions.data,
  //     queryParameters: requestOptions.queryParameters,
  //     options: options,
  //   );
  // }

  // Future<AuthenData?> _refreshToken() async {
  //   final refreshToken = UserPreferences.instance.getRefreshToken();
  //   final response = await requestPost(
  //     ApiPath.refreshToken,
  //     {Keys.refreshToken: refreshToken},
  //     (json) => BaseApiResponse<AuthenData>.fromJson(
  //         json, (data) => AuthenData.fromJson(data)),
  //   );
  //   switch (response.status) {
  //     case ApiStatus.completed:
  //       return response.data;
  //     case ApiStatus.error:
  //     default:
  //       return null;
  //   }
  // }
  // #endregion
}
