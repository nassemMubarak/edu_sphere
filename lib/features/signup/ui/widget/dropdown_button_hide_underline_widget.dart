import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownButtonHideUnderlineWidget extends StatefulWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final List<String> items;
  Function(String?)? onChanged;
   DropdownButtonHideUnderlineWidget(
      {
      super.key,
      required this.hintText,
      this.suffixIcon,
      this.prefixIcon,
      required this.items,
      this.onChanged
      });

  @override
  State<DropdownButtonHideUnderlineWidget> createState() =>
      _DropdownButtonHideUnderlineWidgetState();
}

class _DropdownButtonHideUnderlineWidgetState
    extends State<DropdownButtonHideUnderlineWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          isDense: true,
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ColorsManager.mainBlue,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(16.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1.3,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          hintStyle: TextStyles.font12NeutralGray400Weight,
          hintText: widget.hintText,
          suffixIcon: widget.suffixIcon,
          fillColor: ColorsManager.lightGray,
          filled: true,
        ),
        isExpanded: true,
        iconSize: 0,
        items: widget.items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyles.font14MainBlue400Weight,
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        // value: selectedValue,
        onChanged:widget.onChanged,
      ),
    );
  }
}
