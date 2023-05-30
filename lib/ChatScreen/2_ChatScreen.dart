import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ChatTask extends StatefulWidget {
  ChatTask({Key? key, required this.uid}) : super(key: key);

  final String uid;

  @override
  State<ChatTask> createState() => _ChatTaskState();
}

class _ChatTaskState extends State<ChatTask> {
  TextEditingController chatController = TextEditingController();

  var user = FirebaseFirestore.instance.collection('chatsmsg');
  var message = FirebaseFirestore.instance
      .collection('chatsmsg')
      .orderBy('datetime', descending: false)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat Screen")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: message,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var msg = snapshot.data!.docs[index].data();
                      return Column(
                        children: [
                          Row(
                            children: [
                              msg['sender_id'] == widget.uid
                                  ? Spacer()
                                  : SizedBox(),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: msg['sender_id'] != widget.uid
                                      ? Colors.grey
                                      : Colors.green,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Text(
                                    '${msg['Message']}',
                                    style: TextStyle(
                                        color: msg['sender_id'] != widget.uid
                                            ? Colors.black
                                            : Colors.white),
                                  ),
                                ),
                              ),
                              msg['receiverId'] == widget.uid
                                  ? Spacer()
                                  : SizedBox(),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Text(
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.left,
                    "No Chat",
                  );
                }
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: chatController,
                decoration: InputDecoration(
                  constraints: BoxConstraints(maxWidth: 275),
                  hintText: "Enter your message",
                ),
              ),
              IconButton(
                onPressed: () {
                  String myUid = GetStorage().read('uid'); //viraj
                  String receiverId = GetStorage().read('uid') ==
                          "8uRti7V8HUNitFdLrHLZNbrYus82" //nikunj
                      ? "yMGybwIPgQbMM0nKOo6oGJEzFVo1" //viraj
                      : "8uRti7V8HUNitFdLrHLZNbrYus82"; //nikunj

                  Map<String, dynamic> abc = {};
                  user.add({
                    "msg": chatController.text,
                    "datetime": DateTime.now(),
                    "SenderId": myUid,
                    "receiverId": receiverId
                  });
                  chatController.clear();
                },
                icon: Icon(Icons.send),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
