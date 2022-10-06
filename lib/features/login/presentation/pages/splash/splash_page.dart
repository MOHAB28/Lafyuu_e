import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/network/end_points.dart';
import '../../../../../core/resources/assets_manager.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/routes_manager.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../injection_container.dart';
import '../login/login_page.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(const Duration(seconds:2), _goNext);
  }

  void _goNext() {
    token = sl<SharedPreferences>().getString(tokenKey);
    if (token != null) {
      Navigator.pushReplacementNamed(context, Routes.layoutPage);
    } else {
      Navigator.pushReplacementNamed(context, Routes.loginPageKey);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blue,
      appBar: AppBar(
        elevation: AppSize.s0,
        toolbarHeight: AppSize.s1,
        backgroundColor: ColorManager.blue,
      ),
      body: Center(
        child: SvgPicture.asset(ImageAssets.splashLogo),
      ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
}
