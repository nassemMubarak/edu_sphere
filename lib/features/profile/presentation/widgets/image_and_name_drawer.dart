import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
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
      builder: (context, authState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            String name = 'User not loaded';
            String lastAuth = 'Last auth 30 seconds ago';
            String imagePath = 'assets/images/nassem_image.jpg';

            // Check AuthCubit state
            if (authState is AuthLoadedState) {
              name = authState.user.name;
              lastAuth = 'Last auth 30 seconds ago'; // Adjust this with the actual auth time
            }

            // Check ProfileCubit state
            if (profileState is GetInfoUserLoadedDataState) {
              name = profileState.user.name;
            }

            return Container(
              padding: EdgeInsetsDirectional.only(
                  start: 16.w, end: 16.w, top: 48.h, bottom: 8.h),
              height: 132.w,
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorsManager.mainBlue,
              ),
              child: SingleChildScrollView(
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
                          child: Icon(Icons.person, size: 50.w, color: Colors.grey),
                          // child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                        horizontalSpace(8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Welcome to our application',
                                style: TextStyles.font12White400Weight),
                            verticalSpace(4),
                            Text(name, style: TextStyles.font14White500Weight),
                          ],
                        ),
                      ],
                    ),
                    verticalSpace(8),
                    Text(lastAuth, style: TextStyles.font10White400Weight),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
