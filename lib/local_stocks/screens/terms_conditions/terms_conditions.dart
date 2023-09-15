import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In app webView"),
      ),
      body: SafeArea(
        child: InAppWebView(
          initialUrlRequest: URLRequest(
            url: Uri.parse(
              'https://card-program-disclosures.s3.amazonaws.com/Testing1_0_1.pdf?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20230914T093903Z&X-Amz-SignedHeaders=host&X-Amz-Expires=86400&X-Amz-Credential=AKIAR5EXMZX7PL75CS6A%2F20230914%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=2450607f598439645f0aa267f08d94340e3a6b0917b50addb8c771df272363a8'
            ),
          ),
        ),
      ),
    );
  }
}
