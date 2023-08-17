import 'package:flutter/material.dart';

class ThemeClass {
  Color secondary =const Color(0xffFF8B6A);
  Color accent =const Color(0xffFFD2BB);
  Color white =const Color(0xffffffff);
  Color black =const Color(0xFF000000);
  Color blue =const Color(0xff2196F3);
  Color blueShade100 =const Color(0xBBDEFBFF);
  Color blueShade900 =const Color(0xFF0D47A1);
  Color amber =const Color(0xFFC107FF);
  Color amberShade100 =const Color(0xFFECB3FF);
  Color amberShade900 =const Color(0xFFFF6F00);
  Color grey =const Color(0x9EC9C9CB);
  Color greyShadow800 =const Color(0xFF424242);
  Color greyShadow900 =const Color(0xFF212121);
  Color blueGray =const Color(0xFF607D8B);
  Color blackOpacity3 = Colors.black.withOpacity(0.3);
  Color blackOpacity5 = Colors.black.withOpacity(0.5);
  Color orange =const Color(0xFF9800FF);
  Color red =const Color(0xFFF44336);
  Color redShadow100 = const Color(0xFFFFCDD2);
  Color green = const Color(0xFF4CAF50);
  Color greenShadow100 = const Color(0xFFC8E6C9);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ThemeData.light().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: _themeClass.blue,
      onPrimary: _themeClass.white,
      primaryContainer: _themeClass.blueShade100,
      onPrimaryContainer: _themeClass.black,
      secondary: _themeClass.amber,
      onSecondary: _themeClass.black,
      secondaryContainer: _themeClass.amberShade100,
      onSecondaryContainer: _themeClass.black,
      tertiary: _themeClass.green,
      onTertiary: _themeClass.white,
      tertiaryContainer: _themeClass.greenShadow100,
      onTertiaryContainer: _themeClass.black,
      error: _themeClass.red,
      onError: _themeClass.white,
      errorContainer: _themeClass.redShadow100,
      onErrorContainer: _themeClass.black,
      background: _themeClass.white,
      onBackground: _themeClass.black,
      surface: _themeClass.grey,
      onSurface: _themeClass.black,
      surfaceVariant: _themeClass.blueGray,
      onSurfaceVariant: _themeClass.white,
      outline:_themeClass.grey,
      outlineVariant: _themeClass.blueGray,
      shadow: _themeClass.blackOpacity3,
      scrim: _themeClass.blackOpacity5,
      inverseSurface: _themeClass.black,
      onInverseSurface: _themeClass.white,
      inversePrimary: _themeClass.white,
      surfaceTint: _themeClass.orange,
      primaryVariant: _themeClass.blueShade900,
      secondaryVariant: _themeClass.amberShade900,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    primaryColor: ThemeData.dark().scaffoldBackgroundColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: _themeClass.green,
      onPrimary: _themeClass.white,
      primaryContainer: _themeClass.blueShade100,//Colors.blue.shade100,
      onPrimaryContainer: _themeClass.black,
      secondary: _themeClass.amber,
      onSecondary: _themeClass.white,
      secondaryContainer: _themeClass.amberShade100,
      onSecondaryContainer: _themeClass.white,
      tertiary: _themeClass.green,
      tertiaryContainer: _themeClass.greenShadow100,
      errorContainer: _themeClass.redShadow100,
      background: _themeClass.greyShadow900,
      onBackground: _themeClass.white,
      surface: _themeClass.greyShadow800,
      onSurface: _themeClass.white,
      error: _themeClass.red,
      onError: _themeClass.white,
      onTertiary: _themeClass.white,
      onTertiaryContainer: _themeClass.white,
      onSurfaceVariant: _themeClass.white,
      onErrorContainer: _themeClass.white,
      surfaceVariant: _themeClass.blueGray,
      outline: _themeClass.grey,
      outlineVariant: _themeClass.blueGray,
      shadow: _themeClass.blackOpacity3,
      scrim: _themeClass.blackOpacity5,
      inverseSurface: _themeClass.black,
      onInverseSurface: _themeClass.white,
      inversePrimary: _themeClass.black,
      surfaceTint: _themeClass.orange,
      primaryVariant: _themeClass.blueShade900,
      secondaryVariant: _themeClass.amberShade900,
    ),
  );
}

ThemeClass _themeClass = ThemeClass();

