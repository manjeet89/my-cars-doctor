import 'dart:convert';

import 'package:basic_utils/basic_utils.dart';
import 'package:carinspect/AllCarModel.dart';
import 'package:carinspect/CompleteInspection.dart';
import 'package:carinspect/CompletePIDCheckPoint.dart';
import 'package:carinspect/LeadDetails.dart';
import 'package:carinspect/login.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Subscribe to route changes
    final ModalRoute? route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    // Unsubscribe from route changes
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPopNext() {
    // Called when user comes back to this page
    setState(() {
      FetchData("");
    });
  }

  // Add a RouteObserver to main.dart and pass it to MaterialApp
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();
  String userid = "";
  String token = "";
  String Title = "All Customer List";
  List<AllcarModel> dataload = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FetchData();
  }

  Future<List<AllcarModel>> FetchData(String value) async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    userid = sharedprefrence.getString("Userid")!;
    token = sharedprefrence.getString("Token")!;

    // print(widget.id);

    const uri = "https://tailpass.com/mycarsdoctor/api/pdi/new_car_list";

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

    // If API returns 'data': false, return a special value
    if (data['data'] == false) {
      return Future.error('no_data');
    }

    if (responce.statusCode == 200) {
      for (Map<String, dynamic> index in dataarray) {
        if (index['lead_status'].toString() == value) {
          dataload.add(AllcarModel.fromJson(index));
        } else if (value == "") {
          dataload.add(AllcarModel.fromJson(index));
        }
      }
      return dataload;
    } else {
      return dataload;
    }
  }

  // Example list data
  final List<Map<String, dynamic>> userList = [
    {
      "id": 1,
      "name": "John Doe",
      "type": "old",
      "Number": 9562341753,
      "Status": "Ongoing",
    },
    {
      "id": 2,
      "name": "Jane Smith",
      "type": "new",
      "Number": 9562379253,
      "Status": "Pending",
    },
    {
      "id": 3,
      "name": "Sam Wilson",
      "type": "new",
      "Number": 9641368422,
      "Status": "Pending",
    },
  ];

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

    return WillPopScope(
      onWillPop: () async {
        bool? exit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App'),
            content: Text('Do you want to exit the app?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          ),
        );
        return exit ?? false;
      },
      child: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            Title = "All Customer List";
            dataload.clear();
          });
          FetchData("").then((value) {
            setState(() {
              dataload = value;
            });
          });
        },
        child: Scaffold(
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
                    "Home",
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
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.only(left: 20, right: 20, top: 5),
                width: double.infinity,
                // height: 40,
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
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6),
                  ), // Rounded corners
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// ZondIcons' Icon
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Icon(TeenyIcons.car, color: Color(0xFF4e73b4)),
                    // ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        Title,
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Title == "Ongoing Customer List"
                              ? Colors.orange
                              : Title == "Complete Customer List"
                              ? Colors.blue
                              : Title == "Pending Customer List"
                              ? Colors.greenAccent
                              : const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
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
                                  color: const Color.fromARGB(255, 37, 35, 35),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Title = "All Customer List";
                                        dataload.clear();
                                      });
                                      FetchData("").then((value) {
                                        setState(() {
                                          dataload = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          child: Text(
                                            " A ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            " All ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
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
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Title = "Ongoing Customer List";
                                        dataload.clear();
                                      });
                                      FetchData("1").then((value) {
                                        setState(() {
                                          dataload = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          child: Text(
                                            " O ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            " Ongoing ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.all(8),
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
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Title = "Complete Customer List";
                                        dataload.clear();
                                      });
                                      FetchData("2").then((value) {
                                        setState(() {
                                          dataload = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          child: Text(
                                            " C ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            " Complete ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Container(
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
                                  color: Colors.greenAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(6),
                                    topRight: Radius.circular(6),
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ), // Rounded corners
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        Title = "Pending Customer List";
                                        dataload.clear();
                                      });
                                      FetchData("0").then((value) {
                                        setState(() {
                                          dataload = value;
                                        });
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 20,
                                          child: Text(
                                            " P ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          " : ",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        Container(
                                          width: 70,
                                          child: Text(
                                            " Pending ",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w800,
                                              fontSize: 12,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
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
              Expanded(
                child: FutureBuilder(
                  future: Title == "Ongoing Customer List"
                      ? FetchData("1")
                      : Title == "Complete Customer List"
                      ? FetchData("2")
                      : Title == "Pending Customer List"
                      ? FetchData("0")
                      : FetchData(""),
                  builder: (context, snapshot) {
                    if (snapshot.hasError && snapshot.error == 'no_data') {
                      return ListView.builder(
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Center(
                            child: Text(
                              'No data',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: dataload.length,
                        itemBuilder: (context, index) {
                          final car = dataload[index]; // One car
                          return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                  left: 20,
                                  right: 20,
                                  top: 5,
                                ),
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
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
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
                                // height: 230,
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
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ), // Rounded corners
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.3,
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
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              StringUtils.capitalize(
                                                dataload[index].userFullName
                                                    .toString(),
                                              ),
                                              // (dataload[index].userFullName.toString().replaceFirst(title[0], title[0].toUpperCase())),
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.3,
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
                                        InkWell(
                                          onTap: () async {
                                            // var _url = Uri.parse(
                                            //   "tel:${car.userPhoneNumber.toString()}",
                                            // );
                                            // if (!await launchUrl(
                                            //   _url,
                                            //   mode: LaunchMode.externalApplication,
                                            // )) {
                                            //   throw Exception(
                                            //     'Could not launch $_url',
                                            //   );
                                            // }
                                          },
                                          child: Container(
                                            width:
                                                MediaQuery.of(
                                                  context,
                                                ).size.width *
                                                0.4,
                                            child: Padding(
                                              padding: const EdgeInsets.all(
                                                8.0,
                                              ),
                                              child: Text(
                                                (dataload[index].isNewCar
                                                            .toString() ==
                                                        "1"
                                                    ? "New Car"
                                                    : "Used Car"),
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Number",
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
                                        if (dataload[index].userPhoneNumber
                                                .toString() !=
                                            "null")
                                          InkWell(
                                            onTap: () async {
                                              var _url = Uri.parse(
                                                "tel:${dataload[index].userPhoneNumber.toString()}",
                                              );
                                              if (!await launchUrl(
                                                _url,
                                                mode: LaunchMode
                                                    .externalApplication,
                                              )) {
                                                throw Exception(
                                                  'Could not launch $_url',
                                                );
                                              }
                                            },
                                            child: Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  (dataload[index]
                                                      .userPhoneNumber
                                                      .toString()),
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        else
                                          InkWell(
                                            onTap: () async {
                                              // var _url = Uri.parse(
                                              //   "tel:${dataload[index].userPhoneNumber.toString()}",
                                              // );
                                              // if (!await launchUrl(
                                              //   _url,
                                              //   mode: LaunchMode.externalApplication,
                                              // )) {
                                              //   throw Exception(
                                              //     'Could not launch $_url',
                                              //   );
                                              // }
                                            },
                                            child: Container(
                                              width:
                                                  MediaQuery.of(
                                                    context,
                                                  ).size.width *
                                                  0.4,
                                              child: Padding(
                                                padding: const EdgeInsets.all(
                                                  8.0,
                                                ),
                                                child: Text(
                                                  "-",
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.3,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Status",
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
                                          width:
                                              MediaQuery.of(
                                                context,
                                              ).size.width *
                                              0.4,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Builder(
                                              builder: (context) {
                                                String status = car.leadStatus
                                                    .toString();
                                                String text = '';
                                                Color color = Colors.black;
                                                switch (status) {
                                                  case '0':
                                                    text = 'Pending';
                                                    color = Colors.greenAccent;
                                                    break;
                                                  case '1':
                                                    text = 'Ongoing';
                                                    color = Colors.orange;
                                                    break;
                                                  case '2':
                                                    text = 'Complete';
                                                    color = Colors.blue;
                                                    break;
                                                  case '3':
                                                    text = 'Cancel';
                                                    color = Colors.red;
                                                    break;
                                                  default:
                                                    text = 'Unknown';
                                                    color = Colors.grey;
                                                }
                                                return Text(
                                                  text,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14,
                                                    color: color,
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          if (car.leadStatus.toString() != '0')
                                            SizedBox(
                                              height: 60,
                                              width: 120,
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty.all(
                                                            Colors.orange,
                                                          ),
                                                      // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                                                      // textStyle: MaterialStateProperty.all(
                                                      //   TextStyle(fontSize: 30, color: Colors.white),
                                                      // ),
                                                    ),

                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'View',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_right_alt,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Completepidcheckpoint(
                                                                car: car,
                                                              ),
                                                        ),
                                                      );
                                                      print(
                                                        'Successfully log in ',
                                                      );
                                                    },
                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (car.leadStatus.toString() != '2')
                                            SizedBox(
                                              height: 60,
                                              width: 130,
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 20.0,
                                                      ),
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
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Text(
                                                          'Inspect',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w800,
                                                          ),
                                                        ),
                                                        Icon(
                                                          Icons.arrow_right_alt,
                                                          size: 15,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              Leaddetails(
                                                                car: car,
                                                              ),
                                                        ),
                                                      );
                                                      print(
                                                        'Successfully log in ',
                                                      );
                                                    },
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
                            ],
                          );
                        },
                      );
                    } else if (dataload.isEmpty) {
                      return Center(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ],
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          // floatingActionButton: FloatingActionButton(
          //   child: Icon(Icons.download_done_outlined),
          //   backgroundColor: const Color.fromARGB(255, 25, 39, 235),
          //   foregroundColor: Colors.white,
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => Completeinspection()),
          //     );
          //   },
          // ),
        ),
      ),
    );
  }
}
