import 'dart:math';
import 'dart:ui';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class User {
  final String id;
  final String fullname;
  final String? userImagePath;
  final Color color;
  final bool isOnline;
  User({id, required this.fullname, this.userImagePath, this.isOnline = false})
      : id = id ?? uuid.v4(),
        color = Color((Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(1.0); // generate id and random color
}
