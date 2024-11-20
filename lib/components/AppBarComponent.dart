import 'package:app_giang_vien_vku/constants/AppSizes.dart';
import 'package:app_giang_vien_vku/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key, this.title, this.showBackArrow = false, this.leadingIcon, this.actions, this.leadingOnPressed, this.isLeadingIconWhite});

  final Widget? title;
  final bool showBackArrow;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final Color? isLeadingIconWhite;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: showBackArrow
          ? IconButton(onPressed: () => AppHelperFunctions.navigateback(context), icon: Icon(CupertinoIcons.chevron_back, color: isLeadingIconWhite ?? Colors.white))
          : leadingIcon != null
              ? IconButton(onPressed: () => leadingOnPressed, icon: Icon(leadingIcon))
              : null,
      title: title,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(AppSize.appBarHeight);
}
