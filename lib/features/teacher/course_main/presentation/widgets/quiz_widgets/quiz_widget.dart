import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/shimmer_loading_quiz_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/widgets/quiz_widget/add_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class QuizeWidget extends StatelessWidget {
  int idCourse;
   QuizeWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<QuizCubit>().emitGetAllQuiz(idCourse: 17);
    return BlocBuilder<QuizCubit,QuizState>(
      buildWhen: (previous, current) => current is GetAllQuizLoadedState,
        builder: (context, state) {
          if(state is GetAllQuizLoadingState){
            return ShimmerLoadingQuizWidget();
          }
          if(state is GetAllQuizLoadedState){
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
                      context.read<QuizCubit>().emitSelectQuize(quiz: state.listQuiz[index],indexQuiz: index);
                      context.read<QuizCubit>().indexQuizSelected = index;
                      context.pushNamed(Routes.quizMainPage);
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                    title: Text(state.listQuiz[index].title,style: TextStyles.font14Black500Weight),
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
            if(context.read<QuizCubit>().listQuize.isNotEmpty){
              return SectionCard(
                title: 'Quize',
                icon: 'assets/svgs/quiz_on_computer_question_icon.svg',
                infoDialog:  AddQuizDialog(idCourse: idCourse,),
                widget: ListView.builder(
                  itemCount: context.read<QuizCubit>().listQuiz.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) => ListTile(
                    onTap: (){
                      context.read<QuizCubit>().emitSelectQuize(quiz: context.read<QuizCubit>().listQuize[index],indexQuiz: index);
                      context.read<QuizCubit>().indexQuizSelected = index;
                      context.pushNamed(Routes.quizMainPage);
                    },
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                    leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                    title: Text(context.read<QuizCubit>().listQuiz[index].quizTitle,style: TextStyles.font14Black500Weight),
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
