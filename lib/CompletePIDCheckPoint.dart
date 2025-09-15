import 'dart:convert';

import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/CompletePdiCheckPointModel.dart';
import 'package:carinspect/login.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Completepidcheckpoint extends StatefulWidget {
  final AllcarModel car;
  Completepidcheckpoint({required this.car, super.key});
  @override
  State<Completepidcheckpoint> createState() => _CompletepidcheckpointState();
}

class _CompletepidcheckpointState extends State<Completepidcheckpoint> {
  String userid = "";
  String token = "";
  List<Completepdicheckpointmodel> dataload = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FetchData();
  }

  Future<List<Completepdicheckpointmodel>> FetchData() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    const uri = "https://tailpass.com/mycardoctor/api/pdi/lead_pdi_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {"pdi_lead_id": widget.car.leadId},
    );
    var data = json.decode(responce.body);
    dataload.clear();

    // If API returns 'data': false, return a special value
    if (data['data'] == false) {
      return Future.error('no_data');
    }

    var dataarray = data['data'];
    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        dataload.add(Completepdicheckpointmodel.fromJson(index));
      }
      return dataload;
    } else {
      return dataload;
    }
  }

  @override
  Widget build(BuildContext context) {
    void Logout() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();

      await preferences.clear();

      Navigator.of(
        context,
        rootNavigator: true,
      ).pushReplacement(MaterialPageRoute(builder: (_) => Login()));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 233),
      appBar: AppBar(
        backgroundColor: const Color(0xFF4e73b4),
        automaticallyImplyLeading: false,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Text(
                "PDI Complete CheckPoint ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Logout();
                },
                child: Icon(Icons.logout, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: FetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasError && snapshot.error == 'no_data') {
            return Center(
              child: Text(
                'No data',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            );
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: dataload.length,
              itemBuilder: (context, index) {
                final car = dataload[index];
                return Column(
                  children: [
                    // ...existing code...
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 5, 121, 189),
                        ),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
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
                    // ...existing code...
                    Container(
                      margin: EdgeInsets.only(
                        left: 20,
                        right: 20,
                        top: 0,
                        bottom: 20,
                      ),
                      width: double.infinity,
                      height: 230,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: const Color.fromARGB(255, 5, 121, 189),
                        ),
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(6),
                          bottomRight: Radius.circular(6),
                        ),
                      ),
                      child: Column(
                        children: [
                          // ...existing code for Name, Remark, Image rows...
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Name",
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Remark",
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
                              InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      (dataload[index].pdiComment.toString()),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 14,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 130,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Image",
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
                              InkWell(
                                onTap: () async {},
                                child: Container(
                                  width: 150,
                                  height: 120,
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
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(6),
                                      bottomRight: Radius.circular(6),
                                      topLeft: Radius.circular(6),
                                      topRight: Radius.circular(6),
                                    ),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return Dialog(
                                            backgroundColor: Colors.transparent,
                                            insetPadding: EdgeInsets.all(0),
                                            child: Stack(
                                              children: [
                                                GestureDetector(
                                                  onTap: () => Navigator.of(
                                                    context,
                                                  ).pop(),
                                                  child: Container(
                                                    width: double.infinity,
                                                    height: double.infinity,
                                                    color: Colors.black,
                                                    child: InteractiveViewer(
                                                      child: Image.network(
                                                        "https://tailpass.com/mycardoctor/${car.pdiImageUpload.toString()}",
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Positioned(
                                                  top: 30,
                                                  right: 30,
                                                  child: IconButton(
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.white,
                                                      size: 32,
                                                    ),
                                                    onPressed: () =>
                                                        Navigator.of(
                                                          context,
                                                        ).pop(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(6),
                                        bottomRight: Radius.circular(6),
                                        topLeft: Radius.circular(6),
                                        topRight: Radius.circular(6),
                                      ),
                                      child: Image.network(
                                        "https://tailpass.com/mycardoctor/${car.pdiImageUpload.toString()}",
                                        width: 150,
                                        height: 120,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
