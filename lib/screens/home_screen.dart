import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_change_notifier_gen/change_notifiers/app_change_notifier.dart';
import 'package:flutter_change_notifier_gen/change_notifiers/text_field_change_notifier.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/theme_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TextFieldChangeNotifier, AppChangeNotifier>(
      builder: (context, textFieldChangeNotifier, appChangeNotifier, _) =>
          Scaffold(
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(8),
          color: Theme.of(context).primaryColor,
          child: TextButton.icon(
            label: Text(
              'Null Safety',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Switch(
              value: textFieldChangeNotifier.soundNullSafety,
              onChanged: (_value) {
                textFieldChangeNotifier.soundNullSafety = _value;
              },
            ),
            onPressed: null,
          ),
        ),
        appBar: AppBar(
          title: Text('Flutter Change Notifier Generator'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              appChangeNotifier.brightness =
                  appChangeNotifier.brightness == Brightness.light
                      ? Brightness.dark
                      : Brightness.light;
            },
            icon: Icon(appChangeNotifier.brightness == Brightness.light
                ? Icons.nightlight_round
                : Icons.wb_sunny),
            tooltip: appChangeNotifier.brightness == Brightness.light
                ? 'Switch to Dark Theme'
                : 'Switch to Light Theme',
          ),
          actions: [
            IconButton(
              tooltip: 'Start Fresh',
              icon: Icon(Icons.refresh),
              onPressed: () async {
                if (textFieldChangeNotifier.textFieldCustomWidgets.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Nothing to clear!'),
                    ),
                  );
                  return;
                }
                await showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    actionsPadding: EdgeInsets.all(16),
                    title: Text('Do you want to start fresh?'),
                    content:
                        Text('TextFields & Generated Code would be removed.'),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          textFieldChangeNotifier.clear();
                          Navigator.pop(context);
                        },
                        child: Text('Yes'),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('No'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
        floatingActionButton: textFieldChangeNotifier
                .textFieldCustomWidgets.isNotEmpty
            ? FloatingActionButton(
                onPressed: () async {
                  await Clipboard.setData(
                    ClipboardData(text: textFieldChangeNotifier.generatedCode),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Copied generated code to clipboard'),
                    ),
                  );
                },
                child: Icon(Icons.copy),
                tooltip: 'Copy generated code to clipboard',
              )
            : Container(),
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ...textFieldChangeNotifier.textFieldCustomWidgets.values
                            .map(
                              (e) => Column(
                                children: [
                                  e[0],
                                  SizedBox(
                                    height: 10,
                                  ),
                                  e[1],
                                  SizedBox(
                                    height: 10,
                                  ),
                                  e[2],
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: e[3],
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        SizedBox(
                          height: 50,
                        ),
                        FloatingActionButton(
                          tooltip: 'Add a new field',
                          onPressed: () {
                            final uniqueKey = UniqueKey();
                            textFieldChangeNotifier.addTextField(
                              uniqueKey,
                              [
                                TextFormField(
                                  onChanged: (_) {
                                    textFieldChangeNotifier.generator();
                                  },
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    hintText: 'DataType',
                                    labelText: 'DataType',
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (_) {
                                    textFieldChangeNotifier.generator();
                                  },
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    hintText: 'Variable Name',
                                    labelText: 'Variable Name',
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (_) {
                                    textFieldChangeNotifier.generator();
                                  },
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    hintText: 'Value',
                                    labelText: 'Value',
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    textFieldChangeNotifier
                                        .removeTextField(uniqueKey);
                                  },
                                  child: Icon(Icons.remove),
                                  tooltip: 'Remove this field',
                                ),
                              ],
                            );
                          },
                          child: Icon(Icons.add),
                        ),
                        SizedBox(
                          height: 50,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.all(16),
                  child: SingleChildScrollView(
                    child: HighlightView(
                      textFieldChangeNotifier.generatedCode,
                      padding: EdgeInsets.all(8),
                      language: 'dart',
                      theme: themeMap[
                          appChangeNotifier.brightness == Brightness.light
                              ? 'github'
                              : 'darcula'],
                      textStyle: TextStyle(
                          fontSize: 20,
                          height: 1.5,
                          fontFamily: GoogleFonts.robotoMono().fontFamily),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
