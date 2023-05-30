import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatsExample extends StatefulWidget {
  const ChatsExample({Key? key}) : super(key: key);

  @override
  State<ChatsExample> createState() => _ChatsExampleState();
}

class _ChatsExampleState extends State<ChatsExample> {
  TextEditingController msg = TextEditingController();
  var message = FirebaseFirestore.instance.collection('chatsmsg');
  var messages = FirebaseFirestore.instance
      .collection('chatsmsg')
      .orderBy('datetime', descending: false)
      .snapshots();
  var selected = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: messages,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index].data();
                      return data["sender_id"] == "mamSegbGf7Qw2xV1CiO3"
                          ? Text('${data['msg']}',
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                  fontWeight: FontWeight.w500))
                          : Text('${data['msg']}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.w500));
                    },
                  );
                } else
                  return Center(
                    child: Text('No Data'),
                  );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 60,
                    width: 280,
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          selected = value;
                        });
                      },
                      controller: msg,
                      decoration: InputDecoration(
                        hintText: 'massage',
                        prefixIcon: Icon(Icons.sentiment_dissatisfied),
                        suffixIcon: Icon(Icons.camera_alt),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {
                    Map<String, dynamic> data = {
                      "sender_id": "mamSegbGf7Qw2xV1CiO3",
                      "msg": msg.text,
                      "datetime": '${DateTime.now()}'
                    };
                    message.add(data);
                  },
                  child: Container(
                    width: 52,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: selected.isEmpty
                        ? Icon(
                            Icons.mic,
                            size: 30,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.send,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
