import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/providers/high_contrast_provider.dart';

class ContrastModeWidget extends StatelessWidget {
  const ContrastModeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<HighContrastProvider>(
      builder: (BuildContext context, value, Widget? child) {
        return ElevatedButton(
          onPressed: () {
            Provider.of<HighContrastProvider>(context, listen: false).toggleHighContrastMode();
          },
          child: Text(value.modeName),
        );
      },
    );
  }
}
