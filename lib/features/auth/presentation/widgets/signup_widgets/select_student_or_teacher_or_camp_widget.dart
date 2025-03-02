import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/changTypSignUp/auth_type_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
class SelectStudentOrTeacherOrCampWidget extends StatelessWidget {
  const SelectStudentOrTeacherOrCampWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthTypeCubit, AuthTypeState>(builder: (context, state) {
      if (state is StatusSignUpType) {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<AuthTypeCubit>().emitChangTypeOnClickButton('camp');
                context.read<AuthTypeCubit>().emitChangTypSignUp('camp');

              },
              child: Text(
                AppLocalizations.of(context)!.camp,
                style: state.type == 'camp'
                    ? TextStyles.font16SkyBlue600Weight.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.skyBlue,
                      )
                    : TextStyles.font16Black600Weight
                        .copyWith(decoration: TextDecoration.underline),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorsManager.secondaryColor,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        context
                            .read<AuthTypeCubit>()
                            .emitChangTypSignUp('student');
                        context.read<AuthCubit>().campTeacherId=null;
                      },
                      child: containerRadiusWidget(
                          isSelected: state.type == 'student',
                          text: AppLocalizations.of(context)!.student),),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AuthTypeCubit>()
                          .emitChangTypSignUp('teatcher');
                      context.read<AuthCubit>().campStudentId=null;
                      context.read<AuthCubit>().studentEducationStage=null;
                    },
                    child: containerRadiusWidget(
                        isSelected: state.type == 'teatcher', text: AppLocalizations.of(context)!.teacher),
                  ),
                ],
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            GestureDetector(
              onTap: () {
                context.read<AuthTypeCubit>().emitChangTypeOnClickButton('camp');
              },
              child: Text(
                AppLocalizations.of(context)!.camp,
                style: context.read<AuthTypeCubit>().typeSignUp == 'camp'
                    ? TextStyles.font16SkyBlue600Weight.copyWith(
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.skyBlue,
                      )
                    : TextStyles.font16Black600Weight
                        .copyWith(decoration: TextDecoration.underline),
              ),
            ),
            const Spacer(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: ColorsManager.secondaryColor,
                borderRadius: BorderRadius.circular(50.r),
              ),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: () {
                        context
                            .read<AuthTypeCubit>()
                            .emitChangTypSignUp('student');
                      },
                      child: containerRadiusWidget(
                          isSelected: context.read<AuthTypeCubit>().typeSignUp ==
                              'student',
                          text: AppLocalizations.of(context)!.student,),),
                  GestureDetector(
                    onTap: () {
                      context
                          .read<AuthTypeCubit>()
                          .emitChangTypSignUp('teatcher');
                    },
                    child: containerRadiusWidget(
                        isSelected: context.read<AuthTypeCubit>().typeSignUp ==
                            'teatcher',
                        text: AppLocalizations.of(context)!.teacher,),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    });
  }

  Container containerRadiusWidget({required isSelected, required String text}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: isSelected
          ? BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.r),
            )
          : null,
      child: Text(
        text,
        style: isSelected
            ? TextStyles.font14SecondaryBlue600Weight
            : TextStyles.font14White600Weight,
      ),
    );
  }
}
