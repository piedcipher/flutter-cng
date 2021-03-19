import 'package:flutter/material.dart';

class TextFieldProvider with ChangeNotifier {
  Map<UniqueKey, List<Widget>> _textFieldCustomWidgets = {};
  String _generatedCode = '';

  Map<UniqueKey, List<Widget>> get textFieldCustomWidgets => _textFieldCustomWidgets;

  String get generatedCode => _generatedCode;

  void addTextField(UniqueKey uniqueKey, List<Widget> widgets) {
    _textFieldCustomWidgets[uniqueKey] = widgets;
    generator();
  }

  void removeTextField(UniqueKey uniqueKey) {
    if (_textFieldCustomWidgets.length == 1) {
      clear();
    } else {
      _textFieldCustomWidgets.remove(uniqueKey);
      generator();
    }
  }

  void generator() {
    if (_textFieldCustomWidgets.isEmpty) {
      _generatedCode = '''
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {

}''';
      notifyListeners();
      return;
    }

    int count = 0;
    _generatedCode = '''
import 'package:flutter/material.dart';

class MyProvider extends ChangeNotifier {
''';

    _textFieldCustomWidgets.values.forEach((e) {
      count++;
      var variableName = (e[0] as TextFormField).controller.text;
      variableName = variableName.isEmpty ? 'v$count' : variableName;
      var dataType = (e[1] as TextFormField).controller.text;
      dataType = dataType.isEmpty ? 'dynamic' : dataType;

      _generatedCode += '''
    $dataType _$variableName;

    $dataType get $variableName => _$variableName;

    set $variableName($dataType $variableName) {
        _$variableName = $variableName;
        notifyListeners();
    }
${count == _textFieldCustomWidgets.length ? '' : '\n'}''';
    });

    _generatedCode += '}';
    notifyListeners();
  }

  // calls when appBar refresh action is click to start fresh
  void clear() {
    if (_textFieldCustomWidgets.isNotEmpty) {
      _textFieldCustomWidgets = {};
      _generatedCode = '';
      generator();
    }
  }
}
