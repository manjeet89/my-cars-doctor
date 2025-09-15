import 'package:flutter/material.dart';

class Coupancode extends StatefulWidget {
  const Coupancode({super.key});

  @override
  State<Coupancode> createState() => _CoupancodeState();
}

class _CoupancodeState extends State<Coupancode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Coupons",
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 41, 138, 17), // Border color
              width: 2.0, // Border width
            ),
            color: Colors.lightBlueAccent,
            borderRadius: BorderRadius.circular(8), // Rounded corners
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 20.0,
                  right: 20,
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromARGB(255, 11, 189, 5), // Border color
                      width: 2.0, // Border width
                    ),
                    color: const Color.fromARGB(255, 255, 93, 64),
                    borderRadius: BorderRadius.circular(6), // Rounded corners
                  ),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.copy, color: Colors.white),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          bottom: 8,
                          left: 50,
                        ),
                        child: Text(
                          "JYOTICARDOCTOR",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Lorem ipsum is a placeholder text commonly used in graphic design, publishing, and web development to occupy space in layouts where the final content is not yet available.",
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
