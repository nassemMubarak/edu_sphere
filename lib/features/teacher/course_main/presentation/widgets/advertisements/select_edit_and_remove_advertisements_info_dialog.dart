import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/delete_advertisement_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/edit_advertisements_info_dialog.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectEditAndRemoveAdvertisementsInfoDialog extends StatefulWidget {
  int idCourse;
  SelectEditAndRemoveAdvertisementsInfoDialog({super.key,required this.idCourse});

  @override
  State<SelectEditAndRemoveAdvertisementsInfoDialog> createState() => _SelectEditAndRemoveAdvertisementsInfoDialogState();
}

class _SelectEditAndRemoveAdvertisementsInfoDialogState extends State<SelectEditAndRemoveAdvertisementsInfoDialog> {
   int? selectedIndexAds;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding:const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
         const Spacer(),
          Text(
            'Edit Advertisements',
            style: TextStyles.font16Black600Weight,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              if(selectedIndexAds!=null){
                context.pop();
                showDialog(context: context, builder: (context) => EditAdvertisementsInfoDialog(idCourse: widget.idCourse,ads: context.read<CourseAdvertisementCubit>().advertisementList[selectedIndexAds!], index: selectedIndexAds!));
              }
            },
            child: SvgPicture.asset('assets/svgs/writing_icon.svg',
                color: selectedIndexAds!=null?Colors.green:ColorsManager.neutralGray),
          ),
          horizontalSpace(8),
          GestureDetector(
            onTap: () {
              if(selectedIndexAds!=null){
                context.pop();
                showDialog(context: context, builder: (context) => DeleteAdvertisementInfoDialog(idCourse: widget.idCourse,idAdvertisement: context.read<CourseAdvertisementCubit>().advertisementList[selectedIndexAds!].id,indexAdvertisement: selectedIndexAds!,));
              }
            },
            child: SvgPicture.asset('assets/svgs/delete_icon.svg',
                color: selectedIndexAds!=null?Colors.red:ColorsManager.neutralGray),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
              width:  0.6.sw,
              height: 0.5.sh,
              child: buildListView(listAds: context.read<CourseAdvertisementCubit>().advertisementList)),
          verticalSpace(24),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 2,
                child: AppTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  buttonText: AppLocalizations.of(context)!.cancel,
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Spacer(),

            ],
          )
        ],
      ),
    );
  }

  ListView buildListView({required List<Advertisement> listAds}) {
    return ListView.separated(
        separatorBuilder: (context, index) => verticalSpace(16.h),
        padding: EdgeInsetsDirectional.only(
            top: 24.h, bottom: 40.h, end: 16.w, start: 16.w),
        itemCount: listAds.length,
        itemBuilder: (context, index) => buildGestureDetector(listAds, index));
  }

  GestureDetector buildGestureDetector(List<Advertisement> listAds, int index) {
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
    return GestureDetector(
        onTap: (){
          setState(() {
            selectedIndexAds = index;
          });
        },
        child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24.h,
                    width: 24.w,
                    padding: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: ColorsManager.lightBlue),
                    ),
                    child: Visibility(
                      visible: selectedIndexAds==index,
                      child: Container(
                        height: 18.h,
                        width: 18.w,
                        margin:const EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: ColorsManager.mainBlue,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: Colors.black),
                        ),
                      ),
                    ),
                ),
                horizontalSpace(8),
                SizedBox(
                  width: 0.6.sw,
                  child: Text(
                    listAds[index].text,
                    style: TextStyles.font12Black400Weight
                        .copyWith(color: color),
                    maxLines: null, // Allow multiple lines
                    overflow: TextOverflow
                        .visible, // Ensure text overflow is handled properly
                  ),
                )
              ],
            ),
      );
  }
}
