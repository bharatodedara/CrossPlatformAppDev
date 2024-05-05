// main.dart

import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'login_screen.dart';

void main() async {
  await Parse().initialize(
    'oCpQCTQPf4DYBn8LJud0tg36mu89GPKqwM0Cs0Fo',
    'https://parseapi.back4app.com/',
    clientKey: 'FGwF4sMVSTNAj6kJTc2wZNtRnAMuEnCbvkdZQOP0',
    autoSendSessionId: true,
    debug: true,
  );
  print('done');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickTask',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(), // Set initial screen to LoginScreen
    );
  }
}
