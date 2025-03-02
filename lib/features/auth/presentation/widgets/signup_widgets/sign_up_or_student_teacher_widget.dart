import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/changTypSignUp/auth_type_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/by_clicking_sign_up_text.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/select_student_or_teacher_or_camp_widget.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_form_educational_and_camp_student.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/sign_up_form_teacher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class SignUpStudentOrTeacherWidget extends StatelessWidget {
  const SignUpStudentOrTeacherWidget({super.key});

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
                        BlocBuilder<AuthTypeCubit, AuthTypeState>(
                          builder: (context, state) {
                            if(state is StatusSignUpType){
                              if(state.type == 'teatcher') {
                                return const SignUpFormTeacher();
                              }else if(state.type=='student'){
                                return const SignUpFormEducationalAndCampStudent();

                              }else if(state.type=='camp'){
                                context.pop();
                                return const SizedBox.shrink();
                              }else{
                                return const SizedBox.shrink();
                              }
                            }else{
                              return const SizedBox.shrink();
                            }
                          },
                        ),
                        Column(
                          children: [
                            const ByClickingSignUpText(),
                            verticalSpace(20),
                            AppTextButton(
                              buttonText: AppLocalizations.of(context)!.signUp,
                              onPressed: () {
                                if(context.read<AuthTypeCubit>().typeSignUp=='student'){
                                  if(context.read<AuthCubit>().globalKeyStudentScreen.currentState!.validate()&&context.read<AuthCubit>().campStudentId!=null&&context.read<AuthCubit>().studentEducationStage!=null){
                                    context.read<AuthCubit>().emitRegisterUser(isStudent: true);
                                  }else{
                                    ToastNotificationMessage().showToastNotificationError(message: 'Please enter All required data', context: context);
                                  }
                                }else if(context.read<AuthTypeCubit>().typeSignUp=='teatcher'){
                                  if(context.read<AuthCubit>().globalKeyTeacherScreen.currentState!.validate()&&context.read<AuthCubit>().campTeacherId!=null){
                                    context.read<AuthCubit>().emitRegisterUser(isTeacher: true);
                                  }else{
                                    ToastNotificationMessage().showToastNotificationError(message: 'Please enter All required data', context: context);
                                  }
                                }
                              },
                            ),
                          ],
                        ),
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
