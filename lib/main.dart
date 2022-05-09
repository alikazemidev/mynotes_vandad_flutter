// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_vand/firebase_options.dart';
import 'package:mynotes_vand/views/login_view.dart';
import 'dart:developer' as dev;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: "notes app",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                dev.log('you are a verified user');
              } else {
                dev.log('you`re not verified user');
              }
              return Text('Done!');
            default:
              return Center(
                child: Text('waiting.....'),
              );
          }
        },
      ),
    );
  }
}
