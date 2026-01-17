import 'package:flutter/material.dart';
import 'package:mynotesh/utilities/dialogs/generic_dialog.dart';

Future<void> showPasswordResetSentDialog(BuildContext context) {
  return showGenericDialog(
    context: context,
    title: 'Password Reset',
    content: 'We have now sent you a password reset link.Please cheak your mail for varify',
    optionsBuilder: () => {
      'OK': null,
    },
  );
}
