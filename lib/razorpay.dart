import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/home.dart';
import 'package:sample/provider/cart_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sample/webservice/webservice.dart';

class PaymentScreen extends StatefulWidget {
  List<CartProduct> cart;
  String amount;
  String paymentmethod;
  String date;
  String name;
  String address;
  String phone;
  PaymentScreen({super.key, 
    required this.address,
    required this.amount,
    required this.cart,
    required this.date,
    required this.name,
    required this.paymentmethod,
    required this.phone,
  });

  @override
  _paymentsection createState() => _paymentsection();
}

class _paymentsection extends State<PaymentScreen> {
  Razorpay? razorpay;
  TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _loadUsername();
    razorpay = Razorpay();
    razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    flutterpayment("abcd", 10);
  }

  @override
  void dispose() {
    super.dispose();
    razorpay!.clear();
  }

  String? username;
  void _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      username = prefs.getString('username');
    });
    log("isloggedin = $username");
  }

   orderPlace(
    List<CartProduct> cart,
    String amount,
    String paymentmethod,
    String date,
    String name,
    String address,
    String phone,
  ) async {
    try {
    String jsondata = jsonEncode(cart);
    log('jsondata =$jsondata');
    final vm = Provider.of<Cart>(context, listen: false);
    final response =
        await http.post(Uri.parse("${Webservice.mainurl}order.php"), 
        body: {
      "username": username,
      "amount": amount,
      "paymentmethod": paymentmethod,
      "date": date,
      "quantity": vm.count.toString(),
      "cart": jsondata,
      "name": name,
      "address": address,
      "phone": phone,
    });
    if (response.statusCode == 200) {
      log(response.body);
      if (response.body.contains("Success")) {
        vm.clearCart();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          duration: Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          content: Text(
            "YOUR ORDER SUCCESSFULLY COMPLETED",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ));
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return const HomePage();
          },
        ));
      }
    }
     } catch (e) {
        log(e.toString());
      }
    }
  
    void flutterpayment(String orderId, int t) {
      var options = {
        "key":"rzp_test_L3vnRBpVGbl8N4",
        "amount": t * 100,
        'name':'arshad k usman',
        'currency':'INR',
        'description':'maligai',
        'external': {
          'wallets':['paytm']
        },
        'retry':{'enabled':true,'max_count':1},
        'send_sms_hash':true,
        "prefill":{"contact":"9496785387", "email":"arshadkk892@gmail.com"},
      };
      try {
        razorpay!.open(options);
      } catch (e){
        debugPrint('Error: e');
      }
    }
    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      response.orderId;
      sucessmethd(response.paymentId.toString());

      // Fluttertoast.showToast(
      //   msg: "SUCCESS: "+ response.paymentId!,
      //   toastLength: Toast.LENGTH_SHORT
      // );
    }
    void _handlePaymentError(PaymentFailureResponse response) {
      log("error ==${response.message}");
      // Fluttertoast.showToast(
      //   msg: "ERROR: "+ response.code.toString() + " - " + response.message!,
      //   toastLength: Toast.LENGTH_SHORT
      // );
    }
    void _handleExternalWallet(ExternalWalletResponse response) {
      log("waleeetttt==");
      // Fluttertoast.showToast(
      //   msg: "EXTERNAL_WALLET: "+ response.walletName!,
      //   toastLength: Toast.LENGTH_SHORT
      // );
    }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(),
    );
  }
  void sucessmethd(String paymentid) {
    log("success==$paymentid");
    orderPlace(widget.cart, widget.amount.toString(),
    widget.paymentmethod, widget.date, widget.name, widget.address, widget.phone);
  } 
}