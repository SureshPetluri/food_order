import 'package:flutter/material.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_widgets.dart';
import 'package:food_order/jobs_show/jobs/views/auth/sign_in.dart';
import 'package:food_order/jobs_show/jobs/views/user/home.dart';
import 'forget_password.dart';
import 'sign_up.dart';

class SignUpForms extends StatefulWidget {
  const SignUpForms({Key? key}) : super(key: key);

  @override
  State<SignUpForms> createState() => _SignUpFormsState();
}

class _SignUpFormsState extends State<SignUpForms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: ValueListenableBuilder<int>(
        valueListenable: isSignInNotifier,
        builder: (context, value, child) => isSignInNotifier.value == 0
            ? const SignInScreen()
            : isSignInNotifier.value == 1
                ? const SignUpScreen()
                : const ForgetPassword(),
      ),
    );
  }
}
