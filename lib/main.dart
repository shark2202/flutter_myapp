import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new MyApp());

class RandomWords extends StatefulWidget{
  @override
  createState() => new RandomWordsState();
}

class RandomWordsState extends State<RandomWords>{

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _saved = new Set<WordPair>();
  var _topSaved = false;

  Widget _buildSuggestions(){
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),

      itemBuilder: (context, i){
        if (i.isOdd) return new Divider();
        
        final index = i ~/ 2;

        if(index <= 3){
          if(index >= _suggestions.length){
            _suggestions.addAll(generateWordPairs().take(10));
          }

          if(index == 0){
            //print(index);
            return _buildTop(_suggestions[index]);
          }

          return _buildRow(_suggestions[index]);
          }
      }
    );
  }

  Widget _buildTop(WordPair pair){
    return new ListTile(
      title: new Text("top"),
      trailing: new Icon(
        _topSaved ? Icons.favorite : Icons.favorite_border,
        color: _topSaved ? Colors.red : null,
      ),
      onTap: (){
          setState(() {
              _topSaved = !_topSaved;

              _suggestions.forEach(
                (c) => _topSaved?_saved.add(c):_saved.remove(c)
              );
          });
          print("top");
      },
    );
  }

  Widget _buildRow(WordPair pair){
    if(_topSaved){
      _saved.add(pair);
    }
    final alreadySaved = _saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite  : Icons.favorite_border,
        color: alreadySaved? Colors.red : null,
      ),

      onTap: (){
        setState(() {
          print(pair.asPascalCase); 

          Fluttertoast.showToast(
            msg:pair.asPascalCase
          );

          if(alreadySaved){
            _saved.remove(pair);

            _topSaved = false;
          }else{
            _saved.add(pair);

            var _topSaved2 = true;
            _suggestions.forEach(
              (c){
                if(!_saved.contains(c)){
                  _topSaved2 = false;
                }
              }
            );
            print(_topSaved2);
            _topSaved = _topSaved2;
          }


        });
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();
    //return (new Text(wordPair.asPascalCase));

    return new Scaffold(
      appBar: new AppBar(
        title : new Text("ssss"),
      ),
      body: _buildSuggestions(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //final wordPair = new WordPair.random();

    return new MaterialApp(
      title:"oooo",
      home: new RandomWords(),
    );

    // return new MaterialApp(
    //   title: 'Welcome to Flutter',
    //   home: new Scaffold(
    //     appBar: new AppBar(
    //       title: new Text('Welcome to Flutter'),
    //     ),
    //     body: new Center(
    //       child: new RandomWords(),//new Text(wordPair.asPascalCase),
    //     ),
    //   ),
    // );
  }
}