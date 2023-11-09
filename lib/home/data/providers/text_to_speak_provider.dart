import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class TTSProvider with ChangeNotifier {
  final FlutterTts flutterTts = FlutterTts();

  Future<void> speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.speak(text);
  }
}
