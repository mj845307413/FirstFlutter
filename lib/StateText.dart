import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/widget/MyDrawer.dart';

import 'RandomWordsWidget.dart';

class StateText extends State<RandomWordsWidget> {
  final _suggestions = <WordPair>[];

  final _biggerFont = const TextStyle(
      color: Colors.blue,
      fontSize: 18.0,
      height: 1.2,
      backgroundColor: Colors.yellowAccent,
      fontFamily: "Courier",
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.dashed);
  final _saved = new Set<WordPair>();

  Widget _buildSuggestions() {
    return Material(
      child: CustomScrollView(
        slivers: <Widget>[
          //AppBar，包含一个导航栏
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Demo'),
              background: Image.asset(
                "assets/demos/bottom_navigation_background.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: new SliverGrid(
              //Grid
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, //Grid按两列显示
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 4.0,
              ),
              delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int i) {
                  //创建子widget
                  // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
                  // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
                  // 如果是建议列表中最后一个单词对
                  if (i >= _suggestions.length && _suggestions.length <= 50) {
                    // ...接着再生成10个单词对，然后添加到建议列表
                    _suggestions.addAll(generateWordPairs().take(10));
                  }
                  if (i >= _suggestions.length) {
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          "没有更多了",
                          style: TextStyle(color: Colors.grey),
                        ));
                  }
                  return _buildRow(_suggestions[i]);
                },
                childCount: 61,
              ),
            ),
          ),
          //List
          new SliverFixedExtentList(
            itemExtent: 50.0,
            delegate: new SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              //创建列表项
              return new Container(
                alignment: Alignment.center,
                color: Colors.lightBlue[100 * (index % 9)],
                child: new Text('list item $index'),
              );
            }, childCount: 50 //50个列表项
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    Text text = new Text(
      pair.asPascalCase,
      style: _biggerFont,
    );
    return new ListTile(
      title: text,
      trailing: new Icon(
        alreadySaved ? Icons.delete : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
//      onLongPress: _pressAction(text.data),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.add_to_photos),
            onPressed: () => Navigator.of(context).pushNamed("test"),
          ),
          title: new Text('Startup Name Generator'),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.list),
              onPressed: _pushSaved,
            ),
          ],
        ),
        endDrawer: MyDrawer(),
        drawer: MyDrawer(),
        body: _buildSuggestions(),
        floatingActionButton: FloatingActionButton(onPressed: _pressAction),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
          child: Row(
            children: [
              IconButton(icon: Icon(Icons.home)),
              SizedBox(), //中间位置空出
              IconButton(icon: Icon(Icons.business)),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
          ),
        ));
  }

  void _pressAction() {
    Navigator.of(context).pushNamed("new_page", arguments: "123123");
  }

  void _pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return new ListTile(
                title: new Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Saved Suggestions'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
