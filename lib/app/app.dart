// lib/app/app.dart
import 'package:dairy_farm_app/app/routes.dart';
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../core/theme/text_styles.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MilkMate',

      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        fontFamily: AppTextStyles.fontFamily,
        textTheme: TextTheme(
          displayLarge: AppTextStyles.headline1,
          displayMedium: AppTextStyles.headline2,
          displaySmall: AppTextStyles.headline3,
          titleLarge: AppTextStyles.subtitle1,
          titleMedium: AppTextStyles.subtitle2,
          bodyLarge: AppTextStyles.bodyText1,
          bodyMedium: AppTextStyles.bodyText2,
          labelLarge: AppTextStyles.button,
          labelMedium: AppTextStyles.caption,
          labelSmall: AppTextStyles.overline,
        ),
      ),

      defaultTransition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),

      getPages: AppPages.routes,
      initialRoute: AppPages.initialRoute,
    );
  }
}
