import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/newPage/NewPage.dart';

class NewPageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text("我是新页面"),
      ),
      body: new Center(
        child: new Text(name),
      ),
    );
  }

  final String name;

  NewPageState({@required this.name});
}
