// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'opportunity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Opportunity _$OpportunityFromJson(Map<String, dynamic> json) {
  return _Opportunity.fromJson(json);
}

/// @nodoc
mixin _$Opportunity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get timestamp => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get startTime => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get endTime => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  Option<String> get flierUrl => throw _privateConstructorUsedError;
  Location get location => throw _privateConstructorUsedError;
  bool get isPaid => throw _privateConstructorUsedError;
  Option<OpportunityInteraction> get touched =>
      throw _privateConstructorUsedError;
  bool get deleted => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OpportunityCopyWith<Opportunity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OpportunityCopyWith<$Res> {
  factory $OpportunityCopyWith(
          Opportunity value, $Res Function(Opportunity) then) =
      _$OpportunityCopyWithImpl<$Res, Opportunity>;
  @useResult
  $Res call(
      {String id,
      String userId,
      @DateTimeConverter() DateTime timestamp,
      @DateTimeConverter() DateTime startTime,
      @DateTimeConverter() DateTime endTime,
      String title,
      String description,
      Option<String> flierUrl,
      Location location,
      bool isPaid,
      Option<OpportunityInteraction> touched,
      bool deleted});

  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class _$OpportunityCopyWithImpl<$Res, $Val extends Opportunity>
    implements $OpportunityCopyWith<$Res> {
  _$OpportunityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? title = null,
    Object? description = null,
    Object? flierUrl = null,
    Object? location = null,
    Object? isPaid = null,
    Object? touched = null,
    Object? deleted = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      flierUrl: null == flierUrl
          ? _value.flierUrl
          : flierUrl // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      touched: null == touched
          ? _value.touched
          : touched // ignore: cast_nullable_to_non_nullable
              as Option<OpportunityInteraction>,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationCopyWith<$Res> get location {
    return $LocationCopyWith<$Res>(_value.location, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OpportunityImplCopyWith<$Res>
    implements $OpportunityCopyWith<$Res> {
  factory _$$OpportunityImplCopyWith(
          _$OpportunityImpl value, $Res Function(_$OpportunityImpl) then) =
      __$$OpportunityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      @DateTimeConverter() DateTime timestamp,
      @DateTimeConverter() DateTime startTime,
      @DateTimeConverter() DateTime endTime,
      String title,
      String description,
      Option<String> flierUrl,
      Location location,
      bool isPaid,
      Option<OpportunityInteraction> touched,
      bool deleted});

  @override
  $LocationCopyWith<$Res> get location;
}

/// @nodoc
class __$$OpportunityImplCopyWithImpl<$Res>
    extends _$OpportunityCopyWithImpl<$Res, _$OpportunityImpl>
    implements _$$OpportunityImplCopyWith<$Res> {
  __$$OpportunityImplCopyWithImpl(
      _$OpportunityImpl _value, $Res Function(_$OpportunityImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? timestamp = null,
    Object? startTime = null,
    Object? endTime = null,
    Object? title = null,
    Object? description = null,
    Object? flierUrl = null,
    Object? location = null,
    Object? isPaid = null,
    Object? touched = null,
    Object? deleted = null,
  }) {
    return _then(_$OpportunityImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _value.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      flierUrl: null == flierUrl
          ? _value.flierUrl
          : flierUrl // ignore: cast_nullable_to_non_nullable
              as Option<String>,
      location: null == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as Location,
      isPaid: null == isPaid
          ? _value.isPaid
          : isPaid // ignore: cast_nullable_to_non_nullable
              as bool,
      touched: null == touched
          ? _value.touched
          : touched // ignore: cast_nullable_to_non_nullable
              as Option<OpportunityInteraction>,
      deleted: null == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OpportunityImpl implements _Opportunity {
  const _$OpportunityImpl(
      {required this.id,
      required this.userId,
      @DateTimeConverter() required this.timestamp,
      @DateTimeConverter() required this.startTime,
      @DateTimeConverter() required this.endTime,
      this.title = '',
      this.description = '',
      this.flierUrl = const None(),
      this.location = Location.rva,
      this.isPaid = false,
      this.touched = const None(),
      this.deleted = false});

  factory _$OpportunityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OpportunityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  @DateTimeConverter()
  final DateTime timestamp;
  @override
  @DateTimeConverter()
  final DateTime startTime;
  @override
  @DateTimeConverter()
  final DateTime endTime;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final Option<String> flierUrl;
  @override
  @JsonKey()
  final Location location;
  @override
  @JsonKey()
  final bool isPaid;
  @override
  @JsonKey()
  final Option<OpportunityInteraction> touched;
  @override
  @JsonKey()
  final bool deleted;

  @override
  String toString() {
    return 'Opportunity(id: $id, userId: $userId, timestamp: $timestamp, startTime: $startTime, endTime: $endTime, title: $title, description: $description, flierUrl: $flierUrl, location: $location, isPaid: $isPaid, touched: $touched, deleted: $deleted)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OpportunityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.flierUrl, flierUrl) ||
                other.flierUrl == flierUrl) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.isPaid, isPaid) || other.isPaid == isPaid) &&
            (identical(other.touched, touched) || other.touched == touched) &&
            (identical(other.deleted, deleted) || other.deleted == deleted));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      userId,
      timestamp,
      startTime,
      endTime,
      title,
      description,
      flierUrl,
      location,
      isPaid,
      touched,
      deleted);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OpportunityImplCopyWith<_$OpportunityImpl> get copyWith =>
      __$$OpportunityImplCopyWithImpl<_$OpportunityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OpportunityImplToJson(
      this,
    );
  }
}

abstract class _Opportunity implements Opportunity {
  const factory _Opportunity(
      {required final String id,
      required final String userId,
      @DateTimeConverter() required final DateTime timestamp,
      @DateTimeConverter() required final DateTime startTime,
      @DateTimeConverter() required final DateTime endTime,
      final String title,
      final String description,
      final Option<String> flierUrl,
      final Location location,
      final bool isPaid,
      final Option<OpportunityInteraction> touched,
      final bool deleted}) = _$OpportunityImpl;

  factory _Opportunity.fromJson(Map<String, dynamic> json) =
      _$OpportunityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  @DateTimeConverter()
  DateTime get timestamp;
  @override
  @DateTimeConverter()
  DateTime get startTime;
  @override
  @DateTimeConverter()
  DateTime get endTime;
  @override
  String get title;
  @override
  String get description;
  @override
  Option<String> get flierUrl;
  @override
  Location get location;
  @override
  bool get isPaid;
  @override
  Option<OpportunityInteraction> get touched;
  @override
  bool get deleted;
  @override
  @JsonKey(ignore: true)
  _$$OpportunityImplCopyWith<_$OpportunityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
