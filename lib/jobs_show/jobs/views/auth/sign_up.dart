import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/jobs_show/jobs/constants.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_drop_down_button.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_widgets.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/toast.dart';
import 'package:food_order/jobs_show/jobs/provider/registration.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController cpwController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController universityController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController referredController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController companySelectionController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String selectedGender = '';
  String age = "";
  DateTime selectDate = DateTime.now();

  void _handleRadioValueChange(String? value) {
    setState(() {
      selectedGender = value ?? "";
    });
  }

  String selectedRole = 'Employee';
  bool isSelectedGender = false;
  bool isSelectedResume = false;

  final List<String> roles = ['Employee', 'HR', "Agent"];
  String selectResume = "";
  Uint8List? _imageBytes;
  Uint8List? _resumeBytes;
  String _resume = "";
  Uint8List? _aadhaarBytes;
  String _aadhaar = "";
  Uint8List? _panCardBytes;
  String _panCard = "";
  String _image = "";
  double fileSize = 0.0;
  GlobalKey customWidgetKey = GlobalKey();

  Future<void> _pickImage(List<String> extensions, String capture) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extensions,
    );

    if (result != null && result.files.isNotEmpty) {
      if (capture == 'resume') {
        _resumeBytes = result.files.single.bytes;
        _resume = result.files.single.name;
        // knowing size of file code
        // final Uint8List bytes = result.files.first.bytes!;
        // final lengthKB = bytes.lengthInBytes / 1024;
        // setState(() {
        //   fileSize = lengthKB;
        // });
      } else if (capture == 'aadhaar') {
        _aadhaarBytes = result.files.single.bytes;
        _aadhaar = result.files.single.name;
      } else if (capture == 'panCard') {
        _panCardBytes = result.files.single.bytes;
        _panCard = result.files.single.name;
      } else {
        _imageBytes = result.files.single.bytes;
        _image = result.files.single.name;
      }
      setState(() {});
      print("fileSize is $fileSize");
    }
  }
  Future<void> _agentSignUpForm() async {
    Uri url = Uri.parse(baseUrl+agentLogin); // Replace with your upload URL
    var request = http.MultipartRequest('POST', url);

    // Add fields
    request.fields.addAll({
      "fullname": fullNameController.text,
      "username": userNameController.text,
      "email": emailController.text,
      "phone": mobileController.text,
      "age": age,
      "dob": dobController.text,
      "gender": selectedGender,
      "password": pwController.text,
      "qualification": qualificationController.text,
      "college": universityController.text,
      "state": stateController.text,
      "district": districtController.text,
      "city": cityController.text,
      "pincode": pinCodeController.text,
      "referredBy": referredController.text,
      "status": "inactive",
      "isApproved": "Pending",
      "createdBy": "self",
      "isVerified": "pending",
    });

    // Add files
    // if (_resumeBytes != null) {
    //   request.files.add(http.MultipartFile.fromBytes('resume', _resumeBytes!, filename: _resume));
    // }
    if (_aadhaarBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('aadhar', _aadhaarBytes!, filename: _aadhaar));
    }
    if (_panCardBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('panCard', _panCardBytes!, filename: _panCard));
    }
    if (_imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('profileImg', _imageBytes!, filename: _image));
    }

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Files uploaded successfully');
      // Handle success
    } else {
      print('Files upload failed');
      // Handle failure
    }
  }

  void removeOverlay() {
    dropDownOverlayEntry?.remove();
    dropDownOverlayEntry = null;
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Disable the default back button behavior
        return false;
      },
      child: GestureDetector(
        onPanDown: (up){
          removeOverlay();
        },
        child: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollStartNotification) {
              removeOverlay();
            }
            return false;
          },
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Align(
                alignment: const Alignment(0.5, -0.4),
                child: Card(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 30),
                    width: MediaQuery.sizeOf(context).width > 600
                        ? 600
                        : MediaQuery.sizeOf(context).width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "SIgn Up",
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.w800),
                              ),
                            ),
                            selectedRole == 'Agent'
                                ? Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor: Colors.blue,
                                        child: _imageBytes != null
                                            ? ClipOval(
                                                child: Image.memory(
                                                  _imageBytes!,
                                                  width: 80,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                ),
                                              )
                                            : const SizedBox(),
                                      ),
                                      Positioned(
                                          left: -1.0,
                                          bottom: -1.0,
                                          child: IconButton(
                                              color: Colors.blue,
                                              onPressed: () {
                                                _pickImage([
                                                  'jpg',
                                                  'jpeg',
                                                  'webp',
                                                  'png',
                                                ], 'profile');
                                              },
                                              icon: const Icon(
                                                Icons.mode_edit_outlined,
                                                color: Colors.black,
                                              )))
                                    ],
                                  )
                                : const SizedBox()
                          ],
                        ),
                        buildSizedBoxH10(),
                        CustomDropdownButton(
                          roleController: roleController,
                          items: roles,
                          onItemSelected: (role) {
                            setState(() {
                              selectedRole = role;
                            });
                          },
                        ),
                        buildSizedBoxH20(),
                        MediaQuery.sizeOf(context).width < 600
                            ? buildColumnBelow600()
                            : buildColumnAbove600(),
                        buildSizedBoxH40(),
                        InkWell(
                          onTap: () async {
                            if (selectedGender.isEmpty) {
                              setState(() {
                                isSelectedGender = true;
                              });
                            }
                            if (_resume.isEmpty) {
                              setState(() {
                                isSelectedResume = true;
                              });
                            }
                            if ((_formKey.currentState?.validate() ?? false) &&
                                selectedGender.isNotEmpty &&
                                _resume.isNotEmpty) {
                              Map<String, dynamic> userBody = {
                                "fullname": fullNameController.text,
                                "username": userNameController.text,
                                "email": emailController.text,
                                "phone": mobileController.text,
                                "gender": selectedGender,
                                "password": pwController.text,
                                "qualification": qualificationController.text,
                                "college": universityController.text
                              };
                              Map<String, dynamic> vendorBody = {
                                "fullname": fullNameController.text,
                                "username": userNameController.text,
                                "email": emailController.text,
                                "phone": mobileController.text,
                                "gender": selectedGender,
                                "password": pwController.text,
                                "qualification": qualificationController.text,
                                "college": universityController.text
                              };
                              Map<String, dynamic> agentBody = {
                                "profileImg": "",
                                "fullname": fullNameController.text,
                                "username": userNameController.text,
                                "email": emailController.text,
                                "phone": mobileController.text,
                                "age": age,
                                "dob": dobController.text,
                                "gender": selectedGender,
                                "password": pwController.text,
                                "qualification": qualificationController.text,
                                "college": universityController.text,
                                "aadhar": "aadhar",
                                "panCard": "pancard",
                                "district": buildDistrictField(),
                                "city": "",
                                "pincode": "",
                                "referredBy": referredController.text,
                                "status": "inactive",
                                "isApproved": "Pending",
                                "createdBy": "self",
                                "isVerified": "pending",
                              };
                              print("SignUp..body is.. $userBody");
                              String response = "";
                              if (selectedRole == "HR") {
                                response = await RegistrationRepository
                                    .vendorSignUpPost(vendorBody);
                              } else if (selectedRole == "Agent") {
                                /*response =*/ await _agentSignUpForm();
                                /* await RegistrationRepository.agentSignUpPost(
                                        agentBody);*/
                              } else {
                                response =
                                    await RegistrationRepository.userSignUpPost(
                                        userBody);
                              }

                              Map<String, dynamic> resultMap =
                                  json.decode(response);
                              showCustomToast(context, resultMap['message']);
                            }
                          },
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.8,
                            height: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue),
                            child: const Center(child: Text("Continue")),
                          ),
                        ),
                        selectedRole == "Employee"
                            ? Column(
                                children: [
                                  buildSizedBoxH10(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 1,
                                          width:
                                              MediaQuery.sizeOf(context).width >
                                                      600
                                                  ? MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.13
                                                  : MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.3,
                                          color: Colors.grey),
                                      buildSizedBoxW10(),
                                      Text("or"),
                                      buildSizedBoxW10(),
                                      Container(
                                          height: 1,
                                          width:
                                              MediaQuery.sizeOf(context).width >
                                                      600
                                                  ? MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.13
                                                  : MediaQuery.sizeOf(context)
                                                          .width *
                                                      0.3,
                                          color: Colors.grey),
                                    ],
                                  ),
                                  buildSizedBoxH10(),
                                  InkWell(
                                    onTap: () {
                                      handleGoogleSignIn();
                                    },
                                    child: Container(
                                      width: 140,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        border: Border.all(
                                            color: Colors.blue, width: 2),
                                      ),
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            "assest/img/google.png",
                                            height: 25,
                                            width: 25,
                                          ),
                                          buildSizedBoxW10(),
                                          const Text(
                                            "Google",
                                            style:
                                                TextStyle(color: Colors.blue),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : const SizedBox(),
                        buildSizedBoxH30(),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already have an account? "),
                              InkWell(
                                  onTap: () {
                                    isSignInNotifier.value = 0;
                                  },
                                  child: const Text(
                                    "Sign In",
                                    style: TextStyle(color: Colors.blue),
                                  )),
                            ]),
                        buildSizedBoxH30(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Column buildColumnAbove600() {
    return Column(children: [
      Row(
        children: [
          Flexible(
            child: buildNameField(),
          ),
          buildSizedBoxW10(),
          Flexible(
            child: buildUserNameField(
                selectedRole == 'HR' ? "Company Name" : "User Name"),
          ),
        ],
      ),
      buildSizedBoxH20(),
      Row(
        children: [
          Flexible(
            child: buildEmailField(
                selectedRole == 'HR' ? "Official mail" : "Mail"),
          ),
          buildSizedBoxW10(),
          Flexible(
            child: buildMobileField(),
          ),
        ],
      ),
      buildSizedBoxH20(),
      const Align(alignment: Alignment.centerLeft, child: Text('Gender')),
      buildGendersRow(),
      selectedGender.isEmpty && isSelectedGender
          ? buildGenderErrorAlign()
          : const SizedBox(),
      buildSizedBoxH20(),
      selectedRole == 'Agent' || selectedRole == 'HR'
          ? Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: selectedRole != 'HR'
                          ? GestureDetector(
                              onTap: () => selectDateAndTime(context),
                              child: AbsorbPointer(
                                child: buildNamesTextFormField(
                                  dobController,
                                  "Select DOB",
                                  [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'\s')),
                                  ],
                                  // icon: Icons.email_outlined,
                                  validator: (value) {
                                    age = calculateAge(
                                        selectDate, DateTime.now());
                                    print("age is $age");

                                    if (value!.isEmpty) {
                                      return "Can't be empty";
                                    } else if (int.parse(age.split(",")[0]) <
                                        17) {
                                      return "Age Should be > 18";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                            )
                          : InkWell(
                              key: customWidgetKey,
                              onTap: () {
                                overLayVideoUserInfo(context, customWidgetKey);
                              },
                              child: AbsorbPointer(child: buildCompanySelectionField()),
                            ),
                    ),
                    buildSizedBoxW10(),
                    Flexible(
                      child: buildReferredField(),
                    ),
                  ],
                ),
                buildSizedBoxH20(),
                Row(
                  children: [
                    Flexible(
                      child: buildStateField(),
                    ),
                    buildSizedBoxW10(),
                    Flexible(
                      child: buildDistrictField(),
                    ),
                  ],
                ),
                buildSizedBoxH20(),
                Row(
                  children: [
                    Flexible(
                      child: buildCityField(),
                    ),
                    buildSizedBoxW10(),
                    Flexible(
                      child: buildPinCodeField(),
                    ),
                  ],
                ),
              ],
            )
          : Row(
              children: [
                Flexible(
                  child: buildQualificationField(),
                ),
                buildSizedBoxW10(),
                Flexible(
                  child: buildUniversityField(),
                ),
              ],
            ),
      buildSizedBoxH20(),
      Row(
        children: [
          Flexible(
            child: buildPasswordValueListenable(),
          ),
          buildSizedBoxW10(),
          Flexible(
            child: buildCPWValueListenable(),
          ),
        ],
      ),
      selectedRole == 'Agent'
          ? Column(
              children: [
                buildSizedBoxH20(),
                buildUploadResumeContainer(
                    MediaQuery.sizeOf(context).width > 600
                        ? "Upload PanCard"
                        : "PanCard",
                    'panCard',
                    ['jpg', 'jpeg', 'webp', 'png'],
                    _panCard),
                buildSizedBoxH20(),
                buildUploadResumeContainer(
                    MediaQuery.sizeOf(context).width > 600
                        ? "Upload Aadhaar"
                        : "Aadhaar",
                    'aadhaar',
                    ['jpg', 'jpeg', 'webp', 'png'],
                    _aadhaar),
              ],
            )
          : const SizedBox(),
      buildSizedBoxH20(),
      // buildUploadResumeContainer(
      //     "Upload Resume", 'resume', ['pdf', 'doc', 'docx'], _resume),
    ]);
  }



  dropDownValue(String company) {
    setState(() {
      companySelectionController.text = company;
    });
  }

  Container buildUploadResumeContainer(
      String text, String type, List<String> typeList, String uploadString) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: isSelectedResume ? Colors.red : Colors.grey,
          width: 2,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0.0,
            bottom: 0.0,
            left: 0.0,
            // right: ,
            child: InkWell(
              onTap: () {
                _pickImage(typeList, type);
              },
              child: Container(
                width: MediaQuery.sizeOf(context).width < 400 ? 100 : 200,
                height: 40,
                decoration: BoxDecoration(
                  color: isSelectedResume ? Colors.red : Colors.grey,
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
                ),
                child:
                    Center(child: Text(text)), // Half of the container's width
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            bottom: 0.0,
            right: 0.0,
            left: MediaQuery.sizeOf(context).width < 400 ? 100 : 200,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(child: Text(uploadString)),
            ),
            // No color, empty container
          ),
        ],
      ),
    );
  }

  Column buildColumnBelow600() {
    return Column(children: [
      buildNameField(),
      buildSizedBoxH20(),
      buildUserNameField(selectedRole == 'HR' ? "Company Name" : "User Name"),
      buildSizedBoxH20(),
      buildEmailField(selectedRole == 'HR' ? "Official mail" : "Mail"),
      buildSizedBoxH20(),
      buildMobileField(),
      buildSizedBoxH20(),
      const Align(alignment: Alignment.centerLeft, child: Text('Gender')),
      buildGendersRow(),
      selectedGender.isEmpty && isSelectedGender
          ? buildGenderErrorAlign()
          : const SizedBox(),
      selectedRole == 'Agent' || selectedRole == 'HR'
          ? Column(
              children: [
                selectedRole != 'HR'
                    ? GestureDetector(
                  onTap: () => selectDateAndTime(context),
                  child: AbsorbPointer(
                    child: buildNamesTextFormField(
                      dobController,
                      "Select DOB",
                      [
                        FilteringTextInputFormatter.deny(
                            RegExp(r'\s')),
                      ],
                      // icon: Icons.email_outlined,
                      validator: (value) {
                        age = calculateAge(
                            selectDate, DateTime.now());
                        print("age is $age");

                        if (value!.isEmpty) {
                          return "Can't be empty";
                        } else if (int.parse(age.split(",")[0]) <
                            17) {
                          return "Age Should be > 18";
                        } else {
                          return null;
                        }
                      },
                    ),
                  ),
                )
                    : InkWell(
                  key: customWidgetKey,
                  onTap: () {
                    overLayVideoUserInfo(context, customWidgetKey);
                  },
                  child: AbsorbPointer(child: buildCompanySelectionField()),
                ),
                buildSizedBoxH20(),
                buildReferredField(),
                buildSizedBoxH20(),
                buildStateField(),
                buildSizedBoxH20(),
                buildDistrictField(),
                buildSizedBoxH20(),
                buildCityField(),
                buildSizedBoxH20(),
                buildPinCodeField(),
              ],
            )
          : Column(
              children: [
                buildSizedBoxH20(),
                buildQualificationField(),
                buildSizedBoxH20(),
                buildUniversityField(),
              ],
            ),
      buildSizedBoxH20(),
      buildPasswordValueListenable(),
      buildSizedBoxH20(),
      buildCPWValueListenable(),
      selectedRole == 'Agent'
          ? Column(
              children: [
                buildSizedBoxH20(),
                buildUploadResumeContainer(
                    MediaQuery.sizeOf(context).width > 600
                        ? "Upload PanCard"
                        : "PanCard",
                    'panCard',
                    ['jpg', 'jpeg', 'webp', 'png'],
                    _panCard),
                buildSizedBoxH20(),
                buildUploadResumeContainer(
                    MediaQuery.sizeOf(context).width > 600
                        ? "Upload Aadhaar"
                        : "Aadhaar",
                    'aadhaar',
                    ['jpg', 'jpeg', 'webp', 'png'],
                    _aadhaar),
              ],
            )
          : const SizedBox(),
      buildSizedBoxH20(),
      // buildUploadResumeContainer(
      //     "Upload Resume", 'resume', ['pdf', 'doc', 'docx'], _resume),
    ]);
  }

  ValueListenableBuilder<bool> buildCPWValueListenable() {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureNotifier,
      builder: (context, value, child) => TextFormField(
        controller: cpwController,
        validator: (text) {
          if (cpwController.text.isEmpty) {
            return "Can't be empty";
          } else if (pwController.text == cpwController.text) {
            return null;
          } else {
            return "PW & conform PW must be same";
          }
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: value,
        decoration: buildInputDecoration(
            name: "Conform Password",
            iconData: value ? Icons.lock_outline : Icons.lock_open_outlined),
      ),
    );
  }

  ValueListenableBuilder<bool> buildPasswordValueListenable() {
    return ValueListenableBuilder<bool>(
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
            iconData: value ? Icons.lock_outline : Icons.lock_open_outlined),
      ),
    );
  }

  TextFormField buildUniversityField() {
    return buildNamesTextFormField(
      universityController,
      "University",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  TextFormField buildQualificationField() {
    return buildNamesTextFormField(
      qualificationController,
      "Qualification",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  TextFormField buildReferredField() {
    return buildNamesTextFormField(
      referredController,
      "Referred",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  TextFormField buildStateField() {
    return buildNamesTextFormField(
      stateController,
      "State",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  TextFormField buildDistrictField() {
    return buildNamesTextFormField(
      districtController,
      "District",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  TextFormField buildCityField() {
    return buildNamesTextFormField(
      cityController,
      "City",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }
  TextFormField buildCompanySelectionField() {
    return buildNamesTextFormField(
      companySelectionController,
      "Company Selection",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }
  TextFormField buildPinCodeField() {
    return buildNamesTextFormField(
      pinCodeController,
      "PinCode",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      ],
      // icon: Icons.email_outlined,
      validator: FormUtils.checkValue,
    );
  }

  Align buildGenderErrorAlign() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Text(
          "Select gender",
          style: TextStyle(color: Colors.red.shade300, fontSize: 12),
        ),
      ),
    );
  }

  TextFormField buildUserNameField(String text) {
    return buildNamesTextFormField(
        userNameController,
        text,
        [
          FilteringTextInputFormatter.deny(RegExp(r'\s')),
        ],
        validator: FormUtils.checkValue);
  }

  TextFormField buildNameField() {
    return buildNamesTextFormField(
      fullNameController,
      "Full Name",
      [
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      validator: FormUtils.checkValue,
    );
  }

  Row buildGendersRow() {
    return Row(
      children: [
        Flexible(
          child: Row(
            children: [
              Radio(
                activeColor: Colors.blue,
                value: 'Male',
                groupValue: selectedGender,
                onChanged: _handleRadioValueChange,
              ),
              const Text('Male'),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              Radio(
                activeColor: Colors.blue,
                value: 'Female',
                groupValue: selectedGender,
                onChanged: _handleRadioValueChange,
              ),
              const Text('Female'),
            ],
          ),
        ),
        Flexible(
          child: Row(
            children: [
              Radio(
                activeColor: Colors.blue,
                value: 'Other',
                groupValue: selectedGender,
                onChanged: _handleRadioValueChange,
              ),
              const Text('Other'),
            ],
          ),
        ),
      ],
    );
  }

  TextFormField buildMobileField() {
    return buildNamesTextFormField(
      mobileController,
      "Mobile",
      [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9+]')),
        FilteringTextInputFormatter.deny(RegExp(r'\s')),
      ],
      icon: Icons.email_outlined,
      validator: FormUtils.fieldIsMobile,
    );
  }

  TextFormField buildEmailField(String text) {
    return buildNamesTextFormField(
      emailController,
      text,
      [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9a-zA-Z@._+-]')),
      ],
      icon: Icons.email_outlined,
      validator: FormUtils.fieldIsEmail,
    );
  }

  TextFormField buildNamesTextFormField(TextEditingController controller,
      String hint, List<TextInputFormatter> inputFormat,
      {IconData? icon, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      validator: validator,
      inputFormatters: inputFormat,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: buildInputDecoration(name: hint, iconData: icon),
    );
  }

  Future<void> selectDateAndTime(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1975),
      lastDate: DateTime.now(),
      helpText: "Select DOB",
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue,
            // Color for the header and selected date
            hintColor: Colors.blue,
            // Color for the selected date's text
            colorScheme: const ColorScheme.light(primary: Colors.blue),
            // Color for the selected date
            buttonTheme: const ButtonThemeData(
                textTheme: ButtonTextTheme.primary), // Color for buttons
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      selectDate = DateTime(
        picked.year,
        picked.month,
        picked.day,
      );
      dobController.text = DateFormat('yyyy-MM-dd').format(selectDate);
      setState(() {});
    }
  }

  String calculateAge(DateTime birthDate, DateTime now) {
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;
    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month - 1, 0).day;
    }
    if (months < 0) {
      years--;
      months += 12;
    }
    return '$years,$months,$days';
  }

  @override
  void initState() {
    roleController.text = selectedRole;
    super.initState();
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(clientId: '551750430485-e0ac2tdggo8lrm1up0dkmrvi93f9vr2s.apps.googleusercontent.com',scopes: ['email']);

  Future<void> handleGoogleSignIn() async {
    await _googleSignIn.signOut();
    try {
      final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        print('Google Sign-In Successful');
        print('User ID: ${googleSignInAccount.id}');
        print('Display Name: ${googleSignInAccount.displayName}');
        print('Email: ${googleSignInAccount.email}');
        print('Profile Picture URL: ${googleSignInAccount.photoUrl}');
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
    }
  }

  List<String> industryTypeList = [
    "Health Care",
    "Pharma",
    "Finance",
    "Hotel",
    "IT",
    "Other"
  ];
  OverlayEntry? dropDownOverlayEntry;

  overLayVideoUserInfo(BuildContext context, GlobalKey widgetKey) async {
    if (dropDownOverlayEntry != null) {
      return;
    }
    OverlayState? overlayState = Overlay.of(context);
    RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    dropDownOverlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        child: Material(
          elevation: 5.0,
          color: Colors.grey.shade300,
          borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          child: InkWell(
            hoverColor: Colors.transparent,
            focusColor: Colors.transparent,
            onTap: () {
              removeOverlay();
            },
            child: MouseRegion(
              onHover: (hover) {
              },
              onExit: (exit) {
                removeOverlay();
              },
              child: Container(
                constraints: const BoxConstraints(
                  maxHeight: 300, /*maxWidth: 350*/
                ),
                width: renderBox.size.width,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: industryTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0))),
                      child: InkWell(
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        onTap: () {
                          dropDownValue(industryTypeList[index]);
                          removeOverlay();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            industryTypeList[index],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });

    /// Inserting the OverlayEntry into the Overlay
    overlayState.insert(dropDownOverlayEntry!);
  }
  @override
  void dispose() {
    removeOverlay();
    super.dispose();
  }
}
