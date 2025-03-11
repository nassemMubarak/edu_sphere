import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/camp_subscription/presentation/widgets/permanent_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CampSubscribePage extends StatelessWidget {
  const CampSubscribePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
      widget: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PermanentWidget(
              isShowButtonSubscribe: false,
              price: 'Free',
              supTitle1: '3 teachers allowed',
              supTitle2: '30 students allowed',
              supTitle3: 'Free/permanent',
            ),
            verticalSpace(24),
            PermanentWidget(
              isShowButtonSubscribe: true,
              price: '\$19.99',
              supTitle1: '5 teachers allowed',
              supTitle2: '50 students allowed',
              supTitle3: '\$19.99/permanent',
            ),
            verticalSpace(24),
            PermanentWidget(
              isShowButtonSubscribe: true,
              price: '\$29.99',
              supTitle1: '7 teachers allowed',
              supTitle2: '70 students allowed',
              supTitle3: '\$29.99/permanent',
            ),
             verticalSpace(24), PermanentWidget(
              isShowButtonSubscribe: true,
              price: '\$39.99',
              supTitle1: 'Infinite number teachers allowed',
              supTitle2: 'Infinite number students allowed',
              supTitle3: '\$39.99/permanent',
            ),
            verticalSpace(24),
          ],
        ),
      ),
    );
  }
}
