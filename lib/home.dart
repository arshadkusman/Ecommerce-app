import 'dart:developer';

import 'package:sample/screens/category_products.dart';
import 'package:sample/screens/detailpage.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';

import 'package:flutter/material.dart';
import 'package:sample/constants.dart';
import 'package:sample/drawer.dart';


import 'package:sample/webservice/webservice.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: maincolor,
        title: Text(
          "E-COMMERCE",
          style: TextStyle(
            color: Colors.white,fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: DrawerWidget(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Category",
                  style: TextStyle(
                    fontSize: 20,
                    color: maincolor,
                    fontWeight: FontWeight.bold
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            FutureBuilder(future: Webservice().fetchCategory(),
             builder: (context, snapshot){
              if(snapshot.hasData) {
                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return Padding(padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          log("clicked");
                          Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return Category_productsPage(
                              catid: snapshot.data![index].id!,
                              catname: snapshot.data![index].category!,
                            );
                          },
                      ));                          
                        },
                        child: Container(
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(37,5,2,39),
                          ),
                          child: Center(
                            child: Text(
                               snapshot.data![index].category!,
                              //  "Category Name",
                               style: TextStyle(
                                color: maincolor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                               ),
                            ),
                          ),
                        ),
                      ),
                      );
                    },
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
             }),
             SizedBox(
                  height: 20,
                ),
                Text(
                  "Offer Products",
                  style: TextStyle(
                    fontSize: 18,
                    color: maincolor,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
               Expanded(child: 
               FutureBuilder(
                future: Webservice().fetchProducts(),
                builder: (context, snapshot) {
                  log("product length ==" + snapshot.data!.length.toString());
                  if(snapshot.hasData) {
                    return Container(
                      color: Colors.white,
                child: StaggeredGridView.countBuilder(
                  physics:BouncingScrollPhysics(),
                  shrinkWrap:true,
                  itemCount: snapshot.data!.length,
                  crossAxisCount:2,
                  itemBuilder:(context, index) {
                    final product = snapshot.data![index];
                    return InkWell(
                      onTap: () {
                        log("Clicked");
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailsPage(
                            id:product.id!,
                            name:product.productname!,
                            image:Webservice().imageurl +
                            product.image!,
                            price: product.price!.toString(),
                            description:product.description!,
                          );
                        },
                        )
                        );
                      },
                      child: Padding(
                        padding:const EdgeInsets.all(8.0),
                        child:Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:BorderRadius.circular(15)),
                            child:Column(
                              children: [
                                ClipRRect(
                            borderRadius:BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15)
                            ),
                            child:Container(
                              constraints: BoxConstraints(
                                minHeight: 100,maxHeight: 250
                              ),
                              child: Image(
                                image: NetworkImage (Webservice().imageurl +
                                product.image!,
                               //""
                               //""
                              )
                            ),
                          ),
                           ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Align(
                                    alignment:Alignment.topLeft,
                                    child: Text(
                                      product.productname!,
                                      //"shoes",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                        child:Text(
                                            'Rs.' + product.price!.toString(),
                                            style: TextStyle(
                                              color: Colors.red.shade900,
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600
                                            ),
                                          ),
                                  ),
                                        ],
                                      ),
                                  ),
                                ],
                              ),
                              ),
                        ),
                      );
                        
                  },
                  staggeredTileBuilder:(context) =>
                  StaggeredTile.fit(1)),
              );
  }else{
    return Center(child:CircularProgressIndicator());
  }
}),
               ),
          ],
        ),
      ),);
  }
}