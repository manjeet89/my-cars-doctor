import 'dart:convert';

import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/LeadMainFirst.dart';
import 'package:carinspect/OneDataShowInListpage.dart';
import 'package:carinspect/PDIListOfLeadModel.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UsedNewCarAutofill extends StatefulWidget {
  final AllcarModel car;

  UsedNewCarAutofill({required this.car, super.key});

  @override
  State<UsedNewCarAutofill> createState() => _UsedNewCarAutofillState();
}

class _UsedNewCarAutofillState extends State<UsedNewCarAutofill> {
  bool _isLoading = false;
  List<PdiListOfLeadModel> pdilistoflead = [];

  FunctionCreate() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String userid = sharedprefrence.getString("Userid")!;
    String token = sharedprefrence.getString("Token")!;

    // print(widget.id);
    Map<String, String> requestHeaders = {
      'Accept': 'application/json',
      'Usertoken': token,
      'Userid': userid,
    };
    print(requestHeaders);

    const uri1 = "https://tailpass.com/mycarsdoctor/api/pdi/lead_pdi_list";

    final responce1 = await http.post(
      Uri.parse(uri1),
      headers: requestHeaders,
      body: {"pdi_lead_id": widget.car.leadId.toString()},
    );
    var data1 = json.decode(responce1.body);
    var dataarray1 = data1['data'];
    // dataarray1.clear();

    print(dataarray1);

    if (responce1.statusCode == 200) {
      if (dataarray1 == false) {
        // API returned {"data": false, ...}
        return <PdiListOfLeadModel>[];
      } else {
        for (Map<String, dynamic> index in List<Map<String, dynamic>>.from(
          dataarray1,
        )) {
          pdilistoflead.add(PdiListOfLeadModel.fromJson(index));
        }
        return pdilistoflead;
      }
    } else {
      return <PdiListOfLeadModel>[];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 219, 224, 233),

      appBar: AppBar(
        backgroundColor: const Color(0xFF4e73b4),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            "Car Details",
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
                  margin: EdgeInsets.only(left: 20, right: 20, top: 0),
                  width: double.infinity,
                  // height: 220,
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
                            width: 140,
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
                            width: 150,
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
                            width: 140,
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
                            width: 150,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Fuel Type",
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
                                widget.car.foName.toString(),
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
                            width: 140,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Transmission",
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
                                widget.car.ttName.toString(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.car.isNewCar.toString() != "1")
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 140,
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
                            Container(
                              width: 150,
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
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 65,
                  width: 150,
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
                  width: 150,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: _isLoading
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.blue,
                                ),
                              ),
                              child: Text(
                                'Next ',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              onPressed: () async {
                                setState(() {
                                  _isLoading = true;
                                });
                                List<PdiListOfLeadModel> list =
                                    await FunctionCreate();
                                setState(() {
                                  _isLoading = false;
                                });
                                int pdilistofleadindexnumber = list.length;
                                // print(
                                //   pdilistofleadindexnumber.toString() +
                                //       " why is tera",
                                // );

                                if (list.isEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Leadmainfirst(
                                        car: widget.car,
                                        pdilistoflead: list,
                                        pdilistofleadtotalnumberofIndex:
                                            pdilistofleadindexnumber,
                                        pdilistofleadnextindexnumber: 1,
                                      ),
                                    ),
                                  );
                                  // MaterialPageRoute(
                                  //   builder: (context) =>
                                  //       Onedatashowinlistpage(
                                  //         car: widget.car,
                                  //         pdilistoflead: list,
                                  //         pdilistofleadtotalnumberofIndex: -1,
                                  //         pdilistofleadnextindexnumber: -1,
                                  //       ),
                                  // ),

                                  return;
                                }
                                // print(list.length.toString());
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Leadmainfirst(
                                      car: widget.car,
                                      pdilistoflead: list,
                                      pdilistofleadtotalnumberofIndex:
                                          pdilistofleadindexnumber,
                                      pdilistofleadnextindexnumber: 1,
                                    ),
                                  ),
                                );
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
