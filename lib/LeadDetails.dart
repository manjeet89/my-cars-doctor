import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/Used_New_Car_autofill.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Leaddetails extends StatefulWidget {
  final AllcarModel car;

  Leaddetails({required this.car, super.key});

  @override
  State<Leaddetails> createState() => _LeaddetailsState();
}

class _LeaddetailsState extends State<Leaddetails> {
  String userid = "";
  String token = "";
  bool CallingApi = false;
  String Address = "";
  bool visible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (CallingApi == false) Calling();
  }

  Calling() async {
    var country = await ContryCode();
    var state = await StateCode();
    var district = await DistrictCode();

    setState(() {
      CallingApi = true;

      widget.car.userAddress.toString() == "null" ? visible = false : true;
      Address = widget.car.userAddress.toString() == "null"
          ? ""
          : widget.car.userAddress.toString() +
                ", " +
                district +
                ", " +
                state +
                ", " +
                country +
                " ," +
                widget.car.pinCode.toString();
      print(country + " " + state + " " + district + " " + Address);
    });
  }

  DistrictCode() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    print(widget.car.stateId.toString());

    const uri = "https://tailpass.com/mycardoctor/api/pdi/district_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {"state_id": widget.car.stateId.toString()},
    );
    var data = json.decode(responce.body);
    var dataarray = data['data'];

    // If API returns 'data': false, return a special value
    if (data['data'] == false) {
      return Future.error('no_data');
    }

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        if (widget.car.districtId == index['district_id']) {
          return index['district_name'].toString();
        }
      }
    }
  }

  StateCode() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://tailpass.com/mycardoctor/api/pdi/state_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(
      Uri.parse(uri),
      headers: requestHeaders,
      body: {"country_id": widget.car.countryId.toString()},
    );
    var data = json.decode(responce.body);
    var dataarray = data['data'];

    // If API returns 'data': false, return a special value
    if (data['data'] == false) {
      return Future.error('no_data');
    }

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        if (widget.car.stateId == index['state_id']) {
          return index['state_name'].toString();
        }
      }
    }
  }

  ContryCode() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://tailpass.com/mycardoctor/api/pdi/country_list";

    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    final responce = await http.post(Uri.parse(uri), headers: requestHeaders);
    var data = json.decode(responce.body);
    var dataarray = data['data'];

    // If API returns 'data': false, return a special value
    if (data['data'] == false) {
      return Future.error('no_data');
    }

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        if (widget.car.countryId == index['country_id']) {
          return index['country_name'].toString();
        }
      }
    }
  }

  // StateCode(String string) {
  //   print(string);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 233),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4e73b4),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Customer Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
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
                          "Car  Details",
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6),
                    ), // Rounded corners
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Brand",
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.car.brandName.toString(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Type of Car",
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                (widget.car.isNewCar.toString() == "1"
                                    ? "New Car"
                                    : "Used Car"),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Car Model Type",
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
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                widget.car.modelName.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      // if (widget.car.manufacturingYear.toString() == "" ||
                      //     widget.car.manufacturingYear.toString() == "null")
                      if (widget.car.isNewCar.toString() != "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Manufacturing",
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
                            if (widget.car.manufacturingYear.toString() != "")
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    widget.car.manufacturingYear.toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              )
                            else
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
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
            ),

            Column(
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
                        81,
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
                          "Customer  Details",
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
                  margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  width: double.infinity,
                  // height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(
                        255,
                        5,
                        81,
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
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
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                StringUtils.capitalize(
                                  widget.car.userFullName.toString(),
                                ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                "Contact Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              ":",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              var _url = Uri.parse(
                                "tel:${widget.car.userPhoneNumber.toString()}",
                              );
                              if (!await launchUrl(
                                _url,
                                mode: LaunchMode.externalApplication,
                              )) {
                                throw Exception('Could not launch $_url');
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                                  widget.car.userPhoneNumber.toString(),
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
                    ],
                  ),
                ),
              ],
            ),

            Visibility(
              visible: visible,
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
                          child: Icon(
                            IonIcons.location,
                            color: Color(0xFF4e73b4),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Customer Location",
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
                    margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                    width: double.infinity,
                    height: 100,
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
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Container(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    Address,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 14,
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Colors.orangeAccent,
                          ),
                          // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                          // textStyle: MaterialStateProperty.all(
                          //   TextStyle(fontSize: 30, color: Colors.white),
                          // ),
                        ),

                        child: Text(
                          'Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          print('Successfully log in ');
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 65,
                  width: MediaQuery.of(context).size.width * 0.4,
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

                        child: Text(
                          'Inspect ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  UsedNewCarAutofill(car: widget.car),
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
          ],
        ),
      ),
    );
  }
}
