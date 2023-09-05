import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PlantDoctorHome extends StatefulWidget {
  const PlantDoctorHome({super.key});

  @override
  State<PlantDoctorHome> createState() => _PlantDoctorHomeState();
}

 class _PlantDoctorHomeState extends State<PlantDoctorHome> {
//   bool _loading=true;
//   late File _image;
//   late List _output;
//   final picker =Imagepicker();
//
//   @override
//   void initState(){
//     super.initState();
//     loadModel().then((value){
//       setState(() {
//
//       });
//     });
//   }
//
//   @override
//   void dispose(){
//     super.dispose();
//     Tflite.close();
//   }
//
//   classifyImage(File)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plant Doctor'),
      ),
      body: ListView(
        children: [

        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(width: 16),
          // An example of the extended floating action button.
          //
          // https://m3.material.io/components/extended-fab/specs#686cb8af-87c9-48e8-a3e1-db9da6f6c69b
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
      File image = File(pickedFile!.path);
      // Now you have the selected image in the 'image' variable
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

}
