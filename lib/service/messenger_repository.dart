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
      dateTime: DateTime(2024, 5, 14),
      senderUserId: loggedUser.id,
      receiverUserId: users[1].id,
      text: 'Доброе утро',
    ),
    Message(
      dateTime: DateTime(2024, 6, 14),
      senderUserId: users[1].id,
      receiverUserId: loggedUser.id,
      text: 'Как ты?',
    ),
    Message(
      dateTime: DateTime(2024, 3, 22),
      senderUserId: users[2].id,
      receiverUserId: loggedUser.id,
      text: 'На месте',
    ),
    Message(
      dateTime: DateTime(2024, 5, 16),
      senderUserId: loggedUser.id,
      receiverUserId: users[3].id,
      text: 'Что нового?',
    ),
    Message(
      dateTime: DateTime(2024, 5, 17),
      senderUserId: loggedUser.id,
      receiverUserId: users[2].id,
      text: 'Отлично!',
    ),
    Message(
      dateTime: DateTime(2024, 4, 10),
      senderUserId: users[2].id,
      receiverUserId: loggedUser.id,
      text: 'Увидимся завтра',
    ),
    Message(
      dateTime: DateTime(2024, 5, 18),
      senderUserId: users[0].id,
      receiverUserId: loggedUser.id,
      text: 'Привет, давно не виделись',
    ),
    Message(
      dateTime: DateTime(2024, 5, 20),
      senderUserId: loggedUser.id,
      receiverUserId: users[1].id,
      text: 'Ты здесь?',
    ),
    Message(
      dateTime: DateTime(2024, 6, 1),
      senderUserId: users[3].id,
      receiverUserId: loggedUser.id,
      text: 'На связи',
    ),
    Message(
      dateTime: DateTime(2024, 5, 21),
      senderUserId: loggedUser.id,
      receiverUserId: users[2].id,
      text: 'До встречи',
    ),
  ];

  List<User> getUsers() {
    return users;
  }

  User getCurrentUser() => loggedUser;

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
