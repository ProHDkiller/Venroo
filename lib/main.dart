import 'dart:io';
import 'package:flutter/material.dart';
import 'package:venro/pages/startPage.dart';
import 'package:venro/pages/signIn.dart';
import 'package:venro/pages/signUp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:venro/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:venro/malc/globals.dart';

void main () {

  runApp(Initializer());
}

class Initializer extends StatelessWidget {
  const Initializer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(


      future: Firebase.initializeApp(),



      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(home:Container(child: Center(child: Text('Something went wrong'),),));
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {


          return MyApp();
        }


        return MaterialApp(home: Container(child: CircularProgressIndicator(value: 50,)));
      },
    );
  }
}



class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return MaterialApp(

      initialRoute:StartPage.id,
      routes: {
        HomePage.id: (context) => HomePage(),
        StartPage.id: (context) {
          FirebaseAuth auth = FirebaseAuth.instance;
 bool test = false ;
          auth.authStateChanges().listen((User? user) {
            if (user == null) {
              print('User is currently signed out!');
              test=false;


            } else {
              print('User is signed in! --Main line 84 --');
              test=true;

            }
          });

          if (test) {
            return HomePage();
          }
          else {

            return StartPage();
          }
        },
        SignIn.id: (context) => SignIn(),
        SignUp.id: (context) => SignUp(),
      },
    );
  }
}
