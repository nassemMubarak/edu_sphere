import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/shimmer_loading_advertisement.dart';
import 'package:edu_sphere/features/student/student_main/presentations/bloc/student_advertisements/student_advertisements_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
class StudentAdvertisementsWidget extends StatelessWidget {
  int idCourse;
   StudentAdvertisementsWidget({super.key,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<StudentAdvertisementsCubit>().emitGetAllAdvertisement(idCourse: idCourse);
    return BlocBuilder<StudentAdvertisementsCubit,StudentAdvertisementsState>(
      builder: (context, state) {
        if(state is GetAllStudentAdvertisementsLoadingState){
          return ShimmerLoadingAdvertisement();

        }else if(state is GetAllStudentAdvertisementsLoadedState){
          if(state.advertmints.isNotEmpty){
            return SectionCard(
              title: 'Advertisements',
              icon: 'assets/svgs/advertisements_icon.svg',
              widget: buildListView(listAds: state.advertmints),
            );
          }else{
            return SectionCard(
              title: 'Advertisements',
              icon: 'assets/svgs/advertisements_icon.svg',
              widget:  ImageAndTextEmptyData(
                message: 'You have not added any ads yet.',

              ),
            );
          }
        }else{
        return  context.read<StudentAdvertisementsCubit>().advertisementList.isNotEmpty?
        SectionCard(
          title: 'Advertisements',
          icon: 'assets/svgs/advertisements_icon.svg',
          widget: buildListView(listAds: context.read<StudentAdvertisementsCubit>().advertisementList),
        )
            :SectionCard(
          title: 'Advertisements',
          icon: 'assets/svgs/advertisements_icon.svg',
          widget:  ImageAndTextEmptyData(
            message: 'You have not added any ads yet.',

          ),
        );
        }
      },
    );
  }
  ListView buildListView({required List<Advertisement> listAds}) {
    return ListView.separated(
        separatorBuilder: (context, index) => verticalSpace(16.h),
        padding: EdgeInsetsDirectional.only(top: 24.h,bottom: 40.h,end: 16.w,start: 16.w),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: listAds.length,
        itemBuilder: (context, index) {
          String colorString = listAds[index].color;

          // Remove the "Color(" and ")" and also handle '0x' prefix if it exists
          String colorHex = colorString.replaceAll('Color(', '').replaceAll(')', '').replaceAll('0x', '');

          // Parse the hex string into a color integer
          Color color = Color(int.parse(colorHex, radix: 16));
          return Row(
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
                  style: TextStyles.font12Black400Weight.copyWith(color:color),
                  // style: TextStyles.font12Black400Weight.copyWith(),
                  maxLines: null, // Allow multiple lines
                  overflow: TextOverflow.visible, // Ensure text overflow is handled properly
                ),
              )
            ],
          );
        }

    );
  }

}
