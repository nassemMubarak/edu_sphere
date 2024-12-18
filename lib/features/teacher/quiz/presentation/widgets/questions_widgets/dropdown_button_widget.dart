import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';
class DropdownButtonWidget extends StatefulWidget {
  String hintText;
  List<String> items;
   DropdownButtonWidget({super.key,required this.hintText,required this.items});

  @override
  State<DropdownButtonWidget> createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return   DropdownButtonHideUnderline(
      child:  DropdownButton<String>(
        icon: Icon(Icons.keyboard_arrow_down_outlined),
        borderRadius: BorderRadius.circular(10),
        hint: Text(widget.hintText,style:TextStyles.font12NeutralGray400Weight,),
        value: value,
        items: widget.items.map((val) {
          return DropdownMenuItem(
            value: val,
            child: Text(val,style: TextStyles.font14Black400Weight,),
          );
        }).toList(),
        onChanged: (val){
          setState(() {
            value=val;
          });
        },
      ),

    );
  }
}
