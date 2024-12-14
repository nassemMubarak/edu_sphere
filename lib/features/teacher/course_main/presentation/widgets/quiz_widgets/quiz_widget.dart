import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/add_quiz_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
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
      widget: BlocBuilder<CourseMainCubit,CourseMainState>(
        builder: (context, state) {
          if(state is GetAllQuiz){
            if(state.listQuiz.isNotEmpty){
              return ListView.builder(
                itemCount: state.listQuiz.length,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                  leading: SvgPicture.asset('assets/svgs/quiz_leading_icon.svg'),
                  title: Text(state.listQuiz[index].quizTitle,style: TextStyles.font14Black500Weight),
                ),
              );
            }else{
             return const ImageAndTextEmptyData(
                message: 'You have not added any quizzes yet.',
              );
            }
          }else{
            return const ImageAndTextEmptyData(
              message: 'You have not added any quizzes yet.',
            );
          }
        },
      )
    );
  }
}
