import 'package:flutter/material.dart';

import '../custom_page_view.dart';
import '../custom_widgets/custom_widgets.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Align(alignment: Alignment.centerLeft, child: Text("SIgn In")),
          buildSizedBoxH30(),
          TextFormField(
            decoration: buildInputDecoration("Mobile", Icons.email_outlined),
          ),
          buildSizedBoxH30(),
          ValueListenableBuilder<bool>(
            valueListenable: obscureNotifier,
            builder: (context, value, child) => TextFormField(
              obscureText: value,
              decoration: buildInputDecoration("Password",
                  value ? Icons.lock_outline : Icons.lock_open_outlined),
            ),
          ),
          buildSizedBoxH40(),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductsGrid(),
                  ));
            },
            child: Container(
              width: MediaQuery.sizeOf(context).width * 0.8,
              height: 45,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: const Center(child: Text("Continue")),
            ),
          ),
          buildSizedBoxH30(),
          const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("You don't have an account? "),
            Text("Sign Up"),
          ])
        ],
      ),
    ));
  }

  @override
  void initState() {
    getAddress();
    super.initState();
  }
}
