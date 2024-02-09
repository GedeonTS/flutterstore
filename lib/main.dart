import 'package:flutter/material.dart';
import 'package:sendbird_sdk/sendbird_sdk.dart';
import 'dart:math';

class ChatInputField extends StatelessWidget {
  final Function onStartTyping;
  final Function onStopTyping;

  const ChatInputField({
    required this.onStartTyping,
    required this.onStopTyping,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      color: Colors.black,
      child: Stack(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Color(0x00F3F3F3), Color.fromARGB(0, 255, 69, 147)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.1097, 0.7357],
                  ),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      onStartTyping();
                    } else {
                      onStopTyping();
                    }
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(color: const Color.fromARGB(255, 255, 255, 255)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.pink,
              ),
              child: Center(
                child: Transform.rotate(
                  angle: -pi, 
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChatPage(),
    );
  }
}

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool _isTyping = false;

  // Simulate typing indicator
  void _startTyping() {
    setState(() {
      _isTyping = true;
    });
  }

  void _stopTyping() {
    setState(() {
      _isTyping = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sendbird Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.black,
              child: ListView(
                children: [
                  // Replace these with actual chat messages from Sendbird
                  ChatMessage(
                    message: 'Hello there!',
                    isSentMessage: false,
                  ),
                  ChatMessage(
                    message: 'Hi! How are you?',
                    isSentMessage: true,
                  ),
                ],
              ),
            ),
          ),
          // Typing indicator
          // _isTyping ? TypingIndicator() : SizedBox(),
          // Input text field for sending messages
          ChatInputField(
            onStartTyping: _startTyping,
            onStopTyping: _stopTyping,
          ),
        ],
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String message;
  final bool isSentMessage;

  const ChatMessage({
    required this.message,
    required this.isSentMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSentMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          gradient: isSentMessage
              ? LinearGradient(
            colors: [Color(0xFFFF006B), Color(0xFFFF4593)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            stops: [0.1097, 0.7357],
          )
              : null,
          color: isSentMessage ? null : Color(0xFF1A1A1A),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSentMessage ? Colors.white : Colors.white),
        ),
      ),
    );
  }
}
