import 'package:flutter_struture/constants/response_code.dart';

import '../../../../constants/keys.dart';

// Dart does not support instantiating from a generic type parameter.
// Use a this factory to generate data as you need them.
typedef InitGeneric<T> = T Function(dynamic);

class BaseApiResponse<T> {
  final int? status;
  final T? data;
  final String? message;

  BaseApiResponse({
    this.status,
    this.data,
    this.message,
  });

  BaseApiResponse.fromJson(json, [InitGeneric<T>? dataFactory])
      : status = json[Keys.status],
        data = json[Keys.data] != null
            ? null
            : dataFactory == null
                ? null
                : dataFactory(json[Keys.data]),
        message = json[Keys.message];

  bool get isSuccess => status == ResponseCodes.success;
}
