import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:food_order/local_stocks/app_repository/repository.dart';

import 'custom_toast.dart';


class SwitchMode extends StatefulWidget {
  const SwitchMode(
      {Key? key, required this.themeMode, required this.changeTheme})
      : super(key: key);
  final void Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  @override
  State<SwitchMode> createState() => _SwitchModeState();
}

class _SwitchModeState extends State<SwitchMode> {
  bool isSwitched = false;

  @override
  void didChangeDependencies() {
    if (Repository.isDark() == true) {
      isSwitched = false;
    } else {
      isSwitched = true;
    }
    setState(() {

    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSwitched = !isSwitched;
          if (Repository.isDark() == true) {
            widget.changeTheme(ThemeMode.light);
            Repository.changeTheme(false);
            showCustomToast(context, 'resume.light'.tr());

          } else {
            widget.changeTheme(ThemeMode.dark);
            Repository.changeTheme(true);
            showCustomToast(context, 'resume.dark'.tr());

          }
        });
      },
      child: Container(
        width: 50.0,
        height: 25.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: isSwitched ? Colors.amber : Colors.grey,
        ),
        child: Stack(
          children: [
            AnimatedAlign(
              duration: const Duration(milliseconds: 300),
              alignment: isSwitched ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.all(4.0),
                width: 20.0,
                height: 20.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Icon(
                  isSwitched ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Colors.amber,size: 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

