import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:image_picker/image_picker.dart';

import 'package:wasteagram/models/post.dart';

class PhotoScreen extends StatefulWidget {
static final routeName = "photo_screen";

  @override
  _PhotoScreenState createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  //taken from pub.dev/packages/image_picker
  File _image;
  LocationData _locationData;
  GlobalKey<FormState> _key = GlobalKey();
  Post post = new Post();
  final picker = ImagePicker();

  Future choosePhoto() async{
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
     
    setState(() {
      _image = File(pickedFile.path);
    }); 
  }

  Future takePhoto() async{
    final pickedFile = await picker.getImage(source: ImageSource.camera);
     
    setState(() {
      _image = File(pickedFile.path);
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Wastegram'),
        ),
      body: Center(
        child: _image == null ? displayButtons(context)
        : Form(
          key: _key,
          child: addPost(context)
        )
        ),
    );
  }

  Widget addPost(BuildContext context){
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 10/9,
              child: Image.file(_image),
            ),
            Container(
              child: TextFormField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30),
                decoration: 
                  InputDecoration(
                    labelText: 'Number of wasted items',
                    labelStyle: TextStyle(fontSize: 30, color: Colors.grey),
                    floatingLabelBehavior: FloatingLabelBehavior.auto
                  ),
                  onSaved: (value){
                    post.quantity = num.parse(value);
                  },
              )
            ),
          ]
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 80),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
                ),
                child: Icon(
                  Icons.cloud_upload, size: 80,
                ),
                onPressed: () async{
                  _key.currentState.save();
                  getLocation();
                  saveData(context);
                },
              )
            )
        )
      ]
    );
  }

  void getLocation() async{
    //taken from pub.dev documentation
    Location location = new Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if(!_serviceEnabled){
      _serviceEnabled = await location.requestService();
      if(!_serviceEnabled){
        return;
      }
    }
  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.DENIED) {
    _permissionGranted = await location.requestPermission();
  if (_permissionGranted != PermissionStatus.GRANTED) {
    return;
  }
}

    _locationData = await location.getLocation();
    setState( () {});
}

  Future saveData (BuildContext context) async{
    StorageReference storageReference = FirebaseStorage.instance.ref().child('${Timestamp.now()} ${_image.path}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    final url = await storageReference.getDownloadURL();
    post.imageURL = url;
    post.date = DateTime.now();
    post.latitude = _locationData.latitude;
    post.longitude = _locationData.longitude;
    post.addToDB();
    Navigator.of(context).pop();
  }


  Widget displayButtons(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
        height: 100.0,
        width: 200.0, 
        child: FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.yellow[200],
        child:Text("Open Gallery", style: TextStyle(color: Colors.black, fontSize: 23),),
        onPressed: (){
          choosePhoto();
          },
        )
      ),
      SizedBox(height: 20),
      Container(
        height: 100.0,
        width: 200.0, 
        child: FlatButton(
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
        color: Colors.teal[200],
        child:Text("Take Photo", style: TextStyle(color: Colors.black, fontSize: 23),),
        onPressed: (){
          takePhoto();
          },
        )
      ),
      ]
    );
  }
}