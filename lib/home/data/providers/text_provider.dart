import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/text/text_model.dart';

class TextProvider extends ChangeNotifier {
  TextProvider() {
    _loadStoredText();
  }

  void _loadStoredText() async {
    final box = await Hive.openBox<TextModel>('text_Box');
    if (box.isNotEmpty) {
      final textModel = box.getAt(0);
      if (textModel != null) {
        _textList = textModel.dummyText;
      } else {
        debugPrint("text_box model is null");
      }
    } else {
      debugPrint("text_box empty");
    }
  }

  List<String> _textList = List.empty(growable: true);

  List<String> get textList => _textList;

  void addText(String text) async {
    if (_textList.contains(text)) {
      debugPrint("duplicate Entry");
    } else {
      _textList.add(text);
      notifyListeners();
      final box = await Hive.openBox<TextModel>('text_box');
      if (box.isNotEmpty) {
        final textModel = box.getAt(0);
        if (textModel != null) {
          textModel.dummyText.add(text);
          textModel.save();
        }
      } else {
        final textModel = TextModel([text]);
        box.add(textModel);
      }
    }
  }

  void clearList() async {
    _textList = List.empty(growable: true);
    notifyListeners();
    final box = await Hive.openBox<TextModel>('text_box');
    if (box.isNotEmpty) {
      final textModel = box.getAt(0);
      textModel?.dummyText.clear();
      textModel?.save();
    }
  }
}
