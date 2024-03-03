import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/repository/base_repository.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/util/endpoint.dart';

class GallaryRepository extends BaseRepository {
  Future<ApiResult<List<IGMImage>>> getList(int page, [int limit = 10]) async {
    var res = await requestGetWithPagination(Endpoint.imgList,
        page: page, limit: limit);

    return ApiResult.fromJson(res, (data) {
      return List.from(data.map((e) => IGMImage.fromJson(e)));
    });
  }

  Future<ApiResult<IGMImage>> getImageDetail(String id) async {
    var res = await requestGet(Endpoint.imageDetail(id));

    return ApiResult.fromJson(res, (data) => IGMImage.fromJson(data));
  }
}
