import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import '../ui/component/k_builder/k_builder_component.dart';

class ApiResult<T> {
  String? message;
  int? code;
  T? data;
  ApiResult();

  Rx<ApiStatus> apiStatus = ApiStatus.loading.obs;

  Rx<ApiStatus>? get _apiStatus => apiStatus;
  // set _apiStatus(ApiS) => apiStatus;
  factory ApiResult.fromJson(Response response, [T Function(dynamic)? data]) {
    ApiResult<T> apiResult = ApiResult<T>();

    apiResult.data = data?.call(response.data);
    apiResult.apiStatus(ApiStatus.loaded);
    return apiResult;
  }

  ApiStatus statusResponse(response) {
    if (response.statusCode == 200) {
      return ApiStatus.loaded;
    } else if (response.statusCode == 400) {
      return ApiStatus.error;
    }
    return ApiStatus.connectionError;
  }
}
