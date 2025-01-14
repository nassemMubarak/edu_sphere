import 'package:edu_sphere/core/theming/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUploadFileWidget extends StatelessWidget {
  const ShimmerUploadFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return // Wrap the Container with Shimmer to create a loading effect
      Shimmer.fromColors(
        baseColor: Colors.grey[300]!,  // Base color for the shimmer effect
        highlightColor: Colors.grey[100]!,  // Highlight color for the shimmer effect
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
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

        ),
      );
  }
}
