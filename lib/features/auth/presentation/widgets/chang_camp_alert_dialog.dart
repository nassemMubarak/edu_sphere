import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
class ChangCampAlertDialog extends StatelessWidget {
   ChangCampAlertDialog({super.key});
  List<String> campName = [
    'Nassem',
    'Ahmed',
    'Foad',
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding:const EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Warning message',
        style: TextStyles.font16Red600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          verticalSpace(24),
          Text('Choose a new camp',
            style: TextStyles.font16Black600Weight,
            textAlign: TextAlign.center,
          ),
          Form(
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
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {

                    context.pop();

                  },
                  buttonText: 'Change Camp',
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.pop();
                  },
                  buttonText: AppLocalizations.of(context)!.cancel,
                  buttonWidth: 147,
                  backgroundColor: Colors.white,
                  textStyle: TextStyles.font14Black600Weight,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
