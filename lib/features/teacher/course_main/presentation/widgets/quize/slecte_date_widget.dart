import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlecteDateWidget extends StatelessWidget {
  final String title;
  const SlecteDateWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyles.font16Black500Weight,
          textAlign: TextAlign.start,
        ),
        verticalSpace(10),
        SizedBox(
          width: 1.sw,
          child: Row(
            children: [
              Expanded(
                child: LabelAndWidget(
                  label: 'Day',
                  widget: DropdownWidget(
                    hintText: '',
                    prefixIcon: SvgPicture.asset('assets/svgs/day_icon.svg'),
                    items: ['1', '2', '3', '4', '5', '6', '12'],
                  ),
                ),
              ),
              horizontalSpace(7),
              Expanded(
                child: LabelAndWidget(
                  label: 'Month',
                  widget: DropdownWidget(
                    hintText: '',
                    prefixIcon: SvgPicture.asset('assets/svgs/month_icon.svg'),
                    items: ['1', '2', '3', '4', '5', '6', '12'],
                  ),
                ),
              ),
              horizontalSpace(7),
              Expanded(
                child: LabelAndWidget(
                  label: 'Year',
                  widget: DropdownWidget(
                    hintText: '',
                    prefixIcon: SvgPicture.asset('assets/svgs/year_icon.svg'),
                    items: ['1', '2', '3', '4', '5', '6', '2244'],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
