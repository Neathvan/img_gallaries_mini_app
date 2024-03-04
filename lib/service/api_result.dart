import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';

/// Responsible for response data from server
/// map [ApiStatus.values] for [Response.statusCode]
///
class ApiResult<T> {
  String? message;
  int? code;
  T? data;
  ApiResult();

  Rx<ApiStatus> apiStatus = ApiStatus.loading.obs;

  factory ApiResult.fromJson(Response response, [T Function(dynamic)? data]) {
    ApiResult<T> apiResult = ApiResult<T>();

    /// hanlde status code
    statusResponse(Response response) {
      /// code 200
      /// assign data
      if (response.statusCode == 200) {
        apiResult.data = data!.call(response.data);

        return ApiStatus.loaded;
      } else if (response.statusCode == 400) {
        return ApiStatus.error;
      }
      return ApiStatus.connectionError;
    }

    var _status = statusResponse(response);
    if (_status != ApiStatus.loaded) EasyLoading.showError(_status.msg);

    /// check handle error
    apiResult.apiStatus(_status);
    return apiResult;
  }
}
