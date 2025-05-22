// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _avatarMeta = const VerificationMeta('avatar');
  @override
  late final GeneratedColumn<String> avatar = GeneratedColumn<String>(
    'avatar',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  @override
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, avatar, created, updated];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(
    Insertable<User> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('avatar')) {
      context.handle(
        _avatarMeta,
        avatar.isAcceptableOrUnknown(data['avatar']!, _avatarMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      avatar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar'],
      ),
      created:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created'],
          )!,
      updated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated'],
          )!,
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String name;
  final String? avatar;
  final DateTime created;
  final DateTime updated;
  const User({
    required this.id,
    required this.name,
    this.avatar,
    required this.created,
    required this.updated,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || avatar != null) {
      map['avatar'] = Variable<String>(avatar);
    }
    map['created'] = Variable<DateTime>(created);
    map['updated'] = Variable<DateTime>(updated);
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      name: Value(name),
      avatar:
          avatar == null && nullToAbsent ? const Value.absent() : Value(avatar),
      created: Value(created),
      updated: Value(updated),
    );
  }

  factory User.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      avatar: serializer.fromJson<String?>(json['avatar']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated: serializer.fromJson<DateTime>(json['updated']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'avatar': serializer.toJson<String?>(avatar),
      'created': serializer.toJson<DateTime>(created),
      'updated': serializer.toJson<DateTime>(updated),
    };
  }

  User copyWith({
    int? id,
    String? name,
    Value<String?> avatar = const Value.absent(),
    DateTime? created,
    DateTime? updated,
  }) => User(
    id: id ?? this.id,
    name: name ?? this.name,
    avatar: avatar.present ? avatar.value : this.avatar,
    created: created ?? this.created,
    updated: updated ?? this.updated,
  );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      avatar: data.avatar.present ? data.avatar.value : this.avatar,
      created: data.created.present ? data.created.value : this.created,
      updated: data.updated.present ? data.updated.value : this.updated,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, avatar, created, updated);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.name == this.name &&
          other.avatar == this.avatar &&
          other.created == this.created &&
          other.updated == this.updated);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> avatar;
  final Value<DateTime> created;
  final Value<DateTime> updated;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.avatar = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.avatar = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
  }) : name = Value(name);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? avatar,
    Expression<DateTime>? created,
    Expression<DateTime>? updated,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (avatar != null) 'avatar': avatar,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
    });
  }

  UsersCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<String?>? avatar,
    Value<DateTime>? created,
    Value<DateTime>? updated,
  }) {
    return UsersCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      created: created ?? this.created,
      updated: updated ?? this.updated,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (avatar.present) {
      map['avatar'] = Variable<String>(avatar.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('avatar: $avatar, ')
          ..write('created: $created, ')
          ..write('updated: $updated')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 50,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<String> details = GeneratedColumn<String>(
    'details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdMeta = const VerificationMeta(
    'created',
  );
  @override
  late final GeneratedColumn<DateTime> created = GeneratedColumn<DateTime>(
    'created',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  static const VerificationMeta _updatedMeta = const VerificationMeta(
    'updated',
  );
  @override
  late final GeneratedColumn<DateTime> updated = GeneratedColumn<DateTime>(
    'updated',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<DateTime> completed = GeneratedColumn<DateTime>(
    'completed',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weekDaysRawMeta = const VerificationMeta(
    'weekDaysRaw',
  );
  @override
  late final GeneratedColumn<int> weekDaysRaw = GeneratedColumn<int>(
    'week_days_raw',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    name,
    details,
    created,
    updated,
    completed,
    weekDaysRaw,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('created')) {
      context.handle(
        _createdMeta,
        created.isAcceptableOrUnknown(data['created']!, _createdMeta),
      );
    }
    if (data.containsKey('updated')) {
      context.handle(
        _updatedMeta,
        updated.isAcceptableOrUnknown(data['updated']!, _updatedMeta),
      );
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    if (data.containsKey('week_days_raw')) {
      context.handle(
        _weekDaysRawMeta,
        weekDaysRaw.isAcceptableOrUnknown(
          data['week_days_raw']!,
          _weekDaysRawMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_weekDaysRawMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      details: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}details'],
      ),
      created:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}created'],
          )!,
      updated:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}updated'],
          )!,
      completed: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed'],
      ),
      weekDaysRaw:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}week_days_raw'],
          )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final int id;
  final int userId;
  final String name;
  final String? details;
  final DateTime created;
  final DateTime updated;
  final DateTime? completed;
  final int weekDaysRaw;
  const Habit({
    required this.id,
    required this.userId,
    required this.name,
    this.details,
    required this.created,
    required this.updated,
    this.completed,
    required this.weekDaysRaw,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<String>(details);
    }
    map['created'] = Variable<DateTime>(created);
    map['updated'] = Variable<DateTime>(updated);
    if (!nullToAbsent || completed != null) {
      map['completed'] = Variable<DateTime>(completed);
    }
    map['week_days_raw'] = Variable<int>(weekDaysRaw);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      userId: Value(userId),
      name: Value(name),
      details:
          details == null && nullToAbsent
              ? const Value.absent()
              : Value(details),
      created: Value(created),
      updated: Value(updated),
      completed:
          completed == null && nullToAbsent
              ? const Value.absent()
              : Value(completed),
      weekDaysRaw: Value(weekDaysRaw),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      name: serializer.fromJson<String>(json['name']),
      details: serializer.fromJson<String?>(json['details']),
      created: serializer.fromJson<DateTime>(json['created']),
      updated: serializer.fromJson<DateTime>(json['updated']),
      completed: serializer.fromJson<DateTime?>(json['completed']),
      weekDaysRaw: serializer.fromJson<int>(json['weekDaysRaw']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'name': serializer.toJson<String>(name),
      'details': serializer.toJson<String?>(details),
      'created': serializer.toJson<DateTime>(created),
      'updated': serializer.toJson<DateTime>(updated),
      'completed': serializer.toJson<DateTime?>(completed),
      'weekDaysRaw': serializer.toJson<int>(weekDaysRaw),
    };
  }

  Habit copyWith({
    int? id,
    int? userId,
    String? name,
    Value<String?> details = const Value.absent(),
    DateTime? created,
    DateTime? updated,
    Value<DateTime?> completed = const Value.absent(),
    int? weekDaysRaw,
  }) => Habit(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    details: details.present ? details.value : this.details,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    completed: completed.present ? completed.value : this.completed,
    weekDaysRaw: weekDaysRaw ?? this.weekDaysRaw,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      name: data.name.present ? data.name.value : this.name,
      details: data.details.present ? data.details.value : this.details,
      created: data.created.present ? data.created.value : this.created,
      updated: data.updated.present ? data.updated.value : this.updated,
      completed: data.completed.present ? data.completed.value : this.completed,
      weekDaysRaw:
          data.weekDaysRaw.present ? data.weekDaysRaw.value : this.weekDaysRaw,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('details: $details, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('completed: $completed, ')
          ..write('weekDaysRaw: $weekDaysRaw')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    name,
    details,
    created,
    updated,
    completed,
    weekDaysRaw,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.name == this.name &&
          other.details == this.details &&
          other.created == this.created &&
          other.updated == this.updated &&
          other.completed == this.completed &&
          other.weekDaysRaw == this.weekDaysRaw);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<int> id;
  final Value<int> userId;
  final Value<String> name;
  final Value<String?> details;
  final Value<DateTime> created;
  final Value<DateTime> updated;
  final Value<DateTime?> completed;
  final Value<int> weekDaysRaw;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.name = const Value.absent(),
    this.details = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.completed = const Value.absent(),
    this.weekDaysRaw = const Value.absent(),
  });
  HabitsCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required String name,
    this.details = const Value.absent(),
    this.created = const Value.absent(),
    this.updated = const Value.absent(),
    this.completed = const Value.absent(),
    required int weekDaysRaw,
  }) : userId = Value(userId),
       name = Value(name),
       weekDaysRaw = Value(weekDaysRaw);
  static Insertable<Habit> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? name,
    Expression<String>? details,
    Expression<DateTime>? created,
    Expression<DateTime>? updated,
    Expression<DateTime>? completed,
    Expression<int>? weekDaysRaw,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (name != null) 'name': name,
      if (details != null) 'details': details,
      if (created != null) 'created': created,
      if (updated != null) 'updated': updated,
      if (completed != null) 'completed': completed,
      if (weekDaysRaw != null) 'week_days_raw': weekDaysRaw,
    });
  }

  HabitsCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<String>? name,
    Value<String?>? details,
    Value<DateTime>? created,
    Value<DateTime>? updated,
    Value<DateTime?>? completed,
    Value<int>? weekDaysRaw,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      details: details ?? this.details,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      completed: completed ?? this.completed,
      weekDaysRaw: weekDaysRaw ?? this.weekDaysRaw,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (details.present) {
      map['details'] = Variable<String>(details.value);
    }
    if (created.present) {
      map['created'] = Variable<DateTime>(created.value);
    }
    if (updated.present) {
      map['updated'] = Variable<DateTime>(updated.value);
    }
    if (completed.present) {
      map['completed'] = Variable<DateTime>(completed.value);
    }
    if (weekDaysRaw.present) {
      map['week_days_raw'] = Variable<int>(weekDaysRaw.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('name: $name, ')
          ..write('details: $details, ')
          ..write('created: $created, ')
          ..write('updated: $updated, ')
          ..write('completed: $completed, ')
          ..write('weekDaysRaw: $weekDaysRaw')
          ..write(')'))
        .toString();
  }
}

class $HourIntervalsTable extends HourIntervals
    with TableInfo<$HourIntervalsTable, HourInterval> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HourIntervalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, habitId, time];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hour_intervals';
  @override
  VerificationContext validateIntegrity(
    Insertable<HourInterval> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HourInterval map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HourInterval(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}habit_id'],
          )!,
      time:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}time'],
          )!,
    );
  }

  @override
  $HourIntervalsTable createAlias(String alias) {
    return $HourIntervalsTable(attachedDatabase, alias);
  }
}

class HourInterval extends DataClass implements Insertable<HourInterval> {
  final int id;
  final int habitId;
  final int time;
  const HourInterval({
    required this.id,
    required this.habitId,
    required this.time,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['time'] = Variable<int>(time);
    return map;
  }

  HourIntervalsCompanion toCompanion(bool nullToAbsent) {
    return HourIntervalsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      time: Value(time),
    );
  }

  factory HourInterval.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HourInterval(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      time: serializer.fromJson<int>(json['time']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'time': serializer.toJson<int>(time),
    };
  }

  HourInterval copyWith({int? id, int? habitId, int? time}) => HourInterval(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    time: time ?? this.time,
  );
  HourInterval copyWithCompanion(HourIntervalsCompanion data) {
    return HourInterval(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      time: data.time.present ? data.time.value : this.time,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HourInterval(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, time);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HourInterval &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.time == this.time);
}

class HourIntervalsCompanion extends UpdateCompanion<HourInterval> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> time;
  const HourIntervalsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.time = const Value.absent(),
  });
  HourIntervalsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int time,
  }) : habitId = Value(habitId),
       time = Value(time);
  static Insertable<HourInterval> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? time,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (time != null) 'time': time,
    });
  }

  HourIntervalsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? time,
  }) {
    return HourIntervalsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      time: time ?? this.time,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HourIntervalsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('time: $time')
          ..write(')'))
        .toString();
  }
}

class $HourIntervalCompletedsTable extends HourIntervalCompleteds
    with TableInfo<$HourIntervalCompletedsTable, HourIntervalCompleted> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HourIntervalCompletedsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalIdMeta = const VerificationMeta(
    'intervalId',
  );
  @override
  late final GeneratedColumn<int> intervalId = GeneratedColumn<int>(
    'interval_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedMeta = const VerificationMeta(
    'completed',
  );
  @override
  late final GeneratedColumn<DateTime> completed = GeneratedColumn<DateTime>(
    'completed',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    clientDefault: () => DateTime.now(),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    intervalId,
    time,
    completed,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'hour_interval_completeds';
  @override
  VerificationContext validateIntegrity(
    Insertable<HourIntervalCompleted> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('interval_id')) {
      context.handle(
        _intervalIdMeta,
        intervalId.isAcceptableOrUnknown(data['interval_id']!, _intervalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalIdMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(
        _completedMeta,
        completed.isAcceptableOrUnknown(data['completed']!, _completedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HourIntervalCompleted map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HourIntervalCompleted(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}habit_id'],
          )!,
      intervalId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}interval_id'],
          )!,
      time:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}time'],
          )!,
      completed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}completed'],
          )!,
    );
  }

  @override
  $HourIntervalCompletedsTable createAlias(String alias) {
    return $HourIntervalCompletedsTable(attachedDatabase, alias);
  }
}

class HourIntervalCompleted extends DataClass
    implements Insertable<HourIntervalCompleted> {
  final int id;
  final int habitId;
  final int intervalId;
  final int time;
  final DateTime completed;
  const HourIntervalCompleted({
    required this.id,
    required this.habitId,
    required this.intervalId,
    required this.time,
    required this.completed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['habit_id'] = Variable<int>(habitId);
    map['interval_id'] = Variable<int>(intervalId);
    map['time'] = Variable<int>(time);
    map['completed'] = Variable<DateTime>(completed);
    return map;
  }

  HourIntervalCompletedsCompanion toCompanion(bool nullToAbsent) {
    return HourIntervalCompletedsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      intervalId: Value(intervalId),
      time: Value(time),
      completed: Value(completed),
    );
  }

  factory HourIntervalCompleted.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HourIntervalCompleted(
      id: serializer.fromJson<int>(json['id']),
      habitId: serializer.fromJson<int>(json['habitId']),
      intervalId: serializer.fromJson<int>(json['intervalId']),
      time: serializer.fromJson<int>(json['time']),
      completed: serializer.fromJson<DateTime>(json['completed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'habitId': serializer.toJson<int>(habitId),
      'intervalId': serializer.toJson<int>(intervalId),
      'time': serializer.toJson<int>(time),
      'completed': serializer.toJson<DateTime>(completed),
    };
  }

  HourIntervalCompleted copyWith({
    int? id,
    int? habitId,
    int? intervalId,
    int? time,
    DateTime? completed,
  }) => HourIntervalCompleted(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    intervalId: intervalId ?? this.intervalId,
    time: time ?? this.time,
    completed: completed ?? this.completed,
  );
  HourIntervalCompleted copyWithCompanion(
    HourIntervalCompletedsCompanion data,
  ) {
    return HourIntervalCompleted(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      intervalId:
          data.intervalId.present ? data.intervalId.value : this.intervalId,
      time: data.time.present ? data.time.value : this.time,
      completed: data.completed.present ? data.completed.value : this.completed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HourIntervalCompleted(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('intervalId: $intervalId, ')
          ..write('time: $time, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, intervalId, time, completed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HourIntervalCompleted &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.intervalId == this.intervalId &&
          other.time == this.time &&
          other.completed == this.completed);
}

class HourIntervalCompletedsCompanion
    extends UpdateCompanion<HourIntervalCompleted> {
  final Value<int> id;
  final Value<int> habitId;
  final Value<int> intervalId;
  final Value<int> time;
  final Value<DateTime> completed;
  const HourIntervalCompletedsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.intervalId = const Value.absent(),
    this.time = const Value.absent(),
    this.completed = const Value.absent(),
  });
  HourIntervalCompletedsCompanion.insert({
    this.id = const Value.absent(),
    required int habitId,
    required int intervalId,
    required int time,
    this.completed = const Value.absent(),
  }) : habitId = Value(habitId),
       intervalId = Value(intervalId),
       time = Value(time);
  static Insertable<HourIntervalCompleted> custom({
    Expression<int>? id,
    Expression<int>? habitId,
    Expression<int>? intervalId,
    Expression<int>? time,
    Expression<DateTime>? completed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (intervalId != null) 'interval_id': intervalId,
      if (time != null) 'time': time,
      if (completed != null) 'completed': completed,
    });
  }

  HourIntervalCompletedsCompanion copyWith({
    Value<int>? id,
    Value<int>? habitId,
    Value<int>? intervalId,
    Value<int>? time,
    Value<DateTime>? completed,
  }) {
    return HourIntervalCompletedsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      intervalId: intervalId ?? this.intervalId,
      time: time ?? this.time,
      completed: completed ?? this.completed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (intervalId.present) {
      map['interval_id'] = Variable<int>(intervalId.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (completed.present) {
      map['completed'] = Variable<DateTime>(completed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HourIntervalCompletedsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('intervalId: $intervalId, ')
          ..write('time: $time, ')
          ..write('completed: $completed')
          ..write(')'))
        .toString();
  }
}

class $HabitNotificationDatasTable extends HabitNotificationDatas
    with TableInfo<$HabitNotificationDatasTable, HabitNotificationData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitNotificationDatasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<int> habitId = GeneratedColumn<int>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _intervalIdMeta = const VerificationMeta(
    'intervalId',
  );
  @override
  late final GeneratedColumn<int> intervalId = GeneratedColumn<int>(
    'interval_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekDayMeta = const VerificationMeta(
    'weekDay',
  );
  @override
  late final GeneratedColumn<int> weekDay = GeneratedColumn<int>(
    'week_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<int> time = GeneratedColumn<int>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _repeatsMeta = const VerificationMeta(
    'repeats',
  );
  @override
  late final GeneratedColumn<bool> repeats = GeneratedColumn<bool>(
    'repeats',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("repeats" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    userId,
    habitId,
    intervalId,
    title,
    weekDay,
    time,
    repeats,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_notification_datas';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitNotificationData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('interval_id')) {
      context.handle(
        _intervalIdMeta,
        intervalId.isAcceptableOrUnknown(data['interval_id']!, _intervalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_intervalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('week_day')) {
      context.handle(
        _weekDayMeta,
        weekDay.isAcceptableOrUnknown(data['week_day']!, _weekDayMeta),
      );
    } else if (isInserting) {
      context.missing(_weekDayMeta);
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('repeats')) {
      context.handle(
        _repeatsMeta,
        repeats.isAcceptableOrUnknown(data['repeats']!, _repeatsMeta),
      );
    } else if (isInserting) {
      context.missing(_repeatsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  HabitNotificationData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitNotificationData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}user_id'],
          )!,
      habitId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}habit_id'],
          )!,
      intervalId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}interval_id'],
          )!,
      title:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}title'],
          )!,
      weekDay:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}week_day'],
          )!,
      time:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}time'],
          )!,
      repeats:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}repeats'],
          )!,
    );
  }

  @override
  $HabitNotificationDatasTable createAlias(String alias) {
    return $HabitNotificationDatasTable(attachedDatabase, alias);
  }
}

class HabitNotificationData extends DataClass
    implements Insertable<HabitNotificationData> {
  final int id;
  final int userId;
  final int habitId;
  final int intervalId;
  final String title;
  final int weekDay;
  final int time;
  final bool repeats;
  const HabitNotificationData({
    required this.id,
    required this.userId,
    required this.habitId,
    required this.intervalId,
    required this.title,
    required this.weekDay,
    required this.time,
    required this.repeats,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['user_id'] = Variable<int>(userId);
    map['habit_id'] = Variable<int>(habitId);
    map['interval_id'] = Variable<int>(intervalId);
    map['title'] = Variable<String>(title);
    map['week_day'] = Variable<int>(weekDay);
    map['time'] = Variable<int>(time);
    map['repeats'] = Variable<bool>(repeats);
    return map;
  }

  HabitNotificationDatasCompanion toCompanion(bool nullToAbsent) {
    return HabitNotificationDatasCompanion(
      id: Value(id),
      userId: Value(userId),
      habitId: Value(habitId),
      intervalId: Value(intervalId),
      title: Value(title),
      weekDay: Value(weekDay),
      time: Value(time),
      repeats: Value(repeats),
    );
  }

  factory HabitNotificationData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitNotificationData(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int>(json['userId']),
      habitId: serializer.fromJson<int>(json['habitId']),
      intervalId: serializer.fromJson<int>(json['intervalId']),
      title: serializer.fromJson<String>(json['title']),
      weekDay: serializer.fromJson<int>(json['weekDay']),
      time: serializer.fromJson<int>(json['time']),
      repeats: serializer.fromJson<bool>(json['repeats']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int>(userId),
      'habitId': serializer.toJson<int>(habitId),
      'intervalId': serializer.toJson<int>(intervalId),
      'title': serializer.toJson<String>(title),
      'weekDay': serializer.toJson<int>(weekDay),
      'time': serializer.toJson<int>(time),
      'repeats': serializer.toJson<bool>(repeats),
    };
  }

  HabitNotificationData copyWith({
    int? id,
    int? userId,
    int? habitId,
    int? intervalId,
    String? title,
    int? weekDay,
    int? time,
    bool? repeats,
  }) => HabitNotificationData(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    habitId: habitId ?? this.habitId,
    intervalId: intervalId ?? this.intervalId,
    title: title ?? this.title,
    weekDay: weekDay ?? this.weekDay,
    time: time ?? this.time,
    repeats: repeats ?? this.repeats,
  );
  HabitNotificationData copyWithCompanion(
    HabitNotificationDatasCompanion data,
  ) {
    return HabitNotificationData(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      intervalId:
          data.intervalId.present ? data.intervalId.value : this.intervalId,
      title: data.title.present ? data.title.value : this.title,
      weekDay: data.weekDay.present ? data.weekDay.value : this.weekDay,
      time: data.time.present ? data.time.value : this.time,
      repeats: data.repeats.present ? data.repeats.value : this.repeats,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitNotificationData(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('habitId: $habitId, ')
          ..write('intervalId: $intervalId, ')
          ..write('title: $title, ')
          ..write('weekDay: $weekDay, ')
          ..write('time: $time, ')
          ..write('repeats: $repeats')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    userId,
    habitId,
    intervalId,
    title,
    weekDay,
    time,
    repeats,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitNotificationData &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.habitId == this.habitId &&
          other.intervalId == this.intervalId &&
          other.title == this.title &&
          other.weekDay == this.weekDay &&
          other.time == this.time &&
          other.repeats == this.repeats);
}

class HabitNotificationDatasCompanion
    extends UpdateCompanion<HabitNotificationData> {
  final Value<int> id;
  final Value<int> userId;
  final Value<int> habitId;
  final Value<int> intervalId;
  final Value<String> title;
  final Value<int> weekDay;
  final Value<int> time;
  final Value<bool> repeats;
  const HabitNotificationDatasCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.habitId = const Value.absent(),
    this.intervalId = const Value.absent(),
    this.title = const Value.absent(),
    this.weekDay = const Value.absent(),
    this.time = const Value.absent(),
    this.repeats = const Value.absent(),
  });
  HabitNotificationDatasCompanion.insert({
    this.id = const Value.absent(),
    required int userId,
    required int habitId,
    required int intervalId,
    required String title,
    required int weekDay,
    required int time,
    required bool repeats,
  }) : userId = Value(userId),
       habitId = Value(habitId),
       intervalId = Value(intervalId),
       title = Value(title),
       weekDay = Value(weekDay),
       time = Value(time),
       repeats = Value(repeats);
  static Insertable<HabitNotificationData> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<int>? habitId,
    Expression<int>? intervalId,
    Expression<String>? title,
    Expression<int>? weekDay,
    Expression<int>? time,
    Expression<bool>? repeats,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (habitId != null) 'habit_id': habitId,
      if (intervalId != null) 'interval_id': intervalId,
      if (title != null) 'title': title,
      if (weekDay != null) 'week_day': weekDay,
      if (time != null) 'time': time,
      if (repeats != null) 'repeats': repeats,
    });
  }

  HabitNotificationDatasCompanion copyWith({
    Value<int>? id,
    Value<int>? userId,
    Value<int>? habitId,
    Value<int>? intervalId,
    Value<String>? title,
    Value<int>? weekDay,
    Value<int>? time,
    Value<bool>? repeats,
  }) {
    return HabitNotificationDatasCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      habitId: habitId ?? this.habitId,
      intervalId: intervalId ?? this.intervalId,
      title: title ?? this.title,
      weekDay: weekDay ?? this.weekDay,
      time: time ?? this.time,
      repeats: repeats ?? this.repeats,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<int>(habitId.value);
    }
    if (intervalId.present) {
      map['interval_id'] = Variable<int>(intervalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (weekDay.present) {
      map['week_day'] = Variable<int>(weekDay.value);
    }
    if (time.present) {
      map['time'] = Variable<int>(time.value);
    }
    if (repeats.present) {
      map['repeats'] = Variable<bool>(repeats.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitNotificationDatasCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('habitId: $habitId, ')
          ..write('intervalId: $intervalId, ')
          ..write('title: $title, ')
          ..write('weekDay: $weekDay, ')
          ..write('time: $time, ')
          ..write('repeats: $repeats')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HourIntervalsTable hourIntervals = $HourIntervalsTable(this);
  late final $HourIntervalCompletedsTable hourIntervalCompleteds =
      $HourIntervalCompletedsTable(this);
  late final $HabitNotificationDatasTable habitNotificationDatas =
      $HabitNotificationDatasTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    users,
    habits,
    hourIntervals,
    hourIntervalCompleteds,
    habitNotificationDatas,
  ];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$UsersTableCreateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      required String name,
      Value<String?> avatar,
      Value<DateTime> created,
      Value<DateTime> updated,
    });
typedef $$UsersTableUpdateCompanionBuilder =
    UsersCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<String?> avatar,
      Value<DateTime> created,
      Value<DateTime> updated,
    });

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatar => $composableBuilder(
    column: $table.avatar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get avatar =>
      $composableBuilder(column: $table.avatar, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);
}

class $$UsersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UsersTable,
          User,
          $$UsersTableFilterComposer,
          $$UsersTableOrderingComposer,
          $$UsersTableAnnotationComposer,
          $$UsersTableCreateCompanionBuilder,
          $$UsersTableUpdateCompanionBuilder,
          (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
          User,
          PrefetchHooks Function()
        > {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> avatar = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
              }) => UsersCompanion(
                id: id,
                name: name,
                avatar: avatar,
                created: created,
                updated: updated,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<String?> avatar = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
              }) => UsersCompanion.insert(
                id: id,
                name: name,
                avatar: avatar,
                created: created,
                updated: updated,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UsersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UsersTable,
      User,
      $$UsersTableFilterComposer,
      $$UsersTableOrderingComposer,
      $$UsersTableAnnotationComposer,
      $$UsersTableCreateCompanionBuilder,
      $$UsersTableUpdateCompanionBuilder,
      (User, BaseReferences<_$AppDatabase, $UsersTable, User>),
      User,
      PrefetchHooks Function()
    >;
typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      required int userId,
      required String name,
      Value<String?> details,
      Value<DateTime> created,
      Value<DateTime> updated,
      Value<DateTime?> completed,
      required int weekDaysRaw,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<String> name,
      Value<String?> details,
      Value<DateTime> created,
      Value<DateTime> updated,
      Value<DateTime?> completed,
      Value<int> weekDaysRaw,
    });

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekDaysRaw => $composableBuilder(
    column: $table.weekDaysRaw,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get created => $composableBuilder(
    column: $table.created,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updated => $composableBuilder(
    column: $table.updated,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekDaysRaw => $composableBuilder(
    column: $table.weekDaysRaw,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<DateTime> get created =>
      $composableBuilder(column: $table.created, builder: (column) => column);

  GeneratedColumn<DateTime> get updated =>
      $composableBuilder(column: $table.updated, builder: (column) => column);

  GeneratedColumn<DateTime> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);

  GeneratedColumn<int> get weekDaysRaw => $composableBuilder(
    column: $table.weekDaysRaw,
    builder: (column) => column,
  );
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
          Habit,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> details = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
                Value<DateTime?> completed = const Value.absent(),
                Value<int> weekDaysRaw = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                userId: userId,
                name: name,
                details: details,
                created: created,
                updated: updated,
                completed: completed,
                weekDaysRaw: weekDaysRaw,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required String name,
                Value<String?> details = const Value.absent(),
                Value<DateTime> created = const Value.absent(),
                Value<DateTime> updated = const Value.absent(),
                Value<DateTime?> completed = const Value.absent(),
                required int weekDaysRaw,
              }) => HabitsCompanion.insert(
                id: id,
                userId: userId,
                name: name,
                details: details,
                created: created,
                updated: updated,
                completed: completed,
                weekDaysRaw: weekDaysRaw,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
      Habit,
      PrefetchHooks Function()
    >;
typedef $$HourIntervalsTableCreateCompanionBuilder =
    HourIntervalsCompanion Function({
      Value<int> id,
      required int habitId,
      required int time,
    });
typedef $$HourIntervalsTableUpdateCompanionBuilder =
    HourIntervalsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> time,
    });

class $$HourIntervalsTableFilterComposer
    extends Composer<_$AppDatabase, $HourIntervalsTable> {
  $$HourIntervalsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HourIntervalsTableOrderingComposer
    extends Composer<_$AppDatabase, $HourIntervalsTable> {
  $$HourIntervalsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HourIntervalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HourIntervalsTable> {
  $$HourIntervalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);
}

class $$HourIntervalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HourIntervalsTable,
          HourInterval,
          $$HourIntervalsTableFilterComposer,
          $$HourIntervalsTableOrderingComposer,
          $$HourIntervalsTableAnnotationComposer,
          $$HourIntervalsTableCreateCompanionBuilder,
          $$HourIntervalsTableUpdateCompanionBuilder,
          (
            HourInterval,
            BaseReferences<_$AppDatabase, $HourIntervalsTable, HourInterval>,
          ),
          HourInterval,
          PrefetchHooks Function()
        > {
  $$HourIntervalsTableTableManager(_$AppDatabase db, $HourIntervalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HourIntervalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$HourIntervalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$HourIntervalsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> time = const Value.absent(),
              }) =>
                  HourIntervalsCompanion(id: id, habitId: habitId, time: time),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int time,
              }) => HourIntervalsCompanion.insert(
                id: id,
                habitId: habitId,
                time: time,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HourIntervalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HourIntervalsTable,
      HourInterval,
      $$HourIntervalsTableFilterComposer,
      $$HourIntervalsTableOrderingComposer,
      $$HourIntervalsTableAnnotationComposer,
      $$HourIntervalsTableCreateCompanionBuilder,
      $$HourIntervalsTableUpdateCompanionBuilder,
      (
        HourInterval,
        BaseReferences<_$AppDatabase, $HourIntervalsTable, HourInterval>,
      ),
      HourInterval,
      PrefetchHooks Function()
    >;
typedef $$HourIntervalCompletedsTableCreateCompanionBuilder =
    HourIntervalCompletedsCompanion Function({
      Value<int> id,
      required int habitId,
      required int intervalId,
      required int time,
      Value<DateTime> completed,
    });
typedef $$HourIntervalCompletedsTableUpdateCompanionBuilder =
    HourIntervalCompletedsCompanion Function({
      Value<int> id,
      Value<int> habitId,
      Value<int> intervalId,
      Value<int> time,
      Value<DateTime> completed,
    });

class $$HourIntervalCompletedsTableFilterComposer
    extends Composer<_$AppDatabase, $HourIntervalCompletedsTable> {
  $$HourIntervalCompletedsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HourIntervalCompletedsTableOrderingComposer
    extends Composer<_$AppDatabase, $HourIntervalCompletedsTable> {
  $$HourIntervalCompletedsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completed => $composableBuilder(
    column: $table.completed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HourIntervalCompletedsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HourIntervalCompletedsTable> {
  $$HourIntervalCompletedsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<DateTime> get completed =>
      $composableBuilder(column: $table.completed, builder: (column) => column);
}

class $$HourIntervalCompletedsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HourIntervalCompletedsTable,
          HourIntervalCompleted,
          $$HourIntervalCompletedsTableFilterComposer,
          $$HourIntervalCompletedsTableOrderingComposer,
          $$HourIntervalCompletedsTableAnnotationComposer,
          $$HourIntervalCompletedsTableCreateCompanionBuilder,
          $$HourIntervalCompletedsTableUpdateCompanionBuilder,
          (
            HourIntervalCompleted,
            BaseReferences<
              _$AppDatabase,
              $HourIntervalCompletedsTable,
              HourIntervalCompleted
            >,
          ),
          HourIntervalCompleted,
          PrefetchHooks Function()
        > {
  $$HourIntervalCompletedsTableTableManager(
    _$AppDatabase db,
    $HourIntervalCompletedsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HourIntervalCompletedsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$HourIntervalCompletedsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$HourIntervalCompletedsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> intervalId = const Value.absent(),
                Value<int> time = const Value.absent(),
                Value<DateTime> completed = const Value.absent(),
              }) => HourIntervalCompletedsCompanion(
                id: id,
                habitId: habitId,
                intervalId: intervalId,
                time: time,
                completed: completed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int habitId,
                required int intervalId,
                required int time,
                Value<DateTime> completed = const Value.absent(),
              }) => HourIntervalCompletedsCompanion.insert(
                id: id,
                habitId: habitId,
                intervalId: intervalId,
                time: time,
                completed: completed,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HourIntervalCompletedsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HourIntervalCompletedsTable,
      HourIntervalCompleted,
      $$HourIntervalCompletedsTableFilterComposer,
      $$HourIntervalCompletedsTableOrderingComposer,
      $$HourIntervalCompletedsTableAnnotationComposer,
      $$HourIntervalCompletedsTableCreateCompanionBuilder,
      $$HourIntervalCompletedsTableUpdateCompanionBuilder,
      (
        HourIntervalCompleted,
        BaseReferences<
          _$AppDatabase,
          $HourIntervalCompletedsTable,
          HourIntervalCompleted
        >,
      ),
      HourIntervalCompleted,
      PrefetchHooks Function()
    >;
typedef $$HabitNotificationDatasTableCreateCompanionBuilder =
    HabitNotificationDatasCompanion Function({
      Value<int> id,
      required int userId,
      required int habitId,
      required int intervalId,
      required String title,
      required int weekDay,
      required int time,
      required bool repeats,
    });
typedef $$HabitNotificationDatasTableUpdateCompanionBuilder =
    HabitNotificationDatasCompanion Function({
      Value<int> id,
      Value<int> userId,
      Value<int> habitId,
      Value<int> intervalId,
      Value<String> title,
      Value<int> weekDay,
      Value<int> time,
      Value<bool> repeats,
    });

class $$HabitNotificationDatasTableFilterComposer
    extends Composer<_$AppDatabase, $HabitNotificationDatasTable> {
  $$HabitNotificationDatasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekDay => $composableBuilder(
    column: $table.weekDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get repeats => $composableBuilder(
    column: $table.repeats,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitNotificationDatasTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitNotificationDatasTable> {
  $$HabitNotificationDatasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekDay => $composableBuilder(
    column: $table.weekDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get repeats => $composableBuilder(
    column: $table.repeats,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitNotificationDatasTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitNotificationDatasTable> {
  $$HabitNotificationDatasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<int> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<int> get intervalId => $composableBuilder(
    column: $table.intervalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get weekDay =>
      $composableBuilder(column: $table.weekDay, builder: (column) => column);

  GeneratedColumn<int> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<bool> get repeats =>
      $composableBuilder(column: $table.repeats, builder: (column) => column);
}

class $$HabitNotificationDatasTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitNotificationDatasTable,
          HabitNotificationData,
          $$HabitNotificationDatasTableFilterComposer,
          $$HabitNotificationDatasTableOrderingComposer,
          $$HabitNotificationDatasTableAnnotationComposer,
          $$HabitNotificationDatasTableCreateCompanionBuilder,
          $$HabitNotificationDatasTableUpdateCompanionBuilder,
          (
            HabitNotificationData,
            BaseReferences<
              _$AppDatabase,
              $HabitNotificationDatasTable,
              HabitNotificationData
            >,
          ),
          HabitNotificationData,
          PrefetchHooks Function()
        > {
  $$HabitNotificationDatasTableTableManager(
    _$AppDatabase db,
    $HabitNotificationDatasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$HabitNotificationDatasTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$HabitNotificationDatasTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$HabitNotificationDatasTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> userId = const Value.absent(),
                Value<int> habitId = const Value.absent(),
                Value<int> intervalId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> weekDay = const Value.absent(),
                Value<int> time = const Value.absent(),
                Value<bool> repeats = const Value.absent(),
              }) => HabitNotificationDatasCompanion(
                id: id,
                userId: userId,
                habitId: habitId,
                intervalId: intervalId,
                title: title,
                weekDay: weekDay,
                time: time,
                repeats: repeats,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int userId,
                required int habitId,
                required int intervalId,
                required String title,
                required int weekDay,
                required int time,
                required bool repeats,
              }) => HabitNotificationDatasCompanion.insert(
                id: id,
                userId: userId,
                habitId: habitId,
                intervalId: intervalId,
                title: title,
                weekDay: weekDay,
                time: time,
                repeats: repeats,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$HabitNotificationDatasTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitNotificationDatasTable,
      HabitNotificationData,
      $$HabitNotificationDatasTableFilterComposer,
      $$HabitNotificationDatasTableOrderingComposer,
      $$HabitNotificationDatasTableAnnotationComposer,
      $$HabitNotificationDatasTableCreateCompanionBuilder,
      $$HabitNotificationDatasTableUpdateCompanionBuilder,
      (
        HabitNotificationData,
        BaseReferences<
          _$AppDatabase,
          $HabitNotificationDatasTable,
          HabitNotificationData
        >,
      ),
      HabitNotificationData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HourIntervalsTableTableManager get hourIntervals =>
      $$HourIntervalsTableTableManager(_db, _db.hourIntervals);
  $$HourIntervalCompletedsTableTableManager get hourIntervalCompleteds =>
      $$HourIntervalCompletedsTableTableManager(
        _db,
        _db.hourIntervalCompleteds,
      );
  $$HabitNotificationDatasTableTableManager get habitNotificationDatas =>
      $$HabitNotificationDatasTableTableManager(
        _db,
        _db.habitNotificationDatas,
      );
}
