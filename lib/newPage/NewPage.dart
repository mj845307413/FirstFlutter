import 'package:flutter/widgets.dart';
import 'package:flutterapp/newPage/NewPageState.dart';

class NewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new NewPageState(name: name);
  }

  final String name;

  NewPage({Key key, @required this.name}) : super(key: key);
}
