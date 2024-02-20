import 'package:chat_app/Pages/chat_page.dart';
import 'package:chat_app/Pages/login_page.dart';
import 'package:chat_app/Pages/signup_page.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const TAKAMUL(),
  );
}

class TAKAMUL extends StatelessWidget {
  const TAKAMUL({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        SignupPage.id: (context) => const SignupPage(),
        LoginPage.id: (context) => const LoginPage(),
        ChatPage.id: (context) => ChatPage(),
      },
      initialRoute: LoginPage.id,
    );
  }
}