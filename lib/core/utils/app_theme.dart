import 'package:case_fire/core/utils/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData theme = ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.textHighlightColor,
      selectionColor: AppColors.textHighlightColor,
      selectionHandleColor: AppColors.textHighlightColor,
    ),
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.cardBackground,
      surfaceTintColor: AppColors.background,
      iconTheme: IconThemeData(color: AppColors.textColor),
      titleTextStyle: TextStyle(color: AppColors.textColor, fontSize: 21),
    ),
  );
}
