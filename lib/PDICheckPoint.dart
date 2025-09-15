import 'dart:convert';

import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/PDICheckPointModel.dart';
import 'package:carinspect/UpdateCheckPoint.dart';
import 'package:carinspect/login.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Pdicheckpoint extends StatefulWidget {
  final AllcarModel car;
  Pdicheckpoint({required this.car, super.key});

  @override
  State<Pdicheckpoint> createState() => _PdicheckpointState();
}

class _PdicheckpointState extends State<Pdicheckpoint> {
  String userid = "";
  String token = "";
  List<PdiCheckPointModel> dataload = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FetchData();
  }

  Future<List<PdiCheckPointModel>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://tailpass.com/mycardoctor/api/pdi/check_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data'];
    dataload.clear();

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(PdiCheckPointModel.fromJson(index));
      }
      return dataload;
    } else {
      return dataload;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: FutureBuilder(
        future: FetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: dataload.length,
              itemBuilder: (context, index) {
                final pdidata = dataload[index]; // One car
                return Column(
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
                            child: Icon(
                              TeenyIcons.car,
                              color: Color(0xFF4e73b4),
                            ),
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
                      height: 150,
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
                                    (dataload[index].pcName.toString()),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
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
                                        'Update Check Point',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Updatecheckpoint(
                                          car: widget.car,
                                          pdi: pdidata,
                                        ),
                                      ),
                                    );
                                    print('Successfully log in ');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (dataload.isEmpty) {
            return Center(
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   backgroundColor: const Color(0xFFFF5733),
      //   foregroundColor: Colors.white,
      //   onPressed: () {
      //     Navigator.push(
      //       context,
      //       MaterialPageRoute(builder: (context) => Completeinspection()),
      //     );
      //   },
      // ),
    );
  }
}
