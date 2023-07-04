import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/common/tapped_app_bar.dart';
import 'package:intheloopapp/ui/error/error_view.dart';
import 'package:intheloopapp/ui/loop_feed/loop_feed_cubit.dart';
import 'package:intheloopapp/ui/loop_feed/loop_list.dart';

class LoopFeedView extends StatefulWidget {
  LoopFeedView({
    required this.sourceFunction,
    required this.sourceStream,
    required this.feedKey,
    required this.headerSliver,
    required this.userId,
    this.floatingActionButton,
    ScrollController? scrollController,
    super.key,
  }) {
    this.scrollController = scrollController ?? ScrollController();
  }

  final Future<List<Loop>> Function(
    String userId, {
    int limit,
    String? lastLoopId,
    bool ignoreCache,
  }) sourceFunction;
  final Stream<Loop> Function(
    String userId, {
    int limit,
    bool ignoreCache,
  }) sourceStream;
  final String userId;
  final String feedKey;
  final Widget? headerSliver;
  final FloatingActionButton? floatingActionButton;

  late final ScrollController scrollController;

  @override
  State<LoopFeedView> createState() => _LoopFeedViewState();
}

class _LoopFeedViewState extends State<LoopFeedView>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => LoopFeedCubit(
        userId: widget.userId,
        sourceFunction: widget.sourceFunction,
        sourceStream: widget.sourceStream,
      )..initLoops(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        floatingActionButton: widget.floatingActionButton,
        appBar: widget.headerSliver == null
            ? const TappedAppBar(
                title: 'Loops',
              )
            : null,
        body: LoopList(
          feedKey: widget.feedKey,
          headerSliver: widget.headerSliver,
          scrollController: widget.scrollController,
        ),
      ),
    );
  }
}
