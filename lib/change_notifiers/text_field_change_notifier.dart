import 'package:flutter/material.dart';

class TextFieldChangeNotifier with ChangeNotifier {
  Map<UniqueKey, List<Widget>> _textFieldCustomWidgets = {};
  String _generatedCode = '';
  bool _soundNullSafety = false;
  String _generatedCodeClassName = 'MyChangeNotifier';

  Map<UniqueKey, List<Widget>> get textFieldCustomWidgets =>
      _textFieldCustomWidgets;

  String get generatedCode => _generatedCode;

  bool get soundNullSafety => _soundNullSafety;

  String get generatedCodeClassName => _generatedCodeClassName;

  set generatedCodeClassName(String generatedCodeClassName) {
    _generatedCodeClassName = generatedCodeClassName;
    generator();
  }

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

class $_generatedCodeClassName extends ChangeNotifier {

}''';
      notifyListeners();
      return;
    }

    int count = 0;
    _generatedCode = '''
import 'package:flutter/material.dart';

class $_generatedCodeClassName extends ChangeNotifier {
''';

    _textFieldCustomWidgets.values.forEach((e) {
      count++;
      var variableName = (e[1] as TextFormField).controller!.text.trim();
      variableName = variableName.isEmpty ? 'v$count' : variableName;
      var dataType = (e[0] as TextFormField).controller!.text.trim();
      dataType = dataType.isEmpty
          ? 'dynamic'
          : soundNullSafety
              ? '$dataType?'
              : dataType;
      var value = (e[2] as TextFormField).controller!.text.trim();
      value = value.isNotEmpty ? ' = $value' : '';
      _generatedCode += '''
    $dataType _$variableName$value;

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

  set soundNullSafety(bool soundNullSafety) {
    _soundNullSafety = soundNullSafety;
    generator();
  }
}
