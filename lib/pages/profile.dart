import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';




class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  File _image=File('');
  FirebaseAuth? auth = FirebaseAuth.instance;
  FirebaseStorage _fireStorage = FirebaseStorage.instance;
  final picker = ImagePicker();
  User? user;
  
  
  
  
  Future<void> uploadFile(File image) async {


    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profiles')
        .child(getUID(user));
    try {
      await ref.putFile(image);
      print('image Uploaded successfully');
    } on FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
    }
    
  }


  _openGallery(BuildContext context) async {
    await Permission.storage.request();
    if (await Permission.storage.isGranted) {
      final pickedImage = await picker.getImage(source: ImageSource.gallery);
      this.setState(() {
        if (pickedImage != null) {
          _image = File(pickedImage.path);
        }
          else {
            print('No image selected');
          }

      }
      );

      Navigator.of(context).pop();
      uploadFile(_image);
    }

    else {print('Please I need the Permission ffs');}

  }

_openCamera(BuildContext context) async {
  await Permission.camera.request();
  if (await Permission.camera.isGranted) {
    final pickedImage = await picker.getImage(source: ImageSource.camera);
    this.setState(() {
      if (pickedImage != null) {
        _image = File(pickedImage.path);
      }
      else {
        print('No image selected');
      }

    }
    );

    Navigator.of(context).pop();
    uploadFile(_image);
  }

  else {print('Please I need the Permission ffs');}

}

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[

                  GestureDetector(
                    child: Text("Camera"),
                    onTap: () {
                      _openCamera(context);
                    },
                  ),
                  Padding(padding: EdgeInsets.all(15.0)),
                  GestureDetector(
                    child: Text("Gallery"),
                    onTap: () {
                      _openGallery(context);
                    },
                  ),

                ],
              ),
            ),
          );
        });
  }


  TextEditingController nameController = TextEditingController(text:'Name Here..');
  TextEditingController userNameController = TextEditingController(text:'Username');
  TextEditingController bioController = TextEditingController(text: 'Bio');
  TextEditingController phoneController = TextEditingController(text: 'Phone Number');
  TextEditingController genderController = TextEditingController(text: 'Gender');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Venro'),backgroundColor: Colors.indigo[900],),

        body: SingleChildScrollView(child: Column(
            children:[
              Container(height: 150, width: 150 ,child: Image.network('profile/'+getUID(user))),
              Text('Profile Image Here'),
              Container(child: Row(
                children: [
                  ElevatedButton(child: Text('Upload'), onPressed: ()=>_showChoiceDialog(context),),
                  IconButton(icon: Icon(Icons.upload_file), onPressed: () => uploadFile(_image))
                ],
              ),),
              Container(child: TextFormField(controller: nameController,),),
              Container(child: TextFormField(controller: userNameController,),),
              Container(child: TextFormField(controller: phoneController, keyboardType: TextInputType.number,),),
              Container(child: TextFormField(controller: bioController,),),
              Container(child:ElevatedButton(onPressed: (){}, child: Text('Save changes'),), ),
            ]
        ),

        ),
      ),
    );
  }
}

String getUID (User? user ) {
  if (user != null) {
    print(user.uid);
    return user.uid;
  }
    else {

      print('No user found');

  }
    return '';
  }


 