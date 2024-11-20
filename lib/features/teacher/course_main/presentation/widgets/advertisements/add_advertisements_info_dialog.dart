import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/domain/entities/ads.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/select_color_and_dilog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class AddAdvertisementsInfoDialog extends StatelessWidget {
  const AddAdvertisementsInfoDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Advertisements',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<CourseMainCubit>().globalAdsKey,
            child: BlocBuilder<CourseMainCubit, CourseMainState>(
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
                      controller: context.read<CourseMainCubit>().adsTextEditionController,
                      textStyle: TextStyles.font14MainBlue400Weight,
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
                    if(context.read<CourseMainCubit>().globalAdsKey.currentState!.validate()){
                    context.read<CourseMainCubit>().emitAddAds();
                    context.pop();
                    }

                  },
                  buttonText: 'Add Ads',
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.pop();
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
    );
  }
}
