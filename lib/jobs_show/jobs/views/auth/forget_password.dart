import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../custom_widgets/custom_widgets.dart';
import '../../custom_widgets/form_utils.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  TextEditingController changePwController = TextEditingController();
  double height = 50;
  double width = 250;

  void onTapDown(TapDownDetails details) {
    height = 40.0;
    width = 200;
    setState(() {});
  }

  void onTapUp(TapUpDetails details) {
    height = 50.0;
    width = 250;
    setState(() {});
  }

  bool isOTPClicked = false;
  bool otpVerified = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(0.5, -0.4),
      child: Card(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          width: MediaQuery.sizeOf(context).width > 500
              ? 500
              : MediaQuery.sizeOf(context).width,
          child: Form(
            key: _formKey,
            child: !otpVerified
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          )),
                      buildSizedBoxH20(),
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
                buildSizedBoxH20(),
                InkWell(
                  focusColor: Colors.transparent,
                  overlayColor:
                  MaterialStateProperty.all<Color?>(Colors.transparent),
                  hoverColor: Colors.transparent,
                  onTapDown: onTapDown,
                  onTapUp: onTapUp,
                  onTap: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      isOTPClicked = true;
                      setState(() {});
                    }
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.easeInOut,
                    height: height,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                      boxShadow: const [
                        BoxShadow(
                            blurRadius: 30,
                            offset: Offset(20, 20),
                                  color: Colors.grey),
                              BoxShadow(
                                  blurRadius: 30,
                                  offset: Offset(-20, -20),
                                  color: Colors.white),
                            ],
                          ),
                          margin: EdgeInsets.only(bottom: 50),
                          alignment: Alignment.center,
                          width: width,
                          child:
                              Text(!isOTPClicked ? "Sent OTP" : "Resent OTP"),
                        ),
                ),
                isOTPClicked
                    ? Column(
                  children: [
                    TextFormField(
                      controller: otpController,
                      validator: FormUtils.checkValue,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp(r'[0-9a-zA-Z]')),
                      ],
                      autovalidateMode:
                      AutovalidateMode.onUserInteraction,
                      decoration: buildInputDecoration(
                          name: "Enter OTP",
                          iconData: Icons.email_outlined),
                    ),
                    buildSizedBoxH20(),
                    InkWell(
                      focusColor: Colors.transparent,
                      overlayColor: MaterialStateProperty.all<Color?>(
                          Colors.transparent),
                      hoverColor: Colors.transparent,
                      onTapDown: onTapDown,
                      onTapUp: onTapUp,
                      onTap: () async {
                        if (_formKey.currentState?.validate() ??
                                        false) {
                                      otpVerified = true;
                                      setState(() {});
                                    }
                                  },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                          boxShadow: const [
                            BoxShadow(
                                blurRadius: 30,
                                offset: Offset(20, 20),
                                color: Colors.grey),
                            BoxShadow(
                                blurRadius: 30,
                                offset: Offset(-20, -20),
                                color: Colors.white),
                          ],
                        ),
                        margin: EdgeInsets.only(bottom: 50),
                        alignment: Alignment.center,
                        width: width,
                        child: const Text("Submit"),
                      ),
                    ),
                    buildSizedBoxH20(),
                    Text("Sent OTP ${emailController.text} this mail")
                  ],
                )
                    : const SizedBox()
              ],
              )
            : Column(
                children: [
                  const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forget Password",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.w800),
                          )),
                  buildSizedBoxH40(),
                  TextFormField(
                    controller: changePwController,
                    validator: FormUtils.fieldIsPw,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                    ],
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: buildInputDecoration(
                        name: "Enter New Password", iconData: Icons.password),
                  ),
                  buildSizedBoxH40(),
                  InkWell(
                    focusColor: Colors.transparent,
                    overlayColor:
                        MaterialStateProperty.all<Color?>(Colors.transparent),
                    hoverColor: Colors.transparent,
                    onTapDown: onTapDown,
                    onTapUp: onTapUp,
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        otpVerified = false;
                        isOTPClicked = false;
                        isSignInNotifier.value = 0;
                        setState(() {});
                      }
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      height: height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.blue,
                        boxShadow: const [
                          BoxShadow(
                              blurRadius: 30,
                              offset: Offset(20, 20),
                              color: Colors.grey),
                          BoxShadow(
                              blurRadius: 30,
                              offset: Offset(-20, -20),
                              color: Colors.white),
                        ],
                          ),
                          margin: EdgeInsets.only(bottom: 50),
                          alignment: Alignment.center,
                          width: width,
                          child: const Text("Change Password"),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
