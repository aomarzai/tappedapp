import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intheloopapp/domains/models/option.dart';
import 'package:intheloopapp/ui/create_loop/components/audio_container.dart';
import 'package:intheloopapp/ui/create_loop/cubit/create_loop_cubit.dart';
import 'package:intheloopapp/ui/themes.dart';

class UploadAudioButton extends StatelessWidget {
  const UploadAudioButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateLoopCubit, CreateLoopState>(
      builder: (context, state) {
        return state.pickedAudio.isNone
            ? Ink(
                decoration: const ShapeDecoration(
                  color: tappedAccent,
                  shape: CircleBorder(),
                ),
                child: IconButton(
                  onPressed: () {
                    try {
                      context.read<CreateLoopCubit>().handleAudioFromFiles();
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: Colors.red,
                          content: Text(e.toString()),
                        ),
                      );
                    }
                  },
                  icon: const Icon(
                    Icons.audio_file_outlined,
                    color: Colors.white,
                  ),
                ),
              )
            : const AudioContainer();
      },
    );
  }
}
