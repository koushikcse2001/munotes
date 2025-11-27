import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotesh/main.dart';
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
          const Text("Please Verify Your email address:"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text("Send email verification"),
          ),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.reload(); // ← VERY IMPORTANT
              if (user != null && user.emailVerified) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const NotesView()),
                );
              }
            },
            child: const Text("I have verified my email"),
          ),
        ],
      ),
    );
  }
}
