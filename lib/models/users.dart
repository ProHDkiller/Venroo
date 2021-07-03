import 'package:firebase_auth/firebase_auth.dart';
import 'event.dart';
FirebaseAuth auth = FirebaseAuth.instance;

class Users{
  String uID;
  String firstName;
  String lastName;
  String phoneNumber;
  String profilePicture;
  bool hasStory;
  List<User> friends;
  List<Event> savedEvents;


  
  Users(
      this.uID,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.profilePicture,
      this.hasStory,
      this.friends,
      this.savedEvents,
      );
}
