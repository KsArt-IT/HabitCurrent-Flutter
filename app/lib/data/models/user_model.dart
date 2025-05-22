final class UserModel {
  final int id;
  final String name;
  final String? avatar;
  final DateTime created;
  final DateTime updated;

  UserModel({
    required this.id,
    required this.name,
    this.avatar,
    required this.created,
    required this.updated,
  });

  UserModel copyWith({
    String? name,
    String? avatar,
    DateTime? created,
    DateTime? updated,
  }) =>
      UserModel(
        id: id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        created: created ?? this.created,
        updated: updated ?? this.updated,
      );
}
