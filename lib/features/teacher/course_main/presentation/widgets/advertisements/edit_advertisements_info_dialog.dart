import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/advertisement.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/select_color_and_dilog.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
class EditAdvertisementsInfoDialog extends StatelessWidget {
  Advertisement ads;
  int index;
  int idCourse;
    EditAdvertisementsInfoDialog({super.key,required this.ads,required this.index,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<CourseAdvertisementCubit>().advertisementTextEditionController = TextEditingController(text: ads.text);
    String colorString = ads.color;
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
    context.read<CourseAdvertisementCubit>().colorSelectedTextField = color;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        insetPadding: EdgeInsets.all(16),
        backgroundColor: Colors.white,
        scrollable: true,
        title: Text(
          'Edit Advertisements',
          style: TextStyles.font16Black600Weight,
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: context.read<CourseAdvertisementCubit>().globalAdvertisementKey,
              child: BlocConsumer<CourseAdvertisementCubit, CourseAdvertisementState>(
                listener: (context, state) {
                  if(state is AddOrUpdateOrDeleteLoadingState){
                    context.loading();
                  }
                  else if(state is AdvertisementMessageErrorState){
                    ToastNotificationMessage().showToastNotificationError(message: state.message, context: context);
                    context.pop();
                  }
                  else if(state is GetAllAdvertisementLoadedState){
                    ToastNotificationMessage().showNotificationSuccess(message: 'The advertisement has been successfully update', context: context);
                    context.pop();
                    context.pop();
                  }
                },
                builder: (context, state) {
                  if(state is ChangColorTextInTextField){
                    return  LabelAndWidget(
                      label: 'Advertisement',
                      widget: AppTextFormField(
                        textStyle: TextStyles.font14MainBlue400Weight.copyWith(color: state.colorSelect),
                        maxLines: 5,
                        hintText: 'advertisement',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!.enterCourseName;
                          }
                        },
                        prefixIcon: Container(
                          height: 120,
                          width: 50,
                          alignment: AlignmentDirectional.topCenter,
                          // padding: EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/svgs/advertisements_icon.svg',
                            color: state.colorSelect,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    );
                  }else{
                    return LabelAndWidget(
                      label: 'Advertisement',
                      widget: AppTextFormField(
                        controller: context.read<CourseAdvertisementCubit>().advertisementTextEditionController,
                        textStyle: TextStyles.font14MainBlue400Weight.copyWith(color: context.read<CourseAdvertisementCubit>().colorSelectedTextField),
                        maxLines: 5,
                        hintText: 'advertisement',
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter ads text';
                          }
                        },
                        prefixIcon: Container(
                          height: 120,
                          width: 50,
                          alignment: AlignmentDirectional.topCenter,
                          // padding: EdgeInsets.all(14),
                          child: SvgPicture.asset(
                            'assets/svgs/advertisements_icon.svg',
                            color: ColorsManager.neutralGray,
                            width: 25,
                            height: 25,
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
            verticalSpace(16),
            Text(
              'Color',
              style: TextStyles.font16Black500Weight,
            ),
            SelectColorAndDilog(),
            verticalSpace(24),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      if(context.read<CourseAdvertisementCubit>().globalAdvertisementKey.currentState!.validate()){
                        context.read<CourseAdvertisementCubit>().emitEditAdvertisement(indexAdvertisement: index,idCourse: idCourse,idAdvertisement: context.read<CourseAdvertisementCubit>().advertisementList[index].id);

                        // context.pop();
                      }

                    },
                    buttonText: 'Save',
                    buttonWidth: 147,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.pop();
                      context.read<CourseAdvertisementCubit>().advertisementTextEditionController = TextEditingController();
                      context.read<CourseAdvertisementCubit>().colorSelectedTextField =ColorsManager.mainBlue;
                    },
                    buttonText: AppLocalizations.of(context)!.cancel,
                    buttonWidth: 147,
                    backgroundColor: Colors.white,
                    textStyle: TextStyles.font14Black600Weight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
