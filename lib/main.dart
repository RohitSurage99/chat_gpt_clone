import 'package:flutter/material.dart';
import 'package:my_chat_app/chat_page.dart';
import 'package:my_chat_app/providers/models_provider.dart';
import 'package:provider/provider.dart';

import 'constants/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
       ChangeNotifierProvider(create: (_)=> ModelsProvider(),
       ),
     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          scaffoldBackgroundColor:  scaffoldBackgroundColor,
          //  primarySwatch: Colors.cyan,
        ),
        home: const FirePage(),
      ),
    );
  }
}
