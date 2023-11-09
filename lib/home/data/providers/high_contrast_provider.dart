import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../model/contrast/contrast_model.dart';

class HighContrastProvider with ChangeNotifier {
  bool _highContrastMode = false;
  String _modeName = "Contrast Off";

  HighContrastProvider() {
    _loadContrastData();
  }

  void _loadContrastData() async {
    final box = await Hive.openBox<ContrastModel>('contrast_box');
    final contrastModel = box.isNotEmpty ? box.getAt(0) : null;

    if (contrastModel != null) {
      _highContrastMode = contrastModel.contrastMode;
      updateModeName();
    } else {
      debugPrint("contrast_box model is null");
    }
  }

  void updateModeName() {
    _modeName = _highContrastMode ? "Contrast ON" : "Contrast Off";
  }

  bool get highContrastMode => _highContrastMode;

  String get modeName => _modeName;

  void toggleHighContrastMode() async {
    _highContrastMode = !_highContrastMode;
    updateModeName();
    notifyListeners();

    final box = await Hive.openBox<ContrastModel>('contrast_box');
    final contrastModel = box.isNotEmpty ? box.getAt(0) : null;

    if (contrastModel != null) {
      contrastModel.contrastMode = _highContrastMode;
      contrastModel.save();
    } else {
      final contrastModel = ContrastModel(_highContrastMode);
      box.add(contrastModel);
    }
  }
}
