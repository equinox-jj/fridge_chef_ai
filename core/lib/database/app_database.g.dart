// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarUrlMeta = const VerificationMeta(
    'avatarUrl',
  );
  @override
  late final GeneratedColumn<String> avatarUrl = GeneratedColumn<String>(
    'avatar_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dietaryPreferencesMeta = const VerificationMeta('dietaryPreferences');
  @override
  late final GeneratedColumn<String> dietaryPreferences = GeneratedColumn<String>(
    'dietary_preferences',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    avatarUrl,
    dietaryPreferences,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('avatar_url')) {
      context.handle(
        _avatarUrlMeta,
        avatarUrl.isAcceptableOrUnknown(data['avatar_url']!, _avatarUrlMeta),
      );
    }
    if (data.containsKey('dietary_preferences')) {
      context.handle(
        _dietaryPreferencesMeta,
        dietaryPreferences.isAcceptableOrUnknown(
          data['dietary_preferences']!,
          _dietaryPreferencesMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      avatarUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}avatar_url'],
      ),
      dietaryPreferences: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dietary_preferences'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      ),
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String? name;
  final String? email;
  final String? avatarUrl;
  final String? dietaryPreferences;
  final DateTime? createdAt;
  const UserProfile({
    required this.id,
    this.name,
    this.email,
    this.avatarUrl,
    this.dietaryPreferences,
    this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || name != null) {
      map['name'] = Variable<String>(name);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || avatarUrl != null) {
      map['avatar_url'] = Variable<String>(avatarUrl);
    }
    if (!nullToAbsent || dietaryPreferences != null) {
      map['dietary_preferences'] = Variable<String>(dietaryPreferences);
    }
    if (!nullToAbsent || createdAt != null) {
      map['created_at'] = Variable<DateTime>(createdAt);
    }
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      email: email == null && nullToAbsent ? const Value.absent() : Value(email),
      avatarUrl: avatarUrl == null && nullToAbsent ? const Value.absent() : Value(avatarUrl),
      dietaryPreferences: dietaryPreferences == null && nullToAbsent ? const Value.absent() : Value(dietaryPreferences),
      createdAt: createdAt == null && nullToAbsent ? const Value.absent() : Value(createdAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String?>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      avatarUrl: serializer.fromJson<String?>(json['avatarUrl']),
      dietaryPreferences: serializer.fromJson<String?>(
        json['dietaryPreferences'],
      ),
      createdAt: serializer.fromJson<DateTime?>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String?>(name),
      'email': serializer.toJson<String?>(email),
      'avatarUrl': serializer.toJson<String?>(avatarUrl),
      'dietaryPreferences': serializer.toJson<String?>(dietaryPreferences),
      'createdAt': serializer.toJson<DateTime?>(createdAt),
    };
  }

  UserProfile copyWith({
    String? id,
    Value<String?> name = const Value.absent(),
    Value<String?> email = const Value.absent(),
    Value<String?> avatarUrl = const Value.absent(),
    Value<String?> dietaryPreferences = const Value.absent(),
    Value<DateTime?> createdAt = const Value.absent(),
  }) => UserProfile(
    id: id ?? this.id,
    name: name.present ? name.value : this.name,
    email: email.present ? email.value : this.email,
    avatarUrl: avatarUrl.present ? avatarUrl.value : this.avatarUrl,
    dietaryPreferences: dietaryPreferences.present ? dietaryPreferences.value : this.dietaryPreferences,
    createdAt: createdAt.present ? createdAt.value : this.createdAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      avatarUrl: data.avatarUrl.present ? data.avatarUrl.value : this.avatarUrl,
      dietaryPreferences: data.dietaryPreferences.present ? data.dietaryPreferences.value : this.dietaryPreferences,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dietaryPreferences: $dietaryPreferences, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, avatarUrl, dietaryPreferences, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.avatarUrl == this.avatarUrl &&
          other.dietaryPreferences == this.dietaryPreferences &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String?> name;
  final Value<String?> email;
  final Value<String?> avatarUrl;
  final Value<String?> dietaryPreferences;
  final Value<DateTime?> createdAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.dietaryPreferences = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.avatarUrl = const Value.absent(),
    this.dietaryPreferences = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? avatarUrl,
    Expression<String>? dietaryPreferences,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (dietaryPreferences != null) 'dietary_preferences': dietaryPreferences,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String?>? name,
    Value<String?>? email,
    Value<String?>? avatarUrl,
    Value<String?>? dietaryPreferences,
    Value<DateTime?>? createdAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      dietaryPreferences: dietaryPreferences ?? this.dietaryPreferences,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (avatarUrl.present) {
      map['avatar_url'] = Variable<String>(avatarUrl.value);
    }
    if (dietaryPreferences.present) {
      map['dietary_preferences'] = Variable<String>(dietaryPreferences.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('avatarUrl: $avatarUrl, ')
          ..write('dietaryPreferences: $dietaryPreferences, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SavedRecipeRowsTable extends SavedRecipeRows with TableInfo<$SavedRecipeRowsTable, SavedRecipeRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SavedRecipeRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
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
  static const VerificationMeta _cookTimeMinutesMeta = const VerificationMeta(
    'cookTimeMinutes',
  );
  @override
  late final GeneratedColumn<int> cookTimeMinutes = GeneratedColumn<int>(
    'cook_time_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _moodMeta = const VerificationMeta('mood');
  @override
  late final GeneratedColumn<String> mood = GeneratedColumn<String>(
    'mood',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant<int>(0),
  );
  static const VerificationMeta _savedAtMeta = const VerificationMeta(
    'savedAt',
  );
  @override
  late final GeneratedColumn<DateTime> savedAt = GeneratedColumn<DateTime>(
    'saved_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    cookTimeMinutes,
    mood,
    rating,
    savedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'saved_recipe_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<SavedRecipeRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('cook_time_minutes')) {
      context.handle(
        _cookTimeMinutesMeta,
        cookTimeMinutes.isAcceptableOrUnknown(
          data['cook_time_minutes']!,
          _cookTimeMinutesMeta,
        ),
      );
    }
    if (data.containsKey('mood')) {
      context.handle(
        _moodMeta,
        mood.isAcceptableOrUnknown(data['mood']!, _moodMeta),
      );
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    }
    if (data.containsKey('saved_at')) {
      context.handle(
        _savedAtMeta,
        savedAt.isAcceptableOrUnknown(data['saved_at']!, _savedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_savedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SavedRecipeRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SavedRecipeRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      cookTimeMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cook_time_minutes'],
      ),
      mood: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mood'],
      ),
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      savedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}saved_at'],
      )!,
    );
  }

  @override
  $SavedRecipeRowsTable createAlias(String alias) {
    return $SavedRecipeRowsTable(attachedDatabase, alias);
  }
}

class SavedRecipeRow extends DataClass implements Insertable<SavedRecipeRow> {
  final String id;
  final String title;
  final int? cookTimeMinutes;
  final String? mood;
  final int rating;
  final DateTime savedAt;
  const SavedRecipeRow({
    required this.id,
    required this.title,
    this.cookTimeMinutes,
    this.mood,
    required this.rating,
    required this.savedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || cookTimeMinutes != null) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes);
    }
    if (!nullToAbsent || mood != null) {
      map['mood'] = Variable<String>(mood);
    }
    map['rating'] = Variable<int>(rating);
    map['saved_at'] = Variable<DateTime>(savedAt);
    return map;
  }

  SavedRecipeRowsCompanion toCompanion(bool nullToAbsent) {
    return SavedRecipeRowsCompanion(
      id: Value(id),
      title: Value(title),
      cookTimeMinutes: cookTimeMinutes == null && nullToAbsent ? const Value.absent() : Value(cookTimeMinutes),
      mood: mood == null && nullToAbsent ? const Value.absent() : Value(mood),
      rating: Value(rating),
      savedAt: Value(savedAt),
    );
  }

  factory SavedRecipeRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SavedRecipeRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      cookTimeMinutes: serializer.fromJson<int?>(json['cookTimeMinutes']),
      mood: serializer.fromJson<String?>(json['mood']),
      rating: serializer.fromJson<int>(json['rating']),
      savedAt: serializer.fromJson<DateTime>(json['savedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'cookTimeMinutes': serializer.toJson<int?>(cookTimeMinutes),
      'mood': serializer.toJson<String?>(mood),
      'rating': serializer.toJson<int>(rating),
      'savedAt': serializer.toJson<DateTime>(savedAt),
    };
  }

  SavedRecipeRow copyWith({
    String? id,
    String? title,
    Value<int?> cookTimeMinutes = const Value.absent(),
    Value<String?> mood = const Value.absent(),
    int? rating,
    DateTime? savedAt,
  }) => SavedRecipeRow(
    id: id ?? this.id,
    title: title ?? this.title,
    cookTimeMinutes: cookTimeMinutes.present ? cookTimeMinutes.value : this.cookTimeMinutes,
    mood: mood.present ? mood.value : this.mood,
    rating: rating ?? this.rating,
    savedAt: savedAt ?? this.savedAt,
  );
  SavedRecipeRow copyWithCompanion(SavedRecipeRowsCompanion data) {
    return SavedRecipeRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      cookTimeMinutes: data.cookTimeMinutes.present ? data.cookTimeMinutes.value : this.cookTimeMinutes,
      mood: data.mood.present ? data.mood.value : this.mood,
      rating: data.rating.present ? data.rating.value : this.rating,
      savedAt: data.savedAt.present ? data.savedAt.value : this.savedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SavedRecipeRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('mood: $mood, ')
          ..write('rating: $rating, ')
          ..write('savedAt: $savedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, cookTimeMinutes, mood, rating, savedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SavedRecipeRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.cookTimeMinutes == this.cookTimeMinutes &&
          other.mood == this.mood &&
          other.rating == this.rating &&
          other.savedAt == this.savedAt);
}

class SavedRecipeRowsCompanion extends UpdateCompanion<SavedRecipeRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<int?> cookTimeMinutes;
  final Value<String?> mood;
  final Value<int> rating;
  final Value<DateTime> savedAt;
  final Value<int> rowid;
  const SavedRecipeRowsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.cookTimeMinutes = const Value.absent(),
    this.mood = const Value.absent(),
    this.rating = const Value.absent(),
    this.savedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SavedRecipeRowsCompanion.insert({
    required String id,
    required String title,
    this.cookTimeMinutes = const Value.absent(),
    this.mood = const Value.absent(),
    this.rating = const Value.absent(),
    required DateTime savedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       savedAt = Value(savedAt);
  static Insertable<SavedRecipeRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? cookTimeMinutes,
    Expression<String>? mood,
    Expression<int>? rating,
    Expression<DateTime>? savedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (cookTimeMinutes != null) 'cook_time_minutes': cookTimeMinutes,
      if (mood != null) 'mood': mood,
      if (rating != null) 'rating': rating,
      if (savedAt != null) 'saved_at': savedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SavedRecipeRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int?>? cookTimeMinutes,
    Value<String?>? mood,
    Value<int>? rating,
    Value<DateTime>? savedAt,
    Value<int>? rowid,
  }) {
    return SavedRecipeRowsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      cookTimeMinutes: cookTimeMinutes ?? this.cookTimeMinutes,
      mood: mood ?? this.mood,
      rating: rating ?? this.rating,
      savedAt: savedAt ?? this.savedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (cookTimeMinutes.present) {
      map['cook_time_minutes'] = Variable<int>(cookTimeMinutes.value);
    }
    if (mood.present) {
      map['mood'] = Variable<String>(mood.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (savedAt.present) {
      map['saved_at'] = Variable<DateTime>(savedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SavedRecipeRowsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('cookTimeMinutes: $cookTimeMinutes, ')
          ..write('mood: $mood, ')
          ..write('rating: $rating, ')
          ..write('savedAt: $savedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecipeDetailRowsTable extends RecipeDetailRows with TableInfo<$RecipeDetailRowsTable, RecipeDetailRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeDetailRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payload, cachedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipe_detail_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeDetailRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_cachedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeDetailRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeDetailRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $RecipeDetailRowsTable createAlias(String alias) {
    return $RecipeDetailRowsTable(attachedDatabase, alias);
  }
}

class RecipeDetailRow extends DataClass implements Insertable<RecipeDetailRow> {
  final String id;
  final String payload;
  final DateTime cachedAt;
  const RecipeDetailRow({
    required this.id,
    required this.payload,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payload'] = Variable<String>(payload);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  RecipeDetailRowsCompanion toCompanion(bool nullToAbsent) {
    return RecipeDetailRowsCompanion(
      id: Value(id),
      payload: Value(payload),
      cachedAt: Value(cachedAt),
    );
  }

  factory RecipeDetailRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeDetailRow(
      id: serializer.fromJson<String>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payload': serializer.toJson<String>(payload),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  RecipeDetailRow copyWith({String? id, String? payload, DateTime? cachedAt}) => RecipeDetailRow(
    id: id ?? this.id,
    payload: payload ?? this.payload,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  RecipeDetailRow copyWithCompanion(RecipeDetailRowsCompanion data) {
    return RecipeDetailRow(
      id: data.id.present ? data.id.value : this.id,
      payload: data.payload.present ? data.payload.value : this.payload,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeDetailRow(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload, cachedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeDetailRow &&
          other.id == this.id &&
          other.payload == this.payload &&
          other.cachedAt == this.cachedAt);
}

class RecipeDetailRowsCompanion extends UpdateCompanion<RecipeDetailRow> {
  final Value<String> id;
  final Value<String> payload;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const RecipeDetailRowsCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeDetailRowsCompanion.insert({
    required String id,
    required String payload,
    required DateTime cachedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       payload = Value(payload),
       cachedAt = Value(cachedAt);
  static Insertable<RecipeDetailRow> custom({
    Expression<String>? id,
    Expression<String>? payload,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeDetailRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? payload,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return RecipeDetailRowsCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeDetailRowsCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedScanRowsTable extends CachedScanRows with TableInfo<$CachedScanRowsTable, CachedScanRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedScanRowsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payloadMeta = const VerificationMeta(
    'payload',
  );
  @override
  late final GeneratedColumn<String> payload = GeneratedColumn<String>(
    'payload',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scannedAtMeta = const VerificationMeta(
    'scannedAt',
  );
  @override
  late final GeneratedColumn<DateTime> scannedAt = GeneratedColumn<DateTime>(
    'scanned_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, payload, scannedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_scan_rows';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedScanRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('payload')) {
      context.handle(
        _payloadMeta,
        payload.isAcceptableOrUnknown(data['payload']!, _payloadMeta),
      );
    } else if (isInserting) {
      context.missing(_payloadMeta);
    }
    if (data.containsKey('scanned_at')) {
      context.handle(
        _scannedAtMeta,
        scannedAt.isAcceptableOrUnknown(data['scanned_at']!, _scannedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_scannedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CachedScanRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedScanRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      payload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payload'],
      )!,
      scannedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scanned_at'],
      )!,
    );
  }

  @override
  $CachedScanRowsTable createAlias(String alias) {
    return $CachedScanRowsTable(attachedDatabase, alias);
  }
}

class CachedScanRow extends DataClass implements Insertable<CachedScanRow> {
  final String id;
  final String payload;
  final DateTime scannedAt;
  const CachedScanRow({
    required this.id,
    required this.payload,
    required this.scannedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['payload'] = Variable<String>(payload);
    map['scanned_at'] = Variable<DateTime>(scannedAt);
    return map;
  }

  CachedScanRowsCompanion toCompanion(bool nullToAbsent) {
    return CachedScanRowsCompanion(
      id: Value(id),
      payload: Value(payload),
      scannedAt: Value(scannedAt),
    );
  }

  factory CachedScanRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedScanRow(
      id: serializer.fromJson<String>(json['id']),
      payload: serializer.fromJson<String>(json['payload']),
      scannedAt: serializer.fromJson<DateTime>(json['scannedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'payload': serializer.toJson<String>(payload),
      'scannedAt': serializer.toJson<DateTime>(scannedAt),
    };
  }

  CachedScanRow copyWith({String? id, String? payload, DateTime? scannedAt}) => CachedScanRow(
    id: id ?? this.id,
    payload: payload ?? this.payload,
    scannedAt: scannedAt ?? this.scannedAt,
  );
  CachedScanRow copyWithCompanion(CachedScanRowsCompanion data) {
    return CachedScanRow(
      id: data.id.present ? data.id.value : this.id,
      payload: data.payload.present ? data.payload.value : this.payload,
      scannedAt: data.scannedAt.present ? data.scannedAt.value : this.scannedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedScanRow(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('scannedAt: $scannedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, payload, scannedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedScanRow &&
          other.id == this.id &&
          other.payload == this.payload &&
          other.scannedAt == this.scannedAt);
}

class CachedScanRowsCompanion extends UpdateCompanion<CachedScanRow> {
  final Value<String> id;
  final Value<String> payload;
  final Value<DateTime> scannedAt;
  final Value<int> rowid;
  const CachedScanRowsCompanion({
    this.id = const Value.absent(),
    this.payload = const Value.absent(),
    this.scannedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedScanRowsCompanion.insert({
    required String id,
    required String payload,
    required DateTime scannedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       payload = Value(payload),
       scannedAt = Value(scannedAt);
  static Insertable<CachedScanRow> custom({
    Expression<String>? id,
    Expression<String>? payload,
    Expression<DateTime>? scannedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (payload != null) 'payload': payload,
      if (scannedAt != null) 'scanned_at': scannedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedScanRowsCompanion copyWith({
    Value<String>? id,
    Value<String>? payload,
    Value<DateTime>? scannedAt,
    Value<int>? rowid,
  }) {
    return CachedScanRowsCompanion(
      id: id ?? this.id,
      payload: payload ?? this.payload,
      scannedAt: scannedAt ?? this.scannedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (payload.present) {
      map['payload'] = Variable<String>(payload.value);
    }
    if (scannedAt.present) {
      map['scanned_at'] = Variable<DateTime>(scannedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedScanRowsCompanion(')
          ..write('id: $id, ')
          ..write('payload: $payload, ')
          ..write('scannedAt: $scannedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $SavedRecipeRowsTable savedRecipeRows = $SavedRecipeRowsTable(
    this,
  );
  late final $RecipeDetailRowsTable recipeDetailRows = $RecipeDetailRowsTable(
    this,
  );
  late final $CachedScanRowsTable cachedScanRows = $CachedScanRowsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables => allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    savedRecipeRows,
    recipeDetailRows,
    cachedScanRows,
  ];
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      Value<String?> name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> dietaryPreferences,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String?> name,
      Value<String?> email,
      Value<String?> avatarUrl,
      Value<String?> dietaryPreferences,
      Value<DateTime?> createdAt,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dietaryPreferences => $composableBuilder(
    column: $table.dietaryPreferences,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get avatarUrl => $composableBuilder(
    column: $table.avatarUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dietaryPreferences => $composableBuilder(
    column: $table.dietaryPreferences,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name => $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email => $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get avatarUrl => $composableBuilder(column: $table.avatarUrl, builder: (column) => column);

  GeneratedColumn<String> get dietaryPreferences => $composableBuilder(
    column: $table.dietaryPreferences,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt => $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> dietaryPreferences = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                dietaryPreferences: dietaryPreferences,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<String?> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> avatarUrl = const Value.absent(),
                Value<String?> dietaryPreferences = const Value.absent(),
                Value<DateTime?> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                name: name,
                email: email,
                avatarUrl: avatarUrl,
                dietaryPreferences: dietaryPreferences,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$SavedRecipeRowsTableCreateCompanionBuilder =
    SavedRecipeRowsCompanion Function({
      required String id,
      required String title,
      Value<int?> cookTimeMinutes,
      Value<String?> mood,
      Value<int> rating,
      required DateTime savedAt,
      Value<int> rowid,
    });
typedef $$SavedRecipeRowsTableUpdateCompanionBuilder =
    SavedRecipeRowsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int?> cookTimeMinutes,
      Value<String?> mood,
      Value<int> rating,
      Value<DateTime> savedAt,
      Value<int> rowid,
    });

class $$SavedRecipeRowsTableFilterComposer extends Composer<_$AppDatabase, $SavedRecipeRowsTable> {
  $$SavedRecipeRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SavedRecipeRowsTableOrderingComposer extends Composer<_$AppDatabase, $SavedRecipeRowsTable> {
  $$SavedRecipeRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mood => $composableBuilder(
    column: $table.mood,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get savedAt => $composableBuilder(
    column: $table.savedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SavedRecipeRowsTableAnnotationComposer extends Composer<_$AppDatabase, $SavedRecipeRowsTable> {
  $$SavedRecipeRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title => $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get cookTimeMinutes => $composableBuilder(
    column: $table.cookTimeMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mood => $composableBuilder(column: $table.mood, builder: (column) => column);

  GeneratedColumn<int> get rating => $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<DateTime> get savedAt => $composableBuilder(column: $table.savedAt, builder: (column) => column);
}

class $$SavedRecipeRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SavedRecipeRowsTable,
          SavedRecipeRow,
          $$SavedRecipeRowsTableFilterComposer,
          $$SavedRecipeRowsTableOrderingComposer,
          $$SavedRecipeRowsTableAnnotationComposer,
          $$SavedRecipeRowsTableCreateCompanionBuilder,
          $$SavedRecipeRowsTableUpdateCompanionBuilder,
          (
            SavedRecipeRow,
            BaseReferences<_$AppDatabase, $SavedRecipeRowsTable, SavedRecipeRow>,
          ),
          SavedRecipeRow,
          PrefetchHooks Function()
        > {
  $$SavedRecipeRowsTableTableManager(
    _$AppDatabase db,
    $SavedRecipeRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$SavedRecipeRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$SavedRecipeRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$SavedRecipeRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<DateTime> savedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SavedRecipeRowsCompanion(
                id: id,
                title: title,
                cookTimeMinutes: cookTimeMinutes,
                mood: mood,
                rating: rating,
                savedAt: savedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<int?> cookTimeMinutes = const Value.absent(),
                Value<String?> mood = const Value.absent(),
                Value<int> rating = const Value.absent(),
                required DateTime savedAt,
                Value<int> rowid = const Value.absent(),
              }) => SavedRecipeRowsCompanion.insert(
                id: id,
                title: title,
                cookTimeMinutes: cookTimeMinutes,
                mood: mood,
                rating: rating,
                savedAt: savedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SavedRecipeRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SavedRecipeRowsTable,
      SavedRecipeRow,
      $$SavedRecipeRowsTableFilterComposer,
      $$SavedRecipeRowsTableOrderingComposer,
      $$SavedRecipeRowsTableAnnotationComposer,
      $$SavedRecipeRowsTableCreateCompanionBuilder,
      $$SavedRecipeRowsTableUpdateCompanionBuilder,
      (
        SavedRecipeRow,
        BaseReferences<_$AppDatabase, $SavedRecipeRowsTable, SavedRecipeRow>,
      ),
      SavedRecipeRow,
      PrefetchHooks Function()
    >;
typedef $$RecipeDetailRowsTableCreateCompanionBuilder =
    RecipeDetailRowsCompanion Function({
      required String id,
      required String payload,
      required DateTime cachedAt,
      Value<int> rowid,
    });
typedef $$RecipeDetailRowsTableUpdateCompanionBuilder =
    RecipeDetailRowsCompanion Function({
      Value<String> id,
      Value<String> payload,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

class $$RecipeDetailRowsTableFilterComposer extends Composer<_$AppDatabase, $RecipeDetailRowsTable> {
  $$RecipeDetailRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$RecipeDetailRowsTableOrderingComposer extends Composer<_$AppDatabase, $RecipeDetailRowsTable> {
  $$RecipeDetailRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeDetailRowsTableAnnotationComposer extends Composer<_$AppDatabase, $RecipeDetailRowsTable> {
  $$RecipeDetailRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload => $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt => $composableBuilder(column: $table.cachedAt, builder: (column) => column);
}

class $$RecipeDetailRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeDetailRowsTable,
          RecipeDetailRow,
          $$RecipeDetailRowsTableFilterComposer,
          $$RecipeDetailRowsTableOrderingComposer,
          $$RecipeDetailRowsTableAnnotationComposer,
          $$RecipeDetailRowsTableCreateCompanionBuilder,
          $$RecipeDetailRowsTableUpdateCompanionBuilder,
          (
            RecipeDetailRow,
            BaseReferences<_$AppDatabase, $RecipeDetailRowsTable, RecipeDetailRow>,
          ),
          RecipeDetailRow,
          PrefetchHooks Function()
        > {
  $$RecipeDetailRowsTableTableManager(
    _$AppDatabase db,
    $RecipeDetailRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$RecipeDetailRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$RecipeDetailRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$RecipeDetailRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeDetailRowsCompanion(
                id: id,
                payload: payload,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String payload,
                required DateTime cachedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecipeDetailRowsCompanion.insert(
                id: id,
                payload: payload,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecipeDetailRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeDetailRowsTable,
      RecipeDetailRow,
      $$RecipeDetailRowsTableFilterComposer,
      $$RecipeDetailRowsTableOrderingComposer,
      $$RecipeDetailRowsTableAnnotationComposer,
      $$RecipeDetailRowsTableCreateCompanionBuilder,
      $$RecipeDetailRowsTableUpdateCompanionBuilder,
      (
        RecipeDetailRow,
        BaseReferences<_$AppDatabase, $RecipeDetailRowsTable, RecipeDetailRow>,
      ),
      RecipeDetailRow,
      PrefetchHooks Function()
    >;
typedef $$CachedScanRowsTableCreateCompanionBuilder =
    CachedScanRowsCompanion Function({
      required String id,
      required String payload,
      required DateTime scannedAt,
      Value<int> rowid,
    });
typedef $$CachedScanRowsTableUpdateCompanionBuilder =
    CachedScanRowsCompanion Function({
      Value<String> id,
      Value<String> payload,
      Value<DateTime> scannedAt,
      Value<int> rowid,
    });

class $$CachedScanRowsTableFilterComposer extends Composer<_$AppDatabase, $CachedScanRowsTable> {
  $$CachedScanRowsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CachedScanRowsTableOrderingComposer extends Composer<_$AppDatabase, $CachedScanRowsTable> {
  $$CachedScanRowsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get payload => $composableBuilder(
    column: $table.payload,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scannedAt => $composableBuilder(
    column: $table.scannedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CachedScanRowsTableAnnotationComposer extends Composer<_$AppDatabase, $CachedScanRowsTable> {
  $$CachedScanRowsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id => $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get payload => $composableBuilder(column: $table.payload, builder: (column) => column);

  GeneratedColumn<DateTime> get scannedAt => $composableBuilder(column: $table.scannedAt, builder: (column) => column);
}

class $$CachedScanRowsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedScanRowsTable,
          CachedScanRow,
          $$CachedScanRowsTableFilterComposer,
          $$CachedScanRowsTableOrderingComposer,
          $$CachedScanRowsTableAnnotationComposer,
          $$CachedScanRowsTableCreateCompanionBuilder,
          $$CachedScanRowsTableUpdateCompanionBuilder,
          (
            CachedScanRow,
            BaseReferences<_$AppDatabase, $CachedScanRowsTable, CachedScanRow>,
          ),
          CachedScanRow,
          PrefetchHooks Function()
        > {
  $$CachedScanRowsTableTableManager(
    _$AppDatabase db,
    $CachedScanRowsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () => $$CachedScanRowsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () => $$CachedScanRowsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () => $$CachedScanRowsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> payload = const Value.absent(),
                Value<DateTime> scannedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedScanRowsCompanion(
                id: id,
                payload: payload,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String payload,
                required DateTime scannedAt,
                Value<int> rowid = const Value.absent(),
              }) => CachedScanRowsCompanion.insert(
                id: id,
                payload: payload,
                scannedAt: scannedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0.map((e) => (e.readTable(table), BaseReferences(db, table, e))).toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CachedScanRowsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedScanRowsTable,
      CachedScanRow,
      $$CachedScanRowsTableFilterComposer,
      $$CachedScanRowsTableOrderingComposer,
      $$CachedScanRowsTableAnnotationComposer,
      $$CachedScanRowsTableCreateCompanionBuilder,
      $$CachedScanRowsTableUpdateCompanionBuilder,
      (
        CachedScanRow,
        BaseReferences<_$AppDatabase, $CachedScanRowsTable, CachedScanRow>,
      ),
      CachedScanRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles => $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$SavedRecipeRowsTableTableManager get savedRecipeRows =>
      $$SavedRecipeRowsTableTableManager(_db, _db.savedRecipeRows);
  $$RecipeDetailRowsTableTableManager get recipeDetailRows =>
      $$RecipeDetailRowsTableTableManager(_db, _db.recipeDetailRows);
  $$CachedScanRowsTableTableManager get cachedScanRows => $$CachedScanRowsTableTableManager(_db, _db.cachedScanRows);
}
