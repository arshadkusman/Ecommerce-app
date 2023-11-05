import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sample/constants.dart';
import 'package:flutter/widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? username, password;
  bool processing = false;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 200),
                Text(
                  "welcomeback",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "login with your username and password \n",
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Color(0xffE8E8E8),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'username',
                          ),
                          onChanged: (Text) {
                            setState(() {
                              username = Text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter your username text';
                            }
                            return null;
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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: TextFormField(
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          decoration: InputDecoration.collapsed(
                            hintText: 'password',
                          ),
                          onChanged: (Text) {
                            setState(() {
                              password = Text;
                            });
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'enter your password text';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
                processing == true
                    ? Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 7, 2, 78),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              primary: Colors.white,
                              backgroundColor: maincolor,
                            ),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                log("username = " + username.toString());
                                log("password =" + password.toString());
                              }
                            },
                            child: Text(
                              "Login",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Dont have an account? ",
                      style: TextStyle(fontSize: 16),
                    ),
                    
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
