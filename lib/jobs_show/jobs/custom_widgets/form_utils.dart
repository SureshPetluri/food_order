import 'package:flutter/material.dart';

import 'custom_circularprogress_indicator.dart';

/// Utility Class for forms and validations.
class FormUtils {
  /// Method to validate whether field is empty or not.
  static String? nullOnFieldNotEmpty(value) =>
      value.isEmpty ? 'can\'t be empty' : null;

  static String? checkValue(String? value) {
    if (value == null || value.isEmpty) {
      return 'can\'t be empty';
    }
    return null;
  }

  /// Method to validate whether the field is of email or not.
  static String? fieldIsEmail(String? value) {
    var isEmptyValidation = nullOnFieldNotEmpty(value);
    var boolStringNotEmpty = isEmptyValidation == null;
    if (boolStringNotEmpty) {
      if (isEmail(value!)) {
        return null;
      }
      return 'Invalid email';
    }
    return isEmptyValidation;
  }

  static String? fieldIsMobile(String? value) {
    var isEmptyValidation = nullOnFieldNotEmpty(value);
    var boolStringNotEmpty = isEmptyValidation == null;
    if (boolStringNotEmpty) {
      if ((value?.length ?? 0) >9 && RegExp(r'[0-9]').hasMatch(value ?? "")) {
        return null;
      }
      return 'Ph number must be 10 or above';
    }
    return isEmptyValidation;
  }
 static bool isEmail(String s) => hasMatch(s,
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');


  static bool hasMatch(String? value, String pattern) {
    return (value == null) ? false : RegExp(pattern).hasMatch(value);
  }
   static bool isPassword(String s) => hasMatch(s, r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');

  /// Method to validate whether the field is of password or not.
  static String? fieldIsPw(String? value) {
    var isEmptyValidation = nullOnFieldNotEmpty(value);
    var boolStringNotEmpty = isEmptyValidation == null;
    if (boolStringNotEmpty) {
      if (isPassword(value!) && !RegExp(r'\s+').hasMatch(value)) {
        return null;
      }
      return 'Min 8 chars: 1 uppercase, 1 lowercase letter & 1 digit';
    }
    return isEmptyValidation;
  }

  static void hideKeyboard(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static showProgress(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.transparent,
        // Set to true if you want to allow dismissing by tapping outside the dialog
        builder: (BuildContext context) {
          return const Dialog(
               backgroundColor: Colors.transparent, // Make the dialog background transparent
              child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: AppIndefiniteProgressDialog()));
        });
  }

  static stopProgress(BuildContext context) {
    Navigator.pop(context);
  }
// static getStopProgress() {
//   Get.back();
// }
}
