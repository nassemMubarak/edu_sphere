import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/add_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class QuizeWidget extends StatelessWidget {
  const QuizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Quize',
      icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
      infoDialog: const AddQuizDialog(),
      widget: BlocBuilder<QuizCubit,QuizState>(
        builder: (context, state) {
          if(state is GetAllQuiz){
            if(state.listQuiz.isNotEmpty){
              return ListView.builder(
                itemCount: state.listQuiz.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<QuizCubit>().emitSelectQuiz(quiz: state.listQuiz[index],indexQuiz: index);
                    context.read<QuizCubit>().indexQuizSelected = index;
                    context.pushNamed(Routes.quizMainPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                  title: Text(state.listQuiz[index].quizTitle,style: TextStyles.font14Black500Weight),
                ),
              );
            }else{
             return  ImageAndTextEmptyData(
                message: 'You have not added any quizzes yet.',
              );
            }
          }else{
            if(context.read<QuizCubit>().listQuiz.isNotEmpty){
              return ListView.builder(
                itemCount: context.read<QuizCubit>().listQuiz.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  onTap: (){
                    context.read<QuizCubit>().emitSelectQuiz(quiz: context.read<QuizCubit>().listQuiz[index],indexQuiz: index);
                    context.read<QuizCubit>().indexQuizSelected = index;
                    context.pushNamed(Routes.quizMainPage);
                  },
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                  title: Text(context.read<QuizCubit>().listQuiz[index].quizTitle,style: TextStyles.font14Black500Weight),
                ),
              );
            }else{
              return  ImageAndTextEmptyData(
                message: 'You have not added any quizzes yet.',
              );
            }
          }
        },
      )
    );
  }
}
