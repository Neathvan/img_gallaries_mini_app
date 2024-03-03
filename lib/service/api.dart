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

    ///
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        log('url :: ${options.uri}\nheaders :: ${options.headers}\ndata :: ${options.data}',
            name: 'REQUEST ==>');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        log('url :: ${response.realUri}\ndata :: ${response.data}',
            name: 'RESPONSE ==>');
        return handler.next(response);
      },
      onError: (e, handler) {
        // ignore: avoid_print
        print(":: ERROR :: ${e.message}");
        return handler.next(e);
      },
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
  /// handle dio error
  Response _getResponseError(DioException e) {
    DioException de = e;
    if (e.response == null) {
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
      return response;
    } on DioException catch (e) {
      return _getResponseError(e);
    }
  }

  Future get(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? header}) async {
    try {
      var response = await createDio()
          .get(path, data: params, options: Options(headers: header));
      return response;
    } on DioException catch (e) {
      return _getResponseError(e);
    }
  }
}
