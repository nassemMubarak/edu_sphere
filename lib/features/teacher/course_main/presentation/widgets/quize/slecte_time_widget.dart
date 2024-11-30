import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlecteTimeWidget extends StatelessWidget {
  final String title;
  final List<String> hourList =
      List.generate(12, (index) => (index + 1).toString());
  final List<String> minuteList =
      List.generate(59, (index) => (index + 1).toString());
  SlecteTimeWidget({super.key, required this.title});

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
                  label: 'Hour',
                  widget: DropdownWidget(
                    hintText: '',
                    prefixIcon: SvgPicture.asset(
                      'assets/svgs/hour_icon.svg',
                      width: 20,
                    ),
                    items: hourList,
                  ),
                ),
              ),
              horizontalSpace(7),
              Expanded(
                child: LabelAndWidget(
                  label: 'Minute',
                  widget: DropdownWidget(
                    hintText: '',
                    prefixIcon: SvgPicture.asset(
                      'assets/svgs/minute_icon.svg',
                      width: 15,
                    ),
                    items: minuteList,
                  ),
                ),
              ),
              horizontalSpace(7),
              Expanded(
                child: LabelAndWidget(
                  label: 'Am/Pm',
                  widget: DropdownWidget(
                    hintText: '',
                    // prefixIcon: SvgPicture.asset(
                    //   'assets/svgs/am_icon.svg',
                    //   width: 20,
                    // ),
                    items: ['Am', 'Pm'],
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
