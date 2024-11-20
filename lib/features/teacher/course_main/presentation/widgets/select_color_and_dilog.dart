import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/routing/app_rputer.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SelectColorAndDilog extends StatefulWidget {

  const SelectColorAndDilog({super.key});

  @override
  State<SelectColorAndDilog> createState() => _ColorPickerInfoDilogState();
}

class _ColorPickerInfoDilogState extends State<SelectColorAndDilog> {
  Color pickerColor = ColorsManager.mainBlue;
  Color currentColor = ColorsManager.secondaryColor;
  List colorsList = [
    Colors.black,
    Color(0xFF515151),
    Color(0xFF903131),
    Color(0xFFFF0000),
    Color(0xFF1EFF00),
    Color(0xFF1A00FF),
    Color(0xFF1A00FF),
  ];
// ValueChanged<Color> callback
  void changeColor(Color color) {
    setState(() => pickerColor = color);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 100,
      child: ListView.separated(
        separatorBuilder: (context, index) => horizontalSpace(8),
        scrollDirection: Axis.horizontal,
        itemCount: colorsList.length,
        itemBuilder: (context, index) => cercleColor(
            color: colorsList[index],
            onTap: () {
              if (index == 6) {
                showDialog(
                  context: context,
                  builder: (context) => colorsDialog(context),
                );
              }else{
                context.read<CourseMainCubit>().emitChangColorTextField(color: colorsList[index]);
              }
            },
            index: index),
      ),
    );
  }

  Widget cercleColor({Color? color, Function()? onTap, required int index}) {
    return GestureDetector(
      onTap: onTap,
      child: CircleAvatar(
        child: index == 6
            ? SizedBox(
                height: 30,
                width: 30,
                child: SvgPicture.asset(
                  'assets/svgs/colors_icon.svg',
                  fit: BoxFit.cover,
                ),
              )
            : null,
        radius: 15,
        backgroundColor: color,
      ),
    );
  }

  colorsDialog(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
            ),
          ),
          AppTextButton(
            buttonText: 'Select',
            onPressed: () {
              context.read<CourseMainCubit>().emitChangColorTextField(color: pickerColor);
              setState(() => currentColor = pickerColor);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
