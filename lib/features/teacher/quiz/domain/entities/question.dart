class Question {
  final String questionText;
  final String? questionPathImage; // Can be text (String) or image path (String/File)
  final List<String> options; // Options can be text or image paths
  final String correctAnswer;
  final String questionScore;

  Question({
    required this.questionText,
    this.questionPathImage,
    this.options = const [],
    required this.correctAnswer,
    required this.questionScore,
  });
}