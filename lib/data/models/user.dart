import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  final String id;
  final String username;
  User(id, this.username) : id = id ?? uuid.v4();
}
