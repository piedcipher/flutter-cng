import 'package:flutter/material.dart';
import 'package:flutter_change_notifier_gen/providers/text_field_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TextFieldProvider>(
      builder: (context, textFieldProvider, _) => Scaffold(
        appBar: AppBar(
          title: Text('Flutter Change Notifier Generator'),
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: () {
                textFieldProvider.clear();
              },
            ),
          ],
        ),
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
                        ...textFieldProvider.textFieldCustomWidgets.values
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
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: e[2],
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
                          onPressed: () {
                            final uniqueKey = UniqueKey();
                            textFieldProvider.addTextField(
                              uniqueKey,
                              [
                                TextFormField(
                                  onChanged: (_) {
                                    textFieldProvider.generator();
                                  },
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    hintText: 'Variable Name',
                                    labelText: 'Variable Name',
                                  ),
                                ),
                                TextFormField(
                                  onChanged: (_) {
                                    textFieldProvider.generator();
                                  },
                                  controller: TextEditingController(),
                                  decoration: InputDecoration(
                                    hintText: 'DataType',
                                    labelText: 'DataType',
                                  ),
                                ),
                                FloatingActionButton(
                                  onPressed: () {
                                    textFieldProvider
                                        .removeTextField(uniqueKey);
                                  },
                                  child: Icon(Icons.remove),
                                ),
                              ],
                            );
                          },
                          child: Icon(Icons.add),
                        ),
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
                    child: Text(
                      textFieldProvider.generatedCode,
                      style: TextStyle(
                        fontSize: 24,
                      ),
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
