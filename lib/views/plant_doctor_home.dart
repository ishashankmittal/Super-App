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
  bool _isLoading = false; // Track whether the API call is in progress

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Doctor'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Feature Information Card
            Card(
              elevation: 4,
              margin: EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      'Feature Information',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This is a feature description. You can provide details about how this feature works and its benefits.',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            // Image Container Card
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Uploaded Image',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (_image != null)
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(_image!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      if (_isLoading)
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            // Classification Result Card
            Container(
              width: MediaQuery.of(context).size.width,
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Classification Result',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      if (_result != null)
                        Text(
                          '$_result',
                          style: TextStyle(fontSize: 18),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 16),
          FloatingActionButton.extended(
            onPressed: _isLoading ? null : pickImage, // Disable button during loading
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
        _isLoading = true; // Set loading to true when initiating API call
        print("Image uploaded: ${_image!.path}");
        _result = null; // Clear the previous result
      });

      // Call the API to classify the image
      classifyImage(_image!);
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

    try {
      final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      final client = http.Client();
      final response = await client.send(request).timeout(Duration(seconds: 30));
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(await response.stream.bytesToString());
        final confidence = jsonResponse['confidence']; // Extract confidence value
        setState(() {
          _result = jsonResponse['class_name'];
          _result = '$_result \n(Confidence: $confidence%)';
          _isLoading = false; // Set loading to false when API response is received
        });
      } else {
        print('Error: ${response.statusCode}');
        setState(() {
          _isLoading = false; // Set loading to false on error
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        _isLoading = false; // Set loading to false on exception
      });
    }
  }
}
