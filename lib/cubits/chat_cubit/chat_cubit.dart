import 'package:chat_app/helper/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());
  List<MessageModel> messagesList = [];
  CollectionReference messages = FirebaseFirestore.instance.collection(
    kMessagesCollection,
  );
  // messages: A reference to the Firestore collection where
  // messages are stored.
  void sendMessage({required String email, required String message}) {
    messages.add(
      {
        kMessageField: message,
        kCreatedAt: DateTime.now(),
        kId: email,
      },
    );
  }
  // Sending a message: The sendMessage method takes an email and a message
  // as parameters and adds the message to the Firestore collection.

  void getMessage() {
    //The Request below

    messages
        .orderBy(
          kCreatedAt,
          descending: true,
        )
        .snapshots()
        .listen(
      (event) {
        messagesList.clear();
        // Save Received Messages In It ...
        for (var doc in event.docs) {
          messagesList.add(
            MessageModel.fromJson(doc),
          );
        }
        emit(
          ChatSucessState(messages: messagesList),
          // Now You can send the state with the messagesList to
          // the bloc consumer to show it in our UI ...
        );
      },
    );
  }
  // getMessage: Listens to changes in the Firestore collection, orders the
  // messages by creation time, and emits a ChatSuccessState when a new
  // message is received.
  // listen here ,instead of stream builder...
}
