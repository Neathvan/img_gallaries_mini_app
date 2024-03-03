import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/repository/base_repository.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/util/endpoint.dart';

class GallaryRepository extends BaseRepository {
  Future<ApiResult<List<IGMImage>>> getList() async {
    var res = await requestGet(Endpoint.imgList);

    return ApiResult.fromJson(res, (data) {
      return List.from(data.map((e) => IGMImage.fromJson(e)));
    });
  }
}
