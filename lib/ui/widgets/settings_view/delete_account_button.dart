import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intheloopapp/ui/views/settings/settings_cubit.dart';
import 'package:intheloopapp/ui/widgets/common/forms/apple_login_button.dart';
import 'package:intheloopapp/ui/widgets/common/forms/email_text_field.dart';
import 'package:intheloopapp/ui/widgets/common/forms/google_login_button.dart';
import 'package:intheloopapp/ui/widgets/common/forms/password_text_field.dart';
import 'package:intheloopapp/ui/widgets/settings_view/reauthenticate_button.dart';

class DeleteAccountButton extends StatelessWidget {
  const DeleteAccountButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        return TextButton(
          onPressed: () => showDialog<AlertDialog>(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 5,
              title: const Text('Reauthenticate'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: state.status.isInProgress
                    ? [
                        const CircularProgressIndicator(),
                      ]
                    : [
                        const Text(
                          'Warning: this cannot be undone',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        EmailTextField(
                          onChanged: context.read<SettingsCubit>().updateEmail,
                        ),
                        const SizedBox(height: 20),
                        PasswordTextField(
                          onChanged:
                              context.read<SettingsCubit>().updatePassword,
                        ),
                        const SizedBox(height: 20),
                        ReauthenticateButton(
                          onPressed: context
                              .read<SettingsCubit>()
                              .reauthWithCredentials,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            GoogleLoginButton(
                              onPressed: context
                                  .read<SettingsCubit>()
                                  .reauthWithGoogle,
                            ),
                            const SizedBox(height: 10),
                            if (Platform.isIOS)
                              AppleLoginButton(
                                onPressed: context
                                    .read<SettingsCubit>()
                                    .reauthWithApple,
                              )
                            else
                              const SizedBox.shrink(),
                          ],
                        ),
                      ],
              ),
              actions: [
                TextButton(
                  onPressed: Navigator.of(context).pop,
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
          child: Text(
            'Delete Account',
            style: TextStyle(
              color: Colors.red[300],
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}
