import 'package:edu_sphere/features/teacher/quiz/domain/entities/question1.dart';

class Assessment {
  String title;
  String description;
  int passingScore;
  DateTime startDateTime;
  DateTime endDateTime;
  bool isHideAssessment;
  List<AssessmentFile>? listFilesUrl;

  Assessment({
    required this.title,
    required this.description,
    required this.passingScore,
    required this.startDateTime,
    required this.endDateTime,
    required this.isHideAssessment,
     this.listFilesUrl,
  });
}
class AssessmentFile{
  String title;
  String path;
  AssessmentFile({
    required this.title,
    required this.path,
  });
}
