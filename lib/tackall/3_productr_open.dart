import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductDetail3 extends StatefulWidget {
  const ProductDetail3({Key? key, this.product}) : super(key: key);

  final product;

  @override
  State<ProductDetail3> createState() => _ProductDetail3State();
}

class _ProductDetail3State extends State<ProductDetail3> {
  DocumentReference? productDetails;
  @override
  void initState() {
    productDetails =
        FirebaseFirestore.instance.collection('Products').doc(widget.product);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: productDetails?.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            var dataStore = snapshot.data!.data() as Map<String, dynamic>;

            return Container(
              height: 300,
              width: double.infinity,
              color: Colors.blue.withOpacity(0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Products Name : ${dataStore['Name']}"),
                  Text("Products Price : ${dataStore['Price']}"),
                  Text("Products Discount : ${dataStore['Discount']}"),
                  Text("Products Quantity : ${dataStore['Quantity']}"),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
