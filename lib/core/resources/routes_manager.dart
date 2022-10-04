import 'package:flutter/cupertino.dart';
import '../../features/login/presentation/pages/login/login_page.dart';
import '../../features/login/presentation/pages/splash/splash_page.dart';

class Routes {
  static const String splashPageKey = '/';
  static const String loginPageKey = '/Login';
  static const String registerPageKey = '/Register';
  static const String profilePageKey = '/profileTestPage';
  static const String updateProfilePageKey = '/update_profile_page';
  static const String layoutPage = '/layoutPage';
  static const String searchPageKey = '/SearchPage';
  static Map<String, WidgetBuilder> get routes {
    return {
      splashPageKey: (context) => const SplashView(),
      loginPageKey: (context) => const LoginPage(),
    };
  }
}
