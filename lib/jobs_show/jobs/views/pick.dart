import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera and Gallery Picker',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ImagePickerScreen(),
    );
  }
}

class ImagePickerScreen extends StatefulWidget {
  @override
  _ImagePickerScreenState createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  Uint8List? imageBytes;

  void _pickImageFromCamera() async {
    final html.InputElement input = html.InputElement()..type = 'file'..accept = 'image/*';
    input.click();

    input.onChange.listen((event) {
      final file = input.files!.first;
      final reader = html.FileReader();

      reader.readAsArrayBuffer(file);
      reader.onLoadEnd.listen((event) {
        if (reader.readyState == html.FileReader.DONE) {
          setState(() {
            imageBytes = reader.result as Uint8List?;
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Camera and Gallery Picker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imageBytes != null)
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.blue,
                backgroundImage: MemoryImage(imageBytes!),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickImageFromCamera,
              child: Text('Pick Image from Camera'),
            ),
          ],
        ),
      ),
    );
  }
}
