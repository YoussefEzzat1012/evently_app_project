import 'package:flutter/material.dart';
import 'package:route/utils/app_styles.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
      focusColor: AppColors.whiteColor,
      dividerColor: AppColors.whiteColor,
      splashColor: Colors.grey,
      cardColor: AppColors.blackColor,
      scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.primaryColor,
      iconTheme: IconThemeData(
        color: AppColors.primaryColor
      )
    ),
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20Black,
      headlineMedium: AppStyle.medium16Primary,
      headlineSmall: AppStyle.medium14White,
      titleMedium: AppStyle.bold16White,
      titleSmall: AppStyle.medium16Black,
      bodyLarge: AppStyle.medium16Grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.primaryColor,
      type: BottomNavigationBarType.fixed,
      selectedItemColor: AppColors.whiteColor,
      unselectedItemColor: AppColors.whiteColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryColor,
      shape: StadiumBorder(
        side: BorderSide(
          color: AppColors.whiteColor,
          width: 6
        )
      )
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(35),
      //   side: BorderSide(
      //     color: AppColors.primaryColor,
      //     width: 6
      //   ),
      // ),
      // backgroundColor: AppColors.primaryColor
    )

  );


  static final ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    focusColor: AppColors.primaryColor,
      dividerColor: AppColors.primaryDark,
      splashColor: AppColors.primaryColor,
      cardColor: AppColors.whiteColor,
      appBarTheme: AppBarThemeData(
      backgroundColor: AppColors.primaryDark,
          iconTheme: IconThemeData(
              color: AppColors.primaryColor
          )
    ),
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyle.bold20White,
      headlineMedium: AppStyle.medium16White,
      headlineSmall: AppStyle.medium14White,
      titleMedium: AppStyle.bold16PrimaryDark,
      titleSmall: AppStyle.medium16White,
      bodyLarge: AppStyle.medium16White,
    ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.primaryDark,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.whiteColor,
        unselectedItemColor: AppColors.whiteColor,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryDark,
          shape: StadiumBorder(
              side: BorderSide(
                  color: AppColors.whiteColor,
                  width: 6
              )
          )
  )
  );
}
