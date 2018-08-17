import 'package:flutter/material.dart';

void main() => runApp(new FriendlychatApp());

const String _name = "Sparky";

class FriendlychatApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Friendly Chat',
      theme: ThemeData.light(),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final TextEditingController _tec = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  bool _isComposing = false;

  Widget _buildTextComposer() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: _tec,
                  onSubmitted: _handleSubmitted,
                  onChanged: (t) => _handleOnChanged(_tec.text),
                  decoration:
                      InputDecoration.collapsed(hintText: 'Send a message'),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _isComposing ? () => _handleSend(_tec.text) : null,
              ),
            ],
          )),
    );
  }

  void _handleSubmitted(String textMessage) {
    _tec.clear();
    setState(() {
      _isComposing = false;
    });

    ChatMessage msg = ChatMessage(
      text: textMessage,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 700)),
    );
    
    setState(() {
      _messages.insert(0, msg);
    });
    msg.animationController.forward();
  }

  void _handleOnChanged(String text) {
    setState(() {
      _isComposing = text.length > 0;
    });
  }

  void _handleSend(String text) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) => _messages[index],
              itemCount: _messages.length,
            ),
          ),
          Divider(
            height: 1.0,
          ),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: _buildTextComposer()),
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage msg in _messages) msg.animationController.dispose();
    super.dispose();
  }
}

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});
  final AnimationController animationController;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor:
          CurvedAnimation(parent: animationController, curve: Curves.easeOut),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: const EdgeInsets.only(right: 16.0),
                child: CircleAvatar(child: Text(_name[0]))),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      _name,
                      style: Theme.of(context).textTheme.subhead,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Text(text),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
