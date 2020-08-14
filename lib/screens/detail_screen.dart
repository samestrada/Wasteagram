import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:wasteagram/models/post.dart';
import 'package:wasteagram/widgets/w_scaffold.dart';

class DetailScreen extends StatefulWidget {

  static final routeName = 'detail_screen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    final Post post = ModalRoute.of(context).settings.arguments;

    return WScaffold(
      title: 'Wasteagram',
      child: Center(
        child: Stack(
        // mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text(DateFormat.yMMMEd().format(post.date), style: TextStyle(fontSize: 25),)
              ),
          ),
          Center(
            child: AspectRatio(
              aspectRatio: 10/9,
              child: Image.network(post.imageURL),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(80.0),
              child: Text("${post.quantity} items", style: TextStyle(fontSize: 30))
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Location: (${post.latitude}, ${post.longitude})')
            )
          )
        ],
      ),
    ),
    );
  }


}