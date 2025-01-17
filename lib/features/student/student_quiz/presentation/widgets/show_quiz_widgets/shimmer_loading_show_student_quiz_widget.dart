import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerLoadingShowStudentQuizWidget extends StatelessWidget {
  const ShimmerLoadingShowStudentQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 4,
            color: ColorsManager.shadowColor.withOpacity(0.3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuestionRow(
                number: '1',
                isSelected: false,
                isFirstRow: true
              ),
              verticalSpace(24),
              _buildQuestionRow(
                isSelected: false,
              ),
              verticalSpace(16),
              _buildQuestionRow(
                isSelected: false,
              ),
              verticalSpace(16),
              _buildQuestionRow(
                isSelected: false,
              ),
              verticalSpace(16),
              _buildQuestionRow(
                isSelected: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildQuestionRow({
    String? number,
    required bool isSelected,
    bool isFirstRow = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(color: Colors.blue, width: 2),
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 8,
            backgroundColor:
            isSelected ? ColorsManager.mainBlue : Colors.transparent,
          ),
        ),
        horizontalSpace(8),
       isFirstRow?Container(
          height: 40,
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
        ):Container(
         height: 20,
         width: 200,
         decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.circular(20)
         ),
       )
      ],
    );
  }

}
