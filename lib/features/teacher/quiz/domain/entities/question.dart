import 'package:edu_sphere/features/teacher/quiz/data/models/document_question_model.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/document_question.dart';
import 'package:equatable/equatable.dart';

class Question extends Equatable{
   int id;
   int quizId;
   String title;
   String type;
   List<String> options;
   String correctAnswer;
   int mark;
   DateTime? createdAt; // Nullable
   DateTime? updatedAt; // Nullable
   List<DocumentQuestionModel>? documents; // Nullable, list of related documents

  Question({
    required this.id,
    required this.quizId,
    required this.title,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.mark,
    this.createdAt,
    this.updatedAt,
    this.documents,
  });

  @override
  List<Object?> get props => [
    id,
    quizId,
    title,
    type,
    options,
    correctAnswer,
    mark,
    documents
  ];

}