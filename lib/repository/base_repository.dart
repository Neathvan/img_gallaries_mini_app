import 'package:img_gallaries_mini_app/service/api.dart';

import 'package:img_gallaries_mini_app/util/endpoint.dart';

abstract class BaseRepository extends Api {
  requestPost(String path, [Map<String, dynamic>? params]) {
    return post(path, params: params);
  }

  Future requestGet(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? header}) {
    params = params ?? {};
    return get(path, params: params, header: header);
  }

  Future requestGetWithPagination(String path,
      {Map<String, dynamic>? params, required int page, required int limit}) {
    params = params ?? {};
    return get(Endpoint.addPagination(page, limit, path: path), params: params);
  }
}
