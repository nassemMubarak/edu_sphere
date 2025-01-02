import 'package:edu_sphere/features/teacher/quiz/domain/entities/question1.dart';

class Quiz {
  String quizTitle;
  String description;
  int passingScore;
  int timeLift;
  DateTime startDateTime;
  DateTime endDateTime;
  bool isHideQuiz;
   List<Question1>? questions;

  Quiz({
    required this.quizTitle,
    required this.description,
    required this.passingScore,
    required this.timeLift,
    required this.startDateTime,
    required this.endDateTime,
    required this.isHideQuiz,
     this.questions,
  });
}
