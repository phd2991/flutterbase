import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

enum MultipartFileOrigin { bytes, file }

class MultipartFileExtended extends MultipartFile {
  MultipartFileOrigin? origin;
  String? filePath;
  List<int>? bytes;

  MultipartFileExtended._(
      Stream<List<int>> stream,
      length, {
        filename,
        contentType,
        @required this.origin,
        this.filePath,
        this.bytes,
      }) : super(stream, length, filename: filename, contentType: contentType);

  static MultipartFileExtended fromFileSync(
      String filePath, {
        String? filename,
        MediaType? contentType,
      }) =>
      multipartFileFromPathSync(filePath,
          filename: filename!, contentType: contentType!);

  MultipartFileExtended.fromBytes(
      List<int> value, {
        String? filename,
        MediaType? contentType,
      }) : this._(
    Stream.fromIterable([value]),
    value.length,
    filename: filename,
    contentType: contentType,
    origin: MultipartFileOrigin.bytes,
    bytes: value,
  );
}

MultipartFileExtended multipartFileFromPathSync(
    String filePath, {
      String? filename,
      MediaType? contentType,
    }) {
  filename ??= p.basename(filePath);
  var file = File(filePath);
  var length = file.lengthSync();
  var stream = file.openRead();
  return MultipartFileExtended._(
    stream,
    length,
    filename: filename,
    contentType: contentType,
    origin: MultipartFileOrigin.file,
    filePath: filePath,
  );
}
