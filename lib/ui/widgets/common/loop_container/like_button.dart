import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/ui/widgets/common/loop_container/loop_container_cubit.dart';
import 'package:like_button/like_button.dart' as like;

class LikeButton extends StatelessWidget {
  const LikeButton({
    required this.onLike,
    required this.likeCount,
    this.isLiked,
    super.key,
  });

  final void Function() onLike;
  final bool? isLiked;
  final int likeCount;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoopContainerCubit, LoopContainerState>(
      builder: (context, state) {
        return like.LikeButton(
          // size: 30,
          onTap: (isLiked) async {
            onLike();

            return true;
          },
          isLiked: isLiked,
          circleColor: const like.CircleColor(
            start: Colors.red,
            end: Colors.red,
          ),
          bubblesColor: const like.BubblesColor(
            dotPrimaryColor: Colors.red,
            dotSecondaryColor: Colors.red,
          ),
          likeBuilder: (bool isLiked) {
            return Icon(
              CupertinoIcons.heart_fill,
              color: isLiked ? Colors.red : Colors.grey,
              size: 20,
            );
          },
          likeCount: likeCount,
          countBuilder: (count, isLiked, text) {
            final color = isLiked ? Colors.red : Colors.grey;

            return count == 0
                ? Text('like', style: TextStyle(color: color))
                : Text(text, style: TextStyle(color: color));
          },
        );

        return Row(
          children: [
            const SizedBox(width: 20),
            GestureDetector(
              onTap: () => context.read<LoopContainerCubit>().toggleLoopLike(),
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
            ),
          ],
        );
      },
    );
  }
}
