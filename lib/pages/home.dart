import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:venro/pages/startPage.dart';
import 'profile.dart';
import 'EventPages.dart';

class HomePage extends StatefulWidget {
  static const String id = 'homePage';
  const HomePage({Key? key}) : super(key: key);
  static int tabController = 0;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownValue = 'One';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                  margin: EdgeInsets.fromLTRB(290, 17, 5, 0),
                  child: Icon(Icons.chat)),
              foregroundColor: Colors.black,
              title: Text('Venro'),
              backgroundColor: Colors.indigo,
            ),
            drawer: Drawer(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: IconButton(
                        icon: Icon(
                          Icons.account_circle,
                          size: 50,
                        ),
                        onPressed: () {

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Profile()));
                        },
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 30, left: 10, right: 10),
                    child: MaterialButton(
                      child: Text('QR Code'),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: MaterialButton(
                      child: Text('Favorite'),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                      child: MaterialButton(
                        child: Text('History'),
                        onPressed: () {},
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: MaterialButton(
                      child: Text('Payments'),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                    child: MaterialButton(
                      child: Text('Settings'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(

                children: [
                  Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                  child: EFeed()),
                            ],
                          ),
                        ),
                      ),
                      Event(),
                      Event(),
                      Event(),
                      Event(),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Your Club Name Here'),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Icon(
                        Icons.group,
                        size: 50,
                      ),
                    ),
                    TextFormField(
                      initialValue: 'Club Name',
                    ),
                    TextFormField(
                      initialValue: 'Club Description',
                    ),
                    Text('Manage Members'),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: const TextStyle(color: Colors.deepPurple),
                      underline: Container(
                        height: 2,
                        color: Colors.deepPurpleAccent,
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          dropdownValue = newValue!;
                        });
                      },
                      items: <String>['One', 'Two', 'Free', 'Four']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.black,
              ),
              Container(
                color: Colors.green,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        Navigator.pushNamed(context, StartPage.id);
                        print(HomePage().key.toString());
                      },
                      child: Text('Sign Out')),
                ),
              ),
            ]),
            floatingActionButton: FloatingActionButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EventAddPage()) );

            } ),
            floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
            bottomNavigationBar: 

            
            TabBar(
              
              indicatorColor: Colors.indigoAccent,
              unselectedLabelColor: Colors.blueGrey,
              tabs: [
                IconButton(icon: Icon(Icons.home), onPressed: () {}),
                IconButton(icon: Icon(Icons.group), onPressed: () {}),
                IconButton(icon: Icon(Icons.account_circle), onPressed: () {}),
                IconButton(icon: Icon(Icons.menu), onPressed: () {}),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Event extends StatefulWidget {
  const Event({Key? key}) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Event Title'),
          Placeholder(),
          Text('Event Description'),
        ],
      ),
    );
  }
}

class EFeed extends StatefulWidget {
  const EFeed({Key? key}) : super(key: key);

  @override
  _EFeedState createState() => _EFeedState();
}

class _EFeedState extends State<EFeed> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircleAvatar(
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}


