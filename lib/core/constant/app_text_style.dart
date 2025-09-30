import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_sizes.dart';

class AppTextStyles {
  // ========== Titles ==========
  static const TextStyle titleLarge = TextStyle(
    fontSize: AppSizes.font32,
    fontWeight: FontWeight.bold,
   );

  static const TextStyle titleMedium = TextStyle(
    fontSize: AppSizes.font24,
    fontWeight: FontWeight.w600,
   );

  static const TextStyle titleSmall = TextStyle(
    fontSize: AppSizes.font20,
    fontWeight: FontWeight.w600,
   );

  // ========== Body ==========
  static const TextStyle bodyLarge = TextStyle(
    fontSize: AppSizes.font16,
    fontWeight: FontWeight.normal,
   );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: AppSizes.font14,
    fontWeight: FontWeight.normal,
   );

  static const TextStyle bodySmall = TextStyle(
    fontSize: AppSizes.font12,
    fontWeight: FontWeight.normal,
   );

  // ========== Buttons ==========
  static const TextStyle button = TextStyle(
    fontSize: AppSizes.font16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  // ========== Captions ==========
  static const TextStyle caption = TextStyle(
    fontSize: AppSizes.font12,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );
}
