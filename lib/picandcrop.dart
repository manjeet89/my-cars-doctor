import 'dart:io';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';

// class ImagePickCropPage extends StatefulWidget {
//   const ImagePickCropPage({super.key});

//   @override
//   State<ImagePickCropPage> createState() => _ImagePickCropPageState();
// }

// class _ImagePickCropPageState extends State<ImagePickCropPage> {
//   File? _imageFile;
//   final ImagePicker _picker = ImagePicker();

//   Future<void> _pickAndAutoCrop(ImageSource source) async {
//     final pickedFile = await _picker.pickImage(source: source);
//     if (pickedFile == null) return;

//     final originalBytes = await pickedFile.readAsBytes();
//     final originalImage = img.decodeImage(originalBytes);

//     if (originalImage != null) {
//       // Target aspect ratio = 3:4
//       int targetWidth = originalImage.width;
//       int targetHeight = (targetWidth * 4 / 3).round();

//       if (targetHeight > originalImage.height) {
//         targetHeight = originalImage.height;
//         targetWidth = (targetHeight * 3 / 4).round();
//       }

//       final cropped = img.copyCrop(
//         originalImage,
//         (originalImage.width - targetWidth) ~/ 2,
//         (originalImage.height - targetHeight) ~/ 2,
//         targetWidth,
//         targetHeight,
//       );

//       final croppedFile = File(pickedFile.path)
//         ..writeAsBytesSync(img.encodeJpg(cropped));

//       setState(() {
//         _imageFile = croppedFile;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Pick & Auto Crop (3:4)")),
//       body: Center(
//         child: _imageFile != null
//             ? Image.file(_imageFile!)
//             : const Text("No image selected"),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             heroTag: "camera",
//             onPressed: () => _pickAndAutoCrop(ImageSource.camera),
//             child: const Icon(Icons.camera_alt),
//           ),
//           const SizedBox(height: 10),
//           FloatingActionButton(
//             heroTag: "gallery",
//             onPressed: () => _pickAndAutoCrop(ImageSource.gallery),
//             child: const Icon(Icons.photo_library),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:carinspect/Uploaded_Photos/frontglass.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImagePickCropPage extends StatefulWidget {
  @override
  _ImagePickCropPageState createState() => _ImagePickCropPageState();
}

class _ImagePickCropPageState extends State<ImagePickCropPage> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    // Step 1: Pick image
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile == null) return;

    // Step 2: Crop image immediately after pick
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: pickedFile.path,
      aspectRatio: const CropAspectRatio(ratioX: 3, ratioY: 4), // square
      // cropStyle: CropStyle.rectangle, // or CropStyle.circle
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  Future<void> _pickImages(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.original,
        // ],
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = File(croppedFile.path);
        });
      }
    }
  }

  Future<void> _cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop Image',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop Image'),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _imageFile = File(croppedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Uploaded Photo Front View",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Text(
            "Frontglass",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _imageFile != null
                  ? Image.file(_imageFile!)
                  : Text("No image selected"),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Remark',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                hintText: '',
              ),
            ),
          ),
          SizedBox(
            height: 65,
            width: 250,
            child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                    // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                    // textStyle: MaterialStateProperty.all(
                    //   TextStyle(fontSize: 30, color: Colors.white),
                    // ),
                  ),

                  child: Text(
                    'Submit & Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Frontglass()),
                    );
                    print('Successfully log in ');
                  },
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.white,

            heroTag: "camera",
            onPressed: () => _pickImage(ImageSource.camera),
            child: Icon(Icons.camera_alt, color: Colors.green),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: "gallery",
            onPressed: () => _pickImage(ImageSource.gallery),
            child: Icon(Icons.photo_library, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
