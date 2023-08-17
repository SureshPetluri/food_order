import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/custom_widgets.dart';
import 'package:food_order/jobs_show/jobs/custom_widgets/form_utils.dart';

class ManagementScreen extends StatefulWidget {
  const ManagementScreen({Key? key}) : super(key: key);

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {
  List<Map<String, dynamic>> userDetails = [
    {
      'name': 'User',
      'email': 'User@gnan.in',
      "block": false,
    },
    {
      'name': 'User',
      'email': 'User@gnan.in',
      "block": false,
    },
    {
      'name': 'User',
      'email': 'User@gnan.in',
      "block": false,
    },
    {
      'name': 'User',
      'email': 'User@gnan.in',
      "block": false,
    },
    {
      'name': 'User',
      'email': 'User@gnan.in',
      "block": true,
    },
  ];
  List<Map<String, dynamic>> agentDetails = [
    {
      'name': 'Agent',
      'email': 'Agent@gnan.in',
      "block": true,
    },
    {
      'name': 'Agent',
      'email': 'Agent@gnan.in',
      "block": false,
    },
    {
      'name': 'Agent',
      'email': 'Agent@gnan.in',
      "block": false,
    },
    {
      'name': 'Agent',
      'email': 'Agent@gnan.in',
      "block": false,
    },
    {
      'name': 'Agent',
      'email': 'Agent@gnan.in',
      "block": true,
    },
  ];
  List<Map<String, dynamic>> vendorDetails = [
    {
      'name': 'Vendor',
      'email': 'Vendor@gnan.in',
      "block": false,
    },
    {
      'name': 'Vendor',
      'email': 'Vendor@gnan.in',
      "block": false,
    },
    {
      'name': 'Vendor',
      'email': 'Vendor@gnan.in',
      "block": false,
    },
    {
      'name': 'Vendor',
      'email': 'Vendor@gnan.in',
      "block": true,
    },
    {
      'name': 'Vendor',
      'email': 'Vendor@gnan.in',
      "block": true,
    },
  ];
  int role = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.sizeOf(context).width > 1200
              ? 1200
              : MediaQuery.sizeOf(context).width,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _togglePressed(isUser: true, number: 0);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: !isUserPressed ? Colors.black12 : Colors.blue,
                            boxShadow: !isUserPressed
                                ? innerBoxShadow
                                : outerBoxShadow),
                        alignment: Alignment.center,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("User"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _togglePressed(isVendor: true, number: 1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(color: Colors.black12),
                            color: !isVendorPressed ? Colors.black12 : Colors.blue,
                            boxShadow: !isVendorPressed
                                ? innerBoxShadow
                                : outerBoxShadow),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Vendor"),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _togglePressed(isAgent: true, number: 2);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            color: !isAgentPressed ? Colors.black12 : Colors.blue,
                            boxShadow: !isAgentPressed
                                ? innerBoxShadow
                                : outerBoxShadow),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Agent"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              buildSizedBoxH10(),
              ListView.builder(
                  itemCount: role == 2
                      ? agentDetails.length
                      : role == 1
                          ? vendorDetails.length
                          : userDetails.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    var data = role == 2
                        ? agentDetails[index]
                        : role == 1
                            ? vendorDetails[index]
                            : userDetails[index];
                    return Card(
                      margin: EdgeInsets.zero,
                      child: InkWell(
                        onTap: () {
                          _showAlertDialog(context, data['name']);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: Colors.blue,
                              ),
                              buildSizedBoxW20(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data['name']),
                                  Text(data['email']),
                                ],
                              ),
                              const Spacer(),
                              IconButton(
                                icon: Icon(Icons.person,
                                    color:
                                        data['block'] ? Colors.red : Colors.blue,
                                    size: 25.0),
                                onPressed: () {
                                  setState(() {
                                    data['block'] = !data['block'];
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  bool isAgentPressed = false;
  bool isVendorPressed = false;
  bool isUserPressed = true;

  void _togglePressed(
      {bool isUser = false,
      bool isVendor = false,
      bool isAgent = false,
      int number = 0}) {
    setState(() {
      role = number;
      isAgentPressed = isAgent;
      isVendorPressed = isVendor;
      isUserPressed = isUser;
    });
  }

  bool isBlock = false;

  void _showAlertDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.zero,
          title: Text('$title Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: FormUtils.fieldIsEmail,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9a-zA-Z@._+-]')),
                ],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: buildInputDecoration(
                    name: "Email", iconData: Icons.email_outlined),
              ),
              buildSizedBoxH10(),
              Text('This is an example of an AlertDialog.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }
  /// Outer box shadow list
  List<BoxShadow> outerBoxShadow = [
    // const BoxShadow(
    //   color: Colors.grey,
    //   offset: Offset(
    //     5.0,
    //     5.0,
    //   ),
    //   blurRadius: 5.0,
    //   spreadRadius: 0.5,
    // ), //BoxShadow
    // const BoxShadow(
    //   color: Colors.white,
    //   offset: Offset(0.0, 0.0),
    //   blurRadius: 0.0,
    //   spreadRadius: 0.0,
    // ),
  ];

  /// Inner box shadow list
  List<BoxShadow> innerBoxShadow = [
    const BoxShadow(
      color: Colors.grey,
      blurRadius: 0.0,
      spreadRadius: 0.5,
    ), //BoxShadow
    const BoxShadow(
      color: Colors.white,
      offset: Offset(5.0, 5.0),
      blurRadius: 5.0,
      spreadRadius: 0.5,
    ),
  ];
}
