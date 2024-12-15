import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class QuizMainPage extends StatelessWidget {
  const QuizMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizCubit, QuizState>(
      builder: (context, state) {
        if(state is QuizSelected){
          return SliverWidget(
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
                  Row(
                    children: [
                      Text('Home',style: TextStyles.font12NeutralGray400Weight),
                      horizontalSpace(8),
                      Icon(Icons.arrow_forward_ios_sharp,color: ColorsManager.darkLightBlue,size: 15),
                      horizontalSpace(8),
                      Text('Data Science',style: TextStyles.font12NeutralGray400Weight),
                      horizontalSpace(8),
                      Icon(Icons.arrow_forward_ios_sharp,color: ColorsManager.darkLightBlue,size: 15),
                      horizontalSpace(8),
                      Text(state.quiz.quizTitle,style: TextStyles.font12Black500Weight),
                    ],
                  ),
                  verticalSpace(24),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 4,
                          color: ColorsManager.shadowColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(child: Text('Remaining to start Quiz',style: TextStyles.font10Red400Weight,)),
                        horizontalSpace(13), Expanded(
                          child: SlideCountdownSeparated(
                            style: TextStyles.font12White600Weight,
                            duration: const Duration(days: 5),
                            showZeroValue: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                  verticalSpace(24),
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 4,
                          color: ColorsManager.shadowColor.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          child: ListTile(
                            titleAlignment: ListTileTitleAlignment.center,
                            contentPadding: EdgeInsetsDirectional.zero,
                            leading:  SvgPicture.asset(
                              'assets/svgs/quiz_leading_icon.svg',
                              width: 24.w,
                              height: 24.h,
                              color: ColorsManager.mainBlue,
                            ),
                            title: Text(
                              state.quiz.quizTitle,
                              style: TextStyles.font16Black600Weight,
                            ),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  SvgPicture.asset('assets/svgs/edite_icon.svg',
                                    height: 24, width: 24,
                                    color: Colors.black,
                                  ),
                                  horizontalSpace(8),
                                  SvgPicture.asset('assets/svgs/delete_icon.svg',
                                    height: 24, width: 24,
                                  ),

                                  horizontalSpace(8),
                                  Icon(Icons.visibility_outlined,color: Colors.black,)

                                ],
                              ),
                            )
                            ,
                          ),

                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }else{
          return SizedBox.shrink();
        }
      },
    );
  }
}
