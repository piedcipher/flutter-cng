import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_gen/providers/app_provider.dart';
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
        ChangeNotifierProvider<AppProvider>(
          create: (context) => AppProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, appProvider, _) => MaterialApp(
        theme: ThemeData(
          brightness: appProvider.brightness,
          primaryColor: Colors.indigo,
          primaryColorDark: Colors.indigo[800],
          accentColor: appProvider.brightness == Brightness.dark
              ? Colors.yellowAccent
              : Colors.pinkAccent,
        ),
        home: HomePage(),
      ),
    );
  }
}
