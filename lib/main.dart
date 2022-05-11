// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_vand/firebase_options.dart';
import 'package:mynotes_vand/views/login_view.dart';


import 'package:mynotes_vand/views/register_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: "notes app",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      routes: {
        '/register/': (context) => RegisterView(),
        '/login/': (context) => LoginView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            // if (user?.emailVerified ?? false) {
            //   dev.log('you are a verified user');
            return LoginView();
          // } else {
          //   dev.log('you`re not verified user');
          //   return VerifyEmailView();
          // }
          default:
            return Center(
              child: CircularProgressIndicator(),
            );
        }
      },
    );
  }
}


