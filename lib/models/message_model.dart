import 'package:chat_app/helper/constants.dart';

class MessageModel {
  final String message;
  final String id;
  MessageModel(this.message, this.id);
  factory MessageModel.fromJson(jsonData) {
    return MessageModel(
      jsonData[kMessageField], jsonData[kId],

      //  the logic
      // jsonData is the doc, and we access it then get the needed message field
    );
  }
}
