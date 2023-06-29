import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:som_kart/screens/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:som_kart/const/AppColor.dart';

//import 'pages/main_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Som Kart',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: AppColors.energy_yellow,
              elevation: 0,
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
