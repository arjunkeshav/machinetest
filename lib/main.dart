import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:machinetest/home/presentation/screen/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


import 'home/data/providers/font_provider.dart';
import 'home/data/providers/high_contrast_provider.dart';
import 'home/data/providers/speak_to_text_provider.dart';
import 'home/data/providers/text_provider.dart';
import 'home/data/providers/text_to_speak_provider.dart';
import 'home/model/contrast/contrast_model.dart';
import 'home/model/font/font_model.dart';
import 'home/model/text/text_model.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(FontModelAdapter()); // Register the adapter
  Hive.registerAdapter(TextModelAdapter()); // Register the adapter
  Hive.registerAdapter(ContrastModelAdapter()); // Register the adapter
  await Hive.openBox<TextModel>('text_Box');
  await Hive.openBox<FontModel>('font_box');
  await Hive.openBox<ContrastModel>('contrast_box');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TTSProvider()),
        ChangeNotifierProvider(create: (context) => STTProvider()),
        ChangeNotifierProvider(create: (context) => HighContrastProvider()),
        ChangeNotifierProvider(create: (context) => FontProvider()),
        ChangeNotifierProvider(create: (context) => TextProvider()),
      ],
      child: const MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    final highContrastMode = context.select((HighContrastProvider model) => model.highContrastMode);
    final textTheme = context.select((FontProvider fontProvider) => fontProvider.textTheme);

    final themeData = highContrastMode
        ? ThemeData(
      brightness: Brightness.dark,
      textTheme: textTheme.copyWith(
        bodySmall: const TextStyle(color: Colors.white),
        bodyLarge: const TextStyle(color: Colors.white),
        bodyMedium: const TextStyle(color: Colors.white),
      ),
    )
        : ThemeData(
      brightness: Brightness.light,
      textTheme: textTheme,
    );

    return MaterialApp(
      home: const HomeScreen(),
      theme: themeData,
    );
  }
}

