import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/profile_info_section.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/shimmer_profile_widget.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/upload_image_profile_and_show_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:logger/logger.dart';

class ProfilePage extends StatelessWidget {

  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<ProfileCubit>().emitGetInfoUser();
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) =>current is GetInfoUserLoadedDataState,
          builder: (context, state) {
            if(state is GetInfoUserLoadingState){
              return ProfileShimmer();
            }
            if(state is GetInfoUserLoadedDataState){
              return Column(
                children: [
                  verticalSpace(20),
                  const UploadImageProfileAndShowWidget(),
                  verticalSpace(24),
                   ProfileInfoSection(user: state.user),
                ],
              );
            }else{
              return Column(
                children: [
                  verticalSpace(20),
                  const UploadImageProfileAndShowWidget(),
                  verticalSpace(24),
                  ProfileInfoSection(user: context.read<ProfileCubit>().user!),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}


