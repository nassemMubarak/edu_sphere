import 'dart:convert';

import 'package:edu_sphere/features/student/student_quiz/data/model/question_student_quiz_model.dart';
import 'package:edu_sphere/features/student/student_quiz/domain/entities/question_student_quiz.dart';
import 'package:edu_sphere/features/teacher/quiz/data/models/quiz_model.dart';
import 'package:equatable/equatable.dart';

class ReviewQuiz extends Equatable{
  final int id;
  final int studentId;
  final int quizId;
  final List<QuestionData> data;
  final String createdAt;
  final String updatedAt;
  final QuizDetails quiz;

  ReviewQuiz({
    required this.id,
    required this.studentId,
    required this.quizId,
    required this.data,
    required this.createdAt,
    required this.updatedAt,
    required this.quiz,
  });

  @override
  List<Object?> get props => [
    id,
    studentId,
    quizId,
    data,
    createdAt,
    updatedAt,
    quiz
  ];


}
class QuestionData {
  final int questionId;
  final String title;
  final String type;
  final List<String> options;
  final String correctAnswer;
  final int mark;
  final String studentAnswer;
  final bool isCorrect;
  final List<Document> documents;

  QuestionData({
    required this.questionId,
    required this.title,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.mark,
    required this.studentAnswer,
    required this.isCorrect,
    required this.documents,
  });

  factory QuestionData.fromJson(Map<String, dynamic> json) {
    return QuestionData(
      questionId: json['question_id'],
      title: json['title'],
      type: json['type'],
      options: List<String>.from(jsonDecode(json['options'])),
      correctAnswer: json['correct_answer'],
      mark: json['mark'],
      studentAnswer: json['student_answer'],
      isCorrect: json['is_correct'],
      documents: (json['documents'] as List)
          .map((item) => Document.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question_id': questionId,
      'title': title,
      'type': type,
      'options': jsonEncode(options),
      'correct_answer': correctAnswer,
      'mark': mark,
      'student_answer': studentAnswer,
      'is_correct': isCorrect,
      'documents': documents.map((item) => item.toJson()).toList(),
    };
  }
}

class Document {
  final int id;
  final String documentableType;
  final int documentableId;
  final String? title;
  final String? description;
  final String type;
  final String createdAt;
  final String updatedAt;
  final String url;

  Document({
    required this.id,
    required this.documentableType,
    required this.documentableId,
    this.title,
    this.description,
    required this.type,
    required this.createdAt,
    required this.updatedAt,
    required this.url,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['id'],
      documentableType: json['documentable_type'],
      documentableId: json['documentable_id'],
      title: json['title'],
      description: json['description'],
      type: json['type'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentable_type': documentableType,
      'documentable_id': documentableId,
      'title': title,
      'description': description,
      'type': type,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'url': url,
    };
  }
}

class QuizDetails {
  final int id;
  final String title;
  final String description;
  final int courseId;
  final int degree;
  final int time;
  final int visibility;
  final String startIn;
  final String endIn;
  final String createdAt;
  final String updatedAt;
  final int resultVisible;
  final List<Question> questions;

  QuizDetails({
    required this.id,
    required this.title,
    required this.description,
    required this.courseId,
    required this.degree,
    required this.time,
    required this.visibility,
    required this.startIn,
    required this.endIn,
    required this.createdAt,
    required this.updatedAt,
    required this.resultVisible,
    required this.questions,
  });

  factory QuizDetails.fromJson(Map<String, dynamic> json) {
    return QuizDetails(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      courseId: json['course_id'],
      degree: json['degree'],
      time: json['time'],
      visibility: json['visibility'],
      startIn: json['start_in'],
      endIn: json['end_in'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      resultVisible: json['result_visible'],
      questions: (json['questions'] as List)
          .map((item) => Question.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'course_id': courseId,
      'degree': degree,
      'time': time,
      'visibility': visibility,
      'start_in': startIn,
      'end_in': endIn,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'result_visible': resultVisible,
      'questions': questions.map((item) => item.toJson()).toList(),
    };
  }
}

class Question {
  final int id;
  final int quizId;
  final String title;
  final String type;
  final List<String> options;
  final String correctAnswer;
  final int mark;
  final String createdAt;
  final String updatedAt;

  Question({
    required this.id,
    required this.quizId,
    required this.title,
    required this.type,
    required this.options,
    required this.correctAnswer,
    required this.mark,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      quizId: json['quiz_id'],
      title: json['title'],
      type: json['type'],
      options: List<String>.from(jsonDecode(json['options'])),
      correctAnswer: json['correct_answer'],
      mark: json['mark'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quiz_id': quizId,
      'title': title,
      'type': type,
      'options': jsonEncode(options),
      'correct_answer': correctAnswer,
      'mark': mark,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
