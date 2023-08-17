import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [],),);
  }
}

void main() {
  runApp(ColorSchemeApp());
}

class ColorSchemeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Scheme App',
      theme: ThemeData(
        // brightness: Brightness.light,
        colorScheme: createColorScheme(),
      ),
      darkTheme: ThemeData(
        // brightness: Brightness.dark,
        colorScheme: createColorScheme(),
      ),
      themeMode: ThemeMode.light,
      home: ColorSchemeScreen(),
    );
  }

  ColorScheme createColorScheme() {
    return ColorScheme.light(
      primary: Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: Colors.blue.shade100,
      onPrimaryContainer: Colors.black,
      secondary: Colors.amber,
      onSecondary: Colors.black,
      onSecondaryContainer: Colors.black,
      tertiary: Colors.green,
      onTertiary: Colors.white,
      tertiaryContainer: Colors.green.shade100,
      onTertiaryContainer: Colors.black,
      error: Colors.red,
      onError: Colors.white,
      errorContainer: Colors.red.shade100,
      onErrorContainer: Colors.black,
      background: Colors.white,
      onBackground: Colors.black,
      surface: Colors.grey,
      onSurface: Colors.black,
      surfaceVariant: Colors.blueGrey,
      onSurfaceVariant: Colors.white,
      outline: Colors.grey,
      outlineVariant: Colors.blueGrey,
      shadow: Colors.black.withOpacity(0.3),
      scrim: Colors.black.withOpacity(0.5),
      inverseSurface: Colors.black,
      onInverseSurface: Colors.white,
      inversePrimary: Colors.white,
      surfaceTint: Colors.orange,
      primaryVariant: Colors.blue.shade900,
      secondaryVariant: Colors.amber.shade900,
    );
  }
}

class ColorSchemeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Scheme Demo'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildColorBox('Primary', Theme.of(context).colorScheme.primary),
          _buildColorBox('On Primary', Theme.of(context).colorScheme.onPrimary),
          _buildColorBox(
              'Primary Container', Theme.of(context).colorScheme.primaryContainer),
          _buildColorBox(
              'On Primary Container',
              Theme.of(context).colorScheme.onPrimaryContainer),
          _buildColorBox('Secondary', Theme.of(context).colorScheme.secondary),
          _buildColorBox('On Secondary', Theme.of(context).colorScheme.onSecondary),
          _buildColorBox(
              'Secondary Container', Theme.of(context).colorScheme.secondaryContainer),
          _buildColorBox(
              'On Secondary Container',
              Theme.of(context).colorScheme.onSecondaryContainer),
          _buildColorBox('Tertiary', Theme.of(context).colorScheme.tertiary),
          _buildColorBox('On Tertiary', Theme.of(context).colorScheme.onTertiary),
          _buildColorBox(
              'Tertiary Container', Theme.of(context).colorScheme.tertiaryContainer),
          _buildColorBox(
              'On Tertiary Container',
              Theme.of(context).colorScheme.onTertiaryContainer),
          _buildColorBox('Error', Theme.of(context).colorScheme.error),
          _buildColorBox('On Error', Theme.of(context).colorScheme.onError),
          _buildColorBox(
              'Error Container', Theme.of(context).colorScheme.errorContainer),
          _buildColorBox(
              'On Error Container', Theme.of(context).colorScheme.onErrorContainer),
          _buildColorBox('Background', Theme.of(context).colorScheme.background),
          _buildColorBox('On Background', Theme.of(context).colorScheme.onBackground),
          _buildColorBox('Surface', Theme.of(context).colorScheme.surface),
          _buildColorBox('On Surface', Theme.of(context).colorScheme.onSurface),
          _buildColorBox(
              'Surface Variant', Theme.of(context).colorScheme.surfaceVariant),
          _buildColorBox(
              'On Surface Variant', Theme.of(context).colorScheme.onSurfaceVariant),
          _buildColorBox('Outline', Theme.of(context).colorScheme.outline),
          _buildColorBox(
              'Outline Variant', Theme.of(context).colorScheme.outlineVariant),
          _buildColorBox('Shadow', Theme.of(context).colorScheme.shadow),
          _buildColorBox('Scrim', Theme.of(context).colorScheme.scrim),
          _buildColorBox(
              'Inverse Surface', Theme.of(context).colorScheme.inverseSurface),
          _buildColorBox(
              'On Inverse Surface', Theme.of(context).colorScheme.onInverseSurface),
          _buildColorBox(
              'Inverse Primary', Theme.of(context).colorScheme.inversePrimary),
          _buildColorBox('Surface Tint', Theme.of(context).colorScheme.surfaceTint),
          _buildColorBox(
              'Primary Variant', Theme.of(context).colorScheme.primaryVariant),
          _buildColorBox(
              'Secondary Variant', Theme.of(context).colorScheme.secondaryVariant),
        ],
      ),
    );
  }

  Widget _buildColorBox(String name, Color color) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: color,
      child: Text(
        name,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
