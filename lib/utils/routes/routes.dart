import 'package:app_giang_vien_vku/view/auth/register.dart';
import 'package:app_giang_vien_vku/view/auth/signin.dart';
import 'package:app_giang_vien_vku/view/auth/verify.dart';
import 'package:app_giang_vien_vku/view/course_attendance/course_attendance_screen.dart';
import 'package:app_giang_vien_vku/view/course_details/course_details_screen.dart';
import 'package:app_giang_vien_vku/view/course_details/course_lesson_form_screen.dart';
import 'package:app_giang_vien_vku/view/course_details/course_qr_details_screen.dart';
import 'package:app_giang_vien_vku/view/course_list/list_course_screen.dart';
import 'package:app_giang_vien_vku/view/navigator_menu.dart';
import 'package:app_giang_vien_vku/view/notice/course_cancellation_screen.dart';
import 'package:app_giang_vien_vku/view/notice/course_make_up_screen.dart';
import 'package:app_giang_vien_vku/view/notice/course_notice_details_screen.dart';
import 'package:app_giang_vien_vku/view/splash.dart';
import 'package:flutter/material.dart';

import 'routes_name.dart';

class Routes {
  static MaterialPageRoute _buildRoute(Widget screen, String routesName) {
    return MaterialPageRoute(builder: (BuildContext context) => screen, settings: RouteSettings(name: routesName));
  }

  static MaterialPageRoute generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case RoutesName.home:
      //   return MaterialPageRoute(builder: (BuildContext context) => HomeScreen());
      case RoutesName.login:
        return _buildRoute(const SignInScreen(), RoutesName.login);
      case RoutesName.signUp:
        return _buildRoute(const SignUpScreen(), RoutesName.signUp);
      case RoutesName.verify:
        return _buildRoute(const VerifyScreen(), RoutesName.verify);
      case RoutesName.splash:
        return _buildRoute(SplashScreen(), RoutesName.splash);
      case RoutesName.menuBar:
        return _buildRoute(NavigationMenu(), RoutesName.menuBar);
      case RoutesName.course_details:
        return _buildRoute(CourseDetailsScreen(), RoutesName.course_details);
      case RoutesName.course_list:
        return _buildRoute(const ListCourseScreen(), RoutesName.course_list);
      case RoutesName.course_form:
        return _buildRoute(CourseLessonFormScreen(), RoutesName.course_form);
      case RoutesName.course_attendance:
        return _buildRoute(CourseAttendanceScreen(), RoutesName.course_attendance);
      case RoutesName.course_lesson_details:
        return _buildRoute(const CourseQrDetailsScreen(), RoutesName.course_lesson_details);
      case RoutesName.cancellationFormNotice:
        return _buildRoute(CancellationScreen(), RoutesName.cancellationFormNotice);
      case RoutesName.courseCancelAndMakeUpScreen:
        return _buildRoute(const CourseCancelAndMakeUpScreen(), RoutesName.courseCancelAndMakeUpScreen);
      case RoutesName.makeUpFormNotice:
        return _buildRoute(CourseMakeUpCnScreen(), RoutesName.makeUpFormNotice);

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text("Not found"),
            ),
          );
        });
    }
  }
}
