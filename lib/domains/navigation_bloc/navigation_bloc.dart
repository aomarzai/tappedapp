import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intheloopapp/domains/models/badge.dart';
import 'package:intheloopapp/domains/models/loop.dart';
import 'package:intheloopapp/ui/views/activity/activity_view.dart';
import 'package:intheloopapp/ui/views/badge/badge_view.dart';
import 'package:intheloopapp/ui/views/common/loop_view/loop_view.dart';
import 'package:intheloopapp/ui/views/likes/likes_view.dart';
import 'package:intheloopapp/ui/views/onboarding/onboarding_view.dart';
import 'package:intheloopapp/ui/views/profile/profile_view.dart';

part 'navigation_event.dart';
part 'navigation_state.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  /// build the bloc and defines event handlers
  NavigationBloc({required this.navigationKey})
      : super(const NavigationState()) {
    on<ChangeTab>((event, emit) {
      emit(state.copyWith(selectedTab: event.selectedTab));
    });
    on<PushLoop>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<LoopView>(
          builder: (context) => Material(
            child: LoopView(
              loop: event.loop,
              showComments: event.showComments,
              autoPlay: event.autoPlay,
            ),
          ),
        ),
      );
      emit(state);
    });
    on<PushBadge>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<PushBadge>(
          builder: (context) => Material(
            child: BadgeView(
              badge: event.badge,
            ),
          ),
        ),
      );
      emit(state);
    });
    on<PushProfile>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<PushProfile>(
          builder: (context) => ProfileView(visitedUserId: event.userId),
        ),
      );
      emit(state);
    });
    on<PushActivity>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<ActivityView>(
          builder: (context) => const Material(
            child: ActivityView(),
          ),
        ),
      );
      emit(state);
    });
    on<PushOnboarding>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<PushOnboarding>(
          builder: (context) => const OnboardingView(),
        ),
      );

      emit(state);
    });
    on<PushLikes>((event, emit) {
      navigationKey.currentState?.push(
        MaterialPageRoute<PushLikes>(
          builder: (context) => LikesView(loop: event.loop),
        ),
      );

      emit(state);
    });
    on<Pop>((event, emit) {
      navigationKey.currentState?.pop();

      emit(state);
    });
  }

  final GlobalKey<NavigatorState> navigationKey;
}
