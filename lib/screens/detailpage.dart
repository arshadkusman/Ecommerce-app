import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/constants.dart';
import 'package:sample/home.dart';
import 'package:collection/collection.dart';
import 'package:sample/provider/cart_provider.dart';

class DetailsPage extends StatelessWidget {
  String name, price, image, description;
  int id;
  DetailsPage(
      {super.key, required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.description});

  @override
  Widget build(BuildContext context) {
    log("id = $id");
    log("name = $name");
    log("price = $price");
    log("image = $image");
    log("desc = $description");
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                      image: NetworkImage(
                    image,
                    
                  )),
                ),
                Positioned(
                    left: 15,
                    top: 20,
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.withOpacity(0.5),
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const HomePage();
                            },
                          ));
                        },
                      ),
                    ))
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: (20)),
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 239, 240, 241),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  )),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 2, 20, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(
                        name,
                        style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'Rs.$price',
                      style: TextStyle(
                          color: Colors.red.shade900,
                          fontSize: 16,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      description,
                      textScaleFactor: 1.1,
                      style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              log("price ==${double.parse(price)}");

              var existingItemCart = context
                  .read<Cart>()
                  .getItems.firstWhereOrNull((element) => element.id == id);
              log("existingItemCart----$existingItemCart");
              if (existingItemCart != null) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  content: Text(
                    "This item already in the cart",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ));
              } else {
                context
                    .read<Cart>()
                    .addItem(id, name, double.parse(price),image,1);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  content: Text(
                    "Added to the cart !!!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'muli',
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ));
              }
            },
            child: Container(
              height: 50,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: maincolor
              ),
              child: const Center(
                child: Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ),
            ),
          )),
    ));
  }
}
