import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotesh/helpers/loading/loading_screen.dart';
import 'package:mynotesh/services/auth/bloc/auth_bloc.dart';
import 'package:mynotesh/services/auth/bloc/auth_event.dart';
import 'package:mynotesh/services/auth/bloc/auth_state.dart';
import 'package:mynotesh/services/auth/firebase_auth_provider.dart';
import 'package:mynotesh/views/forgot_password_view.dart';
import 'package:mynotesh/views/login_view.dart';
import 'package:mynotesh/views/notes/create_update_note_view.dart';
import 'package:mynotesh/views/notes/notes_view.dart';
import 'package:mynotesh/views/register_view.dart';
import 'package:mynotesh/views/verify_email_view.dart';
import 'package:mynotesh/constants/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: BlocProvider<AuthBloc>(
        create: (create) => AuthBloc(FirebaseAuthProvider()),
        child: HomePage(),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state){
        if (state.isLoading){
          LoadingScreen().show(
              context: context,
              text: state.loadingText ?? 'Please wait a moment',
          );
        }else{
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthEventLogIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        }else if (state is AuthStateRegistering){
          return const RegisterView();
        } else {
          return const Scaffold(body: CircularProgressIndicator());
        }
      },
    );
  }
}
