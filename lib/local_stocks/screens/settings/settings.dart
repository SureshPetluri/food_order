import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings(
      {super.key,
        required this.themeMode,
        required this.changeTheme});

  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
