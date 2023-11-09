import 'package:hive/hive.dart';

part 'text_model.g.dart';

@HiveType(typeId: 3)
class TextModel extends HiveObject {
  @HiveField(0)
  List<String> dummyText;

  TextModel(this.dummyText);
}