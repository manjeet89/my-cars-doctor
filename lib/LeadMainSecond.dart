import 'dart:convert';
import 'dart:io';
import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/Home.dart';
import 'package:carinspect/LeadMainThired.dart';
import 'package:carinspect/PDICheckPointModel.dart';
import 'package:carinspect/PDIListOfLeadModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Leadmainsecond extends StatefulWidget {
  final AllcarModel car;
  final List<PdiCheckPointModel> dataload;
  final dataloadCurrentIndex;
  final List<PdiListOfLeadModel> pdilistoflead;
  final int pdilistofleadtotalnumberofIndex;
  final int pdilistofleadnextindexnumber;

  Leadmainsecond({
    required this.car,
    required this.dataload,
    required this.dataloadCurrentIndex,

    required this.pdilistoflead,
    required this.pdilistofleadtotalnumberofIndex,
    required this.pdilistofleadnextindexnumber,
    super.key,
  });

  @override
  State<Leadmainsecond> createState() => _LeadmainsecondState();
}

class _LeadmainsecondState extends State<Leadmainsecond> {
  String userid = "";
  String token = "";
  String pcIsBoth = "0";
  bool stop = false;
  int currentIndex = 0; // start from first checkpoint

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

  MarkedLeadAsPdiComplete(String value) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri =
        "https://tailpass.com/mycarsdoctor/api/pdi/mark_completed_pdi_check_point";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {"lead_status": value, "lead_id": widget.car.leadId.toString()},
    );
    var data = json.decode(responce.body);

    // If API returns 'data': false, return a special value

    if (responce.statusCode == 200) {
      return data['message'];
    } else {
      return data['message'];
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
        widget.dataload[widget.dataloadCurrentIndex]; // Get specific index here
    for (
      int i = 0;
      i < widget.pdilistoflead.length && i < widget.dataload.length;
      i++
    ) {
      print(
        widget.pdilistoflead[i].pcId.toString() +
            " ==" +
            widget.dataload[widget.dataloadCurrentIndex].pcId.toString(),
      );
      if (widget.pdilistoflead[i].pcId.toString() ==
          widget.dataload[widget.dataloadCurrentIndex].pcId.toString()) {
        // Autofill Remark from pdicomment
        Remark.text = widget.pdilistoflead[i].pdiComment?.toString() ?? "";
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
              ],
            ),
          ),
          body: SingleChildScrollView(
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
                  height: 550,
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
                              : widget.pdilistoflead[i].pdiImageUpload !=
                                        null &&
                                    widget.pdilistoflead[i].pdiImageUpload
                                        .toString()
                                        .isNotEmpty
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
                                  child: Image.network(
                                    "https://tailpass.com/mycarsdoctor/${widget.pdilistoflead[i].pdiImageUpload}",
                                  ),
                                )
                              : Text("No image selected"),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.all(8.0),
                      //   child: Center(
                      //     child: (() {
                      //       // Check if dataload[index].pcId is present in any pdilistoflead.pcId
                      //       final currentPcId = widget
                      //           .dataload[currentIndex]
                      //           .pcId
                      //           .toString();
                      //       final hasPcId = widget.pdilistoflead.any(
                      //         (item) => item.pcId.toString() == currentPcId,
                      //       );
                      //       if (!hasPcId) {
                      //         return SizedBox.shrink();
                      //       }
                      //       if (_croppedImage != null) {
                      //         return Container(
                      //           margin: EdgeInsets.only(
                      //             left: 20,
                      //             right: 20,
                      //             top: 0,
                      //           ),
                      //           width: double.infinity,
                      //           decoration: BoxDecoration(
                      //             border: Border.all(
                      //               color: const Color.fromARGB(
                      //                 255,
                      //                 5,
                      //                 121,
                      //                 189,
                      //               ),
                      //             ),
                      //             color: const Color.fromARGB(
                      //               255,
                      //               255,
                      //               255,
                      //               255,
                      //             ),
                      //             borderRadius: BorderRadius.all(
                      //               Radius.circular(6),
                      //             ),
                      //           ),
                      //           child: Image.file(_croppedImage!),
                      //         );
                      //       } else if (widget.pdilistofleadtotalnumberofIndex ==
                      //           -1) {
                      //         return Text("");
                      //       } else {
                      //         final pdilistIndex = widget.pdilistoflead
                      //             .indexWhere(
                      //               (item) =>
                      //                   item.pcId.toString() == currentPcId,
                      //             );
                      //         if (pdilistIndex != -1 &&
                      //             widget
                      //                     .pdilistoflead[pdilistIndex]
                      //                     .pdiImageUpload !=
                      //                 null) {
                      //           return Text(
                      //             widget.pdilistoflead[pdilistIndex].pdiComment
                      //                 .toString(),
                      //           );
                      //           // Image.network(
                      //           //   "https://tailpass.com/mycarsdoctor/${widget.pdilistoflead[pdilistIndex].pdiImageUpload.toString()}",
                      //           // );
                      //         } else {
                      //           return Text("");
                      //         }
                      //       }
                      //     })(),
                      //   ),
                      // ),
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
                      if (widget.dataloadCurrentIndex >=
                          widget.dataload.length - 1)
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
                                        String res =
                                            await MarkedLeadAsPdiComplete("2");

                                        print(response.toString());

                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text(res)),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 65,
                              width: 160,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
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
                                      String pcIsBoth = pdidata.pcIsBoth
                                          .toString();

                                      bool isImageValid =
                                          _croppedImage.toString() != "null";
                                      bool isRemarkValid =
                                          Remark.text.isNotEmpty;

                                      bool shouldProceed = false;

                                      switch (pcIsBoth) {
                                        case "0": // Both image and remark are required
                                          if (!isImageValid) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Image is required',
                                                ),
                                              ),
                                            );
                                          } else if (!isRemarkValid) {
                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Remark is required',
                                                ),
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
                                                content: Text(
                                                  'Image is required',
                                                ),
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
                                                content: Text(
                                                  'Remark is required',
                                                ),
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
                                              content: Text(
                                                'Invalid input type',
                                              ),
                                            ),
                                          );
                                          break;
                                      }
                                      if (shouldProceed) {
                                        try {
                                          SharedPreferences sharedprefrence =
                                              await SharedPreferences.getInstance();
                                          String userid = sharedprefrence
                                              .getString("Userid")!;
                                          String token = sharedprefrence
                                              .getString("Token")!;
                                          Dio dio = Dio();
                                          DateTime now = DateTime.now();
                                          print(_croppedImage.toString());

                                          FormData formData = FormData.fromMap({
                                            if (_croppedImage.toString() !=
                                                "null")
                                              'pdi_image_upload':
                                                  await MultipartFile.fromFile(
                                                    _croppedImage!.path,
                                                    filename:
                                                        "${now.second}.jpg",
                                                  ),
                                            'pdi_comment': Remark.text
                                                .toString(),
                                            'pdi_partner_id': userid,
                                            'pdi_lead_id': widget.car.leadId
                                                .toString(),
                                            'pdi_check_id': pdidata.pcId
                                                .toString(),
                                          });

                                          Response response = await dio.post(
                                            'https://tailpass.com/mycarsdoctor/api/pdi/update_pdi_check_point',
                                            data: formData,
                                            options: Options(
                                              headers: {
                                                'Content-type':
                                                    'application/json',
                                                'Accept': 'application/json',
                                                'Usertoken': token,
                                                'Userid': userid,
                                              },
                                            ),
                                          );

                                          if (response.statusCode == 200) {
                                            String res =
                                                await MarkedLeadAsPdiComplete(
                                                  "1",
                                                );

                                            print(response.toString());

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              SnackBar(content: Text(res)),
                                            );
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Leadmainsecond(
                                                  car: widget.car,
                                                  dataload: widget.dataload,
                                                  dataloadCurrentIndex:
                                                      widget
                                                          .dataloadCurrentIndex +
                                                      1,
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
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         Seconddatashowinlistpage(
                                            //           car: widget.car,
                                            //           dataload: widget.dataload,
                                            //           currentIndex:
                                            //               widget.currentIndex + 1,
                                            //           pdilistofleadnextindexnumber:
                                            //               widget
                                            //                   .pdilistofleadnextindexnumber +
                                            //               1,
                                            //           pdilistofleadtotalnumberofIndex:
                                            //               widget
                                            //                   .pdilistofleadtotalnumberofIndex,
                                            //           pdilistoflead:
                                            //               widget.pdilistoflead,
                                            //         ),
                                            //   ),
                                            // );
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
                            SizedBox(
                              height: 65,
                              width: 120,
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                            Colors.orangeAccent,
                                          ),
                                    ),

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          'Skip',
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Leadmainthired(
                                            car: widget.car,
                                            dataload: widget.dataload,
                                            dataloadCurrentIndex:
                                                widget.dataloadCurrentIndex + 1,
                                            pdilistofleadnextindexnumber:
                                                widget
                                                    .pdilistofleadnextindexnumber +
                                                1,
                                            pdilistofleadtotalnumberofIndex: widget
                                                .pdilistofleadtotalnumberofIndex,
                                            pdilistoflead: widget.pdilistoflead,
                                          ),
                                        ),
                                      );
                                    },

                                    // print('Successfully log in ');
                                    // },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                      // ElevatedButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => Leadmainthired(
                      //           car: widget.car,
                      //           dataload: widget.dataload,
                      //           dataloadCurrentIndex:
                      //               widget.dataloadCurrentIndex + 1,
                      //           pdilistofleadnextindexnumber:
                      //               widget.pdilistofleadnextindexnumber + 1,
                      //           pdilistofleadtotalnumberofIndex:
                      //               widget.pdilistofleadtotalnumberofIndex,
                      //           pdilistoflead: widget.pdilistoflead,
                      //         ),
                      //       ),
                      //     );
                      //   },
                      //   child: Text("submit"),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
    // If no match found, show a single message
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
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 20),
              width: double.infinity,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 5, 121, 189), // Border color
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
              margin: EdgeInsets.only(left: 20, right: 20, top: 0, bottom: 20),
              width: double.infinity,
              height: 550,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 5, 121, 189), // Border color
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
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Center(
                  //     child: (() {
                  //       // Check if dataload[index].pcId is present in any pdilistoflead.pcId
                  //       final currentPcId = widget
                  //           .dataload[currentIndex]
                  //           .pcId
                  //           .toString();
                  //       final hasPcId = widget.pdilistoflead.any(
                  //         (item) => item.pcId.toString() == currentPcId,
                  //       );
                  //       if (!hasPcId) {
                  //         return SizedBox.shrink();
                  //       }
                  //       if (_croppedImage != null) {
                  //         return Container(
                  //           margin: EdgeInsets.only(
                  //             left: 20,
                  //             right: 20,
                  //             top: 0,
                  //           ),
                  //           width: double.infinity,
                  //           decoration: BoxDecoration(
                  //             border: Border.all(
                  //               color: const Color.fromARGB(
                  //                 255,
                  //                 5,
                  //                 121,
                  //                 189,
                  //               ),
                  //             ),
                  //             color: const Color.fromARGB(
                  //               255,
                  //               255,
                  //               255,
                  //               255,
                  //             ),
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(6),
                  //             ),
                  //           ),
                  //           child: Image.file(_croppedImage!),
                  //         );
                  //       } else if (widget.pdilistofleadtotalnumberofIndex ==
                  //           -1) {
                  //         return Text("");
                  //       } else {
                  //         final pdilistIndex = widget.pdilistoflead
                  //             .indexWhere(
                  //               (item) =>
                  //                   item.pcId.toString() == currentPcId,
                  //             );
                  //         if (pdilistIndex != -1 &&
                  //             widget
                  //                     .pdilistoflead[pdilistIndex]
                  //                     .pdiImageUpload !=
                  //                 null) {
                  //           return Text(
                  //             widget.pdilistoflead[pdilistIndex].pdiComment
                  //                 .toString(),
                  //           );
                  //           // Image.network(
                  //           //   "https://tailpass.com/mycarsdoctor/${widget.pdilistoflead[pdilistIndex].pdiImageUpload.toString()}",
                  //           // );
                  //         } else {
                  //           return Text("");
                  //         }
                  //       }
                  //     })(),
                  //   ),
                  // ),
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
                  if (widget.dataloadCurrentIndex >= widget.dataload.length - 1)
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Image is required'),
                                      ),
                                    );
                                  } else if (!isRemarkValid) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Remark is required'),
                                      ),
                                    );
                                  } else {
                                    shouldProceed = true;
                                  }
                                  break;

                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                    'pdi_lead_id': widget.car.leadId.toString(),
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
                                    String res = await MarkedLeadAsPdiComplete(
                                      "2",
                                    );

                                    print(response.toString());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res)),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Home(),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Something went wrong'),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Image is required'),
                                      ),
                                    );
                                  } else if (!isRemarkValid) {
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
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
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Remark is required'),
                                      ),
                                    );
                                  } else {
                                    shouldProceed = true;
                                  }
                                  break;

                                default:
                                  ScaffoldMessenger.of(context).showSnackBar(
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
                                    'pdi_lead_id': widget.car.leadId.toString(),
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
                                    String res = await MarkedLeadAsPdiComplete(
                                      "1",
                                    );

                                    print(response.toString());

                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(res)),
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Leadmainthired(
                                          car: widget.car,
                                          dataload: widget.dataload,
                                          dataloadCurrentIndex:
                                              widget.dataloadCurrentIndex + 1,
                                          pdilistofleadnextindexnumber:
                                              widget
                                                  .pdilistofleadnextindexnumber +
                                              1,
                                          pdilistofleadtotalnumberofIndex: widget
                                              .pdilistofleadtotalnumberofIndex,
                                          pdilistoflead: widget.pdilistoflead,
                                        ),
                                      ),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         Seconddatashowinlistpage(
                                    //           car: widget.car,
                                    //           dataload: widget.dataload,
                                    //           currentIndex:
                                    //               widget.currentIndex + 1,
                                    //           pdilistofleadnextindexnumber:
                                    //               widget
                                    //                   .pdilistofleadnextindexnumber +
                                    //               1,
                                    //           pdilistofleadtotalnumberofIndex:
                                    //               widget
                                    //                   .pdilistofleadtotalnumberofIndex,
                                    //           pdilistoflead:
                                    //               widget.pdilistoflead,
                                    //         ),
                                    //   ),
                                    // );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Something went wrong'),
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

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => Leadmainthired(
                  //           car: widget.car,
                  //           dataload: widget.dataload,
                  //           dataloadCurrentIndex:
                  //               widget.dataloadCurrentIndex + 1,
                  //           pdilistofleadnextindexnumber:
                  //               widget.pdilistofleadnextindexnumber + 1,
                  //           pdilistofleadtotalnumberofIndex:
                  //               widget.pdilistofleadtotalnumberofIndex,
                  //           pdilistoflead: widget.pdilistoflead,
                  //         ),
                  //       ),
                  //     );
                  //   },
                  //   child: Text("submit"),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
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
