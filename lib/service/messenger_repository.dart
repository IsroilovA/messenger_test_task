import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';

final loggedUser = User(fullname: "Алишер Исроилов");

List<User> users = [
  User(fullname: 'Виктор Власов', isOnline: true),
  User(fullname: 'Саша Алексеев'),
  User(fullname: "Петр Жаринов"),
  User(fullname: 'Алина Жукова'),
];

class MessengerRepository {
  List<Message> messages = [
    Message(
        dateTime: DateTime(2024, 5, 13),
        senderUserId: loggedUser.id,
        receiverUserId: users.first.id,
        text: 'Привет'),
    Message(
      dateTime: DateTime(2024, 6, 13),
      senderUserId: users[1].id,
      receiverUserId: loggedUser.id,
      text: 'Я вышел',
    ),
    Message(
      dateTime: DateTime(2024, 2, 20),
      senderUserId: users[2].id,
      receiverUserId: loggedUser.id,
      text: 'Я готов',
    ),
    Message(
      dateTime: DateTime(2024, 5, 13),
      senderUserId: loggedUser.id,
      receiverUserId: users[3].id,
      text: 'Уже сделал?',
    ),
    Message(
      dateTime: DateTime(2024, 5, 15),
      senderUserId: loggedUser.id,
      receiverUserId: users[3].id,
      text: 'Как дела?',
    ),
  ];

  List<User> getUsers() {
    return users;
  }

  User getLoggedUser() => loggedUser;

  List<Message> getChatMessages(User user) {
    final userMessages = messages
        .where((element) =>
            element.receiverUserId == user.id ||
            element.senderUserId == user.id)
        .toList();
    userMessages.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return userMessages;
  }

  Message getChatLastMessage(User user) {
    final userMessages = messages
        .where((element) =>
            element.receiverUserId == user.id ||
            element.senderUserId == user.id)
        .toList();
    userMessages.sort((a, b) => a.dateTime.compareTo(b.dateTime));
    return userMessages.last;
  }

  void addMessage(Message message) {
    messages.add(message);
  }
}
