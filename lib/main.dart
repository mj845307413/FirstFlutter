import 'package:flutter/material.dart';

import 'RandomWordsWidget.dart';
import 'newPage/NewPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primaryColor: Colors.blue,
        ),
        initialRoute: "home",
        title: 'Welcome to Flutter',
        routes: {
          "new_page": (context) => NewPage(name: "null"),
          "home": (context) => new RandomWordsWidget(),
          //注册首页路由
        });
  }
}
