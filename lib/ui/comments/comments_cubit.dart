import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:intheloopapp/utils/app_logger.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/models/comment.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/ui/loop_view/loop_view_cubit.dart';

part 'comments_state.dart';

class CommentsCubit extends Cubit<CommentsState> {
  CommentsCubit({
    required this.currentUser,
    required this.loop,
    required this.loopViewCubit,
    required this.databaseRepository,
    this.loading = false,
  }) : super(CommentsState(loop: loop));

  final UserModel currentUser;
  final DatabaseRepository databaseRepository;
  final Loop loop;
  final LoopViewCubit loopViewCubit;
  final bool loading;
  StreamSubscription<Comment>? commentListener;

  Future<void> initComments({bool clearComments = true}) async {
    emit(state.copyWith(loading: true));

    await commentListener?.cancel();
    if (clearComments) {
      emit(
        state.copyWith(
          comments: [],
          commentsCount: loop.commentCount,
        ),
      );
    }

    final commentsAvailable = (await databaseRepository.getComments(
      loop.id,
      limit: 1,
    ))
        .isNotEmpty;
    if (!commentsAvailable) {
      emit(state.copyWith(loading: false));
    }

    commentListener = databaseRepository
        .commentsObserver(
      loop.id,
    )
        .listen((Comment event) {
      try {
        logger.debug('Comment { ${event.id} : ${event.content} }');
        emit(
          state.copyWith(
            loading: false,
            comments: List.of(state.comments)..add(event),
          ),
        );
      } catch (e, s) {
        logger.error('error adding comment', error: e, stackTrace: s);
      }
    });
  }

  void changeComment(String value) {
    emit(state.copyWith(comment: value));
  }

  Future<void> addComment() async {
    if (state.loading) return;

    emit(state.copyWith(loading: true));

    if (state.comment.isNotEmpty) {
      final comment = Comment(
        timestamp: Timestamp.fromDate(DateTime.now()),
        userId: currentUser.id,
        content: state.comment,
        rootId: state.loop.id,
        children: [],
      );

      await databaseRepository.addComment(
        comment,
      );

      loopViewCubit.addComment();

      emit(
        state.copyWith(
          loading: false,
          commentsCount: state.commentsCount + 1,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    await commentListener?.cancel();
    await super.close();
  }
}
