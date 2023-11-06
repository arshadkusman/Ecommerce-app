import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sample/constants.dart';
import 'package:sample/login.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? name, phone, address, username, password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool processing = false;
  registration(String name, phone, address, username, password) async {
    print('webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> Data = {
      'name': name,
      'phone': phone,
      'address': address,
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("https://bootcamp.cyralearnings.com/registration.php"),
      body: Data,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        log("registration successfully completed");
        
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return LoginPage();
          },
        ));
      } else {
        log("registration failed");
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "Register Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text("complete your details \n"),
            SizedBox(height: 28),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                InputDecoration.collapsed(
                                  hintText: 'Name'
                                  ),
                            validator: (value) {
                              if(value!.isEmpty) {
                                return 'enter your name';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                phone = text;
                              });
                            },
                            keyboardType: TextInputType.phone,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your phone number';
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return 'please enter a valid phone number';
                              }
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                InputDecoration.collapsed(hintText: 'phone'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                InputDecoration.collapsed(hintText: 'address'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your address';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                InputDecoration.collapsed(hintText: 'username'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your username';
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'enter your password';
                              }
                            },
                            obscureText: true,
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                InputDecoration.collapsed(hintText: 'Password'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: maincolor,
                        ),
                        onPressed: () {
                          log("name =" + name.toString());
                          log("phone =" + phone.toString());
                          log("address =" + address.toString());
                          log("username =" + username.toString());
                          log("password ="+  password.toString());
                          registration(
                              name!, phone, address, username, password);
                        },
                        child: Text(
                          "register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "do you have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return LoginPage();
                      },
                    ));
                  },
                  child: Text(
                    "login",
                    style: TextStyle(
                        fontSize: 16,
                        color: maincolor,
                        fontWeight: FontWeight.bold),
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
