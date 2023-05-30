import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '3_productr_open.dart';

class ProductView2 extends StatefulWidget {
  const ProductView2({Key? key}) : super(key: key);

  @override
  State<ProductView2> createState() => _ProductView2State();
}

class _ProductView2State extends State<ProductView2> {
  CollectionReference products =
      FirebaseFirestore.instance.collection('Products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: products.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var dataStore =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;

                return ActionChip(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetail3(
                          product: '${snapshot.data!.docs[index].id}',
                        ),
                      ),
                    );
                  },
                  label: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ListTile(
                          leading: Text("Name : "),
                          title: Text('${dataStore['Name']}'),
                        ),
                        ListTile(
                          leading: Text("Price : "),
                          title: Text('${dataStore['Price']}'),
                        ),
                        ListTile(
                          leading: Text("Discount : "),
                          title: Text('${dataStore['Discount']}'),
                        ),
                        ListTile(
                          leading: Text("Quantity : "),
                          title: Text('${dataStore['Quantity']}'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
