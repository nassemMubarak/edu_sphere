import 'dart:io';
import 'package:edu_sphere/core/widgets/full_screen_image_widget.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/teacher/quiz/presentation/bloc/quiz_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theming/styles.dart';
class UploadImageWidget extends StatefulWidget {
   UploadImageWidget({super.key});

  @override
  State<UploadImageWidget> createState() => _UploadImageWidgetState();
}

class _UploadImageWidgetState extends State<UploadImageWidget> {
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  // For picking an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = image; // Update the image when picked
        context.read<QuizCubit>().questionPathImage = _image!.path;
      });
    }
    }
  @override
  Widget build(BuildContext context) {
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          onTap: (){
            _pickImageFromGallery();
          },
          contentPadding: EdgeInsets.zero,
          leading: SvgPicture.asset('assets/svgs/upload_image_icon.svg'),
          title: Text('Upload question as image',style: TextStyles.font14Black400Weight,),
        ),
        _image!=null?GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullScreenImageWidget(imagePath: _image!.path),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),  // Image border radius
            child: Image.file(
              File(_image!.path),
              width: 105.0,  // Set image width to fit container
              height: 115.0, // Set image height to fit container
              fit: BoxFit.cover, // Crop the image to cover the container
            ),
          ),
        ):SizedBox.shrink()

      ],
    );
  }
}
