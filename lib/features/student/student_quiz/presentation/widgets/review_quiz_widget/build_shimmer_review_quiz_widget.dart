import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class BuildShimmerReviewQuizWidget extends StatelessWidget {
  const BuildShimmerReviewQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        3,
            (index) => Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 40,
              height: 40,
              color: Colors.grey[300],
            ),
            title: Container(
              width: double.infinity,
              height: 16,
              color: Colors.grey[300],
            ),
            trailing: Container(
              width: 50,
              height: 16,
              color: Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
}
