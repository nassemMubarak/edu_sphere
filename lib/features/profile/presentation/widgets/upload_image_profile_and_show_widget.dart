import 'dart:io';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UploadImageProfileAndShowWidget extends StatefulWidget {
  const UploadImageProfileAndShowWidget({super.key});

  @override
  State<UploadImageProfileAndShowWidget> createState() => _UploadImageProfileAndShowWidgetState();
}

class _UploadImageProfileAndShowWidgetState extends State<UploadImageProfileAndShowWidget> {
  File? _imageFile;

  // Function to pick an image
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      setState(() {
        _imageFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160.h,
      width: 160.w,
      child: Stack(
        children: [
          // Display either the picked image or the default SVG
          Container(
            height: 150.h,
            width: 150.w,
            decoration: BoxDecoration(
              color: ColorsManager.nearNeutral,
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: _imageFile != null
                ? ClipRRect(
              borderRadius: BorderRadius.circular(100.r),
              child: Image.file(
                _imageFile!,
                fit: BoxFit.cover,
                alignment: Alignment.center,

              ),
            )
                : Container(
              margin: EdgeInsetsDirectional.all(50),
              child: SvgPicture.asset(
                'assets/svgs/person_icon.svg',
                color: ColorsManager.darkGray,
              ),
            ),
          ),
          // Floating action button for image selection
          PositionedDirectional(
            bottom: 0,
            end: 5,
            child: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Set custom radius
              ),
              onPressed: _pickImage, // Call _pickImage function on press
              child: Icon(
                Icons.camera_alt_outlined,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
