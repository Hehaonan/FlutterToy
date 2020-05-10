import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//class FirstPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return new MaterialApp(
//      title: 'FirstPage',
//      theme: new ThemeData(primaryColor: Colors.blue),
//      home: new RandomWords(),
//    );
//  }
//}

class FirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RandomWordsState();
  }
}

class RandomWordsState extends State<FirstPage> {
  final _mList = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 20);
  final _saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
        ),
        automaticallyImplyLeading: true, //控制是否有按钮
        title: new Text('List'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: _jumpToSaved)
        ],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (context, index) {
          if (index.isOdd) {
            return new Divider(height: 1, color: Colors.lightBlue);
          }
          final last = index ~/ 2;
          if (last >= _mList.length) {
            _mList.addAll(generateWordPairs().take(10));
          }
          return buildListItem(_mList[last]);
        });
  }

  Widget buildListItem(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
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
    );
  }

  _jumpToSaved() {
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
              title: new Text('Saved item'),
            ),
            body: new ListView(children: divided),
          );
        },
      ),
    );
  }
}
