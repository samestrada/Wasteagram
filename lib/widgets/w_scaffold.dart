import 'package:flutter/material.dart';

import 'package:wasteagram/screens/photo_screen.dart';

class WScaffold extends StatelessWidget {

const WScaffold({Key key, this.title, this.child, this.button}) : super(key : key);

  final String title;
  final Widget child;
  final bool button;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('$title')
      ),
      body: child,
      
      floatingActionButton: _createFAB(button, context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

Widget _createFAB(button, context){
  if(button==true){
    return Semantics(
          label: 'Add a new post',
          button: true,
          child: FloatingActionButton(
            onPressed: () => Navigator.pushNamed(context, PhotoScreen.routeName),
            child: Icon(Icons.add_a_photo)
          )
    );
  } else{
    return Container();
  }
}