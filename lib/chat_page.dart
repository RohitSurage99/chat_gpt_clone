import 'package:flutter/material.dart';
import 'package:my_chat_app/constants/constants.dart';
import 'package:my_chat_app/screens/chat_screen.dart';


void main() {
  runApp(const FirePage());
}

class FirePage extends StatelessWidget {
  const FirePage({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: ThemeData(
          scaffoldBackgroundColor: scaffoldBackgroundColor,
        appBarTheme: AppBarTheme(color: cardColor,)
      ),
      home: const ChatScreen(),
    );
  }
}

class ChatApk extends StatefulWidget {
  const ChatApk({Key? key}) : super(key: key);

  @override
  State<ChatApk> createState() => _ChatApkState();
}

class _ChatApkState extends State<ChatApk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('I Am Chatting App')
        ),
      ),

      body: const Text(' '),



    );
  }
}
