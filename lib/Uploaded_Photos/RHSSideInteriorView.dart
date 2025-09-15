import 'dart:io';
import 'package:carinspect/Uploaded_Photos/EngineCompatment.dart';
import 'package:carinspect/Uploaded_Photos/FrontRHSsideTriangleView.dart';
import 'package:carinspect/Uploaded_Photos/FrontView.dart';
import 'package:carinspect/Uploaded_Photos/RearRHSTyre.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Rhssideinteriorview extends StatefulWidget {
  const Rhssideinteriorview({Key? key}) : super(key: key);

  @override
  State<Rhssideinteriorview> createState() => _RhssideinteriorviewState();
}

class _RhssideinteriorviewState extends State<Rhssideinteriorview> {
  File? _croppedImage;
  TextEditingController Remark = TextEditingController();

  Future<void> _pickAndCropImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3), // Fixed 4:3
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true, // lock to 4:3
          ),
          IOSUiSettings(aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedImage = File(croppedFile.path);
        });
      }
    }
  }

  Future<void> _pickAndCropcamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 3), // Fixed 4:3
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            lockAspectRatio: true, // lock to 4:3
          ),
          IOSUiSettings(aspectRatioLockEnabled: true),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _croppedImage = File(croppedFile.path);
          // print(croppedFile.path.toString()+"Heree");
        });
      }
    }
  }

  uploadData() async {
    try {
      SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
      String userid = sharedprefrence.getString("Userid")!;
      String token = sharedprefrence.getString("Token")!;
      Dio dio = Dio();
      DateTime now = DateTime.now();

      FormData formData = FormData.fromMap({
        'pet_image': await MultipartFile.fromFile(
          _croppedImage!.path,
          filename: "${now.second}.jpg",
        ),
        'remark': Remark.text.toString(),
      });

      Response response = await dio.post(
        'https://inkc.in/api/dog/pedigree_dog_registration',
        data: formData,
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Usertoken': token,
            'Userid': userid,
          },
        ),
      );

      if (response.statusCode == 200) {
        print(response.toString());

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SuccessFully Registered')),
        );
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Something went wrong')));
        print('something worng');
      }

      // images = File(pickedFile.path);
    } catch (e) {
      print('no image  selected false');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF4e73b4),
        title: Center(
          child: Text(
            "Uploaded Photo RHS Side Interior View",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "RHS Side Interior View",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: _croppedImage != null
                  ? Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                      width: double.infinity,
                      // height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(
                            255,
                            5,
                            121,
                            189,
                          ), // Border color
                          // width: 2.0, // Border width
                        ),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(
                          Radius.circular(6),
                        ), // Rounded corners
                      ),
                      child: Image.file(_croppedImage!),
                    )
                  : Text("No image selected"),
            ),
          ),
          Padding(
            //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextField(
              controller: Remark,
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
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 65,
                width: 250,
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Colors.green,
                        ),
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
                        // uploadData();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Rearrhstyre(),
                          ),
                        );
                        print('Successfully log in ');
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: _pickAndCropImage,
              child: const Icon(Icons.photo_library),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              onPressed: _pickAndCropcamera,
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ],
      ),
    );
  }
}
