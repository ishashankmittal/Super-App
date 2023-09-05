import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantDoctorHome extends StatefulWidget {
  const PlantDoctorHome({Key? key}) : super(key: key);

  @override
  State<PlantDoctorHome> createState() => _PlantDoctorHomeState();
}

class _PlantDoctorHomeState extends State<PlantDoctorHome> {
  File? _image; // Declare _image as nullable
  String? _result; // Store the classification result

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Doctor'),
      ),
      body: ListView(
        children: [
      Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (_image != null) // Display the selected image
            Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          if (_result != null) // Display the classification result
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Classification Result: $_result',
                style: TextStyle(fontSize: 18),
              ),
            ),
        ],
      ),
    ),
      ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: pickImage,
            label: const Text('Upload Image'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
    );

  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        print("Image uploaded: ${_image!.path}");
      });

      // Call the API to classify the image
      await classifyImage(_image!);
    } else {
      // Handle the case where the user didn't select an image
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('No Image Selected'),
            content: Text('You didn\'t select an image.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> classifyImage(File image) async {
    final apiUrl = 'https://apitest-6gkp.onrender.com/classify'; // Replace with your API URL

    // Create a multipart request for sending the image
    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        setState(() {
          _result = jsonResponse['class_name'];
          final confidence = jsonResponse['confidence']; // Extract confidence value
          _result = '$_result (Confidence: $confidence)';
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
