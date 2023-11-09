import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/font_provider.dart';

class ChangeFontWidget extends StatelessWidget {
  const ChangeFontWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Text('font selected:'),
        Consumer<FontProvider>(
          builder: (BuildContext context, fontProvider, Widget? child) {
            return DropdownButton<String>(
              value: fontProvider.selectedFont,
              items: <String>['Lato', 'Roboto', 'Open Sans'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      value,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,

                    ),
                  ),
                );
              }).toList(),
              onChanged: (newFont) {
                Provider.of<FontProvider>(context, listen: false).changeFont(newFont!);
              },
            );
          },
        )
      ],
    );
  }
}
