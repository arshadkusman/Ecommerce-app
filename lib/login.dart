import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:sample/constants.dart';
import 'package:sample/registration.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  void initState() {
    super.initState();
    _loadCounter();
  }

  void _loadCounter() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    log("isLoggedIn = " + isLoggedIn.toString());
    if (isLoggedIn) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  login(String username, String password) async {
    print('webservice');
    print(username);
    print(password);
    var result;
    final Map<String, dynamic> loginData = {
      'username': username,
      'password': password,
    };

    final response = await http.post(
      Uri.parse("https://bootcamp.cyralearnings.com/registration.php"),
      body: loginData,
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      if (response.body.contains("success")) {
        log("registration successfully completed");
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool("isLoggedIn", true);
        prefs.setString("username", username);
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ));
      } else {
        log("Login Failed");
      }
    } else {
      result = {log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }

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
                          onChanged: (text) {
                            setState(() {
                              username = text;
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
                          onChanged: (text) {
                            setState(() {
                              password = text;
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
                        padding: EdgeInsets.all(8.0),
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
                                login(username.toString(), password.toString());
                              }
                            },
                            child: Text(
                              "Login",
                              style: TextStyle(
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
                    GestureDetector(
                      onTap: () {
                        log("go to registration");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegistrationPage();
                            },
                          ),
                        );
                      },
                      child: Text(
                        "Go To Register",
                        style: TextStyle(
                            fontSize: 16,
                            color: maincolor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
