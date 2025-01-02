import 'dart:io';

import 'package:edu_sphere/core/theming/colors.dart';
import 'package:flutter/material.dart';
class FullScreenImageWidget extends StatelessWidget {
   String? imagePath;
   String? networkImageUrl;

  FullScreenImageWidget({ this.imagePath,this.networkImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: InteractiveViewer(
        
            child: networkImageUrl!=null?
                Image.network(networkImageUrl!)
            // CachedNetworkImage(
            //   imageUrl: networkImageUrl!,
            //   placeholder: (context, url) => Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: CircularProgressIndicator(),
            //   ),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // )
                :
            Image.file(File(imagePath!)), // Show the image in full screen
          ),
        ),
      ),
    );
  }
}