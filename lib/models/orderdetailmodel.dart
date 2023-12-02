
class OrderModel {
    int id;
    String username;
    String totalamount;
    String paymentmethod;
    DateTime date;
    List<Product> products;

    OrderModel({
        required this.id,
        required this.username,
        required this.totalamount,
        required this.paymentmethod,
        required this.date,
        required this.products,
    });

    factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json["id"],
        username: json["username"],
        totalamount: json["totalamount"],
        paymentmethod: json["paymentmethod"],
        date: DateTime.parse(json["date"]),
        products: List<Product>.from(json["products"]!.map((x) => Product.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "totalamount": totalamount,
        "paymentmethod": paymentmethod,
        "date": date,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
    };
}

class Product {
    String price;
    String productname;
    String image;
    String quantity;

    Product({
       required this.price,
       required this.productname,
       required this.image,
       required this.quantity,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"],
        productname: json["productname"],
        image: json["image"],
        quantity: json["quantity"],
    );

    Map<String, dynamic> toJson() => {
        "price": price,
        "productname": productname,
        "image": image,
        "quantity": quantity,
    };
}
