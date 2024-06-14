import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Message {
  final String id;
  final String? text;
  final DateTime dateTime;
  final String senderUserId;
  final String receiverUserId;
  final String? filePath;
  Message({
    id,
    this.text,
    required this.dateTime,
    required this.senderUserId,
    required this.receiverUserId,
    this.filePath,
  }) : id = id ?? uuid.v4();
}
