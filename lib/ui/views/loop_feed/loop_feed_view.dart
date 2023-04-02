import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/ui/views/common/easter_egg_placeholder.dart';
import 'package:intheloopapp/ui/views/common/loading/loading_view.dart';
import 'package:intheloopapp/ui/views/loop_feed/loop_feed_cubit.dart';
import 'package:intheloopapp/ui/widgets/common/loop_container/loop_container.dart';

class LoopFeedView extends StatelessWidget {
  const LoopFeedView({
    required this.sourceFunction,
    required this.sourceStream,
    super.key,
  });

  final Future<List<Loop>> Function(
    String currentUserId, {
    int limit,
    String? lastLoopId,
  }) sourceFunction;
  final Stream<Loop> Function(
    String currentUserId, {
    int limit,
  }) sourceStream;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OnboardingBloc, OnboardingState, Onboarded>(
      selector: (state) => state as Onboarded,
      builder: (context, userState) {
        return BlocProvider(
          create: (context) => LoopFeedCubit(
            currentUserId: userState.currentUser.id,
            sourceFunction: sourceFunction,
            sourceStream: sourceStream,
          )..initLoops(),
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            body: RefreshIndicator(
              displacement: 20,
              onRefresh: () async {
                await context
                    .read<LoopFeedCubit>()
                    .initLoops(clearLoops: false);
              },
              child: BlocBuilder<LoopFeedCubit, LoopFeedState>(
                builder: (context, state) {
                  switch (state.status) {
                    case LoopFeedStatus.initial:
                      return const LoadingView();
                    case LoopFeedStatus.success:
                      if (state.loops.isEmpty) {
                        return const Center(
                          child: EasterEggPlaceholder(
                            text: 'No Loops',
                            color: Colors.white,
                          ),
                        );
                      }

                      return ListView.builder(
                        // shrinkWrap: true,
                        // physics: const ClampingScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return LoopContainer(
                            loop: state.loops[index],
                          );
                        },
                        itemCount: state.loops.length,
                      );

                    case LoopFeedStatus.failure:
                      return const Center(
                        child: EasterEggPlaceholder(
                          text: 'Error Fetching Loops :(',
                          color: Colors.white,
                        ),
                      );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
