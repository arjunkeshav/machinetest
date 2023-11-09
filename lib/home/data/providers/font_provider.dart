import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import '../../model/font/font_model.dart';

class FontProvider extends ChangeNotifier {
  String _selectedFont = "Lato"; // Default font

  String get selectedFont => _selectedFont;

  FontProvider() {
    _loadSelectedFont();
  }

  void _loadSelectedFont() async {
    final box = await Hive.openBox<FontModel>('font_box');
    final fontModel = box.isNotEmpty ? box.getAt(0) : null;

    if (fontModel != null) {
      _selectedFont = fontModel.selectedFont;
    } else {
      debugPrint("font_box model is null");
    }
  }

  void changeFont(String font) async {
    _selectedFont = font;
    notifyListeners();

    final box = await Hive.openBox<FontModel>('font_box');
    final fontModel = box.isNotEmpty ? box.getAt(0) : null;

    if (fontModel != null) {
      fontModel.selectedFont = font;
      fontModel.save();
    } else {
      box.add(FontModel(font));
    }
  }

  TextTheme get textTheme => GoogleFonts.getTextTheme(_selectedFont);
}
