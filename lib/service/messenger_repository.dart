import 'package:intl/intl.dart';
import 'package:messenger_test_task/data/models/message.dart';
import 'package:messenger_test_task/data/models/user.dart';

final loggedUser = User(fullname: "Алишер Исроилов");

List<User> users = [
  User(fullname: 'Виктор Власов', isOnline: true),
  User(fullname: 'Саша Алексеев'),
  User(fullname: "Петр Жаринов"),
  User(fullname: 'Алина Жукова'),
  User(fullname: 'Райан Гослинг'),
];

final dateFormatter = DateFormat('dd.MM.yy');

class MessengerRepository {
  List<Message> messages = [
    Message(
      dateTime: DateTime(2024, 5, 14, 9, 30),
      senderUserId: loggedUser.id,
      receiverUserId: users[1].id,
      text: 'Доброе утро',
    ),
    Message(
      dateTime: DateTime(2024, 5, 14, 16, 45),
      senderUserId: users[1].id,
      receiverUserId: loggedUser.id,
      text: 'Как ты?',
    ),
    Message(
      dateTime: DateTime(2024, 3, 22, 14, 15),
      senderUserId: users[2].id,
      receiverUserId: loggedUser.id,
      text: 'На месте',
    ),
    Message(
      dateTime: DateTime(2024, 5, 16, 10, 00),
      senderUserId: loggedUser.id,
      receiverUserId: users[3].id,
      text: 'Что нового?',
    ),
    Message(
      dateTime: DateTime(2024, 5, 17, 18, 20),
      senderUserId: loggedUser.id,
      receiverUserId: users[4].id,
      text: 'Отлично!',
    ),
    Message(
      dateTime: DateTime(2024, 4, 10, 8, 45),
      senderUserId: users[4].id,
      receiverUserId: loggedUser.id,
      text: 'Увидимся завтра',
    ),
    Message(
      dateTime: DateTime(2024, 5, 18, 11, 10),
      senderUserId: users[0].id,
      receiverUserId: loggedUser.id,
      text: 'Привет, давно не виделись',
    ),
    Message(
      dateTime: DateTime(2024, 5, 20, 19, 50),
      senderUserId: loggedUser.id,
      receiverUserId: users[1].id,
      text: 'Ты здесь?',
    ),
    Message(
      dateTime: DateTime(2024, 6, 1, 13, 30),
      senderUserId: users[3].id,
      receiverUserId: loggedUser.id,
      text: 'На связи',
    ),
    Message(
      dateTime: DateTime(2024, 5, 21, 17, 40),
      senderUserId: loggedUser.id,
      receiverUserId: users[2].id,
      text: 'До встречи',
    ),
    Message(
      dateTime: DateTime.now().subtract(
          const Duration(days: 2, hours: 2, minutes: 15)), // Yesterday
      senderUserId: users[2].id,
      receiverUserId: loggedUser.id,
      text: 'Cкоро увидемся',
    ),
    Message(
      dateTime: DateTime.now().subtract(
          const Duration(days: 1, hours: 3, minutes: 40)), // Yesterday
      senderUserId: loggedUser.id,
      receiverUserId: users[4].id,
      text: 'Как дела вчера?',
    ),
    Message(
      dateTime: DateTime.now().subtract(
          const Duration(days: 1, hours: 1, minutes: 30)), // Yesterday
      senderUserId: users[1].id,
      receiverUserId: loggedUser.id,
      text: 'Что нового вчера?',
    ),
    Message(
      dateTime: DateTime.now()
          .subtract(const Duration(hours: 4, minutes: 10)), // Today
      senderUserId: users[0].id,
      receiverUserId: loggedUser.id,
      text: 'Сегодняшнее утро',
    ),
    Message(
      dateTime: DateTime.now()
          .subtract(const Duration(hours: 3, minutes: 20)), // Today
      senderUserId: loggedUser.id,
      receiverUserId: users[3].id,
      text: 'Сегодняшнее сообщение',
    ),
    Message(
      dateTime: DateTime.now()
          .subtract(const Duration(hours: 2, minutes: 5)), // Today
      senderUserId: users[3].id,
      receiverUserId: loggedUser.id,
      text: 'Привет сегодня',
    ),
    Message(
      dateTime: DateTime.now().subtract(const Duration(minutes: 30)), // Today
      senderUserId: users[4].id,
      receiverUserId: loggedUser.id,
      text: 'Как дела сейчас?',
    ),
    Message(
      dateTime: DateTime.now(), // Now
      senderUserId: loggedUser.id,
      receiverUserId: users[0].id,
      text: 'Прямо сейчас',
    ),
    Message(
      dateTime: DateTime.now().subtract(const Duration(days: 1)),
      senderUserId: loggedUser.id,
      receiverUserId: users[1].id,
      text: 'Вчерашнее сообщение',
    ),
  ];

  List<User> getUsers() {
    return users;
  }

  User getCurrentUser() => loggedUser;

  Map<String, List<Message>> getChatMessages(User user) {
    Map<String, List<Message>> userMessagesSorted = {};
    final userMessages = messages
        .where((element) =>
            element.receiverUserId == user.id ||
            element.senderUserId == user.id)
        .toList();
    userMessages.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    for (final msg in userMessages) {
      if (userMessagesSorted.containsKey(dateFormatter.format(msg.dateTime))) {
        userMessagesSorted[dateFormatter.format(msg.dateTime)]!.add(msg);
      } else {
        userMessagesSorted[dateFormatter.format(msg.dateTime)] = [msg];
      }
    }

    return userMessagesSorted;
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
