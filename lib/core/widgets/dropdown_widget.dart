import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class DropdownWidget extends StatelessWidget {
  final String? hintText;
  final Widget? prefixIcon;
  final List<String> items;

  Function(String?)? onChanged;

   DropdownWidget({
    super.key,
     this.hintText,
    this.prefixIcon,
    required this.items,
     this.onChanged
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdown.search(
      decoration: CustomDropdownDecoration(
        
        hintStyle: TextStyles.font12NeutralGray400Weight,
        closedFillColor: ColorsManager.lightGray,
        prefixIcon: prefixIcon,
        listItemStyle: TextStyles.font12NeutralGray400Weight,
        headerStyle:TextStyles.font14MainBlue400Weight,
        errorStyle: TextStyles.font12Red400Weight,

        searchFieldDecoration: SearchFieldDecoration(
          hintStyle: TextStyles.font12NeutralGray400Weight,
          textStyle: TextStyles.font14MainBlue400Weight,

        ),
      ),
      
      items: items,
      onChanged: onChanged,
      hintText: hintText,
      excludeSelected: false,
      
    );
  }
}
