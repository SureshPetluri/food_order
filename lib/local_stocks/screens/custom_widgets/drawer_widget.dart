import 'package:flutter/material.dart';

import 'const_widgets.dart';
import 'switch_modes.dart';


class DrawerWidget extends StatelessWidget {
  const DrawerWidget(
      {super.key, required this.themeMode, required this.changeTheme});

  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      // shadowColor:Theme.of(context).colorScheme.primary ,
      // surfaceTintColor: Theme.of(context).colorScheme.primary,
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                "</Suresh/>",
              ),
              sizedBox20(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: SwitchMode(
                  themeMode: themeMode,
                  changeTheme: changeTheme,
                ),
              ),
              sizedBox150()
            ],
          ),
        ),
      ),
    );
  }
}
