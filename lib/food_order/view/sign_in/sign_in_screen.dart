import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../biometric/local_auth.dart';
import '../custom_page_view.dart';
import '../custom_widgets/custom_widgets.dart';
import '../sign_up/sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
                Image.asset("assest/img/login_bg.jpg",fit: BoxFit.contain,),
                Image.asset("assest/img/login_bg.jpg",fit: BoxFit.contain,),
                Image.asset("assest/img/login_bg.jpg",fit: BoxFit.contain,),
              ],
            ),
            // Positioned(
            //     top: 400,
            //     child: Image.asset("assest/img/login_bg2.jpg",fit: BoxFit.fill,)),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "SIgn In",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                        )),
                    buildSizedBoxH30(),
                    TextFormField(
                      decoration:
                          buildInputDecoration("Mobile", Icons.email_outlined),
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
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue),
                        // padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: const Center(child: Text("Continue")),
                      ),
                    ),
                    buildSizedBoxH30(),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text("You don't have an account? "),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Colors.blue),
                          )),
                    ]),
                    !kIsWeb ?Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        iconSize: 70,
                        icon: const Icon(
                          Icons.fingerprint,
                          color: Colors.cyan,
                        ),
                        onPressed: (){
                         authenticationLocalAuth(context);
                        },
                      ),
                    ):const SizedBox(),
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

  authenticationLocalAuth(BuildContext context) async {
    bool authComplete = false;
    bool getLocalDetails = await LocalAuth().authenticateWithNameAndPassword();
    if (getLocalDetails ==true) {
      authComplete = await LocalAuth.authenticate();
    }
    if (authComplete) {
      // AuthRepository.loginComplete("completed");
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const ProductsGrid(),),);
    }
  }


}
