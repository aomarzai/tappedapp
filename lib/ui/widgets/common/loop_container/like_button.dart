import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/ui/widgets/common/loop_container/loop_container_cubit.dart';

class LikeButton extends StatelessWidget {
  const LikeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoopContainerCubit, LoopContainerState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () =>
              context.read<NavigationBloc>().add(PushLikes(state.loop)),
          child: Row(
            children: [
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () =>
                    context.read<LoopContainerCubit>().toggleLoopLike(),
                child: Icon(
                  state.isLiked ? Icons.favorite : Icons.favorite_border,
                  color: state.isLiked ? Colors.red : const Color(0xFF757575),
                  size: 20,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '${state.likeCount}',
                style: TextStyle(
                  fontSize: 10,
                  color: state.isLiked ? Colors.red : const Color(0xFF757575),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
