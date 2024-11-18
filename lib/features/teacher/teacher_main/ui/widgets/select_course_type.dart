import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/teacher/teacher_main/logic/teacher_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SelectCourseType extends StatefulWidget {
  bool? isSelectedPaid;
  SelectCourseType({super.key, this.isSelectedPaid});

  @override
  State<SelectCourseType> createState() => _SelectCourseTypeState();
}

class _SelectCourseTypeState extends State<SelectCourseType> {
  bool isPaid = true;
  bool isFree = false;
  @override
  void initState() {
    super.initState();
    isPaid = widget.isSelectedPaid != null ? widget.isSelectedPaid! : true;
    context.read<TeacherMainCubit>().courseType = isPaid?'Paid':'Free';
    isFree = isPaid==true?false:true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.courseType,
          style: TextStyles.font14Black500Weight,
        ),
        verticalSpace(8),
        Row(
          children: [
            selecteAndLabel(
              onTap: () {
                setState(() {
                  isFree = false;
                  isPaid = true;
                });

                context.read<TeacherMainCubit>().emitChangCourseType('Paid');
              },
              label: AppLocalizations.of(context)!.paid,
              isSelected: isPaid,
            ),
            horizontalSpace(32),
            selecteAndLabel(
              onTap: () {
                setState(() {
                  isFree = true;
                  isPaid = false;
                });
                context.read<TeacherMainCubit>().emitChangCourseType('Free');
              },
              label: AppLocalizations.of(context)!.free,
              isSelected: isFree,
            ),
          ],
        ),
        verticalSpace(8),
        Visibility(
          visible: isPaid,
          child: Text(
            AppLocalizations.of(context)!.paymentNoticePaid,
            style: TextStyles.font12Red400Weight,
          ),
        ),
        Visibility(
          visible: isFree,
          child: Text(
            AppLocalizations.of(context)!.paymentNoticeFree,
            style: TextStyles.font12Green400Weight,
          ),
        ),
      ],
    );
  }

  Widget selecteAndLabel(
      {required String label,
      required bool isSelected,
      required Function() onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: isSelected ? ColorsManager.mainBlue : Colors.white,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(color: ColorsManager.lightBlue),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 14,
                    )
                  : const Padding(padding: EdgeInsets.all(6)),
            ),
            horizontalSpace(8),
            Text(label, style: TextStyles.font12Black500Weight),
          ],
        ),
      ),
    );
  }
}
