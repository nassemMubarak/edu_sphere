import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
class IconAndLabelAndSelectItemWidget extends StatelessWidget {
  List<String> items;
  String? value;
  String urlIcon;
  String label;
  String hintText;
  Function(String?)? onChanged;
   IconAndLabelAndSelectItemWidget({
    super.key,
     required this.items,
     required this.urlIcon,
     required this.label,
     required this.hintText,
     this.onChanged,
     this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(urlIcon),
              horizontalSpace(8),
              Text(label,style: TextStyles.font14Black400Weight,),
            ],
          ),
          verticalSpace(8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 1,horizontal: 10),
            decoration: BoxDecoration(
                color: Color(0xFFFAF9F9),
                borderRadius: BorderRadius.circular(10)
            ),
            child: DropdownButtonHideUnderline(
              child:  DropdownButton<String>(
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                borderRadius: BorderRadius.circular(10),
                hint: Text(hintText,style:TextStyles.font12NeutralGray400Weight,),
                value: value,
                items: items.map((val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(val,style: TextStyles.font14Black400Weight,),
                  );
                }).toList(),
                onChanged: onChanged,
              ),

            ),
          ),
        ],
      ),
    );
  }
}
