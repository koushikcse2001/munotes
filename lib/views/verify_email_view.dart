import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesh/services/auth/auth_service.dart';
import 'package:mynotesh/services/auth/bloc/auth_bloc.dart';
import 'package:mynotesh/services/auth/bloc/auth_event.dart';
import '../constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify Your Email")),
      body: Column(
        children: [
          const Text("We've sent you an email verification"),
          const Text(
            "If you haven't received a verification email yet,Resent it",
          ),
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(
                const AuthEventSendEmailVerification(),
              );
            },
            child: const Text("Send email verification"),
          ),
          //
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                const AuthEventLogOut(),
              );
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}

