import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '2_products.dart';

class EnterProduct extends StatefulWidget {
  const EnterProduct({Key? key}) : super(key: key);

  @override
  State<EnterProduct> createState() => _EnterProductState();
}

class _EnterProductState extends State<EnterProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController quantity = TextEditingController();

  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');
  DocumentReference produc = FirebaseFirestore.instance
      .collection('Products')
      .doc('SSMPM6l1CPir2LJTPEka');
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductView2(),
            ),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: name,
              decoration: InputDecoration(
                labelText: "product name",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: price,
              decoration: InputDecoration(
                labelText: "price",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: discount,
              decoration: InputDecoration(
                labelText: "discount",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: quantity,
              decoration: InputDecoration(
                labelText: "quantity",
                constraints: BoxConstraints(maxWidth: 300),
              ),
            ),
            loading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      produc.update({
                        "Name": name.text,
                        "Price": price.text,
                        "Discount": discount.text,
                        "Quantity": quantity.text,
                      });

                      name.clear();
                      price.clear();
                      discount.clear();
                      quantity.clear();
                      setState(() {
                        loading = false;
                      });
                    },
                    child: Text("update"),
                  ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                products.add({
                  "Name": name.text,
                  "Price": price.text,
                  "Discount": discount.text,
                  "Quantity": quantity.text,
                });

                name.clear();
                price.clear();
                discount.clear();
                quantity.clear();
                setState(() {
                  loading = false;
                });
              },
              child: Text("add"),
            ),
          ],
        ),
      ),
    );
  }
}
