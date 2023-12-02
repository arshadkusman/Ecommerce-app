import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:sample/constants.dart';
import 'package:sample/login.dart';
import 'package:http/http.dart' as http;

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

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
            return  LoginPage();
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
            const SizedBox(
              height: 50,
            ),
            const Text(
              "Register Account",
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text("complete your details \n"),
            const SizedBox(height: 28),
            Form(
              key: _formkey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Color(0xffE8E8E8),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                const InputDecoration.collapsed(hintText: 'Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your name";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                return "enter your phone number";
                              } else if (value.length > 10 ||
                                  value.length < 10) {
                                return "please enter a valid phone number";
                              }
                              return null;
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                const InputDecoration.collapsed(hintText: 'phone'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding:
                            const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                        child: Center(
                          child: TextFormField(
                            maxLines: 4,
                            onChanged: (text) {
                              setState(() {
                                address = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                const InputDecoration.collapsed(hintText: 'address'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your address";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                username = text;
                              });
                            },
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                const InputDecoration.collapsed(hintText: 'username'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your username";
                              }
                              return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Color(0xffE8E8E8),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Center(
                          child: TextFormField(
                            onChanged: (text) {
                              setState(() {
                                password = text;
                              });
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "enter your password";
                              }
                              return null;
                            },
                            obscureText: true,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                            decoration:
                                const InputDecoration.collapsed(hintText: 'Password'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                          if (_formkey.currentState!.validate()) {
                            log("name =$name");
                            log("phone =$phone");
                            log("address =$address");
                            log("username =$username");
                            log("password =$password");
                            registration(
                                name!, phone, address, username, password);
                          }
                        },
                        child: const Text(
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "do you have an account?",
                  style: TextStyle(fontSize: 16),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return const LoginPage();
                      },
                    ));
                  },
                  child: const Text(
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
