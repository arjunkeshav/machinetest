
import 'package:flutter/material.dart';
import 'package:machinetest/home/data/providers/text_provider.dart';
import 'package:provider/provider.dart';

import '../../data/providers/speak_to_text_provider.dart';
import '../../data/providers/text_to_speak_provider.dart';
import '../widgets/change_font_widget.dart';
import '../widgets/contrast_mode_widget.dart';
import '../widgets/stored_text_view_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static ValueNotifier<String> textNotifier = ValueNotifier("");
  static TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Machine Test'),
        actions: const [
          ContrastModeWidget(),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ChangeFontWidget(),
              const SizedBox(
                height: 100,
              ),
              Consumer<STTProvider>(
                builder: (BuildContext context, sttProvider, Widget? child) {
                  if (sttProvider.isListening) {
                    textEditingController.text = sttProvider.recognizedText;
                    textNotifier.value = sttProvider.recognizedText;
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Text to Speak:'),
                        buildTextField(context),
                        const SizedBox(
                          height: 10,
                        ),
                        Visibility(
                          visible: sttProvider.isListening,
                          child: const Align(alignment: Alignment.centerRight, child: Text("Listening....")),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        buildButtons(sttProvider),
                        const StoredTextViewWidget()
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  ValueListenableBuilder<String> buildButtons(STTProvider sttProvider) {
    return ValueListenableBuilder(
                        valueListenable: textNotifier,
                        builder: (BuildContext context, String textNotifier, Widget? child) {
                          return Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Provider.of<TTSProvider>(context, listen: false)
                                      .speak(textNotifier.isNotEmpty ? textNotifier : "Nothing to speak");
                                },
                                child: const Text('Speak'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (sttProvider.isListening) {
                                    Provider.of<STTProvider>(context, listen: false).stopListening();
                                  } else {
                                    Provider.of<STTProvider>(context, listen: false).startListening();
                                  }
                                },
                                child: Text(sttProvider.isListening ? 'Stop Listening' : 'Start Listening'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (textNotifier.isNotEmpty) {
                                    Provider.of<TextProvider>(context, listen: false).addText(textNotifier);
                                  }else{
                                    Provider.of<TTSProvider>(context, listen: false)
                                        .speak("Nothing to Save");
                                  }
                                },
                                child: const Text("Store Data"),
                              ),
                            ],
                          );
                        },
                      );
  }

  Row buildTextField(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textEditingController,
            onChanged: (text) {
              textNotifier.value = text;
              // Update text to speak
            },
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: textNotifier,
          builder: (BuildContext context, String value, Widget? child) {
            return Visibility(
              visible: value.isNotEmpty,
              child: SizedBox(
                height: 30,
                width: 30,
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    textEditingController.clear();
                    textNotifier.value = "";
                    Provider.of<STTProvider>(context, listen: false).clearText();
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }



}
