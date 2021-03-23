import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_gen/change_notifiers/app_change_notifier.dart';
import 'package:flutter_change_notifier_gen/change_notifiers/text_field_change_notifier.dart';
import 'package:flutter_change_notifier_gen/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    kIsWeb
        ? MultiProvider(
            providers: [
              ChangeNotifierProvider<TextFieldChangeNotifier>(
                create: (context) => TextFieldChangeNotifier()..generator(),
              ),
              ChangeNotifierProvider<AppChangeNotifier>(
                create: (context) => AppChangeNotifier(),
              ),
            ],
            child: MyApp(),
          )
        : MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Unsupported Platform'),
              ),
            ),
          ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppChangeNotifier>(
      builder: (context, appChangeNotifier, _) => MaterialApp(
        theme: ThemeData(
          brightness: appChangeNotifier.brightness,
          primaryColor: Colors.indigo,
          primaryColorDark: Colors.indigo[800],
          accentColor: appChangeNotifier.brightness == Brightness.dark
              ? Colors.yellowAccent
              : Colors.pinkAccent,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
