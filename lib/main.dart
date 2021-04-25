import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './screens/auth_screen.dart';
import './screens/chat_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ViperChat',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        backgroundColor: Colors.pink,
        accentColor: Colors.deepPurpleAccent,
        accentColorBrightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.orange,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      home: StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(), builder: (context, userSnapshot) {
        if(userSnapshot.hasData) {
          return ChatScreen();
        }
        return AuthScreen();
      },),
    );
  }
}
