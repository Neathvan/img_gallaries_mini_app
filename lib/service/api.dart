import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:img_gallaries_mini_app/service/config.dart';

abstract class WebUtil {
  Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: IGMConfig.baseUrl,
      headers: defaultHeader,
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

  set defaultHeader(Map<String, dynamic> value) {}
  Map<String, dynamic> get defaultHeader => {
        // 'Accept': 'application/json',
        'Content-Type': 'application/json',
      };
}

class Api extends WebUtil {
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
      var response = await createDio().post(path, data: params);
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
      var response = await createDio()
          .get(path, data: params, options: Options(headers: header));
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
      Response response = await createDio().post(
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
