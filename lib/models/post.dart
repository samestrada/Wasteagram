import 'package:cloud_firestore/cloud_firestore.dart';

class Post{
  DateTime date;
  String imageURL;
  int quantity;
  double latitude;
  double longitude; 

  Post({this.date, this.imageURL, this.quantity, this.latitude, this.longitude});

  void addToDB(){
    Firestore.instance.collection('posts').add({
      'date': this.date,
      'imageURL': this.imageURL,
      'quantity': this.quantity, 
      'latitude': this.latitude,
      'longitude': this.longitude
    });
  }
}


