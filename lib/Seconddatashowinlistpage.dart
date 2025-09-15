import 'dart:convert';
import 'dart:io';

import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/Home.dart';
import 'package:carinspect/PDICheckPointModel.dart';
import 'package:carinspect/PDIListOfLeadModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class Seconddatashowinlistpage extends StatefulWidget {
  final AllcarModel car;
  final List<PdiCheckPointModel> dataload;
  final List<PdiListOfLeadModel> pdilistoflead;
  final int pdilistofleadtotalnumberofIndex;
  final int pdilistofleadnextindexnumber;

  int currentIndex;
  Seconddatashowinlistpage({
    required this.car,
    required this.dataload,
    required this.currentIndex,

    required this.pdilistoflead,
    required this.pdilistofleadtotalnumberofIndex,
    required this.pdilistofleadnextindexnumber,
    super.key,
  });

  @override
  State<Seconddatashowinlistpage> createState() =>
      _SeconddatashowinlistpageState();
}

class _SeconddatashowinlistpageState extends State<Seconddatashowinlistpage> {
  String userid = "";
  String token = "";
  List<PdiCheckPointModel> dataload = [];
  String pcIsBoth = "0";
  bool stop = false;
  int currentIndex = 0; // start from first checkpoint
  // late Future<List<PdiCheckPointModel>> _futureData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (stop == false) FetchData();
    // _futureData = FetchData(); // Run only once
  }

  Future<List<PdiCheckPointModel>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://tailpass.com/mycarsdoctor/api/pdi/check_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    // dataload.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(PdiCheckPointModel.fromJson(index));
      }
      setState(() {
        stop = true;
      });
      return dataload;
    } else {
      return dataload;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final pdidata =
        widget.dataload[widget.currentIndex]; // Get specific index here
    print(widget.currentIndex.toString() + widget.dataload.length.toString());
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 233),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4e73b4),
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "PDI Check Point",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // Center(
            //   child: InkWell(
            //     onTap: () {
            //       Logout();
            //     },
            //     child: Icon(Icons.logout, color: Colors.white),
            //   ),
            // ),
          ],
        ),
      ),
      body:
          // FutureBuilder(
          //   future: _futureData,
          //   builder: (context, snapshot) {
          //     if (snapshot.hasData) {
          //       return ListView.builder(
          //         itemCount: 1,
          //         itemBuilder: (context, index) {
          //           // final pdidata = dataload[index]; // One car
          //           return
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  width: double.infinity,
                  height: 40,
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
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6),
                    ), // Rounded corners
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /// ZondIcons' Icon
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(TeenyIcons.car, color: Color(0xFF4e73b4)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Owner Details",
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 0,
                    bottom: 20,
                  ),
                  width: double.infinity,
                  height: 450,
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 130,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Check Point Name",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (pdidata.pcName.toString()),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: _croppedImage != null
                              ? Container(
                                  margin: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    top: 0,
                                  ),
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
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: (() {
                            // Check if dataload[index].pcId is present in any pdilistoflead.pcId
                            final currentPcId = widget
                                .dataload[currentIndex]
                                .pcId
                                .toString();
                            final hasPcId = widget.pdilistoflead.any(
                              (item) => item.pcId.toString() == currentPcId,
                            );
                            if (!hasPcId) {
                              return SizedBox.shrink();
                            }
                            if (_croppedImage != null) {
                              return Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 0,
                                ),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromARGB(
                                      255,
                                      5,
                                      121,
                                      189,
                                    ),
                                  ),
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(6),
                                  ),
                                ),
                                child: Image.file(_croppedImage!),
                              );
                            } else if (widget.pdilistofleadtotalnumberofIndex ==
                                -1) {
                              return Text("");
                            } else {
                              final pdilistIndex = widget.pdilistoflead
                                  .indexWhere(
                                    (item) =>
                                        item.pcId.toString() == currentPcId,
                                  );
                              if (pdilistIndex != -1 &&
                                  widget
                                          .pdilistoflead[pdilistIndex]
                                          .pdiImageUpload !=
                                      null) {
                                return Text(
                                  widget.pdilistoflead[pdilistIndex].pdiComment
                                      .toString(),
                                );
                                // Image.network(
                                //   "https://tailpass.com/mycarsdoctor/${widget.pdilistoflead[pdilistIndex].pdiImageUpload.toString()}",
                                // );
                              } else {
                                return Text("");
                              }
                            }
                          })(),
                        ),
                      ),
                      if (pdidata.pcIsBoth.toString() == "0" ||
                          pdidata.pcIsBoth.toString() == "2")
                        Padding(
                          //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                          padding: EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
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
                      if (widget.currentIndex >= widget.dataload.length - 1)
                        SizedBox(
                          height: 65,
                          width: 200,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue,
                                  ),
                                  // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                                  // textStyle: MaterialStateProperty.all(
                                  //   TextStyle(fontSize: 30, color: Colors.white),
                                  // ),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Finish',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  String pcIsBoth = pdidata.pcIsBoth.toString();

                                  bool isImageValid =
                                      _croppedImage.toString() != "null";
                                  bool isRemarkValid = Remark.text.isNotEmpty;

                                  bool shouldProceed = false;

                                  switch (pcIsBoth) {
                                    case "0": // Both image and remark are required
                                      if (!isImageValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Image is required'),
                                          ),
                                        );
                                      } else if (!isRemarkValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Remark is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    case "1": // Only image is required
                                      if (!isImageValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Image is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    case "2": // Only remark is required
                                      if (!isRemarkValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Remark is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    default:
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Invalid input type'),
                                        ),
                                      );
                                      break;
                                  }
                                  if (shouldProceed) {
                                    try {
                                      SharedPreferences sharedprefrence =
                                          await SharedPreferences.getInstance();
                                      String userid = sharedprefrence.getString(
                                        "Userid",
                                      )!;
                                      String token = sharedprefrence.getString(
                                        "Token",
                                      )!;
                                      Dio dio = Dio();
                                      DateTime now = DateTime.now();
                                      print(_croppedImage.toString());

                                      FormData formData = FormData.fromMap({
                                        if (_croppedImage.toString() != "null")
                                          'pdi_image_upload':
                                              await MultipartFile.fromFile(
                                                _croppedImage!.path,
                                                filename: "${now.second}.jpg",
                                              ),
                                        'pdi_comment': Remark.text.toString(),
                                        'pdi_partner_id': userid,
                                        'pdi_lead_id': widget.car.leadId
                                            .toString(),
                                        'pdi_check_id': pdidata.pcId.toString(),
                                      });

                                      Response response = await dio.post(
                                        'https://tailpass.com/mycarsdoctor/api/pdi/update_pdi_check_point',
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

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'SuccessFully Uploaded',
                                            ),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => Home(),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Something went wrong',
                                            ),
                                          ),
                                        );
                                        print('something worng');
                                      }

                                      // images = File(pickedFile.path);
                                    } catch (e) {
                                      print('no image  selected false');
                                    }
                                  }
                                },
                              ),
                            ),
                          ),
                        )
                      else
                        SizedBox(
                          height: 65,
                          width: 200,
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                    Colors.blue,
                                  ),
                                  // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                                  // textStyle: MaterialStateProperty.all(
                                  //   TextStyle(fontSize: 30, color: Colors.white),
                                  // ),
                                ),

                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Save & Next',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                                onPressed: () async {
                                  String pcIsBoth = pdidata.pcIsBoth.toString();

                                  bool isImageValid =
                                      _croppedImage.toString() != "null";
                                  bool isRemarkValid = Remark.text.isNotEmpty;

                                  bool shouldProceed = false;

                                  switch (pcIsBoth) {
                                    case "0": // Both image and remark are required
                                      if (!isImageValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Image is required'),
                                          ),
                                        );
                                      } else if (!isRemarkValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Remark is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    case "1": // Only image is required
                                      if (!isImageValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Image is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    case "2": // Only remark is required
                                      if (!isRemarkValid) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Remark is required'),
                                          ),
                                        );
                                      } else {
                                        shouldProceed = true;
                                      }
                                      break;

                                    default:
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text('Invalid input type'),
                                        ),
                                      );
                                      break;
                                  }
                                  if (shouldProceed) {
                                    try {
                                      SharedPreferences sharedprefrence =
                                          await SharedPreferences.getInstance();
                                      String userid = sharedprefrence.getString(
                                        "Userid",
                                      )!;
                                      String token = sharedprefrence.getString(
                                        "Token",
                                      )!;
                                      Dio dio = Dio();
                                      DateTime now = DateTime.now();
                                      print(_croppedImage.toString());

                                      FormData formData = FormData.fromMap({
                                        if (_croppedImage.toString() != "null")
                                          'pdi_image_upload':
                                              await MultipartFile.fromFile(
                                                _croppedImage!.path,
                                                filename: "${now.second}.jpg",
                                              ),
                                        'pdi_comment': Remark.text.toString(),
                                        'pdi_partner_id': userid,
                                        'pdi_lead_id': widget.car.leadId
                                            .toString(),
                                        'pdi_check_id': pdidata.pcId.toString(),
                                      });

                                      Response response = await dio.post(
                                        'https://tailpass.com/mycarsdoctor/api/pdi/update_pdi_check_point',
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

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'SuccessFully Uploaded',
                                            ),
                                          ),
                                        );
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Seconddatashowinlistpage(
                                                  car: widget.car,
                                                  dataload: widget.dataload,
                                                  currentIndex:
                                                      widget.currentIndex + 1,
                                                  pdilistofleadnextindexnumber:
                                                      widget
                                                          .pdilistofleadnextindexnumber +
                                                      1,
                                                  pdilistofleadtotalnumberofIndex:
                                                      widget
                                                          .pdilistofleadtotalnumberofIndex,
                                                  pdilistoflead:
                                                      widget.pdilistoflead,
                                                ),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              'Something went wrong',
                                            ),
                                          ),
                                        );
                                        print('something worng');
                                      }

                                      // images = File(pickedFile.path);
                                    } catch (e) {
                                      print('no image  selected false');
                                    }
                                  }
                                },
                                // onPressed: () {
                                //   print(
                                //     widget.currentIndex.toString() +
                                //         "worklinh" +
                                //         widget.dataload.length.toString(),
                                //   );

                                //   Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //       builder: (context) =>
                                //           Thireddatashowinlistpage(
                                //             car: widget.car,
                                //             dataload: widget.dataload,
                                //             currentIndex: widget.currentIndex + 1,
                                //           ),
                                //     ),
                                //   );
                                //   print('Successfully log in ');
                                // },
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),

      //         },
      //       );
      //     } else if (dataload.isEmpty) {
      //       return Center(
      //         child: Column(
      //           children: [
      //             Center(
      //               child: Padding(
      //                 padding: const EdgeInsets.all(12.0),
      //                 child: CircularProgressIndicator(),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     } else {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //   },
      // ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (pdidata.pcIsBoth.toString() == "0" ||
              pdidata.pcIsBoth.toString() == "1")
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                onPressed: _pickAndCropImage,
                child: const Icon(Icons.photo_library),
              ),
            ),
          if (pdidata.pcIsBoth.toString() == "0" ||
              pdidata.pcIsBoth.toString() == "1")
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
