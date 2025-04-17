import 'package:habit_current/models/user.dart';

final class UserModel {
  final int id;
  final String name;
  final String? avatar;
  final DateTime created;

  UserModel({
    required this.id,
    required this.name,
    this.avatar,
    required this.created,
  });

  User copyWith({String? name, String? avatar, DateTime? created}) => User(
    id: id,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar,
    created: created ?? this.created,
  );
}
