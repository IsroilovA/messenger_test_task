import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';

class MessengerRepository {
  List<User> users = [
    User(fullname: 'Виктор Власов'),
    User(fullname: 'Саша Алексеев'),
    User(fullname: "Петр Жаринов"),
    User(fullname: 'Алина Жукова'),
  ];

  final loggedUser = User(fullname: "Алишер Исроилов");

  List<Message> messages = [];

  List<User> getUsers() {
    return users;
  }

  User getLoggedUser() => loggedUser;

  void addMessage(Message message) {
    messages.add(message);
  }
}
