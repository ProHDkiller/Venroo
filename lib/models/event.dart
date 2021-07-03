import 'package:flutter/material.dart';
import 'package:venro/models/users.dart';

class Event {
  Users user;
  String date;
  String desc;
  String imageURL;
  List<Users> participants;
  String locationID;

  Event(
    this.user,
    this.date,
    this.desc,
    this.imageURL,
    this.participants,
    this.locationID,
//TODO: Implement more Event Class infos, Such as Content in the event page to show. Must be included here;
);


}
