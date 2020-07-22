import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/widget/WillPopScopeTestRoute.dart';

import 'RandomWordsWidget.dart';
import 'newPage/NewPage.dart';

//void main() => () {
//      //通过重写onError方法来处理错误的回调
//      FlutterError.onError = (FlutterErrorDetails details) {
//        FlutterError.reportError(details);
//      };
//      //运行flutterAPP，这边是入口
//      runApp(new MyApp());
//    };

//hook住所有print方法
void collectLog(String line) {
  //收集日志
}

void reportErrorAndLog(FlutterErrorDetails details) {
  //上报错误和日志逻辑
}

FlutterErrorDetails makeDetails(Object obj, StackTrace stack) {
  // 构建错误信息
}

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    reportErrorAndLog(details);
  };
  runZoned(
    () => runApp(MyApp()),
    zoneSpecification: ZoneSpecification(
      print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
        collectLog(line); // 收集日志
      },
    ),
    onError: (Object obj, StackTrace stack) {
      var details = makeDetails(obj, stack);
      reportErrorAndLog(details);
    },
  );
}

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
          "test": (context) => new WillPopScopeTestRoute()
          //注册首页路由
        });
  }
}
