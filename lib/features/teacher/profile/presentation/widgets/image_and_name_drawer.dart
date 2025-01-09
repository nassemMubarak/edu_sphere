import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ImageAndNameDrawer extends StatelessWidget {
  ImageAndNameDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is AuthLoadingState) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is AuthLoadedState) {
          return Container(
            padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 48.h, bottom: 8.h),
            height: 132.w,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.mainBlue,
            ),
            child: SingleChildScrollView( // Wrap with SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/images/nassem_image.jpg', fit: BoxFit.cover),
                      ),
                      horizontalSpace(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome to our application', style: TextStyles.font12White400Weight),
                          verticalSpace(4),
                          Text(state.user.name, style: TextStyles.font14White500Weight),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  Text('Last auth 30 seconds ago', style: TextStyles.font10White400Weight),
                ],
              ),
            ),
          );
        } else {
          return Container(
            padding: EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 48.h, bottom: 8.h),
            height: 132.w,
            width: double.infinity,
            decoration: BoxDecoration(
              color: ColorsManager.mainBlue,
            ),
            child: SingleChildScrollView( // Wrap with SingleChildScrollView
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.r),
                          color: Colors.white,
                        ),
                        child: Image.asset('assets/images/nassem_image.jpg', fit: BoxFit.cover),
                      ),
                      horizontalSpace(8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Welcome to our application', style: TextStyles.font12White400Weight),
                          verticalSpace(4),
                          Text('User not loaded', style: TextStyles.font14White500Weight),
                        ],
                      ),
                    ],
                  ),
                  verticalSpace(8),
                  Text('Last auth 30 seconds ago', style: TextStyles.font10White400Weight),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
