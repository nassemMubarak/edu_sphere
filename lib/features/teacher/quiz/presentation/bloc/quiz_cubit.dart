import 'package:bloc/bloc.dart';
import 'package:edu_sphere/features/teacher/quiz/domain/entities/quiz.dart';
import 'package:meta/meta.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  late Quiz quiz;
  emitSelectQuiz({required Quiz quiz}){
    emit(QuizSelected(quiz: quiz));
  }
}
