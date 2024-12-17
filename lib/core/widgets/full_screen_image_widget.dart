import 'dart:io';

import 'package:flutter/material.dart';
class FullScreenImageWidget extends StatelessWidget {
  final String imagePath;

  FullScreenImageWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
          child: Image.file(File(imagePath)), // Show the image in full screen
        ),
      ),
    );
  }
}