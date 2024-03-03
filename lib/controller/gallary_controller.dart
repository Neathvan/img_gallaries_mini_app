import 'package:img_gallaries_mini_app/controller/base_controller.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/repository/gallary_repository.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/service/config.dart';
import 'package:img_gallaries_mini_app/ui/component/k_builder/k_builder_component.dart';

class GallaryController extends BaseController<GallaryRepository> {
  GallaryController() : super(GallaryRepository());

  ApiResult<List<IGMImage>> gallariesResult = ApiResult()..data = [];
  ApiResult<IGMImage> imageDetailResult = ApiResult();

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  Future<ApiResult<List<IGMImage>>> getList({bool loadMore = false}) async {
    int page = !loadMore ? 0 : gallariesResult.data!.length;

    var res = await repo.getList(page, kLimit);

    if (res.apiStatus.value == ApiStatus.loaded) {
      // append item to list if load more
      if (loadMore) {
        gallariesResult.data?.addAll(res.data ?? []);
      } else {
        // clear and add new list to gallary is refresh page or first loading
        gallariesResult = res;
      }
    }
    update();
    return res;
  }

  Future<ApiResult<IGMImage>> getImageDetail(String id) async {
    return await repo.getImageDetail(id).then((value) {
      imageDetailResult = value;
      update();
      return value;
    });
  }
}
