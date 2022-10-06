import 'package:flutter/cupertino.dart';
import '../../features/favourite/presentation/pages/all_fav_products_page.dart';
import '../../features/home/presentation/pages/layout/layout_page.dart';
import '../../features/register/presentation/pages/register_page.dart';
import '../../features/login/presentation/pages/login/login_page.dart';
import '../../features/login/presentation/pages/splash/splash_page.dart';

class Routes {
  static const String splashPageKey = '/';
  static const String loginPageKey = '/Login';
  static const String registerPageKey = '/Register';
  static const String profilePageKey = '/profileTestPage';
  static const String updateProfilePageKey = '/update_profile_page';
  static const String layoutPage = '/layoutPage';
  static const String allFavsPageKey = '/allFavsPageKey';
  static const String searchPageKey = '/SearchPage';
  static Map<String, WidgetBuilder> get routes {
    return {
      splashPageKey: (context) => const SplashView(),
      loginPageKey: (context) => const LoginPage(),
      registerPageKey: (context) => const RegisterPage(),
      layoutPage: (context) => const LayoutPage(),
      allFavsPageKey: (context) => const AllFavProductPage(),
    };
  }
}
