


import 'package:firebase_auth/firebase_auth.dart';
import 'package:venro/pages/startPage.dart';
import 'package:venro/pages/home.dart';
class Testing {


  String isLoggedIn() {

String toWhere ='';
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        toWhere = StartPage.id;
        print('User is currently signed out!');
      } else {
        toWhere = HomePage.id;
        print('User is signed in!');
      }
    });
    return toWhere;
  }

}