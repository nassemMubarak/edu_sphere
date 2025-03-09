import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/admin/teacher_admin/domain/entities/show_teacher_courses.dart';
import 'package:edu_sphere/features/admin/teacher_admin/presintation/bloc/show_courrse_teacher/show_course_teacher_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShowAdvertisementWidget extends StatelessWidget {
  ShowCourseTeacher? showCourseTeacher;
  ShowAdvertisementWidget({super.key, this.showCourseTeacher});

  @override
  Widget build(BuildContext context) {
    return context
        .read<ShowCourseTeacherCubit>()
        .showCourseTeacher !=
        null &&
        context
            .read<ShowCourseTeacherCubit>()
            .showCourseTeacher!
            .advertisements
            .isNotEmpty
        ? SectionCard(
      title: 'Advertisements',
      icon: 'assets/svgs/advertisements_icon.svg',
      widget: buildListView(
          listAds: context
              .read<ShowCourseTeacherCubit>()
              .showCourseTeacher!
              .advertisements),
    )
        : SectionCard(
      title: 'Advertisements',
      icon: 'assets/svgs/advertisements_icon.svg',
      widget: ImageAndTextEmptyData(
          message: 'There is no students yet'),
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

// Extract the RGBA components from the string, assuming the format is like:
// "alpha: 1.0000, red: 0.1176, green: 1.0000, blue: 0.0000"
          RegExp regExp = RegExp(r'alpha: ([\d.]+), red: ([\d.]+), green: ([\d.]+), blue: ([\d.]+)');
          Match? match = regExp.firstMatch(colorHex);
          Color color = Colors.black;
          if (match != null) {
            // Extract each color component as a double
            double alpha = double.parse(match.group(1)!);
            double red = double.parse(match.group(2)!);
            double green = double.parse(match.group(3)!);
            double blue = double.parse(match.group(4)!);

            // Convert each component to an integer in the 0-255 range
            int redValue = (red * 255).round();
            int greenValue = (green * 255).round();
            int blueValue = (blue * 255).round();
            int alphaValue = (alpha * 255).round();

            // Combine RGBA values into a hex integer and create the color
            color = Color.fromARGB(alphaValue, redValue, greenValue, blueValue);

            // Now you can use the 'color' object
            print(color);  // This prints the color as a Color object (e.g., Color(0xFF1EFF00))
          } else {
            // If the format doesn't match, handle the case gracefully
            print("Invalid color format");
          }
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
