import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Profilemore extends StatefulWidget {
  const Profilemore({super.key});

  @override
  State<Profilemore> createState() => _ProfilemoreState();
}

class _ProfilemoreState extends State<Profilemore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        titleSpacing: 00.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        elevation: 0.00,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),

          onPressed: () {},
        ),
        // systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Divider(color: Colors.grey),
          ),
          Container(
            // margin: EdgeInsets.only(top: 8),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Text(
                      "Manjeet Rajbhar",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 8, 53, 202),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      width: 30,
                      height: 30,

                      child: Icon(Icons.edit, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      width: 30,
                      height: 30,

                      child: Icon(Icons.email_outlined, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Text(
                      "manjeetrajbhar89@gmail.com",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 2.0,
                left: 8,
                right: 8,
                bottom: 4,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                      width: 30,
                      height: 30,

                      child: Icon(Icons.phone, color: Colors.grey),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 4.0,
                      left: 8,
                      right: 8,
                      bottom: 4,
                    ),
                    child: Text(
                      "1234567890",
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: Divider(color: Colors.grey),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 40,
                          right: 8,
                          bottom: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                width: 30,
                                height: 30,

                                child: Icon(
                                  Icons.notifications,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Text(
                                "Notifications",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 8,
                    right: 40,
                    bottom: 4,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 40,
                          right: 8,
                          bottom: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                width: 30,
                                height: 30,

                                child: Icon(Icons.circle, color: Colors.grey),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Text(
                                "My Leads",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 8,
                    right: 40,
                    bottom: 4,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 4.0,
                          left: 40,
                          right: 8,
                          bottom: 4,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(
                                    255,
                                    255,
                                    255,
                                    255,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                width: 30,
                                height: 30,

                                child: Icon(
                                  Icons.logout_outlined,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 4.0,
                                left: 8,
                                right: 8,
                                bottom: 4,
                              ),
                              child: Text(
                                "Logout",
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 4.0,
                    left: 8,
                    right: 40,
                    bottom: 4,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
