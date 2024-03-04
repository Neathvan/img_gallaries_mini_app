import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
// import 'package:get/get.dart' hide Response;
import 'package:img_gallaries_mini_app/service/config.dart';

abstract class BaseApi {
  late Dio _dio;

  BaseApi() {
    createDio();
  }

  /// enables you to make HTTP requests
  /// create instance of dio with default key-value
  createDio() {
    _dio = Dio(BaseOptions(
      baseUrl: IGMConfig.baseUrl,
      headers: defaultHeader,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
    ));

    /// add handling of requet resp and hanle
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (kDebugMode) {
          print(
              '[====================== REQUEST ====================== ]\n** url :: ${options.uri}\n** headers :: ${options.headers}\n** data :: ${options.data}');
        }
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('[====================== RESPONSE ====================== ]\n** url :: ${response.realUri}\n** data :: ${response.data}');
        return handler.next(response);
      },
      onError: (e, handler) {
        // ignore: avoid_print
        print(":: ERROR :: ${e.message}");
        return handler.next(e);
      },
    ));
  }

  set defaultHeader(Map<String, dynamic> value) {}

  Map<String, dynamic> get defaultHeader => {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
}

class Api extends BaseApi {
  /// handle dio error
  Response _getResponseError(DioException e) {
    DioException de = e;
    if (e.response == null) {
      return Response(
        data: {},
        requestOptions: de.requestOptions,
        statusCode: -1,
        statusMessage: de.message,
      );
    }
    return e.response!;
  }

  Future post(String path, {Map<String, dynamic>? params}) async {
    try {
      var response = await _dio.post(path, data: params);
      return response;
    } on DioException catch (e) {
      return _getResponseError(e);
    }
  }

  Future get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? header}) async {
    try {
      var response =
          await _dio.get(path, data: params, options: Options(headers: header));
      return response;
    } on DioException catch (e) {
      return _getResponseError(e);
    }
  }
}
