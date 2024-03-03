import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:img_gallaries_mini_app/service/config.dart';

class WebUtil {
  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: IGMConfig.baseUrl,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 60), // 60 seconds
      receiveTimeout: const Duration(seconds: 60), // 60 seconds
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

  Future post(String path, {Map<String, dynamic>? params}) async {
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

  Future get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? header}) async {
    try {
      var response = await WebUtil.createDio().get(
          'https://picsum.photos/v2/list?page=2&limit=10',
          data: params,
          options: Options(headers: header));
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
