import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/estimate_widget/show_review_quiz_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowReviewQuizPage extends StatelessWidget {
  const ShowReviewQuizPage({super.key});

  @override
  Widget build(BuildContext context) {
    var coursesModel = context.read<CourseMainCubit>().coursesModel;
    var quiz = context.read<QuizCubit>().quize;
    return Scaffold(
      body: SliverWidget(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        widget: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              BreadCrumbWidget(
                items: [
                  'Home',
                  coursesModel.title,
                  quiz!.title!,
                  'Estimate',
                  'Nassem Ah Mubarak'
                ],
              ),
              verticalSpace(24),
              ShowReviewQuizWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
