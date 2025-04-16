import 'package:flutter/foundation.dart';

final class User {
  final int id;
  final String name;
  final String? avatar;

  User({required this.id, required this.name, this.avatar});

  User copyWith({
    String? name,
    String? avatar, //
  }) => User(
    id: id,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar, //
  );
}
