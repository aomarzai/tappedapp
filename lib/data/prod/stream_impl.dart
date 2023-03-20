import 'package:cancelable_retry/cancelable_retry.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:intheloopapp/data/stream_repository.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

final _functions = FirebaseFunctions.instance;
final _fireStore = FirebaseFirestore.instance;

final _usersRef = _fireStore.collection('users');

/// Stream implementation using the stream api
class StreamImpl extends StreamRepository {
  /// clients must provide a stream client to create this impl
  StreamImpl(this._client);

  final StreamChatClient _client;
  bool _connected = false;

  @override
  Future<bool> connectUser(String userId) async {
    if (!_connected) {
      try {
        await _client.disconnectUser();
        final token = await getToken();
        await _client.connectUser(
          User(
            id: userId,
          ),
          token,
          // user.streamChatToken,
        );
        _connected = true;
      } on Exception {
        _connected = false;
      }
    }

    return _connected;
  }

  @override
  Future<List<UserModel>> getChatUsers() async {
    final result = await _client.queryUsers();
    final chatUsers = await Future.wait(
      result.users
          .where((element) => element.id != _client.state.currentUser!.id)
          .map(
        (User e) async {
          final userSnapshot = await _usersRef.doc(e.id).get();
          final user = UserModel.fromDoc(userSnapshot);

          return user;
        },
      ),
    );
    return chatUsers;
  }

  @override
  Future<String> getToken() async {
    final callable =
        _functions.httpsCallable('ext-auth-chat-getStreamUserToken');

    final request = CancelableRetry(
      // Provide request function
      // ignore: unnecessary_lambdas
      () => callable<String>(),
      // Set conditions for retry
      retryIf: (result) => result == '',
      // Optional:
      // - Define max retry attempts
      maxAttempts: 5,
      // - Define max delay between retries
      // maxDelay: const Duration(seconds: 30),
      // - Tune delay between retries
      delayFactor: const Duration(milliseconds: 100),
      // randomizationFactor: 0.25,
    );

    final results = await request.run();
    final token = results.data;

    // print('TOKEN ' + token);

    return token;

    // In Development mode you can just use :
    // return _client.devToken(userId).rawValue;
  }

  @override
  Future<Channel> createGroupChat(
    String id,
    String? name,
    List<String?>? members, {
    String? image,
  }) async {
    var channel = _client.channel('messaging');

    final res = await _client.queryChannelsOnline(
      state: false,
      watch: false,
      filter: Filter.raw(
        value: {
          'members': [
            ...members!,
            _client.state.currentUser!.id,
          ],
          'distinct': true,
        },
      ),
      messageLimit: 0,
      paginationParams: const PaginationParams(
        limit: 1,
      ),
    );

    final channelExisted = res.length == 1;
    if (channelExisted) {
      channel = res.first;
      await channel.watch();
    } else {
      channel = _client.channel(
        'messaging',
        extraData: {
          'name': name,
          'image': image,
          'members': [
            ...members,
            _client.state.currentUser!.id,
          ],
        },
      );
      await channel.watch();
    }

    return channel;
  }

  @override
  Future<Channel> createSimpleChat(String? friendId) async {
    var channel = _client.channel('messaging');

    final res = await _client.queryChannelsOnline(
      state: false,
      watch: false,
      filter: Filter.raw(
        value: {
          'members': [
            // ..._selectedUsers.map((e) => e.id),
            friendId,
            _client.state.currentUser!.id,
          ],
          'distinct': true,
        },
      ),
      messageLimit: 0,
      paginationParams: const PaginationParams(
        limit: 1,
      ),
    );

    final channelExisted = res.length == 1;
    if (channelExisted) {
      channel = res.first;
      await channel.watch();
    } else {
      channel = _client.channel(
        'messaging',
        extraData: {
          'members': [
            // ..._selectedUsers.map((e) => e.id),
            friendId,
            _client.state.currentUser!.id,
          ],
        },
      );
      await channel.watch();
    }

    return channel;
  }

  @override
  Future<void> logout() async {
    return _client.disconnectUser();
  }

  // @override
  // Future<bool> connectIfExist(String userId) async {
  //   final token = await getToken(userId);
  //   await _client.connectUser(
  //     User(id: userId),
  //     token ?? '',
  //   );
  //   return _client.state.currentUser!.id != userId;
  // }
}
