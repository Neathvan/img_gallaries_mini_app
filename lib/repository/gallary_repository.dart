import 'package:img_gallaries_mini_app/repository/base_repository.dart';
import 'package:img_gallaries_mini_app/util/endpoint.dart';

class GallaryRepository extends BaseRepository {
  Future getList() async {
    return request(Endpoint.imgList);
  }
}
