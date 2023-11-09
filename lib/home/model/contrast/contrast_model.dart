import 'package:hive/hive.dart';

part 'contrast_model.g.dart';

@HiveType(typeId: 4)
class ContrastModel extends HiveObject {
  @HiveField(0)
  bool contrastMode;

  ContrastModel(this.contrastMode);
}