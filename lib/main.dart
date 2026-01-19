import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors_app/const/app_pref.dart' show AppPref;
import 'package:visitors_app/const/binding.dart';
import 'package:visitors_app/const/colors.dart';
import 'package:visitors_app/const/responsive.dart';
import 'package:visitors_app/const/route_generate.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPref.init();

  InitialBinding().dependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            Responsive().init(constraints, orientation);
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                fontFamily: GoogleFonts.inter().fontFamily,
                scaffoldBackgroundColor: AppColor.scaffoldColor,
                appBarTheme: const AppBarTheme(
                  surfaceTintColor: AppColor.white,
                  backgroundColor: AppColor.backgroundColor,
                  elevation: 0,
                ),
              ),
              getPages: RouteGenerate.routes,
              initialRoute: RouteGenerate.landingScreen,
            );
          },
        );
      },
    );
  }
}
