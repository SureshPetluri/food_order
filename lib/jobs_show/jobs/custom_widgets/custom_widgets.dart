import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

TextStyle buildTextStyle(Color color, FontWeight fontWeight, double size) =>
    TextStyle(color: color, fontWeight: fontWeight, fontSize: size);

class CardFormatter extends TextInputFormatter {
  final String sample;
  final String separator;
  CardFormatter({
    required this.sample,
    required this.separator
  });
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isNotEmpty) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > sample.length) return oldValue;
        if (newValue.text.length < sample.length &&
            sample[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text: "${oldValue.text}$separator${newValue.text.substring(
                newValue.text.length - 1)}",
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}


Widget appLogoWithCircularProgressBar(){
  return Center(
    child: Stack(
      alignment: Alignment.center,
      children: [
         const SizedBox(
          height: 80,
          width: 80,
          child: CircularProgressIndicator(color: Colors.blue,),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: networkImage(
              imageUrl: 'https://polytokdev.pages.dev/logos/polytok.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    ),
  );
}
Image networkImage(
    {required String imageUrl,
      double? height,
      double? width,
      BoxFit? fit,
      Color? color}) {
  return Image.network(
    imageUrl, height: height,
    fit: fit,
    width: width,
    color: color,
    errorBuilder: (_, __, ___) => Image.asset(
      'assets/images/placeholder-image.png',
      fit: fit,
      width: width,
      color: color,
    ), // Show a placeholder image in case of an error.
  );
}

SizedBox buildSizedBoxW10() =>const SizedBox(width: 10,);
SizedBox buildSizedBoxW20() =>const SizedBox(width: 20,);
SizedBox buildSizedBoxW30() =>const SizedBox(width: 30,);
SizedBox buildSizedBoxW40() =>const SizedBox(width: 40,);

SizedBox buildSizedBoxH10() =>const SizedBox(height: 10,);
SizedBox buildSizedBoxH20() =>const SizedBox(height: 20,);
SizedBox buildSizedBoxH30() =>const SizedBox(height: 30,);
SizedBox buildSizedBoxH40() =>const SizedBox(height: 40,);


ValueNotifier<bool> obscureNotifier = ValueNotifier<bool>(true);
ValueNotifier<Map> cityNotifier = ValueNotifier<Map>({});

InputDecoration buildInputDecoration({
  String? name,
  IconData? iconData,
}) {
  return InputDecoration(
    fillColor: Colors.grey.shade300,
    filled: true,
    hintText: name,
    suffixIcon:name == "Password" || name == "Conform Password" ? IconButton(
      onPressed: () {
        if (name == "Password" || name == "Conform Password") {
          obscureNotifier.value = !obscureNotifier.value;
        }
      },
      icon: Icon(iconData),
    ): Icon(iconData),
    border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.green)),
    errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red)),
    enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.blue)),
    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.yellow)),
    focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(color: Colors.red)),
  );
}

ValueNotifier<int> isSignInNotifier = ValueNotifier<int>(0);
