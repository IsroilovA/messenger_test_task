import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  final String id;
  final String fullname;
  final String? userImagePath;
  User({id, required this.fullname, this.userImagePath}) : id = id ?? uuid.v4();
}
