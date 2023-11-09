import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class STTProvider with ChangeNotifier {
  final SpeechToText speech = SpeechToText();
  String _recognizedText = '';
  bool _isListening = false;

  String get recognizedText => _recognizedText;

  bool get isListening => _isListening;

  STTProvider() {
    // Initialize the STT engine during class instantiation.
    initializeSTT();
  }

  Future<void> initializeSTT() async {
    bool available = await speech.initialize();
    debugPrint('Microphone available: $available');
    if (!available) {
      debugPrint("The user has denied the use of speech recognition.");
    }
  }

  void clearText() {
    _recognizedText = '';
    notifyListeners();
  }

  void startListening() async {
    if (speech.isAvailable) {
      await speech.listen(
        listenFor: const Duration(minutes: 10),
        onResult: (result) {
          debugPrint(result.recognizedWords);
          _recognizedText = result.recognizedWords;
          notifyListeners();
        },
      );
      _isListening = true;
      notifyListeners();
    } else {
      debugPrint("STT engine is not available");
    }
  }

  void stopListening() {
    if (speech.isListening) {
      speech.stop();
    }
    _isListening = false;
    notifyListeners();
  }
}
