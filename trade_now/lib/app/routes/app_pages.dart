import "package:get/get_navigation/src/routes/get_route.dart";
import "package:trade_now/app/ui/pages/address_page.dart";
import "package:trade_now/app/ui/pages/announcement_page.dart";
import "package:trade_now/app/ui/pages/home_page.dart";
import "package:trade_now/app/ui/pages/login_page.dart";
import "package:trade_now/app/ui/pages/perfil_page.dart";
import "package:trade_now/app/ui/pages/product_details_page.dart";
import "package:trade_now/app/ui/pages/register_page.dart";
import "package:trade_now/app/ui/pages/search_page.dart";
part "./app_routes.dart";

class AppPages {
  final List<GetPage> pages = [
    GetPage(name: Routes.home, page: () => HomePage()),
    GetPage(name: Routes.login, page: () => const LoginPage()),
    GetPage(name: Routes.register, page: () => const RegisterPage()),
    GetPage(name: Routes.announcement, page: () => const AnnouncementPage()),
    GetPage(name: Routes.perfil, page: () => const PerfilPage()),
    GetPage(name: Routes.search, page: () => const SearchPage()),
    GetPage(name: Routes.details, page: () => const ProductDetailsPage()),
    GetPage(name: Routes.address, page: () => const AddressPage())
  ];
}
