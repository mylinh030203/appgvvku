import 'dart:async';

import 'package:app_giang_vien_vku/components/ButtonComponent.dart';
import 'package:app_giang_vien_vku/components/IconComponent.dart';
import 'package:app_giang_vien_vku/components/RowComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/components/TextComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/auth/signin.view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../utils/DataLocal.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  bool _initScreen = false;

  @override
  Widget build(BuildContext context) {
    final signinViewModel = Provider.of<SigninViewModel>(context, listen: false);
    if (!_initScreen) {
      signinViewModel.countDownTime(context);
      _initScreen = true;
    }

    AppInfo.getScreenHeight(context);
    AppInfo.isMobileLarge(context);
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Image background
          Positioned.fill(
            child: Image.asset(
              'assets/images/background/vku_landscape.jpg', // Đường dẫn đến hình ảnh của bạn
              fit: BoxFit.cover,
            ),
          ),
          // Overlay container
          Positioned.fill(
            child: Container(
              color: const Color(0xff2A498E).withOpacity(0.8),
              padding: EdgeInsets.symmetric(
                  vertical: isSmall
                      ? 55
                      : isMedium
                          ? 65
                          : 80),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SpaceComponent(
                      height: isSmall ? 40 : 50,
                    ),
                    const VkuLogo(),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: isSmall ? 30 : 70.0, top: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextComponent(
                              text: 'Welcome to',
                              fontSize: isSmall
                                  ? 20
                                  : isMedium
                                      ? 25
                                      : 30,
                              color: Colors.white,
                              type: TextType.bold,
                            ),
                            TextComponent(
                              text: 'VKUniversal!',
                              fontSize: isSmall
                                  ? 30
                                  : isMedium
                                      ? 40
                                      : 45,
                              color: Colors.white,
                              type: TextType.semibold,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Buttoncomponent(
                      onPress: () {
                        Navigator.pushReplacementNamed(
                          context,
                          RoutesName.login,
                        );
                      },
                      text: "Sign in",
                      type: "primary",
                      color: AppColors.gray2.withOpacity(0.5),
                      width: AppInfo.getScreenWidth(context) * 0.8,
                      height: 55,
                    ),
                    const SizedBox(height: 20),
                    RowComponent(children: [
                      TextComponent(
                        text: "Don't have an account?",
                        color: AppColors.white,
                        fontSize: isSmall ? 15 : 18,
                      ),
                      const SpaceComponent(
                        width: 10,
                      ),
                      Buttoncomponent(
                        text: "Sign up",
                        onPress: () {
                          Navigator.pushNamed(
                            context,
                            RoutesName.signUp,
                          );
                        },
                        type: "link",
                        textFont: isSmall ? 15 : 18,
                      )
                    ])
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VkuLogo extends StatelessWidget {
  const VkuLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Iconcomponent(
      isCircles: true,
      size: 120,
      icon: Image.asset("assets/images/icons/vku.png"),
    );
  }
}
