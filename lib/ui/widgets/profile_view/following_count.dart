import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/ui/views/follow_relationship/follow_relationship_view.dart';
import 'package:intheloopapp/ui/views/profile/profile_cubit.dart';
import 'package:intl/intl.dart';

class FollowingCount extends StatelessWidget {
  const FollowingCount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => FollowRelationshipView(
                  visitedUserId: state.visitedUser.id,
                  initialIndex: 1,
                ),
              ),
            );
          },
          child: Text(
            '${NumberFormat.compactCurrency(
              decimalDigits: 0,
              symbol: '',
            ).format(state.followingCount)} Following',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      },
    );
  }
}
