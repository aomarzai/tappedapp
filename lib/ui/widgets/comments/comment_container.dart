import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/database_repository.dart';
import 'package:intheloopapp/domains/models/comment.dart';
import 'package:intheloopapp/domains/models/user_model.dart';
import 'package:intheloopapp/domains/navigation_bloc/navigation_bloc.dart';
import 'package:intheloopapp/domains/onboarding_bloc/onboarding_bloc.dart';
import 'package:intheloopapp/linkify.dart';
import 'package:intheloopapp/ui/views/error/error_view.dart';
import 'package:intheloopapp/ui/widgets/common/user_avatar.dart';
import 'package:skeletons/skeletons.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentContainer extends StatefulWidget {
  const CommentContainer({required this.comment, super.key});
  final Comment comment;

  @override
  State<CommentContainer> createState() => _CommentContainerState();
}

class _CommentContainerState extends State<CommentContainer> {
  bool _isLiked = false;
  int _likeCount = 0;

  @override 
  void initState() {
    super.initState();

    _likeCount = widget.comment.likeCount;
  }

  @override
  Widget build(BuildContext context) {
    final databaseRepository =
        RepositoryProvider.of<DatabaseRepository>(context);
    final navigationBloc = RepositoryProvider.of<NavigationBloc>(context);

    return BlocSelector<OnboardingBloc, OnboardingState, UserModel?>(
      selector: (state) => (state is Onboarded) ? state.currentUser : null,
      builder: (context, currentUser) {
        if (currentUser == null) {
          return const ErrorView();
        }

        return FutureBuilder<UserModel?>(
          future: databaseRepository.getUserById(widget.comment.userId),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return SkeletonListTile();
            }

            final user = snapshot.data!;

            return FutureBuilder<bool>(
              future: databaseRepository.isVerified(widget.comment.userId),
              builder: (context, snapshot) {
                final isVerified = snapshot.data ?? false;

                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ListTile(
                    onTap: () => navigationBloc.add(PushProfile(user.id)),
                    leading: UserAvatar(
                      radius: 20,
                      imageUrl: user.profilePicture,
                      verified: isVerified,
                    ),
                    trailing: TextButton.icon(
                      onPressed: () {
                        if (_isLiked) {
                          databaseRepository.unlikeComment(
                            currentUser.id,
                            widget.comment,
                          );
                        } else {
                          databaseRepository.likeComment(
                            currentUser.id,
                            widget.comment,
                          );
                        }

                        setState(() {
                          if (_isLiked) {
                            _likeCount--;
                          } else {
                            _likeCount++;
                          }

                          _isLiked = !_isLiked;
                        });
                      },
                      label: Text(
                        _likeCount.toString(),
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      icon: _isLiked
                          ? const Icon(
                              CupertinoIcons.heart_fill,
                              size: 14,
                              color: Colors.red,
                            )
                          : const Icon(
                              CupertinoIcons.heart,
                              size: 14,
                              color: Colors.grey,
                            ),
                    ),
                    title: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                        children: [
                          TextSpan(
                            text: user.displayName,
                          ),
                          TextSpan(
                            text: timeago.format(
                              widget.comment.timestamp.toDate(),
                              locale: 'en_short',
                            ),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Linkify(
                      text: widget.comment.content,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
