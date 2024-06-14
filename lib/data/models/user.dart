import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  final String id;
  final String fullname;
  final String? userImagePath;
  final bool isOnline;
  User({id, required this.fullname, this.userImagePath, this.isOnline = false})
      : id = id ?? uuid.v4();
}
