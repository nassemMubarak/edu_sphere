import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BreadCrumbWidget extends StatelessWidget {
  final List<String> items;

  const BreadCrumbWidget({Key? key, required this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Wrap(
        alignment: WrapAlignment.start,
        spacing: 8.0, // Horizontal spacing between items
        runSpacing: 4.0, // Vertical spacing between lines
        children: List.generate(items.length, (index) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  _popContext(context, items.length - index - 1);
                },
                child: Text(
                  items[index],
                  style: index == items.length - 1
                      ? TextStyles.font12Black500Weight
                      : TextStyles.font12NeutralGray400Weight,
                ),
              ),
              if (index < items.length - 1) ...[
                horizontalSpace(8),
                const Icon(Icons.arrow_forward_ios_sharp,
                    color: ColorsManager.darkLightBlue, size: 15),
                horizontalSpace(8),
              ],
            ],
          );
        }),
      ),
    );
  }

  void _popContext(BuildContext context, int count) {
    for (int i = 0; i < count; i++) {
      if (Navigator.canPop(context)) {
        context.pop();
      }
    }
  }
}
