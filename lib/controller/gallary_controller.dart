import 'package:img_gallaries_mini_app/controller/base_controller.dart';
import 'package:img_gallaries_mini_app/repository/gallary_repository.dart';

class GallaryController extends BaseController<GallaryRepository> {
  GallaryController() : super(GallaryRepository());

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  Future getList() async {
    var res = await repo.getList();

    print(res.data!.length);
  }
}
