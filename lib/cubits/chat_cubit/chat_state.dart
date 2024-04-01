part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitialState extends ChatState {}

final class ChatSucessState extends ChatState {
  final List<MessageModel> messages;

  ChatSucessState({required this.messages});
}
