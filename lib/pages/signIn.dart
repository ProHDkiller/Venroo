import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:venro/pages/home.dart';


class SignIn extends StatefulWidget {
  static const String id ='signIn';

  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String _email='';
  String _password='';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(child: Scaffold(
        appBar: AppBar(title: Text('Venro'), backgroundColor: Colors.indigo, leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                margin: EdgeInsets.only(left: 10,right: 10,top: 20),
                child: Icon(Icons.account_circle, size: 150,)),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 5),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                initialValue: 'Email Address',
                onChanged: (value) {
                  _email = value;
                } ,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10,right: 10,top: 5),
              child: TextFormField(
                initialValue: 'Password',
                onChanged: (value) {
                  _password = value;
                } ,
              ),
            ),
            ElevatedButton(onPressed: () {
              FirebaseAuth auth = FirebaseAuth.instance;
              try {

                auth.signInWithEmailAndPassword(
                    email: _email, password: _password);
              }
              on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  print('No user found for that email.');
                } else if (e.code == 'wrong-password') {
                  print('Wrong password provided for that user.');
                }
              }
              auth.authStateChanges().listen((User? user) {
                if (user==null) {
                  print("There's no user Try Again");

                }
                else {
                  print('User is Signed in Redirecting to HomePage...');
                  Navigator.pushNamed(context, HomePage.id);
                }

              });
            },
                child: Text('Sign in')),


        ],),
      ),
      )),
    );
  }
}



