import 'package:app_giang_vien_vku/components/ButtonComponent.dart';
import 'package:app_giang_vien_vku/components/InputComponent.dart';
import 'package:app_giang_vien_vku/components/RowComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/components/TextComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/LocalNotificationService.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:app_giang_vien_vku/view_model/auth/signin.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/imageString.dart';
import 'components/SShapeClipper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool remember = true;
  String error = "";

  bool formValidator() {
    // if (!Validate.isEmail( emailController.text)) {
    //   // Email không hợp lệ
    //  Utils.snackBar("Email không hợp lệ \n", context, true);
    //   return false;
    // }

    // if (!Validate.isPasswordValid( passwordController.text)) {
    //   // Mật khẩu không hợp lệ
    //    Utils.snackBar("Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ cái và một số", context, true);
    //   return false;
    // }

    return true;
  }

  void signIn() async {
    await LocalNotifications().showNotification(
      title: "Test notification",
      body: "Số lượng điểm danh 40",
      payload: "abc",
    );
    if (formValidator()) {
      // TODO: Call API to sign in
      // Example:
      // final response = await ApiService.signIn(emailController.text, passwordController.text);
      // if (response.success) {
      //   // Sign in successfully
      //   Navigator.of(context).pop();
      // } else {
      //   setState(() {
      //     error = response.message;
      //   });
      // }
      await Navigator.pushReplacementNamed(
        context,
        RoutesName.menuBar,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isSmall = AppInfo.isMobileSmall(context);
    bool isMedium = AppInfo.isMobileMedium(context);
    bool isMobileLarge = AppInfo.isMobileLarge(context);
    // print(AppInfo.getScreenHeight(context));
    final signinViewModel = Provider.of<SigninViewModel>(context);

    void handleLogin() {
      if (formValidator()) {
        signinViewModel.loginApi(emailController.text, passwordController.text, context);
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            // Background image
            Positioned(
                child: Column(
              children: [
                ClipPath(
                  clipper: SShapeClipper(),
                  child: SizedBox(
                    height: isSmall
                        ? 180
                        : isMedium
                            ? 260
                            : 280,
                    width: double.infinity,
                    child: Image.asset(
                      ImageString.vku_landscape,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        TextComponent(
                          text: "Đăng nhập",
                          color: AppColors.titleAuth,
                          type: TextType.semibold,
                          fontSize: isSmall
                              ? 28
                              : isMedium
                                  ? 32
                                  : 36,
                        ),
                        SpaceComponent(
                          height: isSmall ? AppSize.spaceBtwItems : AppSize.spaceBtwInputFields,
                        ),
                        InputComponent(
                          placeholder: "Email",
                          controller: emailController,
                          colorBackground: AppColors.thirdPrimary,
                          affix: const Icon(
                            CupertinoIcons.person_fill,
                            color: Colors.black,
                          ),
                        ),
                        SpaceComponent(
                          height: isSmall ? AppSize.spaceBtwItems : AppSize.spaceBtwInputFields,
                        ),
                        InputComponent(
                          placeholder: "Password",
                          controller: passwordController,
                          colorBackground: AppColors.thirdPrimary,
                          affix: const Icon(
                            CupertinoIcons.lock_fill,
                            color: Colors.black,
                          ),
                          isPassword: true,
                        ),
                        SpaceComponent(
                          height: isSmall ? AppSize.spaceBtwItems : AppSize.spaceBtwInputFields,
                        ),
                        RowComponent(justify: MainAxisAlignment.start, children: [
                          GestureDetector(
                              onTap: () {
                                setState(() {
                                  remember = !remember;
                                });
                              },
                              child: remember
                                  ? const Icon(
                                      CupertinoIcons.checkmark_alt_circle_fill,
                                      color: Colors.black,
                                    )
                                  : const Icon(CupertinoIcons.circle)),
                          const SpaceComponent(
                            width: 10,
                          ),
                          const TextComponent(text: "Remember Me"),
                          SpaceComponent(
                            height: isSmall ? AppSize.spaceBtwItems : AppSize.spaceBtwInputFields,
                          )
                        ]),
                        SpaceComponent(
                          height: isSmall ? AppSize.spaceBtwItems : AppSize.spaceBtwInputFields,
                        ),
                        Buttoncomponent(
                          text: "Login",
                          onPress: handleLogin,
                          type: "primary",
                          height: isMobileLarge ? 55 : 52,
                          width: AppInfo.getScreenWidth(context) * 0.8,
                        ),
                        SizedBox(height: isMobileLarge ? 28 : 25),
                        RowComponent(children: [
                          const TextComponent(
                            text: "Chưa có tài khoản?",
                          ),
                          const SpaceComponent(
                            width: 10,
                          ),
                          Buttoncomponent(
                            text: "Sign up",
                            onPress: () {
                              AppHelperFunctions.navigateToScreenName(context, RoutesName.signUp);
                            },
                            type: "link",
                            textFont: 15,
                          )
                        ])
                      ],
                    ),
                  ),
                )
              ],
            )),

            // White container with login form
          ],
        ),
      ),
    );
  }
}
