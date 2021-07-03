import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  static const String id = 'signUp';
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static TextEditingController emailController =
      TextEditingController(text: 'Email Address');
  static TextEditingController passController =
      TextEditingController(text: 'Password');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
              title: Text('Venro'),
              backgroundColor: Colors.indigo[900],
              leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  })),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Icon(
                    Icons.account_circle,
                    size: 150,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 75, left: 10, right: 10),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    onTap: () {
                      emailController.text = '';
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, left: 10, right:10),
                  child: TextFormField(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    controller: passController,
                    onTap: () {
                      passController.text = '';
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    child: Text('Sign Up'),
                    onPressed: () async {
                      print(passController.text.toString());
                      try {
                        final newuser =
                            await _auth.createUserWithEmailAndPassword(
                                email: emailController.text.toString(),
                                password: passController.text.toString());
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'weak-password') {
                          print('The password provided is too weak.');
                        } else if (e.code == 'email-already-in-use') {
                          print('The account already exists for that email.');
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Google'),
                      Text('Facebook'),
                      Text('Something')
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
