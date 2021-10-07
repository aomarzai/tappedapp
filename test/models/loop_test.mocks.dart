// Mocks generated by Mockito 5.0.16 from annotations
// in intheloopapp/test/models/loop_test.dart.
// Do not manually edit this file.

import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDocumentReference_0<T extends Object?> extends _i1.Fake
    implements _i2.DocumentReference<T> {}

class _FakeSnapshotMetadata_1 extends _i1.Fake implements _i2.SnapshotMetadata {
}

/// A class which mocks [DocumentSnapshot].
///
/// See the documentation for Mockito's code generation for more information.
class MockDocumentSnapshot<T extends Object?> extends _i1.Mock
    implements _i2.DocumentSnapshot<T> {
  MockDocumentSnapshot() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get id =>
      (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  _i2.DocumentReference<T> get reference => (super.noSuchMethod(
      Invocation.getter(#reference),
      returnValue: _FakeDocumentReference_0<T>()) as _i2.DocumentReference<T>);
  @override
  _i2.SnapshotMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata),
          returnValue: _FakeSnapshotMetadata_1()) as _i2.SnapshotMetadata);
  @override
  bool get exists =>
      (super.noSuchMethod(Invocation.getter(#exists), returnValue: false)
          as bool);
  @override
  dynamic get(Object? field) =>
      super.noSuchMethod(Invocation.method(#get, [field]));
  @override
  dynamic operator [](Object? field) =>
      super.noSuchMethod(Invocation.method(#[], [field]));
  @override
  String toString() => super.toString();
}
