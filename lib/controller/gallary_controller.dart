import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:img_gallaries_mini_app/controller/base_controller.dart';
import 'package:img_gallaries_mini_app/model/igm_image.dart';
import 'package:img_gallaries_mini_app/repository/gallary_repository.dart';
import 'package:img_gallaries_mini_app/service/api_result.dart';
import 'package:img_gallaries_mini_app/util/config.dart';
import 'package:img_gallaries_mini_app/util/igm_enum.dart';

class GallaryController extends BaseController<GallaryRepository> {
  GallaryController() : super(GallaryRepository());

  ApiResult<List<IGMImage>> gallariesResult = ApiResult()..data = [];
  ApiResult<IGMImage> imageDetailResult = ApiResult()
    ..apiStatus = ApiStatus.loaded.obs;

  /// BOX-
  Box<IGMImage> gallaryBox = Hive.box<IGMImage>(IGMImage.boxName);

  /// METHODS
  Future<ApiResult<List<IGMImage>>> getList({bool loadMore = false}) async {
    int page = !loadMore ? 0 : gallariesResult.data!.length;

    var res = await repo.getList(page, kLimit);

    // update api status
    gallariesResult.apiStatus(res.apiStatus.value);

    // response section
    if (res.apiStatus.value == ApiStatus.loaded) {
      List<IGMImage> data = res.data ?? [];

      // append item to local storage list if load more
      if (page != 0) {
        gallaryBox.addAll(data);
      } else {
        // clear local data
        gallariesResult.data?.clear();

        // clear and add new list to gallary is refresh page or first loading
        gallaryBox.clear().then((value) {
          gallaryBox.addAll(data);
        });
      }

      /// append for listen status
      /// to know page number
      gallariesResult.data?.addAll(data);
    }
    update();
    return res;
  }

  /// DEAIL SECTION
  Future<ApiResult<IGMImage>> getImageDetail(IGMImage igmImage) async {
    imageDetailResult.data = igmImage;

    // response section
    return await repo.getImageDetail(igmImage.id!).then((value) {
      imageDetailResult = value;

      if (value.apiStatus.value == ApiStatus.loaded) {
        // update value if item is in the box
        if (igmImage.isInBox) {
          igmImage.copyWith(value.data!);
        }
      }
      update();
      return value;
    });
  }
}
