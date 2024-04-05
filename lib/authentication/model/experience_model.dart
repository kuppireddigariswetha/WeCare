import 'package:hive/hive.dart';
part 'experience_model.g.dart';
@HiveType(typeId: 1)
class Experience {
  @HiveField(0)
  final String question;
  @HiveField(1)
  final String answer;
  Experience({
    required this.question,
    required this.answer,
  });
}