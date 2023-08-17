import 'package:flutter/material.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';

import '../../custom_widgets/custom_widgets.dart';

class CreateJobScreen extends StatefulWidget {
  const CreateJobScreen({Key? key}) : super(key: key);

  @override
  State<CreateJobScreen> createState() => _CreateJobScreenState();
}

class _CreateJobScreenState extends State<CreateJobScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
          title: const Text(
            "Create Job",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Card(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: SizedBox(
                width: MediaQuery.sizeOf(context).width > 1000
                    ? 1000
                    : MediaQuery.sizeOf(context).width,
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.checkValue,
                        decoration: buildInputDecoration(
                          name: "title",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.checkValue,
                        decoration: buildInputDecoration(
                          name: "Image Url",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: (text){
                          if(text == null){
                            return "can't be empty";
                          }else if(text.length > 250){
                            return null;
                          }else{
                            return "Description above 250 letters";
                          }
                        },
                        minLines: 10,
                        maxLines: 20,
                        decoration: buildInputDecoration(
                          name: "Company Description",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.checkValue,
                        decoration: buildInputDecoration(
                          name: "qualifications",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.checkValue,
                        decoration: buildInputDecoration(
                          name: "DRIVE DETAILS",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.checkValue,
                        decoration: buildInputDecoration(
                          name: "Position",
                        ),
                      ),
                      buildSizedBoxH20(),
                      TextFormField(
                        validator: FormUtils.fieldIsEmail,
                        decoration: buildInputDecoration(
                          name: "Email",
                        ),
                      ),
                      buildSizedBoxH40(),
                      InkWell(
                        focusColor: Colors.transparent,
                        overlayColor: MaterialStateProperty.all<Color?>(
                            Colors.transparent),
                        hoverColor: Colors.transparent,
                        onTapDown: onTapDown,
                        onTapUp: onTapUp,
                        onTap: () async {
                          if (_formKey.currentState?.validate() ?? false) {}
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
