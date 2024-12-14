import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/routes.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/snackbar_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/changTypSignUp/auth_type_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/by_clicking_sign_up_text.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/gender_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/select_student_or_teacher_or_camp_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_form_educational_and_camp_student.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_form_student.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_form_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SelectStudentOrTeacherOrCampWidget(),
                    verticalSpace(24),
                    Text(
                      AppLocalizations.of(context)!.welcomeBackMessage,
                      style: TextStyles.font18Black600Weight,
                    ),
                    verticalSpace(8),
                    Text(
                      AppLocalizations.of(context)!.createAccount,
                      style: TextStyles.font16NeutralGray400Weight,
                    ),
                    verticalSpace(26),
                    Column(
                      children: [
                        SignUpFormStudent(),
                        BlocBuilder<AuthTypeCubit,AuthTypeState>(builder: (context, state){
                          print(state is StatusSignUpType);
                          if(state is StatusSignUpType){
                            print('---------------------------${state.type}');
                            if(state.type=='camp'){
                              return Column(
                                children: [
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText:
                                    AppLocalizations.of(context)!.signUp,
                                    onPressed: () {
                                      if (context
                                          .read<AuthCubit>()
                                          .globalKeyRegisterScreen
                                          .currentState!
                                          .validate()) {
                                        context
                                            .read<AuthTypeCubit>()
                                            .emitChangTypeOnClickButton(
                                          context.read<AuthTypeCubit>().typeSignUp!,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              );
                            }else if(state.type=='teacher'){
                              return Column(
                                children: [
                                  const GenderWidget(),
                                  verticalSpace(16),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText:
                                    AppLocalizations.of(context)!.continueText,
                                    onPressed: () {
                                      context.pushNamed(Routes.signUpStudentOrTeacherPage);
                                      if (context
                                          .read<AuthCubit>()
                                          .globalKeyRegisterScreen
                                          .currentState!
                                          .validate()&&AppRegex.isPasswordValid(context.read<AuthCubit>().passwordRegisterController.text)) {

                                        context.pushNamed(Routes.signUpStudentOrTeacherPage);
                                        // context
                                        //     .read<AuthTypeCubit>()
                                        //     .emitChangTypeOnClickButton(
                                        //   context.read<AuthTypeCubit>().typeSignUp!,
                                        // );
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                            else{
                              return Column(
                                children: [
                                  const GenderWidget(),
                                  verticalSpace(16),
                                  const ByClickingSignUpText(),
                                  verticalSpace(20),
                                  AppTextButton(
                                    buttonText:
                                    AppLocalizations.of(context)!.continueText,
                                    onPressed: () {
                                      if (context
                                          .read<AuthCubit>()
                                          .globalKeyRegisterScreen
                                          .currentState!
                                          .validate()&&AppRegex.isPasswordValid(context.read<AuthCubit>().passwordRegisterController.text)) {
                                        // context
                                        //     .read<AuthTypeCubit>()
                                        //     .emitChangTypeOnClickButton(
                                        //   context.read<AuthTypeCubit>().typeSignUp!,
                                        // );
                                        context.pushNamed(Routes.signUpStudentOrTeacherPage);

                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          }else{
                            return Column(
                              children: [
                                const GenderWidget(),
                                verticalSpace(16),
                                const ByClickingSignUpText(),
                                verticalSpace(20),
                                AppTextButton(
                                  buttonText:
                                  AppLocalizations.of(context)!.continueText,
                                  onPressed: () {
                                    if (context
                                        .read<AuthCubit>()
                                        .globalKeyRegisterScreen
                                        .currentState!
                                        .validate()&&AppRegex.isPasswordValid(context.read<AuthCubit>().passwordRegisterController.text)) {
                                      // context
                                      //     .read<AuthTypeCubit>()
                                      //     .emitChangTypeOnClickButton(
                                      //   context.read<AuthTypeCubit>().typeSignUp!,
                                      // );
                                      context.pushNamed(Routes.signUpStudentOrTeacherPage);

                                    }
                                  },
                                ),
                              ],
                            );
                          }
                        }),

                      ],
                    ),
                    // BlocBuilder<AuthTypeCubit, AuthTypeState>(
                    //   builder: (context, state) {
                    //     if (state is StatusSignUpTypeOnClickButton) {
                    //       if (state.type == 'camp') {
                    //         return Column(
                    //           children: [
                    //             SignUpFormStudent(labelCamp: true),
                    //             const ByClickingSignUpText(),
                    //             verticalSpace(20),
                    //             AppTextButton(
                    //               buttonText: AppLocalizations.of(context)!.signUp,
                    //               onPressed: () {
                    //
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       } else if (state.type == 'teatcher') {
                    //         return Column(
                    //           children: [
                    //             const SignUpFormTeacher(),
                    //             const ByClickingSignUpText(),
                    //             verticalSpace(20),
                    //             AppTextButton(
                    //               buttonText: AppLocalizations.of(context)!.signUp,
                    //               onPressed: () {
                    //
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       } else if (state.type == 'student') {
                    //         return Column(
                    //           children: [
                    //             const SignUpFormEducationalAndCampStudent(),
                    //             verticalSpace(16),
                    //             const ByClickingSignUpText(),
                    //             verticalSpace(20),
                    //             AppTextButton(
                    //                 buttonText: AppLocalizations.of(context)!.signUp,
                    //                 onPressed: (){
                    //                   if(context.read<AuthCubit>().globalKeyStudentScreen.currentState!.validate()&&context.read<AuthCubit>().universityMajor!=null&&context.read<AuthCubit>().campName!=null){
                    //                     context.read<AuthCubit>().emitRegisterUser();
                    //                   }else{
                    //                     SnackBarMessage()
                    //                         .showSnackBarError(message: 'Please enter All required data', context: context);
                    //
                    //                   }
                    //                 }
                    //             ),
                    //           ],
                    //         );
                    //       } else {
                    //         return Column(
                    //           children: [
                    //             SignUpFormStudent(),
                    //             const GenderWidget(),
                    //             verticalSpace(16),
                    //             const ByClickingSignUpText(),
                    //             verticalSpace(20),
                    //             AppTextButton(
                    //               buttonText: AppLocalizations.of(context)!.continueText,
                    //               onPressed: () {
                    //
                    //                 if (context.read<AuthTypeCubit>().typeSignUp ==
                    //                     'camp') {
                    //                 } else {
                    //                   if(context.read<AuthCubit>().globalKeyRegisterScreen.currentState!.validate()){
                    //                     context
                    //                         .read<AuthTypeCubit>()
                    //                         .emitChangTypeOnClickButton(
                    //                       context.read<AuthTypeCubit>().typeSignUp!,
                    //                     );
                    //                   }
                    //                 }
                    //               },
                    //             ),
                    //           ],
                    //         );
                    //       }
                    //     } else {
                    //       return Column(
                    //         children: [
                    //           SignUpFormStudent(),
                    //           const GenderWidget(),
                    //           verticalSpace(16),
                    //           const ByClickingSignUpText(),
                    //           verticalSpace(20),
                    //           AppTextButton(
                    //             buttonText: AppLocalizations.of(context)!.continueText,
                    //             onPressed: () {
                    //               context
                    //                   .read<AuthTypeCubit>()
                    //                   .emitChangTypeOnClickButton(
                    //                 context.read<AuthTypeCubit>().typeSignUp!,
                    //               );
                    //               if (context.read<AuthTypeCubit>().typeSignUp ==
                    //                   'camp') {
                    //               } else {
                    //                 if(context.read<AuthCubit>().globalKeyRegisterScreen.currentState!.validate()){
                    //                   context
                    //                       .read<AuthTypeCubit>()
                    //                       .emitChangTypeOnClickButton(
                    //                     context.read<AuthTypeCubit>().typeSignUp!,
                    //                   );
                    //                 }
                    //               }
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     }
                    //   },
                    // ),
                    verticalSpace(40),
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
