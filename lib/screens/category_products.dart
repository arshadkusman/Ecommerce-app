import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:sample/screens/detailpage.dart';
import 'package:sample/webservice/webservice.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class Category_productsPage extends StatefulWidget {
  String catname;
  int catid;
  Category_productsPage({super.key, required this.catid, required this.catname});

  @override
  State<Category_productsPage> createState() => _Category_productsPageState();
}

class _Category_productsPageState extends State<Category_productsPage> {
  @override
  Widget build(BuildContext context) {
    log("catname${widget.catname}");
    log("catid${widget.catid}");
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.grey.shade100,
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          title: Text(
            widget.catname,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: FutureBuilder(
            future: Webservice().fetchCatProducts(widget.catid.toString()),
            builder: (context, snapshot) {
              log("Length ==${snapshot.data!.length}");
              if (snapshot.hasData) {
                return StaggeredGridView.countBuilder(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    crossAxisCount: 2,
                    itemBuilder: (context, index) {
                      final product = snapshot.data![index];
                      return InkWell(
                        onTap: () {
                          log("clicked");
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return DetailsPage(
                                id: product.id!,
                                name: product.productname!,
                                image: Webservice().imageurl + product.image!,
                                price: product.price!.toString(),
                                description: product.description!,
                              );
                            },
                          ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                  child: Container(
                                    constraints: const BoxConstraints(
                                        minHeight: 100, maxHeight: 250),
                                    child: Image(
                                        image: NetworkImage(
                                      Webservice().imageurl + product.image!,
                                    )),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          product.productname!,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                'Rs. ',
                                                style: TextStyle(
                                                    color: Colors.red.shade900,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                product.price!.toString(),
                                                style: TextStyle(
                                                  color: Colors.red.shade900,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
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
                    staggeredTileBuilder: (context) =>
                        const StaggeredTile.fit(1));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }));
  }
}
