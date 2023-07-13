import 'package:flutter/material.dart';
import 'package:food_order/view/sign_in/sign_in_screen.dart';

import '../custom_widgets/custom_widgets.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.orange,
        body: WillPopScope(
          onWillPop: () async {
            // Disable the default back button behavior
            return false;
          },
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    Image.asset(
                      "assest/img/login_bg.jpg",
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assest/img/login_bg.jpg",
                      fit: BoxFit.contain,
                    ),
                    Image.asset(
                      "assest/img/login_bg.jpg",
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_outlined,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "SIgn Up",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w800),
                            )),
                        buildSizedBoxH30(),
                        TextFormField(
                          decoration: buildInputDecoration(
                              "Email", Icons.email_outlined),
                        ),
                        buildSizedBoxH30(),
                        TextFormField(
                          decoration: buildInputDecoration(
                              "Mobile", Icons.email_outlined),
                        ),
                        buildSizedBoxH30(),
                        ValueListenableBuilder<bool>(
                          valueListenable: obscureNotifier,
                          builder: (context, value, child) => TextFormField(
                            obscureText: value,
                            decoration: buildInputDecoration(
                                "Password",
                                value
                                    ? Icons.lock_outline
                                    : Icons.lock_open_outlined),
                          ),
                        ),
                        buildSizedBoxH30(),
                        ValueListenableBuilder<bool>(
                          valueListenable: obscureNotifier,
                          builder: (context, value, child) => TextFormField(
                            obscureText: value,
                            decoration: buildInputDecoration(
                                "Conform Password",
                                value
                                    ? Icons.lock_outline
                                    : Icons.lock_open_outlined),
                          ),
                        ),
                        buildSizedBoxH40(),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignInScreen(),
                                ));
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
                              const Text("Already have an account? "),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()));
                                  },
                                  child: Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ])
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }
}
