// ignore_for_file: must_be_immutable, avoid_print

import 'package:chat_app/Components/chat_bubble.dart';
import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = "ChatPage";
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  final TextEditingController textEditingController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    // final String email=ModalRoute.of(context)!.settings.arguments as String;
    // Onther way , I tell him that will be string in case he did not know.
    return StreamBuilder<QuerySnapshot>(
      // Straem used to update UI automatically when any changes happen.
      stream: messages
          .orderBy(
            kCreatedAt,
            descending: true,
          )
          .snapshots(), //The Request
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<MessageModel> messageList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            messageList.add(
              MessageModel.fromJson(
                snapshot.data!.docs[i],
                // the access
              ),
            );
          }
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: AppBar(
              centerTitle: true,
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    kImage,
                    height: 35,
                  ),
                  const Text(
                    " Chat",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      itemCount: messageList.length,
                      itemBuilder: (context, index) {
                        return messageList[index].id == email
                            ? ChatBubble(
                                message: messageList[index],
                              )
                            : FriendChatBubble(
                                message: messageList[index],
                              );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: TextField(
                    controller: textEditingController,
                    onSubmitted: (data) {
                      messages.add(
                        {
                          kMessageField: (data),
                          kCreatedAt: DateTime.now(),
                          kId: email,
                        },
                      );
                      textEditingController.clear();
                      scrollController.animateTo(
                        0, // alwayes down
                        // scrollController.position.maxScrollExtent,
                        // go to the end of the list
                        duration: const Duration(
                          seconds: 1,
                        ),
                        curve: Curves.fastOutSlowIn,
                      );
                    },
                    decoration: InputDecoration(
                      hintText: "Send Message",
                      suffixIcon: Icon(
                        Icons.send,
                        color: Colors.grey.shade600,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: Colors.grey.shade600,
                        ),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const Text(
            "Is Loading ...",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          );
        }
      },
    );
  }
}
