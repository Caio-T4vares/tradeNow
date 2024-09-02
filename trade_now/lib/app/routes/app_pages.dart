import "package:get/get_navigation/src/routes/get_route.dart";
import "package:trade_now/app/ui/pages/home_page.dart";
part "./app_routes.dart";

class AppPages {
  final List<GetPage> pages = [
    GetPage(name: Routes.home, page: () => const HomePage())
  ];
}
