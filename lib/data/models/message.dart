import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Message {
  final String id;
  final String? text;
  final DateTime dateTime;
  final String senderUserId;
  final String receiverUserId;
  final String? filePath;
  final bool isRead;
  Message({
    id,
    this.text,
    required this.dateTime,
    required this.senderUserId,
    required this.receiverUserId,
    File? file,
    this.isRead = true,
  })  : id = id ?? uuid.v4(),
        filePath = file?.path;
}
