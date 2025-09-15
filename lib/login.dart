import 'dart:convert';

import 'package:carinspect/Home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController number = TextEditingController();
  TextEditingController password = TextEditingController();
  bool passwordVisible = false;
  bool onlyonetime = false;

  @override
  void initState() {
    super.initState();
    if (onlyonetime == false) {
      setState(() {
        checkLogin();
        onlyonetime = true;
      });
    }
    passwordVisible = true;
  }

  checkLogin() async {
    SharedPreferences sharedprefrence = await SharedPreferences.getInstance();
    String? Token = sharedprefrence.getString("Token");

    if (Token.toString() != "null") {
      // Timer(
      //   const Duration(seconds: 2, milliseconds: 50),
      //   () =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
        // ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(title: Text("GeeksforGeeks")),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                  width: 150,
                  height: 150,
                  /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                  child: Image.asset('assets/porche.png'),
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Phone number, email or username',
                  hintText: 'Enter valid email id as abc@gmail.com',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
                top: 15,
                bottom: 0,
              ),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: password,
                obscureText: passwordVisible,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                  labelText: "Password",
                  helperText: "Password must contain special character",
                  helperStyle: TextStyle(color: Colors.green),
                  suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  // alignLabelWithHint: false,
                  // filled: true,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
            ),

            SizedBox(
              height: 65,
              width: 250,
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      // padding: MaterialStateProperty.all(EdgeInsets.all(50)),
                      // textStyle: MaterialStateProperty.all(
                      //   TextStyle(fontSize: 30, color: Colors.white),
                      // ),
                    ),

                    child: Text(
                      'Log in ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () async {
                      if (number.text.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your number '),
                          ),
                        );
                      } else if (password.text.toString().isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please enter your password'),
                          ),
                        );
                      } else {
                      
                        String Number = number.text.toString();
                       
                        String Password = password.text.toString();
                       
                        final uri =
                            "https://tailpass.com/mycardoctor/api/partnerlogin";
                       
                        final responce = await http.post(
                          Uri.parse(
                            "https://tailpass.com/mycardoctor/api/partnerlogin",
                          ),
                          body: {
                            "user_phone_number": number.text.toString(),
                            "user_password": password.text.toString(),
                          },
                        );
                     
                        var data = json.decode(responce.body);
                        print(data.toString());

                        if (data['code'].toString() == "200") {
                         
                          SharedPreferences Token =
                              await SharedPreferences.getInstance();
                          await Token.setString("Token", data['user_token']);
                         
                          SharedPreferences Userid =
                              await SharedPreferences.getInstance();
                          await Userid.setString(
                            "Userid",
                            data['data']['user_id'],
                          );
                          
                          SharedPreferences Username =
                              await SharedPreferences.getInstance();
                          await Username.setString(
                            "Username",
                            data['data']['user_full_name'],
                          );
                         
                          SharedPreferences email =
                              await SharedPreferences.getInstance();
                          await email.setString(
                            "email",
                            data['data']['user_email_id'],
                          );
                        
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Home()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Wrong credential.')),
                          );
                        }
                        // LoginHere();
                      }

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Home()),
                      // );
                      print('Successfully log in ');
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 50),
            Container(
              child: Center(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 2),
                      child: Text('Forgot your login details? '),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 1.0),
                      child: InkWell(
                        onTap: () {
                          print('hello');
                        },
                        child: Text(
                          'Get help logging in.',
                          style: TextStyle(fontSize: 14, color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void LoginHere() async {
    String Number = number.text;
    String Password = password.text;

    const uri = "https://tailpass.com/mycardoctor/api/partnerlogin";

    final responce = await http.post(
      Uri.parse(uri),
      body: {"user_phone_number": Number, "user_password": Password},
    );
    var data = json.decode(responce.body);
    print(data.toString());

    if (data['code'] == 200) {
      SharedPreferences Token = await SharedPreferences.getInstance();
      await Token.setString("Token", data['user_token']);

      SharedPreferences Userid = await SharedPreferences.getInstance();
      await Userid.setString("Userid", data['data']['user_id']);

      SharedPreferences Username = await SharedPreferences.getInstance();
      await Username.setString("Username", data['data']['user_full_name']);

      SharedPreferences email = await SharedPreferences.getInstance();
      await email.setString("email", data['data']['user_email_id']);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Wrong credential.')));
    }
  }
}
