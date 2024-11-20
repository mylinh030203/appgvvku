import 'package:app_giang_vien_vku/data/local/baonghi_baobu.local.dart';
import 'package:app_giang_vien_vku/data/local/hocphan.local.dart';
import 'package:app_giang_vien_vku/data/local/namhoc_hocky.local.dart';
import 'package:app_giang_vien_vku/data/local/qr_base64.local.dart';
import 'package:app_giang_vien_vku/data/local/user.local.dart';
import 'package:app_giang_vien_vku/data/network/BaseApiService.dart';
import 'package:app_giang_vien_vku/data/network/NetworkApiService.dart';
import 'package:app_giang_vien_vku/repository/auth/auth.repository.dart';
import 'package:app_giang_vien_vku/repository/auth/auth.repositoryImpl.dart';
import 'package:app_giang_vien_vku/repository/course/hocphan.repository.dart';
import 'package:app_giang_vien_vku/repository/course/namhoc_hocky.repository.dart';
import 'package:app_giang_vien_vku/repository/course_info/course_make_up.repo.dart';
import 'package:app_giang_vien_vku/repository/course_info/lichtrinhhocpan.repoImpl.dart';
import 'package:app_giang_vien_vku/utils/BackGroundService.dart';
import 'package:app_giang_vien_vku/utils/LocalNotificationService.dart';
import 'package:app_giang_vien_vku/utils/local/BaseDataLocal.dart';
import 'package:app_giang_vien_vku/utils/local/localImpl/jwt_token.local_impl.dart';
import 'package:app_giang_vien_vku/utils/local/localImpl/namhoc_hocky.local_impl.dart';
import 'package:app_giang_vien_vku/utils/local/localImpl/qr_base64.local_impl.dart';
import 'package:app_giang_vien_vku/utils/local/localImpl/thoi_khoa_bieu.local_impl.dart';
import 'package:app_giang_vien_vku/utils/routes/routes.dart';
import 'package:app_giang_vien_vku/utils/ScreenInfo.dart';
import 'package:app_giang_vien_vku/utils/themes/themes.dart';
import 'package:app_giang_vien_vku/view/splash.dart';
import 'package:app_giang_vien_vku/view_model/auth/signin.view_model.dart';
import 'package:app_giang_vien_vku/view_model/auth/signup.view_model.dart';
import 'package:app_giang_vien_vku/view_model/bottom_navigator/botttom_navigator.service.dart';
import 'package:app_giang_vien_vku/view_model/course_attendance/course_attendance.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_notice/course_cancellation.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_details.view_model.dart';
import 'package:app_giang_vien_vku/view_model/course_detail/course_form.view_model.dart';
import 'package:app_giang_vien_vku/services/attendance.service.dart';
import 'package:app_giang_vien_vku/services/course.service.dart';
import 'package:app_giang_vien_vku/view_model/course_notice/course_makeup.view_model.dart';
import 'package:app_giang_vien_vku/view_model/home/home.view_model.dart';
import 'package:app_giang_vien_vku/services/lophocphan.service.dart';
import 'package:app_giang_vien_vku/services/namhoc_hocky.service.dart';
import 'package:app_giang_vien_vku/view_model/schedule/schedule.view_model.dart';
import 'package:app_giang_vien_vku/view_model/setting/setting.view_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Khởi chạy local Notificaltion
  await LocalNotifications().init();
  // await Permission.notification.isDenied.then((value) {
  //   if (value) {
  //     Permission.notification.request();
  //   }
  // });

  await Hive.initFlutter();
  Hive.registerAdapter(UserLocalAdapter());
  Hive.registerAdapter(NamhocHockyAdapter());
  Hive.registerAdapter(BaoNghiAdapter());
  Hive.registerAdapter(BaoBuAdapter());
  Hive.registerAdapter(ThoiKhoaBieuAdapter());
  Hive.registerAdapter(QRBase64Adapter());

  runApp(MultiProvider(
    providers: [
      // BaseApisServices
      Provider<BaseApisService>(create: (_) => NetworkApiService()),

      // Base Data Local
      Provider<BaseLocal<String>>(create: (_) => JWTTokenDataLocal()),
      Provider<BaseLocal<List<NamhocHocky>>>(create: (_) => NamhocHockyLocalImpl()),
      Provider<BaseLocal<List<ThoiKhoaBieu>>>(create: (_) => ThoiKhoaBieuLocalImpl()),
      Provider<BaseLocal<List<QRBase64>>>(create: (_) => QRBase64LocalImpl()),

      // BackgroundService
      Provider<BackgroundService>(create: (_) => BackgroundService()),

      // Repo
      Provider<HocphanRepository>(
        create: (context) => HocPhanRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<NamhocHockyRepository>(
        create: (context) => NamhocHockyRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<LichtrinhHocPhanRepository>(
        create: (context) => LichtrinhHocPhanRepoImpl(
          apiService: context.read<BaseApisService>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
        ),
      ),
      Provider<AuthRepository>(
        create: (context) => AuthRepositoryImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),
      Provider<MakeupCourseRepo>(
        create: (context) => MakeupCourseRepoImpl(
          apiService: context.read<BaseApisService>(),
        ),
      ),

      // Service : Lưu trữ data dùng chung
      ChangeNotifierProvider<LopHocPhanService>(
        create: (context) => LopHocPhanService(
          hocPhanRepoImpl: context.read<HocphanRepository>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
          thoiKhoaBieuBox: context.read<BaseLocal<List<ThoiKhoaBieu>>>(),
        ),
      ),
      ChangeNotifierProvider<NamHocHocKyService>(
        create: (context) => NamHocHocKyService(
          namhochockyRepoImpl: context.read<NamhocHockyRepository>(),
          namhocHockybox: context.read<BaseLocal<List<NamhocHocky>>>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
        ),
      ),
      ChangeNotifierProvider<BotttomNavigatorService>(
        create: (context) => BotttomNavigatorService(),
      ),
      ChangeNotifierProvider<CourseDetailsService>(
        create: (context) => CourseDetailsService(
          hocphanService: context.read<LopHocPhanService>(),
          lichtrinhHocPhanRepoImpl: context.read<LichtrinhHocPhanRepository>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
        ),
      ),
      ChangeNotifierProvider<AttendanceService>(
        create: (context) => AttendanceService(
          hocphanService: context.read<LopHocPhanService>(),
          lichtrinhHocPhanRepoImpl: context.read<LichtrinhHocPhanRepository>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
          courseDetailsService: context.read<CourseDetailsService>(),
        ),
      ),

      // ViewModel
      ChangeNotifierProvider(
        create: (context) => SigninViewModel(
          jwtTokenBox: context.read<BaseLocal<String>>(),
          authRepoImpl: context.read<AuthRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SignupViewModel(
          authRepoImpl: context.read<AuthRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => HomeViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHocKyService: context.read<NamHocHocKyService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => ScheduleViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHocKyService: context.read<NamHocHocKyService>(),
        ),
      ),
      ChangeNotifierProvider<CourseDetailsViewModel>(
        create: (context) => CourseDetailsViewModel(
          attendanceService: context.read<AttendanceService>(),
          courseDetailService: context.read<CourseDetailsService>(),
          hocphanService: context.read<LopHocPhanService>(),
          qrBase64Box: context.read<BaseLocal<List<QRBase64>>>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => SettingViewModel(
          jwtTokenBox: context.read<BaseLocal<String>>(),
          qrBase64Box: context.read<BaseLocal<List<QRBase64>>>(),
          namhocHockyBox: context.read<BaseLocal<List<NamhocHocky>>>(),
          thoiKhoaBieuBox: context.read<BaseLocal<List<ThoiKhoaBieu>>>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CourseLessonFormViewModel(
          courseDetailService: context.read<CourseDetailsService>(),
          hocPhanService: context.read<LopHocPhanService>(),
          lichtrinhHocPhanRepoImpl: context.read<LichtrinhHocPhanRepository>(),
          qrBase64Box: context.read<BaseLocal<List<QRBase64>>>(),
          backgroundService: context.read<BackgroundService>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
          settingViewModel: context.read<SettingViewModel>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CourseAttendanceViewModel(
          attendanceService: context.read<AttendanceService>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CourseCancellationViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHockyService: context.read<NamHocHocKyService>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
          lichtrinhHocPhanRepoImpl: context.read<LichtrinhHocPhanRepository>(),
        ),
      ),
      ChangeNotifierProvider(
        create: (context) => CourseMakeUpViewModel(
          hocphanService: context.read<LopHocPhanService>(),
          namHocHockyService: context.read<NamHocHocKyService>(),
          jwtTokenBox: context.read<BaseLocal<String>>(),
          makeupCourseRepoImpl: context.read<MakeupCourseRepo>(),
        ),
      ),
    ],
    builder: (context, child) {
      ScreenInfo().initialize(context);

      return child!;
    },
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // Add other supported locales if needed
        Locale('vi', ''), // Vietnamese locale
      ],
      builder: (context, child) {
        ScreenInfo().initialize(context); // Initialize once for the entire app
        return child!;
      },
      locale: const Locale('vi', ''), //
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.lightTheme,
      themeMode: ThemeMode.light,
      home: SplashScreen(),
      onGenerateRoute: Routes.generateRoute,
    );
  }
}
