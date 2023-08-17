import 'dart:typed_data';
import 'dart:convert';
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'File Upload Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FileUploadScreen(),
    );
  }
}

class FileUploadScreen extends StatefulWidget {
  @override
  _FileUploadScreenState createState() => _FileUploadScreenState();
}

class _FileUploadScreenState extends State<FileUploadScreen> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String selectedGender = 'Male';
  TextEditingController pwController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController universityController = TextEditingController();

  Uint8List? resumeBytes;
  Uint8List? aadharBytes;
  Uint8List? panCardBytes;
  Uint8List? imageBytes;

  Future<void> _uploadFile() async {
    Uri url = Uri.parse("http://example.com/upload"); // Replace with your upload URL
    var request = http.MultipartRequest('POST', url);

    // Add fields
    request.fields.addAll({
      "fullname": fullNameController.text,
      "username": userNameController.text,
      "email": emailController.text,
      "phone": mobileController.text,
      "gender": selectedGender,
      "password": pwController.text,
      "qualification": qualificationController.text,
      "college": universityController.text,
    });

    // Add files
    if (resumeBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('resume', resumeBytes!, filename: 'resume.pdf'));
    }
    if (aadharBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('aadhar', aadharBytes!, filename: 'aadhar.pdf'));
    }
    if (panCardBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('panCard', panCardBytes!, filename: 'panCard.pdf'));
    }
    if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes!, filename: 'image.jpg'));
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

  // Helper function to handle file selection
  Future<void> _selectFile(String acceptType, Function(Uint8List) setBytes) async {
    final input = FileUploadInputElement()..accept = acceptType;
    input.click();
    input.onChange.listen((event) async {
      final files = input.files;
      if (files!.isNotEmpty) {
        final reader = FileReader();
        reader.readAsArrayBuffer(files[0]);
        reader.onLoadEnd.listen((event) {
          if (reader.readyState == FileReader.DONE) {
            setState(() {
              setBytes(Uint8List.fromList(reader.result as List<int>));
            });
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Upload Example'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(controller: fullNameController, decoration: InputDecoration(labelText: 'Full Name')),
              TextField(controller: userNameController, decoration: InputDecoration(labelText: 'Username')),
              TextField(controller: emailController, decoration: InputDecoration(labelText: 'Email')),
              TextField(controller: mobileController, decoration: InputDecoration(labelText: 'Mobile')),
              DropdownButton<String>(
                value: selectedGender,
                onChanged: (newValue) {
                  setState(() {
                    selectedGender = newValue!;
                  });
                },
                items: <String>['Male', 'Female', 'Other'].map<DropdownMenuItem<String>>(
                      (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
              TextField(controller: pwController, decoration: InputDecoration(labelText: 'Password')),
              TextField(controller: qualificationController, decoration: InputDecoration(labelText: 'Qualification')),
              TextField(controller: universityController, decoration: InputDecoration(labelText: 'University')),
              ElevatedButton(
                onPressed: () => _selectFile('application/pdf', (bytes) => resumeBytes = bytes),
                child: Text('Choose Resume PDF'),
              ),
              ElevatedButton(
                onPressed: () => _selectFile('application/pdf', (bytes) => aadharBytes = bytes),
                child: Text('Choose Aadhar PDF'),
              ),
              ElevatedButton(
                onPressed: () => _selectFile('application/pdf', (bytes) => panCardBytes = bytes),
                child: Text('Choose Pan Card PDF'),
              ),
              ElevatedButton(
                onPressed: () => _selectFile('image/*', (bytes) => imageBytes = bytes),
                child: Text('Choose Image'),
              ),
              ElevatedButton(
                onPressed: _uploadFile,
                child: Text('Upload'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
