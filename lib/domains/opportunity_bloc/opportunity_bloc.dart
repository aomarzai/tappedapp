import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intheloopapp/data/auth_repository.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/authentication_bloc/authentication_bloc.dart';
import 'package:intheloopapp/domains/models/opportunity.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/tapped_route.dart';

part 'opportunity_event.dart';
part 'opportunity_state.dart';

final _analytics = FirebaseAnalytics.instance;

class OpportunityBloc extends Bloc<OpportunityEvent, OpportunityState> {
  OpportunityBloc({
    required this.nav,
    required this.auth,
    required this.authBloc,
    required this.database,
  }) : super(const OpportunityState()) {
    on<InitQuotaListener>((event, emit) {
      final currentUserId =
          (authBloc.state as Authenticated).currentAuthUser.uid;
      _quotaSubscription = database
          .getUserOpportunityQuotaObserver(currentUserId)
          .listen((event) {
        add(SetQuota(quota: event));
      });
    });
    on<SetQuota>((event, emit) {
      final quota = event.quota;
      emit(
        state.copyWith(opQuota: quota),
      );
    });
    on<DislikeOpportunity>((event, emit) async {
      final currentUserId =
          (authBloc.state as Authenticated).currentAuthUser.uid;
      final op = event.opportunity;
      await database.dislikeOpportunity(
        opportunity: op,
        userId: currentUserId,
      );
    });
    on<ApplyForOpportunity>((event, emit) async {
      final currentUserId =
          (authBloc.state as Authenticated).currentAuthUser.uid;
      final userComment = event.userComment;
      final op = event.opportunity;

      // check credits
      if (state.opQuota == 0) {
        await _analytics.logEvent(
          name: 'quota_limit_hit',
          parameters: {
            'user_id': currentUserId,
            'opportunity_id': op.id,
          },
        );
        nav.push(WaitlistPage());
        return;
      }

      await database.applyForOpportunity(
        opportunity: op,
        userId: currentUserId,
        userComment: userComment,
      );

      final claim = await auth.getCustomClaim();
      if (claim.isNone) {
        await database.decrementUserOpportunityQuota(currentUserId);
      }
    });
  }

  @override
  Future<void> close() {
    _quotaSubscription?.cancel();
    return super.close();
  }

  final DatabaseRepository database;
  final AuthRepository auth;
  final AuthenticationBloc authBloc;
  final NavigationBloc nav;
  StreamSubscription<int?>? _quotaSubscription;
}
