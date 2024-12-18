import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/add_advertisements_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/select_edit_and_remove_advertisements_info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AdvertisementsWidget extends StatelessWidget {
 const  AdvertisementsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<CourseMainCubit, CourseMainState>(
      builder: (context, state) {
        if(state is GetAllAds){
          if(state.listAds.isNotEmpty){
            return SectionCard(
              onTapEdit: (){
                showDialog(
                  context: context,
                  builder: (context) => SelectEditAndRemoveAdvertisementsInfoDialog(),
                );
              },
              title: 'Advertisements',
              icon: 'assets/svgs/advertisements_icon.svg',
              infoDialog: AddAdvertisementsInfoDialog(),
              widget: buildListView(listAds: state.listAds),
            );
          }else{
            return SectionCard(
              title: 'Advertisements',
              icon: 'assets/svgs/advertisements_icon.svg',
              infoDialog: AddAdvertisementsInfoDialog(),
              widget:  ImageAndTextEmptyData(
                message: 'You have not added any ads yet.',

              ),
            );
          }
        }else{
          return SectionCard(
            title: 'Advertisements',
            icon: 'assets/svgs/advertisements_icon.svg',
            infoDialog: AddAdvertisementsInfoDialog(),
            widget:  ImageAndTextEmptyData(
              message: 'You have not added any ads yet.',

            ),
          );
        }
      },
    );

  }

  ListView buildListView({required List<Ads> listAds}) {
    return ListView.separated(
    separatorBuilder: (context, index) => verticalSpace(16.h),
    padding: EdgeInsetsDirectional.only(top: 24.h,bottom: 40.h,end: 16.w,start: 16.w),
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: listAds.length,
    itemBuilder: (context, index) =>Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgPicture.asset(
          'assets/svgs/ads_icon.svg',
        ),
        horizontalSpace(8),
        SizedBox(
          width: 0.6.sw,
          child: Text(
            listAds[index].text,
            style: TextStyles.font12Black400Weight.copyWith(color: listAds[index].colorText),
            maxLines: null, // Allow multiple lines
            overflow: TextOverflow.visible, // Ensure text overflow is handled properly
          ),
        )
      ],
    )

  );
  }
}
