import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

const baseUrl = "http://192.168.1.108:8000/";
const hostspot = "http://172.20.10.4:8000/api/";

class WebUtil {
  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: hostspot,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      receiveDataWhenStatusError: true,
      connectTimeout: Duration(seconds: 5), // 60 seconds
      receiveTimeout: Duration(seconds: 5), // 60 seconds
    ));

    dio.interceptors.add(LogInterceptor(
      requestHeader: true,
      request: true,
      requestBody: true,
      responseHeader: false,
    ));

    return dio;
  }
}

class Api {
  Api();
  Response _getResponseError(DioException e) {
    DioException de = e;
    if (de.response == null) {
      return Response(
        requestOptions: de.requestOptions,
        statusCode: -1,
        statusMessage: de.message,
      );
    }
    return e.response!;
  }

  Future post(String path, Map<String, dynamic> params) async {
    try {
      var response = await WebUtil.createDio().post(path, data: params);
      log("Response ::: ${response.data}");
      return response;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        return e;
      }

      return e;
    }
  }

  Future postWithHeader(String path, Map<String, dynamic>? params,
      Map<String, dynamic> header) async {
    try {
      Response response = await WebUtil.createDio().post(
        path,
        data: params,
        options: Options(
          headers: header,
        ),
      );
      log("Response ::: $response");
      return response;
    } on DioException catch (e) {
      log('_________________ERROR______________________');
      // ignore: unnecessary_type_check
      if (params is Map) log(jsonEncode(params));
      if (params is FormData) log(params.toString());
      return _getResponseError(e);
    }
  }
}
