import 'package:get/get.dart';
import 'package:img_gallaries_mini_app/ui/gallary/image_detail_page.dart';
import 'package:img_gallaries_mini_app/ui/home_page.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteName.imageDetail,
      page: () => ImageDetailPage(image: Get.arguments['image']),
    ),
  ];
}

class RouteName {
  static const homePage = '/home', imageDetail = '/image-detail-page';
}
