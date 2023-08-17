import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_widgets.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/toast.dart';
import 'package:food_order/jobs_show/jobs/provider/login.dart';
import 'package:food_order/jobs_show/jobs/repository/app_repository.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Disable the default back button behavior
          return false;
        },
        child: Form(
            key: _formKey,
            child: Align(
              alignment: const Alignment(0.5, -0.4),
              child: Card(
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
                  width: MediaQuery.sizeOf(context).width > 500
                      ? 500
                      : MediaQuery.sizeOf(context).width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "SIgn In",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          )),
                      buildSizedBoxH30(),
                      TextFormField(
                        controller: emailController,
                        validator: FormUtils.fieldIsEmail,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9a-zA-Z@._+-]')),
                        ],
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: buildInputDecoration(
                            name: "Email", iconData: Icons.email_outlined),
                      ),
                      buildSizedBoxH30(),
                      ValueListenableBuilder<bool>(
                        valueListenable: obscureNotifier,
                        builder: (context, value, child) => TextFormField(
                          controller: pwController,
                          validator: FormUtils.fieldIsPw,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r'\s')),
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          obscureText: value,
                          decoration: buildInputDecoration(
                              name: "Password",
                              iconData: value
                                  ? Icons.lock_outline
                                  : Icons.lock_open_outlined),
                        ),
                      ),
                      Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              isSignInNotifier.value = 2;
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Forget Password",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          )),
                      buildSizedBoxH40(),
                      InkWell(
                        onTap: () async {


                          if ((_formKey.currentState?.validate() ?? false)) {

                            AppRepository.isSignIn(true);
                            Map<String, dynamic> body = {
                              "email": emailController.text,
                              "password": pwController.text
                            };
                            // var response =
                            //  await http.post(Uri.parse("http://localhost:8081/user/login"), body: body);
                            String? response =
                                await LoginRepository.userLoginPost(body);
                            Map<String, dynamic> resultMap =
                                json.decode(response ?? "{}");
                            showCustomToast(context, resultMap['message']);
                            // print("userLoginPost......${response.body}");
                            print("userLoginPost......$response");


                            showCustomToast(context, "ddd");

                          }
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue),
                          // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                          child: const Center(child: Text("Continue")),
                        ),
                      ),
                      buildSizedBoxH30(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("You don't have an account? "),
                            InkWell(
                                onTap: () {
                                  isSignInNotifier.value = 1;
                                  /*Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));*/
                                },
                                child: const Text(
                                  "Sign Up",
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ]),
                    ],
                  ),
                ),
              ),
            ),),);
  }

  @override
  void initState() {
    super.initState();
  }
}
