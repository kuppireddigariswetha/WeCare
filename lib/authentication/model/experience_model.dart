import 'package:hive/hive.dart';
part 'experience_model.g.dart';
@HiveType(typeId: 1)
class Experience {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;
  @HiveField(2)
  final  Uint8List;
  @HiveField(3)
  final String user;
  Experience({
    required this.question,
    required this.answer,
    required this.Uint8List,
    required this.user,
  });
}