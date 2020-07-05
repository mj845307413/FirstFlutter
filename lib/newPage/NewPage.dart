import 'package:flutter/widgets.dart';
import 'package:flutterapp/newPage/NewPageState.dart';

class NewPage extends StatefulWidget {
  NewPageState mPageState;

  @override
  State<StatefulWidget> createState() {
    mPageState = NewPageState();
    return mPageState;
  }

  final String name;

  NewPage({Key key, @required this.name}) : super(key: key);

  NewPageState of() {
    return mPageState;
  }
}
