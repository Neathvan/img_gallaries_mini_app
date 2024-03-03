import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/repository/base_repository.dart';

abstract class BaseController<T extends BaseRepository> extends GetxController {
  late T repo;

  BaseController(this.repo) : super();
}
