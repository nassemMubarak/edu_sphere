import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/signup/logic/sign_up_cubit.dart';
import 'package:edu_sphere/features/signup/logic/sign_up_state.dart';
import 'package:edu_sphere/features/signup/ui/widget/by_clicking_sign_up_text.dart';
import 'package:edu_sphere/features/signup/ui/widget/gender_widget.dart';
import 'package:edu_sphere/features/signup/ui/widget/selecte_student_or_teacher_or_camp_widget.dart';
import 'package:edu_sphere/features/signup/ui/widget/sign_up_form_educational_and_camp_student.dart';
import 'package:edu_sphere/features/signup/ui/widget/sign_up_form_student.dart';
import 'package:edu_sphere/features/signup/ui/widget/sign_up_form_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Container(
                margin: EdgeInsets.only(
                  top: 158.h,
                  bottom: 60.h,
                ), // margin to create space from the top
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(4),
                  boxShadow: [
                    BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 4,
                      color: ColorsManager.shadowColor.withOpacity(0.4),
                    ),
                  ],
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SelecteStudentOrTeacherOrCampWidget(),
                      verticalSpace(24),
                      Text(
                        'Welcome Back',
                        style: TextStyles.font18Black600Weight,
                      ),
                      verticalSpace(8),
                      Text(
                        'Create an account to continue',
                        style: TextStyles.font16NeutralGray400Weight,
                      ),
                      verticalSpace(26),
                      BlocBuilder<SignUpCubit, SignUpState>(
                        builder: (context, state) {
                          if (state is StatusSignUpTypeOnClicBotton) {
                            if (state.type == 'camp') {
                              return Column(
                                children: [
                                  SignUpFormStudent(labelCamp: true),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText: 'Sign up',
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              );
                            } else if (state.type == 'teatcher') {
                              return Column(
                                children: [
                                  const SignUpFormTeacher(),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText: 'Sign up',
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              );
                            } else if (state.type == 'student') {
                              return Column(
                                children: [
                                  const SignUpFormEducationalAndCampStudent(),
                                  verticalSpace(16),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText: 'Sign up',
                                    onPressed: () {

                                    },
                                  ),
                                ],
                              );
                            } else {
                              return Column(
                                children: [
                                  SignUpFormStudent(),
                                  const GenderWidget(),
                                  verticalSpace(16),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText: 'Continue',
                                    onPressed: () {
                                      if (context.read<SignUpCubit>().typeSignUp ==
                                          'camp') {
                                      } else {
                                        context
                                            .read<SignUpCubit>()
                                            .emitChangTypeOnClicBotton(
                                          context.read<SignUpCubit>().typeSignUp!,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          } else {
                            return Column(
                              children: [
                                SignUpFormStudent(),
                                const GenderWidget(),
                                verticalSpace(16),
                                const ByClickingSignUpText(),
                                verticalSpace(20),
                                AppTextButton(
                                  buttonText: 'Continue',
                                  onPressed: () {
                                    if (context.read<SignUpCubit>().typeSignUp ==
                                        'camp') {
                                    } else {
                                      context
                                          .read<SignUpCubit>()
                                          .emitChangTypeOnClicBotton(
                                        context.read<SignUpCubit>().typeSignUp!,
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                        },
                      ),

                      verticalSpace(40),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
