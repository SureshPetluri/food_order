import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/jobs_show/jobs/constants.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_widgets.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';
import 'package:food_order/jobs_show/jobs/views/auth/sign_up_forms.dart';
import 'package:food_order/jobs_show/jobs/views/user/details.dart';
import 'package:food_order/jobs_show/jobs/views/vendor/create_job_screen.dart';

import '../../repository/app_repository.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  bool isHome = false;
  bool onClickIsHome = false;
  bool isPharma = false;
  bool onClickIsPharma = false;
  bool isJobs = false;
  bool onClickIsJobs = false;
  bool isInterviews = false;
  bool onClickIsInterviews = false;
  bool isContact = false;
  bool isCreateJob = false;
  bool isLogin = false;
  bool onClickIsContact = false;
  bool clearSearch = false;
  bool menuColor = false;
  bool isExpand = false;
  bool isExpandJobs = false;
  bool isOpenDialog = false;

  TextEditingController searchController = TextEditingController();

  colorChange(
      {bool isHomeColor = false,
      bool onClickIsHomeColor = false,
      bool isPharmaColor = false,
      bool onClickIsPharmaColor = false,
      bool isJobsColor = false,
      bool isCreateJobColor = false,
      bool onClickIsJobsColor = false,
      bool isInterviewsColor = false,
      bool onClickIsInterviewsColor = false,
      bool onClickIsContactColor = false,
      bool isLoginColor = false,
      bool isContactColor = false}) {
    setState(() {
      isHome = isHomeColor;
      onClickIsHome = isHomeColor;
      isPharma = isPharmaColor;
      onClickIsPharma = isPharmaColor;
      isJobs = isJobsColor;
      isCreateJob = isCreateJobColor;
      onClickIsJobs = isJobsColor;
      isInterviews = isInterviewsColor;
      onClickIsInterviews = isInterviewsColor;
      isContact = isContactColor;
      onClickIsContact = isContactColor;
      isLogin = isLoginColor;
    });
  }

  bool width = false;
  final GlobalKey jobWidgetKey = GlobalKey();
  final GlobalKey pharmaWidgetKey = GlobalKey();
  final GlobalKey profileWidgetKey = GlobalKey();

  String imageUrl =
      "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=";
  String title = "Google announced the release of Flutter 3 and Dart 2.17.";
  String description =
      "On May 12, 2022, Google announced the release of Flutter 3 and Dart 2.17. This update expanded the total number of platforms supported to six, including stable support for Linux and macOS on both Intel and Apple Silicon processors On May 6, 2020, the Dart software development kit (SDK) version 2.8 and Flutter 1.17.0 were released, adding support for the Metal API which improves performance on iOS devices by approximately 50%, as well as new Material widgets and network tracking development tools.On March 3, 2021, Google released Flutter 2 during an online Flutter Engage event. This major update brought official support for web-based applications with a new Canvas Kit renderer and web specific widgets, early-access desktop application support for Windows, macOS, and Linux and improved Add-to-App APIs.[12] This release also utilized Dart 2.0 that featured sound null-safety, which caused many breaking changes and issues with many external packages; however, the Flutter team included instructions and tools to mitigate these issues.[13]";
  bool isParticularJob = false;

  @override
  void dispose() {
    removeOverlay();
    removePharmaOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.sizeOf(context).width > 1100;
    if (width) {
      menuColor = false;
    }
    return GestureDetector(
      onPanDown: (pan) {
        removeOverlay();
        removePharmaOverlay();
        removeProfileOverlay();
      },
      child: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            removeOverlay();
            removePharmaOverlay();
            removeProfileOverlay();
          }
          return false;
        },
        child: Scaffold(
          body: GestureDetector(
              onTap: () {
                removeOverlay();
                removePharmaOverlay();
              },
              child: !menuColor
                  ? SingleChildScrollView(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Card(
                          margin: EdgeInsets.zero,
                          child: SizedBox(
                              width: MediaQuery.sizeOf(context).width > 1200
                                  ? 1200
                                  : MediaQuery.sizeOf(context).width,
                              child: buildBodyColumn(
                                  context, jobWidgetKey, pharmaWidgetKey)),
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          Container(
                            width: 250,
                            height: MediaQuery.sizeOf(context).height,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              // borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  // Shadow color
                                  offset: Offset(0, 2),
                                  // Horizontal and vertical offset of the shadow
                                  blurRadius: 5,
                                  // Blur radius of the shadow
                                  spreadRadius:
                                      0, // Spread radius of the shadow
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 18.0),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.only(top: 28.0),
                                      child: Align(
                                        alignment: Alignment.topCenter,
                                        child: CircleAvatar(
                                          backgroundColor: Colors.blue,
                                          radius: 40,
                                        ),
                                      ),
                                    ),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isParticularJob = false;
                                            colorChange(
                                                onClickIsHomeColor: true);
                                          });
                                        },
                                        child: MouseRegion(
                                          onHover: (hover) {
                                            setState(() {
                                              colorChange(isHomeColor: true);
                                              removeOverlay();
                                              removePharmaOverlay();
                                            });
                                          },
                                          onExit: (exit) {
                                            onClickIsHome
                                                ? null
                                                : colorChange(
                                                    isHomeColor: false);
                                          },
                                          child: Text(
                                            "HOME",
                                            style: buildTextStyle(
                                                isHome && onClickIsHome
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                                FontWeight.w800,
                                                16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isParticularJob = false;
                                            colorChange(isJobsColor: true);
                                            isExpand = false;
                                            isExpandJobs = !isExpandJobs;
                                          });
                                        },
                                        child: MouseRegion(
                                          key: jobWidgetKey,
                                          onHover: (hover) {
                                            setState(() {});
                                          },
                                          onExit: (exit) {
                                            // colorChange(isJobsColor: false);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "PHARMA JOBS",
                                                style: buildTextStyle(
                                                    isJobs
                                                        ? Colors.blue
                                                        : Colors.grey.shade800,
                                                    FontWeight.w800,
                                                    16),
                                              ),
                                              Icon(
                                                Icons.arrow_left_outlined,
                                                color: isJobs
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    isExpandJobs
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Column(
                                              children: [
                                                paddingText("Freshers Jobs"),
                                                paddingText(
                                                    "FINANCE AND ACCOUNT JOBS"),
                                                paddingText(
                                                    "MAINTENANCE/ENGINEERING JOBS"),
                                                paddingText("MEDICAL CODING"),
                                                paddingText("PRODUCTION JOBS"),
                                                paddingText("PURCHASE JOBS"),
                                                paddingText("QA JOBS"),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isParticularJob = false;
                                          });
                                        },
                                        child: MouseRegion(
                                          onHover: (hover) {
                                            setState(() {
                                              colorChange(
                                                  isInterviewsColor: true);
                                            });
                                          },
                                          onExit: (exit) {
                                            colorChange(
                                                isInterviewsColor: false);
                                          },
                                          child: Text(
                                            "WALK-IN INTERVIEWS",
                                            style: buildTextStyle(
                                                isInterviews
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                                FontWeight.w800,
                                                16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            isParticularJob = false;
                                            colorChange(isPharmaColor: true);
                                            isExpand = !isExpand;
                                            // isExpandJobs = false;
                                          });
                                        },
                                        child: MouseRegion(
                                          key: pharmaWidgetKey,
                                          onHover: (hover) {
                                            setState(() {});
                                          },
                                          onExit: (exit) {
                                            // colorChange(isPharmaColor: false);
                                          },
                                          child: Row(
                                            children: [
                                              Text(
                                                "PHARMACOVILANCE",
                                                style: buildTextStyle(
                                                    isPharma
                                                        ? Colors.blue
                                                        : Colors.grey.shade800,
                                                    FontWeight.w800,
                                                    16),
                                              ),
                                              Icon(
                                                Icons.arrow_left_outlined,
                                                color: isPharma
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    isExpand
                                        ? Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Column(
                                              children: [
                                                paddingText(
                                                    "CLINICAL RESEARCH JOBS"),
                                                paddingText("MEDICAL CODING"),
                                                paddingText("PRODUCTION JOBS"),
                                                paddingText("PURCHASE JOBS"),
                                                paddingText("QA JOBS"),
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: MouseRegion(
                                        onHover: (hover) {
                                          setState(() {
                                            colorChange(isContactColor: true);
                                          });
                                        },
                                        onExit: (exit) {
                                          colorChange(isContactColor: false);
                                        },
                                        child: Text(
                                          "CONTACT",
                                          style: buildTextStyle(
                                              isContact
                                                  ? Colors.blue
                                                  : Colors.grey.shade800,
                                              FontWeight.w800,
                                              16),
                                        ),
                                      ),
                                    ),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const CreateJobScreen()));
                                        },
                                        child: MouseRegion(
                                          onHover: (hover) {
                                            setState(() {
                                              colorChange(
                                                  isCreateJobColor: true);
                                            });
                                          },
                                          onExit: (exit) {
                                            colorChange(
                                                isCreateJobColor: false);
                                          },
                                          child: Text(
                                            "CREATE JOB",
                                            style: buildTextStyle(
                                                isCreateJob
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                                FontWeight.w800,
                                                16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    buildSizedBoxH20(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              colorChange(isLoginColor: true);

                                              // isExpandJobs = false;
                                            });
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const SignUpForms()));
                                            /* _controller?.forward();
                                            showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                // barrierColor: Colors.transparent,
                                                // Set to true if you want to allow dismissing by tapping outside the dialog
                                                builder: (BuildContext context) {
                                                  return loginDialog();
                                                });*/
                                          },
                                          child: Text(
                                            "Sign In",
                                            style: buildTextStyle(
                                                isLogin
                                                    ? Colors.blue
                                                    : Colors.grey.shade800,
                                                FontWeight.w800,
                                                16),
                                          )),
                                    ),
                                    buildSizedBoxH40(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                              child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                                width: MediaQuery.sizeOf(context).width > 1200
                                    ? 1200
                                    : MediaQuery.sizeOf(context).width,
                                child: buildBodyColumn(
                                    context, jobWidgetKey, pharmaWidgetKey)),
                          )),
                        ],
                      ),
                    )),
        ),
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }

  Column buildBodyColumn(
      BuildContext context, GlobalKey jobWidgetKey, GlobalKey pharmaWidgetKey) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          color: Colors.blue,
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 18.0, top: 10, bottom: 8.0, right: 20.0),
            child: ListTile(
              title: Text(
                app_name,
                style: buildTextStyle(Colors.white, FontWeight.bold, 24),
              ),
              subtitle: Text(
                desc,
                overflow: TextOverflow.ellipsis,
                style:
                    buildTextStyle(Colors.grey.shade300, FontWeight.normal, 14),
              ),
              trailing: InkWell(
                key: profileWidgetKey,
                onTap: () {
                  if (AppRepository.getSignIn()) {
                    overLayProfileInfo(context, profileWidgetKey);
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpForms()));
                  }
                },
                child: ValueListenableBuilder<bool>(
                  valueListenable: ValueNotifier(AppRepository.getSignIn()),
                  builder: (BuildContext context, bool value, _) {
                    return value
                        ? const CircleAvatar(
                            backgroundColor: Colors.yellow,
                            radius: 30,
                          )
                        : const Text(
                            "Sign In",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w800,
                            ),
                          );
                  },
                ),
              ),
            ),
          ),
        ),
        Container(
            color: Colors.yellow,
            height: 60,
            child: width
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isParticularJob = false;
                              colorChange(onClickIsHomeColor: true);
                            });
                          },
                          child: MouseRegion(
                            onHover: (hover) {
                              setState(() {
                                colorChange(isHomeColor: true);
                                removeOverlay();
                                removePharmaOverlay();
                              });
                            },
                            onExit: (exit) {
                              onClickIsHome
                                  ? null
                                  : colorChange(isHomeColor: false);
                            },
                            child: Text(
                              "HOME",
                              style: buildTextStyle(
                                  isHome && onClickIsHome
                                      ? Colors.blue
                                      : Colors.grey.shade800,
                                  FontWeight.w800,
                                  16),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: buildTextStyle(
                            Colors.grey.shade400, FontWeight.normal, 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isParticularJob = false;
                            });
                          },
                          child: MouseRegion(
                            key: jobWidgetKey,
                            onHover: (hover) {
                              setState(() {
                                colorChange(isJobsColor: true);
                                overLayJobInfo(context, jobWidgetKey);
                                removePharmaOverlay();
                              });
                            },
                            onExit: (exit) {
                              colorChange(isJobsColor: false);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "PHARMA JOBS",
                                  style: buildTextStyle(
                                      isJobs
                                          ? Colors.blue
                                          : Colors.grey.shade800,
                                      FontWeight.w800,
                                      16),
                                ),
                                Icon(
                                  Icons.arrow_left_outlined,
                                  color: isJobs
                                      ? Colors.blue
                                      : Colors.grey.shade800,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: buildTextStyle(
                            Colors.grey.shade400, FontWeight.normal, 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isParticularJob = false;
                            });
                          },
                          child: MouseRegion(
                            onHover: (hover) {
                              setState(() {
                                colorChange(isInterviewsColor: true);
                                removeOverlay();
                                removePharmaOverlay();
                              });
                            },
                            onExit: (exit) {
                              colorChange(isInterviewsColor: false);
                            },
                            child: Text(
                              "WALK-IN INTERVIEWS",
                              style: buildTextStyle(
                                  isInterviews
                                      ? Colors.blue
                                      : Colors.grey.shade800,
                                  FontWeight.w800,
                                  16),
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: buildTextStyle(
                            Colors.grey.shade400, FontWeight.normal, 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isParticularJob = false;
                            });
                          },
                          child: MouseRegion(
                            key: pharmaWidgetKey,
                            onHover: (hover) {
                              setState(() {
                                colorChange(isPharmaColor: true);
                                removeOverlay();
                                overLayPharmaInfo(context, pharmaWidgetKey);
                              });
                            },
                            onExit: (exit) {
                              colorChange(isPharmaColor: false);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "PHARMACOVILANCE",
                                  style: buildTextStyle(
                                      isPharma
                                          ? Colors.blue
                                          : Colors.grey.shade800,
                                      FontWeight.w800,
                                      16),
                                ),
                                Icon(
                                  Icons.arrow_left_outlined,
                                  color: isPharma
                                      ? Colors.blue
                                      : Colors.grey.shade800,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: buildTextStyle(
                            Colors.grey.shade400, FontWeight.normal, 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: MouseRegion(
                          onHover: (hover) {
                            setState(() {
                              colorChange(isContactColor: true);
                              removeOverlay();
                              removePharmaOverlay();
                            });
                          },
                          onExit: (exit) {
                            colorChange(isContactColor: false);
                          },
                          child: Text(
                            "CONTACT",
                            style: buildTextStyle(
                                isContact ? Colors.blue : Colors.grey.shade800,
                                FontWeight.w800,
                                16),
                          ),
                        ),
                      ),
                      Text(
                        "/",
                        style: buildTextStyle(
                            Colors.grey.shade400, FontWeight.normal, 14),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const CreateJobScreen()));
                          },
                          child: MouseRegion(
                            onHover: (hover) {
                              setState(() {
                                colorChange(isCreateJobColor: true);
                                removeOverlay();
                                removePharmaOverlay();
                              });
                            },
                            onExit: (exit) {
                              colorChange(isCreateJobColor: false);
                            },
                            child: Text(
                              "CREATE JOB",
                              style: buildTextStyle(
                                  isCreateJob
                                      ? Colors.blue
                                      : Colors.grey.shade800,
                                  FontWeight.w800,
                                  16),
                            ),
                          ),
                        ),
                      ),
                      const Spacer(),
                      Container(
                          margin: const EdgeInsets.only(
                            right: 20.0,
                          ),
                          width: 250,
                          height: 40,
                          child: TextFormField(
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[a-zA-Z]')),
                              // Only letters allowed

                              // CardFormatter(sample: "**:**:**",separator: ':')
                            ],
                            controller: searchController,
                            onChanged: (text) {
                              searchController.text.isNotEmpty
                                  ? clearSearch = true
                                  : clearSearch = false;
                              setState(() {});
                            },
                            decoration: InputDecoration(
                              isDense: true,
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              suffix: clearSearch
                                  ? IconButton(
                                      onPressed: () {
                                        searchController.clear();
                                        clearSearch = false;
                                        setState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.clear,
                                        size: 15,
                                      ))
                                  : const SizedBox(),
                              border: const OutlineInputBorder(),
                              // Border for the input field
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .grey), // Border color when the input field is enabled
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors
                                        .green), // Border color when the input field is focused
                              ),
                              errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .red), // Border color when the input field has an error
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors
                                    .red), // Border color when the input field is focused and has an error
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(
                  alignment: Alignment.centerLeft,
                  color: Colors.yellow,
                  height: 60,
                  child: InkWell(
                    onTap: () {
                      setState(
                        () {
                          menuColor = !menuColor;
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.menu,
                          size: 20,
                          color: menuColor ? Colors.blue : Colors.grey.shade400,
                        ),
                        Text(
                          "Menu",
                          style: buildTextStyle(
                              menuColor ? Colors.blue : Colors.grey.shade400,
                              FontWeight.normal,
                              14),
                        )
                      ],
                    ),
                  ),
                ),
        ),
        const SizedBox(
          height: 20,
        ),
        ListTile(
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Join Our What's App Community",
                  overflow: TextOverflow.ellipsis,
                  style: buildTextStyle(Colors.blue, FontWeight.w800, 16),
                ),
              ),
            ),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.blue),
                  ),
                  onPressed: () {},
                  child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                    child: Text("Join Now"),
                  )),
            )),
        const SizedBox(
          height: 20,
        ),
        width
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                      flex: 5,
                      child: isParticularJob
                          ? const JobDetailsScreen()
                          : buildJobsListView()),
                  Flexible(
                      flex: 2,
                      child: ListView.builder(
                        itemCount: 20,
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return Text("Related Jobs");
                        },
                      )),
                ],
              )
            : isParticularJob
                ? const JobDetailsScreen()
                : buildJobsListView(),
      ],
    );
  }

  Column buildJobsListView() {
    return Column(
      children: [
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 50,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20.0,
                bottom: 20,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10.0)),
              height: 300,
              child: Column(
                children: [
                  Flexible(
                    flex: 4,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(
                            imageUrl,
                            // height: 300,
                            width: 200, fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        buildSizedBoxH10(),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                maxLines: 2,
                              ),
                              buildSizedBoxH10(),
                              Flexible(
                                child: Text(
                                  description,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              buildSizedBoxH20(),
                              MediaQuery.sizeOf(context).width > 640
                                  ? buildButtonRow(context)
                                  : const SizedBox(),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  MediaQuery.sizeOf(context).width < 640
                      ? Flexible(flex: 1, child: buildButtonRow(context))
                      : const SizedBox(),
                ],
              ), // height: 50,
            );
          },
          // separatorBuilder: (BuildContext context, int index) {
          //   return buildSizedBoxH20();
          // },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            10,
            (index) => InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: (){
                setState(() {
                  pageIndex= index + 1;
                });

              },
              child: Container(
                color:pageIndex==index+1 ?Colors.blue:Colors.transparent,
                  margin: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                  padding: EdgeInsets.all(10.0),
                  child: Text("${index+1}")),
            ),
          ),
        )
      ],
    );
  }
int pageIndex = 0;
  Row buildButtonRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: () {
              FormUtils.showProgress(context);
              Future.delayed(const Duration(seconds: 2), () {
                setState(() {
                  isParticularJob = true;
                });
                FormUtils.stopProgress(context);
              });
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text("FULL ARTICLE"),
            )),
        const SizedBox(
          width: 20,
        ),
        MediaQuery.sizeOf(context).width > 400
            ? OutlinedButton(
                onPressed: () {
                  FormUtils.showProgress(context);
                  Future.delayed(const Duration(seconds: 2), () {
                    setState(() {
                      isParticularJob = true;
                    });
                    FormUtils.stopProgress(context);
                  });
                },
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Text("NO COMMENT"),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  OverlayEntry? overlayEntry;

  overLayJobInfo(
    BuildContext context,
    GlobalKey widgetKey,
  ) async {
    if (overlayEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        child: MouseRegion(
          onHover: (hover) {},
          onExit: (exit) {
            overlayEntry?.remove();
            overlayEntry = null;
          },
          child: Material(
              elevation: 5.0,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: MouseRegion(
                onHover: (hover) {},
                onExit: (exit) {
                  overlayEntry?.remove();
                  overlayEntry = null;
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        paddingText("Freshers Jobs"),
                        paddingText("FINANCE AND ACCOUNT JOBS"),
                        paddingText("MAINTENANCE/ENGINEERING JOBS"),
                        paddingText("MEDICAL CODING"),
                        paddingText("PRODUCTION JOBS"),
                        paddingText("PURCHASE JOBS"),
                        paddingText("QA JOBS"),
                      ],
                    )),
              )),
        ),
      );
    });

    /// Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayEntry!);
  }

  OverlayEntry? overlayPharmaEntry;

  overLayPharmaInfo(BuildContext context, GlobalKey pharmaWidgetKey) async {
    if (overlayPharmaEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    RenderBox renderBox =
        pharmaWidgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    overlayPharmaEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: position.dx,
        top: position.dy + renderBox.size.height,
        child: MouseRegion(
          onHover: (hover) {},
          onExit: (exit) {
            overlayPharmaEntry?.remove();
            overlayPharmaEntry = null;
          },
          child: Material(
              elevation: 5.0,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: MouseRegion(
                onHover: (hover) {},
                onExit: (exit) {
                  overlayPharmaEntry?.remove();
                  overlayPharmaEntry = null;
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        paddingText("CLINICAL RESEARCH JOBS"),
                        paddingText("MEDICAL CODING"),
                        paddingText("PRODUCTION JOBS"),
                        paddingText("PURCHASE JOBS"),
                        paddingText("QA JOBS"),
                      ],
                    )),
              )),
        ),
      );
    });

    /// Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayPharmaEntry!);
  }

  OverlayEntry? overlayProfileEntry;

  overLayProfileInfo(
    BuildContext context,
    GlobalKey widgetKey,
  ) async {
    if (overlayProfileEntry != null) {
      return;
    }

    OverlayState? overlayState = Overlay.of(context);
    RenderBox renderBox =
        widgetKey.currentContext!.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);

    overlayProfileEntry = OverlayEntry(builder: (context) {
      return Positioned(
        left: position.dx - 150,
        top: position.dy + renderBox.size.height,
        child: MouseRegion(
          onHover: (hover) {},
          onExit: (exit) {
            removeProfileOverlay();
          },
          child: Material(
              elevation: 5.0,
              color: Colors.white,
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: MouseRegion(
                onHover: (hover) {},
                onExit: (exit) {
                  removeProfileOverlay();
                },
                child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      children: [
                        paddingText("Profile"),
                        paddingText("Related Jobs"),
                        InkWell(
                            onTap: () {

                              removeProfileOverlay();
                            },
                            child: paddingText("Notifications")),
                        paddingText("favourite jobs"),
                        paddingText("Change Password"),
                        InkWell(
                            onTap: () {
                              setState(() {
                                AppRepository.isSignIn(false);
                              });
                              removeProfileOverlay();
                            },
                            child: paddingText("Logout")),
                        // paddingText("QA JOBS"),
                      ],
                    )),
              )),
        ),
      );
    });

    /// Inserting the OverlayEntry into the Overlay
    overlayState.insert(overlayProfileEntry!);
  }

  removeProfileOverlay() {
    if (overlayProfileEntry != null) {
      overlayProfileEntry?.remove();
      overlayProfileEntry = null;
    }
  }

  Padding paddingText(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(width: 150, child: Text(text)),
    );
  }

  removeOverlay() {
    if (overlayEntry != null) {
      overlayEntry?.remove();
      overlayEntry = null;
    }
  }

  removePharmaOverlay() {
    if (overlayPharmaEntry != null) {
      overlayPharmaEntry?.remove();
      overlayPharmaEntry = null;
    }
  }
}
