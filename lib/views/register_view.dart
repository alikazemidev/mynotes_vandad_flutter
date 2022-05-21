import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes_vand/constants/routes.dart';
import 'package:mynotes_vand/firebase_options.dart';

import 'package:mynotes_vand/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  static const routeName = '/register';
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController _email;
  late TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register')),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return Column(
                children: [
                  TextField(
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Enter your email here',
                    ),
                  ),
                  TextField(
                    obscureText: true,
                    autocorrect: false,
                    enableSuggestions: false,
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: 'Enter your password here',
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      final email = _email.text;
                      final password = _password.text;

                      try {
                       
                     await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                          email: email,
                          password: password,
                        );
                        final user = FirebaseAuth.instance.currentUser;
                        await user?.sendEmailVerification();
                        Navigator.of(context).pushNamed(verifyEmailRoute);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          await showErrorDialog(
                            context,
                            'Weak password',
                          );
                        } else if (e.code == 'email-already-in-use') {
                          await showErrorDialog(
                            context,
                            'Email is already in use',
                          );
                        } else if (e.code == 'invalid-email') {
                          await showErrorDialog(
                            context,
                            'This is an invalid Email address',
                          );
                        } else {
                          await showErrorDialog(
                            context,
                            'Error :${e.code}',
                          );
                        }
                      } catch (e) {
                        await showErrorDialog(
                          context,
                          e.toString(),
                        );
                      }
                    },
                    child: Text('Register'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (route) => false,
                      );
                    },
                    child: Text('already register? login here!'),
                  ),
                ],
              );
            default:
              return Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    );
  }
}
