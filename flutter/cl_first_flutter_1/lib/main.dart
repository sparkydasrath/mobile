import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  final wordpair = WordPair.random();
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Random Words',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Random Words'),
        ),
        body: RandomWords(),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  _RandomWordState createState() => _RandomWordState();
}

class _RandomWordState extends State<RandomWords> {
  final WordPair wordPair = WordPair.random();
  final List<WordPair> _suggestions = <WordPair>[];
  final TextStyle _biggerFont = const TextStyle(fontSize: 18.0);

  Widget _buildRow(WordPair pair) {
    return ListTile(
      title: new Text(pair.asPascalCase, style: _biggerFont),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemBuilder: (BuildContext _context, int i) {
          if (i.isOdd) {
            return Divider();
          }
          final int index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }

          return _buildRow(_suggestions[index]);
        });
  }

  @override
  Widget build(BuildContext context) {
    return _buildSuggestions();
  }
}
