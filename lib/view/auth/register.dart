import 'package:app_giang_vien_vku/components/ButtonComponent.dart';
import 'package:app_giang_vien_vku/components/IconComponent.dart';
import 'package:app_giang_vien_vku/components/InputComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/components/TextComponent.dart';
import 'package:app_giang_vien_vku/constants/AppColor.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:app_giang_vien_vku/view_model/auth/signup.view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController usernameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    bool formValidator() {
      // if (!Validate.isEmail(emailController.text)) {
      //   // Email không hợp lệ
      //   Utils.snackBar("Email không hợp lệ \n", context, true);
      //   return false;
      // }

      // if (!Validate.isPasswordValid(passwordController.text)) {
      //   // Mật khẩu không hợp lệ
      //   Utils.snackBar(
      //       "Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất một chữ cái và một số",
      //       context,
      //       true);
      //   return false;
      // }

      return true;
    }

    final signinViewModel = Provider.of<SignupViewModel>(context);

    void handleRegister() {
      if (formValidator()) {
        signinViewModel.signupApi(emailController.text, passwordController.text, usernameController.text, context);
      }
    }

    bool isMobileLarge = AppInfo.isMobileLarge(context);
    bool isSmall = AppInfo.isMobileSmall(context);
    AppInfo.isMobileMedium(context);
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Scaffold(
            body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SpaceComponent(
                  height: isSmall ? 40 : 50,
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      child: Iconcomponent(
                        size: isSmall ? 35 : 40,
                        icon: Icon(
                          CupertinoIcons.back,
                          size: isSmall ? 25 : 30,
                        ),
                        onPress: () {
                          AppHelperFunctions.navigateback(context);
                        },
                      ),
                      left: 0,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            'Đăng Ký',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A498E),
                            ),
                          ),
                          TextComponent(
                            text: 'Tạo tài khoản',
                            fontSize: 18,
                            type: TextType.semibold,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SpaceComponent(
                  height: 50,
                ),
                InputComponent(
                  controller: usernameController,
                  affix: Icon(
                    Icons.person,
                    color: Colors.black,
                  ),
                  type: TextInputType.text,
                  placeholder: 'Họ và tên',
                  colorBackground: AppColors.thirdPrimary,
                ),
                SpaceComponent(
                  height: 20,
                ),
                InputComponent(
                  controller: emailController,
                  affix: Icon(
                    Icons.email,
                    color: Colors.black,
                  ),
                  type: TextInputType.emailAddress,
                  placeholder: 'Email',
                  colorBackground: AppColors.thirdPrimary,
                  onEnd: () {
                    // print("a");
                  },
                ),
                SpaceComponent(
                  height: 20,
                ),
                InputComponent(
                  controller: passwordController,
                  affix: Icon(
                    Icons.lock,
                    color: Colors.black,
                  ),
                  type: TextInputType.text,
                  isPassword: true,
                  placeholder: 'Mật khẩu',
                  colorBackground: AppColors.thirdPrimary,
                ),
                SpaceComponent(
                  height: isSmall ? 40 : 50,
                ),
                Buttoncomponent(
                  height: isMobileLarge ? 55 : 52,
                  width: AppInfo.getScreenWidth(context),
                  type: 'primary',
                  textFont: 16,
                  text: 'Đăng Ký',
                  textColor: Colors.white,
                  color: AppColors.secondPrimary,
                  onPress: () {
                    handleRegister();
                  },
                ),
                SpaceComponent(
                  height: isSmall ? 30 : 40,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Divider(
                        color: Colors.black, // Line color
                        thickness: 1, // Line thickness
                        endIndent: 8, // Space before the text
                      ),
                    ),
                    TextComponent(text: "hoặc đăng nhập với"),
                    Expanded(
                      child: Divider(
                        color: Colors.black, // Line color
                        thickness: 1, // Line thickness
                        indent: 8, // Space after the text
                      ),
                    ),
                  ],
                ),
                SpaceComponent(
                  height: isSmall ? 30 : 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/icons/google.png',
                      width: 25,
                      height: 25,
                    ),
                    TextComponent(
                      color: AppColors.secondPrimary,
                      text: "  Đăng nhập với Google",
                    ),
                  ],
                ),
                SpaceComponent(
                  height: isSmall ? 20 : 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextComponent(
                      text: 'Bạn đã có tài khoản ?',
                    ),
                    Buttoncomponent(
                      type: "link",
                      text: " Đăng nhập",
                      onPress: () {
                        AppHelperFunctions.navigateback(context);
                      },
                    ),
                  ],
                )
              ],
            ),
          )),
        )));
  }
}
