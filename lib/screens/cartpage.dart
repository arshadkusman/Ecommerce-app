
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/constants.dart';
import 'package:sample/provider/cart_provider.dart';
import 'package:sample/screens/checkoutpage.dart';

class CartPage extends StatelessWidget {
  List<CartProduct> cartlist =[];

  CartPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            },
          ),
          
          title: const Text(
            "cart",
            style: TextStyle(
              fontSize: 25,
              color: Colors.black,
            ),
          ),
          actions: [
            context.watch<Cart>().getItems.isEmpty
            ? const SizedBox()
            :
            IconButton(
              onPressed: () {
                context.read<Cart>().clearCart();
              },
              icon: const Icon(
                Icons.delete,
                color: Color.fromARGB(255, 56, 55, 55),
              ),
            )
          ],
        ),
         body: 
         context.watch<Cart>().getItems.isEmpty?
          const Center(
          child: Text("Empty cart"),
        )
        : 
        Consumer<Cart>(builder: (context,cart,child) {
          cartlist = cart.getItems;
          return
        ListView.builder(
          itemCount:
          cart.count,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)
                ),
                child: SizedBox(
                  height: 100,
                  child:Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 100,
                       child: Padding(
                       padding: const EdgeInsets.only(left:9),
                       child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                          borderRadius: const BorderRadius.all(Radius.circular(20)),
                          image: DecorationImage(
                            image: NetworkImage(
                              cartlist[index].imageUrl
                              
                            ),
                           fit: BoxFit.fill
                          ),
                        ),
                        //
                       ),
                  ),
                      ),
                    Flexible(child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Wrap(
                        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        // "Product name"
                        cartlist[index].name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            
                            cartlist[index].price.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade900
                            ),
                          ),
                          Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartlist[index].qty == 1
                                    ? cart.removeItem(cartlist[index])
                                    : cart.reduceByOne(cartlist[index]);
                                  },
                                  icon:cartlist[index].qty == 1?
                                  const Icon(
                                    Icons.delete,
                                    size: 18,
                                  )
                                  : const Icon(
                                    Icons.minimize_rounded,
                                    size: 18,
                                  )
                                  ),
                                  Text(
                                    cartlist[index].qty.toString(),
                                    
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontFamily: 'Acme',
                                      color: Colors.red.shade900
                                    ),
                                  ),
                                  IconButton(onPressed:() {
                                    cart.increment(cartlist[index]);
                                  },
                                  icon: const Icon(
                                    Icons.add,
                                    size: 18,
                                  ),
                                  ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                        ],
                    ),
                ),
              )
                    ],
              ),
                )),
            );
          }
        );
       // }
}),
        bottomSheet: Padding(padding:const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Total :${context.watch<Cart>().totalPrice}",
              style: TextStyle(
                fontSize: 20,
                color: Colors.red.shade900,
                fontWeight: FontWeight.bold
              ),
            ),
            InkWell(
              onTap: () {
                context.read<Cart>().getItems.isEmpty
                ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  duration: Duration(seconds: 3),
                  behavior: SnackBarBehavior.floating,
                  padding: EdgeInsets.all(15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  content: Text("Cart is empty !!!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white
                  ),
                  ),
                ))

                //log("cartlist -- " + cartlist.toString());
                :Navigator.push(context, MaterialPageRoute(builder: (context){
                  return CheckoutPage(cart: cartlist);
                },
                ));
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width / 2.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: maincolor
                ),
                child: const Center(
                  child: Text(
                    "Order Now",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        ),
        );
  }
}
