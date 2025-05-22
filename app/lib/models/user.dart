final class User {
  final int id;
  final String name;
  final String? avatar;
  final DateTime created;
  final DateTime updated;

  User({
    required this.id,
    required this.name,
    this.avatar,
    required this.created,
    required this.updated,
  });

  User copyWith({
    String? name,
    String? avatar,
    DateTime? created,
    DateTime? updated,
  }) => User(
    id: id,
    name: name ?? this.name,
    avatar: avatar ?? this.avatar,
    created: created ?? this.created,
    updated: updated ?? this.updated,
  );
}
