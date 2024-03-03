import 'package:img_gallaries_mini_app/service/api.dart';

abstract class BaseRepository extends Api {
  requestPost(String path, [Map<String, dynamic>? params]) {
    return post(path, params: params);
  }

  Future requestGet(String path,
      {Map<String, dynamic>? params, Map<String, dynamic>? header}) {
    params = params ?? {};
    return get(path, params: params, header: header);
  }
}
