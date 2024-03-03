import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:img_gallaries_mini_app/ui/home_page.dart';

class AppRoute {
  static final List<GetPage> pages = [
    GetPage(
      name: RouteName.homePage,
      page: () => const HomePage(),
    ),
    GetPage(
      name: RouteName.imageDetail,
      page: () => const HomePage(),
    ),
  ];
}

class RouteName {
  static const homePage = '/home', imageDetail = '/image-detail-page';
}
