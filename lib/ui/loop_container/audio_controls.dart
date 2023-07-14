import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/data/audio_repository.dart';
import 'package:intheloopapp/domains/controllers/audio_controller.dart';
import 'package:intheloopapp/ui/loop_container/loop_seek_bar.dart';
import 'package:intheloopapp/ui/loop_container/play_pause_button.dart';
import 'package:intheloopapp/utils/app_logger.dart';
import 'package:skeletons/skeletons.dart';
import 'package:uuid/uuid.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({
    required this.audioPath,
    required this.title,
    required this.artist,
    required this.profilePicture,
    super.key,
  });

  final String audioPath;
  final String title;
  final String artist;
  final String? profilePicture;

  @override
  Widget build(BuildContext context) {
    if (audioPath.isEmpty) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<AudioController?>(
      future: AudioController.fromUrl(
        audioRepo: RepositoryProvider.of<AudioRepository>(context),
        url: audioPath,
        title: title,
        artist: artist,
        image: profilePicture,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SkeletonListTile();
        }

        final audioController = snapshot.data!;
        final uuid = const Uuid().v4();

        return VisibilityDetector(
          key: Key('$uuid-$audioPath'),
          onVisibilityChanged: (visibilityInfo) {
            final visiblePercentage = visibilityInfo.visibleFraction * 100;
            // logger.debug(
            //   'Widget ${visibilityInfo.key} is ${visiblePercentage}% visible',
            // );
            if (visiblePercentage > 50) {
              audioController.play();
            } else {
              audioController.pause();
            }
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  PlayPauseButton(
                    audioController: audioController,
                  ),
                  Expanded(
                    child: LoopSeekBar(
                      audioController: audioController,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
