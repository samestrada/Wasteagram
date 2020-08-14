import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:intl/intl.dart';
import 'package:wasteagram/screens/detail_screen.dart';


import 'package:wasteagram/widgets/w_scaffold.dart';
import 'package:wasteagram/models/post.dart';

class ListScreen extends StatefulWidget {

  static final routeName = "/";
  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance.collection('posts').orderBy('date', descending: true).snapshots(),
        builder: (content, snapshot){
          if(snapshot.hasData && snapshot.data.documents != null && snapshot.data.documents.length > 0){
            return WScaffold(
              title: 'Wasteagram - ${calcTotal(snapshot.data.documents)}',
              child: Center(
                child: ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) => loadPost(context, snapshot.data.documents[index])
                ),
              ),
              button: true,
            );
          } else {
              return WScaffold(
               title: 'Wasteagram',
               child: Center(
                  child:
                    CircularProgressIndicator()),
              button: true,
              );
            }
        }
      );
  }

  Widget loadPost(BuildContext context, DocumentSnapshot snapshot){
    var p = snapshot;
    Post post = Post(
      date: p['date'].toDate(),
      imageURL: p['imageURL'],
      quantity: p['quantity'],
      latitude: p['latitude'],
      longitude: p['longitude'], 
    );
    return Semantics(
      button: true,
      onTapHint: 'Click to view details',
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, DetailScreen.routeName, arguments: post);
        },
        child: ListTile(
          trailing: Text(post.quantity.toString(), style: TextStyle(fontSize: 23)),
          title: Text(DateFormat.MMMEd().format(post.date), style: TextStyle(fontSize: 21))
        )
      )
    );
  }

  int calcTotal(elements){
    int sum = 0;
    
    for (var post in elements){
      sum += post['quantity'];
    }
    return sum;
  }
}

