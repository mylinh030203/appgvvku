import 'package:app_giang_vien_vku/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class AppHelperFunctions {
  static Color? getColor(String value) {
    if (value == 'Green') {
      return Colors.green;
    }

    return null;
  }

  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static Future<void> navigateToScreenName(BuildContext context, String screenName) async {
    await Navigator.pushNamed(
      context,
      screenName,
    );
  }

  static void navigateback(BuildContext context) {
    Navigator.pop(
      context,
    );
  }

  static void navigateToScreenAndRemove(BuildContext context, String screenName) {
    Navigator.pushReplacementNamed(
      context,
      screenName,
    );
  }

  static void navigateToScreenAndRemoveAll(BuildContext context, String screenName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      screenName,
      (route) => true,
    );
  }

  static void navigateToScreenAndRemoveUntil(BuildContext context, String screenName, String desScreenName) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      screenName,
      (route) {
        return route.settings.name == desScreenName;
      },
    );
  }

  static void navigateRemoveUntil(BuildContext context, String screenName) {
    Navigator.of(context).popUntil(
      ModalRoute.withName(screenName),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkmode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static List<T> removeDupticates<T>(List<T> list) {
    return list.toSet().toList();
  }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}
