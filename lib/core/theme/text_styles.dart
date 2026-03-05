import 'package:dairy_farm_app/core/contants/ui/app_sizes.dart';
import 'package:dairy_farm_app/core/theme/color.dart';
import 'package:flutter/material.dart';

class AppTextStyles {
  static const String fontFamily = 'TestSohne';
  // ===== Headline / Large Titles =====
  static const TextStyle headline1 = TextStyle(
    fontSize: AppSizes.fontXLarge,
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3, // line-height
  );

  static const TextStyle headline2 = TextStyle(
    fontSize: AppSizes.fontLarge,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  static const TextStyle headlineheader = TextStyle(
    fontSize: AppSizes.fontLarge,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
    color: Colors.white,
    height: 1.8,
  );

  static const TextStyle headline3 = TextStyle(
    fontSize: AppSizes.fontMedium,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    color: AppColors.textPrimary,
    height: 1.3,
  );

  // ===== Subtitle =====
  static const TextStyle subtitle1 = TextStyle(
    fontSize: AppSizes.fontMedium,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
    height: 1.25,
  );

  static const TextStyle subtitle2 = TextStyle(
    fontSize: AppSizes.fontRegular,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
    height: 1.25,
  );

  // ===== Body / Paragraph =====
  static const TextStyle bodyText1 = TextStyle(
    fontSize: AppSizes.fontRegular,
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle bodyText2 = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  // ===== Caption / Small Text =====
  static const TextStyle caption = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.2,
  );

  // ===== Button Text =====
  static const TextStyle button = TextStyle(
    fontSize: AppSizes.fontMedium,
    fontFamily: fontFamily,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.0,
    letterSpacing: 1.0,
  );

  // ===== Label Text =====
  static const TextStyle label = TextStyle(
    fontSize: AppSizes.fontRegular,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.25,
  );

  // ===== Hint / Placeholder =====
  static const TextStyle hint = TextStyle(
    fontSize: AppSizes.fontRegular,
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: AppColors.textHint,
    height: 1.25,
  );

  // ===== Error / Validation =====
  static const TextStyle error = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontFamily: fontFamily,
    fontWeight: FontWeight.normal,
    color: AppColors.error,
    height: 1.2,
  );

  // ===== Overline / Tiny text =====
  static const TextStyle overline = TextStyle(
    fontSize: AppSizes.fontSmall,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
    color: AppColors.textSecondary,
    letterSpacing: 1.2,
    height: 1.0,
  );

  // ===== Link Text =====
  static const TextStyle link = TextStyle(
    fontSize: AppSizes.fontRegular,
    fontFamily: fontFamily,
    fontWeight: FontWeight.w500,
    color: AppColors.link,
    decoration: TextDecoration.underline,
    height: 1.25,
  );
}
