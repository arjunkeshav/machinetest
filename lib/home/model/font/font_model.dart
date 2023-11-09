import 'package:hive/hive.dart';

part 'font_model.g.dart';

@HiveType(typeId: 1)
class FontModel extends HiveObject {
  @HiveField(0)
  String selectedFont;

  FontModel(this.selectedFont);
}