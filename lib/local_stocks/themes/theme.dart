import 'package:flutter/material.dart';

class ThemeClass {
  final BuildContext context; // Add this field

  ThemeClass(this.context);

  Color secondary = const Color(0xffFF8B6A);
  Color accent = const Color(0xffFFD2BB);
  Color white = const Color(0xFFFFFFFF);
  Color black = const Color(0xFF000000);
  Color blue = const Color(0xff2196F3);
  Color blueShade100 = const Color(0xBBDEFBFF);
  Color blueShade900 = const Color(0xFF0D47A1);
  Color amber = const Color(0xFFC107FF);
  Color amberShade100 = const Color(0xFFECB3FF);
  Color amberShade900 = const Color(0xFFFF6F00);
  Color grey = const Color(0x9EC9C9CB);
  Color greyShadow800 = const Color(0xFF424242);
  Color greyShadow900 = const Color(0xFF212121);
  Color blueGray = const Color(0xFF607D8B);
  Color blackOpacity3 = Colors.black.withOpacity(0.3);
  Color blackOpacity5 = Colors.black.withOpacity(0.5);
  Color orange = const Color(0xFF9800FF);
  Color red = const Color(0xFFF44336);
  Color redShadow100 = const Color(0xFFFFCDD2);
  Color green = const Color(0xFF4CAF50);
  Color greenShadow100 = const Color(0xFFC8E6C9);

  static ThemeData lightTheme(BuildContext context) {
    final themeClass = ThemeClass(context);
    return ThemeData(
      useMaterial3: true,
      primaryColor: ThemeData.light().scaffoldBackgroundColor,
      inputDecorationTheme: inputDecoration(context),
      colorScheme: const ColorScheme.light().copyWith(
        primary: themeClass.white,
        onPrimary: themeClass.white,
        primaryContainer: themeClass.blueShade100,
        onPrimaryContainer: themeClass.black,
        secondary: themeClass.amber,
        onSecondary: themeClass.black,
        secondaryContainer: themeClass.amberShade100,
        onSecondaryContainer: themeClass.black,
        tertiary: themeClass.green,
        onTertiary: themeClass.white,
        tertiaryContainer: themeClass.greenShadow100,
        onTertiaryContainer: themeClass.black,
        error: themeClass.red,
        onError: themeClass.white,
        errorContainer: themeClass.redShadow100,
        onErrorContainer: themeClass.black,
        background: themeClass.white,
        onBackground: themeClass.black,
        surface: themeClass.grey,
        onSurface: themeClass.black,
        surfaceVariant: themeClass.blueGray,
        onSurfaceVariant: themeClass.white,
        outline: themeClass.grey,
        outlineVariant: themeClass.blueGray,
        shadow: themeClass.blackOpacity3,
        scrim: themeClass.blackOpacity5,
        inverseSurface: themeClass.black,
        onInverseSurface: themeClass.white,
        inversePrimary: themeClass.white,
        surfaceTint: themeClass.orange,
      ),
    );
  }

  static InputDecorationTheme inputDecoration(BuildContext context) {
    return Theme.of(context).inputDecorationTheme.copyWith(
          filled: true,
          fillColor: Colors.grey.withOpacity(0.8),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          // hintStyle: AppTextTheme.robotoHintTextStyle,
          contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        );
  }

  static ThemeData darkTheme(BuildContext context) {
    final themeClass = ThemeClass(context);

    return ThemeData(
      useMaterial3: true,
      inputDecorationTheme: inputDecoration(context),
      primaryColor: ThemeData.dark().scaffoldBackgroundColor,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: themeClass.black,
        onPrimary: themeClass.white,
        primaryContainer: themeClass.blueShade100,
        //Colors.blue.shade100,
        onPrimaryContainer: themeClass.black,
        secondary: themeClass.amber,
        onSecondary: themeClass.white,
        secondaryContainer: themeClass.amberShade100,
        onSecondaryContainer: themeClass.white,
        tertiary: themeClass.green,
        tertiaryContainer: themeClass.greenShadow100,
        errorContainer: themeClass.redShadow100,
        background: themeClass.greyShadow900,
        onBackground: themeClass.white,
        surface: themeClass.grey,
        onSurface: themeClass.white,
        error: themeClass.red,
        onError: themeClass.white,
        onTertiary: themeClass.white,
        onTertiaryContainer: themeClass.white,
        onSurfaceVariant: themeClass.white,
        onErrorContainer: themeClass.white,
        surfaceVariant: themeClass.blueGray,
        outline: themeClass.grey,
        outlineVariant: themeClass.blueGray,
        shadow: themeClass.blackOpacity3,
        scrim: themeClass.blackOpacity5,
        inverseSurface: themeClass.black,
        onInverseSurface: themeClass.white,
        inversePrimary: themeClass.black,
        surfaceTint: themeClass.orange,
      ),
    );
  }
}


