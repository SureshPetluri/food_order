import 'package:flutter/material.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({Key? key,}): super(key: key);

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(jobDetails["title"]),
          Text(jobDetails["companyDes"]),
          Align(
            alignment: Alignment.center,
            child: Image.network(
              jobDetails["companyLogo"],
              height: 300,
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: jobDetails["qualifications"].length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                  minLeadingWidth: 0.0,
                  contentPadding: EdgeInsets.zero,
                  minVerticalPadding: 0.0,
                  visualDensity:
                      const VisualDensity(vertical: 0.0, horizontal: 0.0),
                  leading: const Icon(
                    Icons.arrow_right,
                    color: Colors.grey,
                    size: 25,
                  ),
                  title: Text(jobDetails["qualifications"][index]));
            },
          ),
          Text(jobDetails["WALK-IN DRIVE DETAILS"]['Walk-In Date']),
          Text(jobDetails["WALK-IN DRIVE DETAILS"]['Time']),
          Text(jobDetails["WALK-IN DRIVE DETAILS"]['Venue']),
          Text(jobDetails["Position"]),
          Text(jobDetails["preferredLocation"]),
          Text(jobDetails["Position"]),
          ListView.builder(
            shrinkWrap: true,
            itemCount: jobDetails["relatedPosts"].length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(jobDetails["relatedPosts"][index]["companyName"]),
                  Text(jobDetails["relatedPosts"][index]["title"]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

Map<String, dynamic> jobDetails = {
  "title": "Granules India Limited – Freshers Walk-In Drive on 2nd Aug’ 2023",
  "companyLogo":
      "https://media.istockphoto.com/id/1146517111/photo/taj-mahal-mausoleum-in-agra.jpg?s=612x612&w=0&k=20&c=vcIjhwUrNyjoKbGbAQ5sOcEzDUgOfCsm9ySmJ8gNeRk=",
  "companyDes":
      "Granules India Limited is an Indian pharmaceutical manufacturing company based in Hyderabad, India. Granules manufactures several off-patent drugs, including Paracetamol, Ibuprofen, Metformin and Guaifenesin, on a large scale for customers in the regulated and rest of the world markets. Granules India Limited is a vertically integrated Indian pharmaceutical company based at Hyderabad. We are among the few pharmaceutical companies in the world to be present in the manufacturing of entire value chain from Active Pharmaceutical Ingredients (APIs), Pharmaceutical Formulation Intermediates (PFIs) and Finished Dosages (FDs). Our products are being distributed to over 250 customers in regulated and semi-regulated markets and their global presence extends to over 60 countries.",
  "drive": "Walk-In Drive For Freshers @ Granules India Limited",
  "qualifications": [
    "ITI, Diploma, B.Sc Freshers for Production",
    "Should be willing to work in shifts",
    "More than 50% in all academics",
    "Passed out years – 2020/21/22/23",
    "Age Limit – 18-22 years",
    "Experience 2-8"
  ],
  "WALK-IN DRIVE DETAILS": {
    "Walk-In Date": "2nd August, 2023",
    "Time": "10.00 AM – 1.00 PM",
    "Venue":
        "Granules India Limited, Gagillapur Village, Dundigal-Gandimaisamma Mandal, Medchal-Malkhajgiri District – 500 043, Telangana, India",
  },
  "Position": "Officer to Sr. Executive/freshers",
  "preferredLocation": "Hyderabad,Banglore",
  "relatedPosts": [
    {
      "companyName": "Granules India Limited",
      "title":
          "Freshers Walk-In Drive for QC / QA Departments on 6th July’ 2023",
      "link": "url",
    },
    {
      "companyName": ": Warren Remedies",
      "title":
          "Walk-In Interviews for Production, QC, QA, Warehouse, EHS, Safety, Machine Operators on 4th Aug’ 2023",
      "link": "url",
    },
    {
      "companyName": "Micro Labs Limited",
      "title": "Walk-In Interviews on 5th August’ 2023",
      "link": "url",
    },
    {
      "companyName": "TATA Consultancy Services",
      "title": "Walk-In Drive for Freshers on 5th August’ 2023 @ Hyderabad",
      "link": "url",
    }
  ]
};
