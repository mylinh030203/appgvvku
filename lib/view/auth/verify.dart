import 'package:app_giang_vien_vku/components/ButtonComponent.dart';
import 'package:app_giang_vien_vku/components/ContainerComponent.dart';
import 'package:app_giang_vien_vku/components/InputComponent.dart';
import 'package:app_giang_vien_vku/components/SpaceComponent.dart';
import 'package:app_giang_vien_vku/constants/AppInfo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants/AppColor.dart';
import '../../utils/utils.dart';
import '../../view_model/auth/signup.view_model.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({super.key});

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  @override
  Widget build(BuildContext context) {
    final codeController = TextEditingController();
    final verifyViewModel = Provider.of<SignupViewModel>(context);

    void handleRegister() {
      if (codeController.text != "null") {
        verifyViewModel.verifyApi(codeController.text, context);
      } else {
        Utils.snackBar("Vui lòng nhập mã code\n", context, true);
      }
    }

    return ContainerComponent(
      padding: const EdgeInsets.all(20),
      isBack: true,
      title: "Xác thực email",
      children: [
        InputComponent(
            placeholder: "Mã code",
            colorBackground: AppColors.thirdPrimary,
            affix: const Icon(
              Icons.key,
              color: Colors.black,
            ),
            controller: codeController),
        SpaceComponent(
          height: AppInfo.getScreenHeight(context) * 0.05,
        ),
        Buttoncomponent(
          text: "Xác nhận",
          onPress: handleRegister,
        )
      ],
    );
  }
}
