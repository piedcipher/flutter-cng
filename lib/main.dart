import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_gen/providers/text_field_provider.dart';
import 'package:flutter_change_notifier_gen/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TextFieldProvider>(
          create: (context) => TextFieldProvider()..generator(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
