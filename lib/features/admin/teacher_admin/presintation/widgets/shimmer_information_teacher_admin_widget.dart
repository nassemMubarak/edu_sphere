import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
class ShimmerInformationTeacherAdminWidget extends StatelessWidget {
  const ShimmerInformationTeacherAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        _buildShimmerSection(),
        verticalSpace(24),
        _buildShimmerSection(),
        verticalSpace(24),
        _buildShimmerSection(),
        verticalSpace(24),
        _buildShimmerSection(),
        verticalSpace(24),
      ],
    );
  }

  // This function builds the shimmer effect for each section
  Widget _buildShimmerSection() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 200,
        color: Colors.white,
      ),
    );
  }
}
