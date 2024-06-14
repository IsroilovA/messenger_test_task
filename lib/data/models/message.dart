import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Message{
  final String id;
  final String text;
  final DateTime dateTime;
  final String username;
  Message(id, this.text, this.dateTime, this.username): id = id ?? uuid.v4();
}