// Mocks generated by Mockito 5.0.16 from annotations
// in intheloopapp/test/ui/likes_cubit_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;

import 'package:intheloopapp/data/database_repository.dart' as _i5;
import 'package:intheloopapp/domains/models/activity.dart' as _i7;
import 'package:intheloopapp/domains/models/comment.dart' as _i4;
import 'package:intheloopapp/domains/models/loop.dart' as _i3;
import 'package:intheloopapp/domains/models/user_model.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeUserModel_0 extends _i1.Fake implements _i2.UserModel {}

class _FakeLoop_1 extends _i1.Fake implements _i3.Loop {}

class _FakeComment_2 extends _i1.Fake implements _i4.Comment {}

/// A class which mocks [DatabaseRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockDatabaseRepository extends _i1.Mock
    implements _i5.DatabaseRepository {
  MockDatabaseRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<bool> userEmailExists(String? email) =>
      (super.noSuchMethod(Invocation.method(#userEmailExists, [email]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<void> createUser(_i2.UserModel? user) =>
      (super.noSuchMethod(Invocation.method(#createUser, [user]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<_i2.UserModel?> getUserByUsername(String? username) =>
      (super.noSuchMethod(Invocation.method(#getUserByUsername, [username]),
              returnValue: Future<_i2.UserModel?>.value())
          as _i6.Future<_i2.UserModel?>);
  @override
  _i6.Future<_i2.UserModel> getUser(String? userId) =>
      (super.noSuchMethod(Invocation.method(#getUser, [userId]),
              returnValue: Future<_i2.UserModel>.value(_FakeUserModel_0()))
          as _i6.Future<_i2.UserModel>);
  @override
  _i6.Future<_i3.Loop> getLoopById(String? loopId) =>
      (super.noSuchMethod(Invocation.method(#getLoopById, [loopId]),
              returnValue: Future<_i3.Loop>.value(_FakeLoop_1()))
          as _i6.Future<_i3.Loop>);
  @override
  _i6.Future<int> followersNum(String? userid) =>
      (super.noSuchMethod(Invocation.method(#followersNum, [userid]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<int> followingNum(String? userid) =>
      (super.noSuchMethod(Invocation.method(#followingNum, [userid]),
          returnValue: Future<int>.value(0)) as _i6.Future<int>);
  @override
  _i6.Future<void> updateUserData(_i2.UserModel? user) =>
      (super.noSuchMethod(Invocation.method(#updateUserData, [user]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> followUser(String? currentUserId, String? visitedUserId) =>
      (super.noSuchMethod(
          Invocation.method(#followUser, [currentUserId, visitedUserId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> unfollowUser(String? currentUserId, String? visitedUserId) =>
      (super.noSuchMethod(
          Invocation.method(#unfollowUser, [currentUserId, visitedUserId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<bool> isFollowingUser(
          String? currentUserId, String? visitedUserId) =>
      (super.noSuchMethod(
          Invocation.method(#isFollowingUser, [currentUserId, visitedUserId]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<List<_i2.UserModel>> getFollowing(String? currentUserId) =>
      (super.noSuchMethod(Invocation.method(#getFollowing, [currentUserId]),
              returnValue: Future<List<_i2.UserModel>>.value(<_i2.UserModel>[]))
          as _i6.Future<List<_i2.UserModel>>);
  @override
  _i6.Future<List<_i2.UserModel>> getFollowers(String? currentUserId) =>
      (super.noSuchMethod(Invocation.method(#getFollowers, [currentUserId]),
              returnValue: Future<List<_i2.UserModel>>.value(<_i2.UserModel>[]))
          as _i6.Future<List<_i2.UserModel>>);
  @override
  _i6.Future<void> uploadLoop(_i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#uploadLoop, [loop]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> deleteLoop(_i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#deleteLoop, [loop]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<List<_i3.Loop>> getUserLoops(String? userId,
          {int? limit = 20, String? lastLoopId}) =>
      (super.noSuchMethod(
              Invocation.method(#getUserLoops, [userId],
                  {#limit: limit, #lastLoopId: lastLoopId}),
              returnValue: Future<List<_i3.Loop>>.value(<_i3.Loop>[]))
          as _i6.Future<List<_i3.Loop>>);
  @override
  _i6.Stream<_i3.Loop> userLoopsObserver(String? userId, {int? limit = 20}) =>
      (super.noSuchMethod(
          Invocation.method(#userLoopsObserver, [userId], {#limit: limit}),
          returnValue: Stream<_i3.Loop>.empty()) as _i6.Stream<_i3.Loop>);
  @override
  _i6.Future<List<_i3.Loop>> getFollowingLoops(String? currentUserId,
          {int? limit = 20, String? lastLoopId}) =>
      (super.noSuchMethod(
              Invocation.method(#getFollowingLoops, [currentUserId],
                  {#limit: limit, #lastLoopId: lastLoopId}),
              returnValue: Future<List<_i3.Loop>>.value(<_i3.Loop>[]))
          as _i6.Future<List<_i3.Loop>>);
  @override
  _i6.Stream<_i3.Loop> followingLoopsObserver(String? currentUserId,
          {int? limit = 20}) =>
      (super.noSuchMethod(
          Invocation.method(
              #followingLoopsObserver, [currentUserId], {#limit: limit}),
          returnValue: Stream<_i3.Loop>.empty()) as _i6.Stream<_i3.Loop>);
  @override
  _i6.Future<List<_i3.Loop>> getAllLoops(String? currentUserId,
          {int? limit = 20, String? lastLoopId}) =>
      (super.noSuchMethod(
              Invocation.method(#getAllLoops, [currentUserId],
                  {#limit: limit, #lastLoopId: lastLoopId}),
              returnValue: Future<List<_i3.Loop>>.value(<_i3.Loop>[]))
          as _i6.Future<List<_i3.Loop>>);
  @override
  _i6.Stream<_i3.Loop> allLoopsObserver(String? currentUserId,
          {int? limit = 20}) =>
      (super.noSuchMethod(
          Invocation.method(
              #allLoopsObserver, [currentUserId], {#limit: limit}),
          returnValue: Stream<_i3.Loop>.empty()) as _i6.Stream<_i3.Loop>);
  @override
  _i6.Future<void> likeLoop(String? currentUserId, _i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#likeLoop, [currentUserId, loop]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> unlikeLoop(String? currentUserId, _i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#unlikeLoop, [currentUserId, loop]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<bool> isLikeLoop(String? currentUserId, _i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#isLikeLoop, [currentUserId, loop]),
          returnValue: Future<bool>.value(false)) as _i6.Future<bool>);
  @override
  _i6.Future<List<_i2.UserModel>> getLikes(_i3.Loop? loop) =>
      (super.noSuchMethod(Invocation.method(#getLikes, [loop]),
              returnValue: Future<List<_i2.UserModel>>.value(<_i2.UserModel>[]))
          as _i6.Future<List<_i2.UserModel>>);
  @override
  _i6.Future<List<_i7.Activity>> getActivities(String? userId,
          {int? limit = 20, String? lastActivityId}) =>
      (super.noSuchMethod(
              Invocation.method(#getActivities, [userId],
                  {#limit: limit, #lastActivityId: lastActivityId}),
              returnValue: Future<List<_i7.Activity>>.value(<_i7.Activity>[]))
          as _i6.Future<List<_i7.Activity>>);
  @override
  _i6.Stream<_i7.Activity> activitiesObserver(String? userId,
          {int? limit = 20}) =>
      (super.noSuchMethod(
              Invocation.method(#activitiesObserver, [userId], {#limit: limit}),
              returnValue: Stream<_i7.Activity>.empty())
          as _i6.Stream<_i7.Activity>);
  @override
  _i6.Future<void> addActivity(
          {String? currentUserId,
          String? visitedUserId,
          _i7.ActivityType? type,
          _i3.Loop? loop}) =>
      (super.noSuchMethod(
          Invocation.method(#addActivity, [], {
            #currentUserId: currentUserId,
            #visitedUserId: visitedUserId,
            #type: type,
            #loop: loop
          }),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<void> markActivityAsRead(_i7.Activity? activity) =>
      (super.noSuchMethod(Invocation.method(#markActivityAsRead, [activity]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  _i6.Future<List<_i4.Comment>> getLoopComments(_i3.Loop? loop,
          {int? limit = 20}) =>
      (super.noSuchMethod(
              Invocation.method(#getLoopComments, [loop], {#limit: limit}),
              returnValue: Future<List<_i4.Comment>>.value(<_i4.Comment>[]))
          as _i6.Future<List<_i4.Comment>>);
  @override
  _i6.Stream<_i4.Comment> loopCommentsObserver(_i3.Loop? loop,
          {int? limit = 20}) =>
      (super.noSuchMethod(
          Invocation.method(#loopCommentsObserver, [loop], {#limit: limit}),
          returnValue: Stream<_i4.Comment>.empty()) as _i6.Stream<_i4.Comment>);
  @override
  _i6.Future<_i4.Comment> getComment(_i3.Loop? loop, String? commentId) =>
      (super.noSuchMethod(Invocation.method(#getComment, [loop, commentId]),
              returnValue: Future<_i4.Comment>.value(_FakeComment_2()))
          as _i6.Future<_i4.Comment>);
  @override
  _i6.Future<void> addComment(_i4.Comment? comment, String? visitedUserId) =>
      (super.noSuchMethod(
          Invocation.method(#addComment, [comment, visitedUserId]),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  String toString() => super.toString();
}
