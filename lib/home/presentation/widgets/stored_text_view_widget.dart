import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/text_provider.dart';
import '../../data/providers/text_to_speak_provider.dart';

class StoredTextViewWidget extends StatelessWidget {
  const StoredTextViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TextProvider>(
      builder: (BuildContext context, list, Widget? child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: list.textList.isNotEmpty,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    "Stored Texts",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: ()=> Provider.of<TextProvider>(context, listen: false).clearList(),
                    child: const SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Clear List",
                          style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 500,
              child: ListView(
                children: List.generate(list.textList.length, (index) => InkWell(
                  onTap: ()=>Provider.of<TTSProvider>(context, listen: false)
                      .speak(list.textList[index]),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(list.textList[index]),
                  ),
                )),
              ),
            ),
          ],
        );
      },
    );
  }
}
