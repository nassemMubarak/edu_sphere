import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_quiz_widget.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/add_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class StudentQuizWidget extends StatelessWidget {
  int idCourse;
  StudentQuizWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<StudentQuizCubit>().emitGetAllStudentQuiz(idCourse: idCourse);
    return BlocBuilder<StudentQuizCubit,StudentQuizState>(
        builder: (context, state) {
          if(state is GetAllStudentQuizLoadingState){
            return ShimmerLoadingQuizWidget();
          }
          if(state is GetAllStudentQuizLoadedState){
            if(state.listQuiz.isNotEmpty){
              return SectionCard(
                title: 'Quize',
                icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
                infoDialog:  AddQuizDialog(idCourse: idCourse,),
                widget: ListView.builder(
                  itemCount: state.listQuiz.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    onTap: (){
                      context.read<StudentQuizCubit>().quizSelected = state.listQuiz[index];
                      // context.read<QuizCubit>().emitSelectQuize(quiz: state.listQuiz[index],indexQuiz: index);
                      // context.read<QuizCubit>().indexQuizSelected = index;
                      // context.pushNamed(Routes.quizMainPage);
                      context.pushNamed(Routes.studentQuizMainPage);
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                    title: Text(state.listQuiz[index].title!,style: TextStyles.font14Black500Weight),
                  ),
                ),
              );
            }else{
             return  SectionCard(
               title: 'Quize',
               icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
               infoDialog:  AddQuizDialog(idCourse: idCourse,),
               widget: ImageAndTextEmptyData(
                  message: 'You have not added any quizzes yet.',
                ),
             );
            }
          }else{
            if(context.read<StudentQuizCubit>().listQuiz.isNotEmpty){
              return SectionCard(
                title: 'Quize',
                icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
                infoDialog:  AddQuizDialog(idCourse: idCourse,),
                widget: ListView.builder(
                  itemCount: context.read<StudentQuizCubit>().listQuiz.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    onTap: (){
                      context.read<StudentQuizCubit>().quizSelected = context.read<StudentQuizCubit>().listQuiz[index];

                      // context.read<QuizCubit>().emitSelectQuize(quiz: context.read<QuizCubit>().listQuize[index],indexQuiz: index);
                      // context.read<QuizCubit>().indexQuizSelected = index;
                      context.pushNamed(Routes.studentQuizMainPage);
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                    title: Text(context.read<StudentQuizCubit>().listQuiz[index].title!,style: TextStyles.font14Black500Weight),
                  ),
                ),
              );
            }else{
              return SectionCard(
                title: 'Quize',
                icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
                infoDialog:  AddQuizDialog(idCourse: idCourse,),
                widget: ImageAndTextEmptyData(
                  message: 'You have not added any quizzes yet.',
                ),
              );
            }
          }
        },
    );
  }
}
