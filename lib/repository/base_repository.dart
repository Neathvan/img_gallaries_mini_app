import 'package:img_gallaries_mini_app/service/api.dart';

abstract class BaseRepository extends Api {
  request(String path, [Map<String, dynamic>? params]) {
    return post(path, params);
  }
}
