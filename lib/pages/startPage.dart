import 'package:flutter/material.dart';
import 'signIn.dart';
import 'signUp.dart';
import 'package:venro/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
class StartPage extends StatelessWidget {

  static const String id ='startPage';
  const StartPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
        Navigator.pushNamed(context, HomePage.id);

      }
    });
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('Venro'), backgroundColor: Colors.indigo,),
          body: Column(
            children: [
              Container(margin: EdgeInsets.only(top: 100),child: Icon(Icons.account_circle, size: 150.0, color: Colors.indigo,),),
              Container(margin: EdgeInsets.only(top: 50),
                child: ElevatedButton(onPressed: (){ Navigator.pushNamed(context, SignIn.id);},
                    child: Text('Sign In')),),
              Container(
                  child: ElevatedButton(onPressed: () {Navigator.pushNamed(context, SignUp.id);},
                      child: Text('Sign Up'))),
              Container(),
            ],
          ),
        ),
      ),
    );


  }

}
