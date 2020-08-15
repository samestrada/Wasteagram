// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.


import 'package:flutter_test/flutter_test.dart';

import 'package:wasteagram/models/post.dart';


void main() {

    group('Testing Post Class', (){
      TestWidgetsFlutterBinding.ensureInitialized();
      DateTime currentTime = DateTime.now();
      

      test('Default constructor returns empty object', (){
        Post post = Post();
        expect(post.date, null);
      });

      test('Test Post Model with values populates accordingly', (){
        Post pPost = Post(
        date:currentTime,
        imageURL: 'my-image.url',
        quantity: 10,
        latitude: 592.0,
        longitude: -42.0
      );
        expect(currentTime, pPost.date);
        expect('my-image.url', pPost.imageURL);
        expect(10, pPost.quantity);
        expect(592.0, pPost.latitude);
        expect(-42.0, pPost.longitude);
        }
      );
    });
}
