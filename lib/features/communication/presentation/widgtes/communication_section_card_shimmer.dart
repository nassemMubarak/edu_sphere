import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CommunicationSectionCardShimmer extends StatelessWidget {
  const CommunicationSectionCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 150,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 16),
          ...List.generate(4, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      height: 20,
                      color: Colors.grey[300],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Container(
                    height: 20,
                    width: 20,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
