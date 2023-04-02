// Mocks generated by Mockito 5.4.0 from annotations
// in intheloopapp/test/domains/models/user_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeDocumentReference_0<T extends Object?> extends _i1.SmartFake
    implements _i2.DocumentReference<T> {
  _FakeDocumentReference_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeSnapshotMetadata_1 extends _i1.SmartFake
    implements _i2.SnapshotMetadata {
  _FakeSnapshotMetadata_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
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
  String get id => (super.noSuchMethod(
        Invocation.getter(#id),
        returnValue: '',
      ) as String);
  @override
  _i2.DocumentReference<T> get reference => (super.noSuchMethod(
        Invocation.getter(#reference),
        returnValue: _FakeDocumentReference_0<T>(
          this,
          Invocation.getter(#reference),
        ),
      ) as _i2.DocumentReference<T>);
  @override
  _i2.SnapshotMetadata get metadata => (super.noSuchMethod(
        Invocation.getter(#metadata),
        returnValue: _FakeSnapshotMetadata_1(
          this,
          Invocation.getter(#metadata),
        ),
      ) as _i2.SnapshotMetadata);
  @override
  bool get exists => (super.noSuchMethod(
        Invocation.getter(#exists),
        returnValue: false,
      ) as bool);
  @override
  dynamic get(Object? field) => super.noSuchMethod(Invocation.method(
        #get,
        [field],
      ));
  @override
  dynamic operator [](Object? field) => super.noSuchMethod(Invocation.method(
        #[],
        [field],
      ));
}
