import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ChangCampAlertDialog extends StatelessWidget {
  Function()? changCampOnTap;
   ChangCampAlertDialog({super.key,this.changCampOnTap});
  List<String> campName = [
    'Nassem',
    'Ahmed',
    'Foad',
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(title: 'Choose a new camp', textButton: 'Change Camp',
        widget: Form(
          child: LabelAndWidget(
            label: AppLocalizations.of(context)!.camp,
            widget: DropdownWidget(
              onChanged: (value){
                if(value != null){

                }
              },
              hintText: AppLocalizations.of(context)!.campName,
              items: campName,
              prefixIcon: SvgPicture.asset('assets/svgs/camp.svg'),
            ),
          ),
        ),
        onTapButton:changCampOnTap?? (){

            context.pop();
     });
  }
}
