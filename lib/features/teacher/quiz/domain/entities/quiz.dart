class Quiz {
  String quizTitle;
  String description;
  int passingScore;
  int timeLift;
  DateTime startDateTime;
  DateTime endDateTime;

  Quiz({
    required this.quizTitle,
    required this.description,
    required this.passingScore,
    required this.timeLift,
    required this.startDateTime,
    required this.endDateTime,
  });
}
