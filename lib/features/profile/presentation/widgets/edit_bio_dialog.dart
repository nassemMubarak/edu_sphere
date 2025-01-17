import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditBioDialog extends StatelessWidget {
  EditBioDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: 'Edit Bio',
      textButton: 'Edit',
      widget: LabelAndWidget(
        label: 'Bio',
        widget: AppTextFormField(
          textStyle: TextStyles.font12Black500Weight,
          maxLines: 5,
          hintText: 'Enter BIO',
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter bio';
            }
          },
          prefixIcon: Container(
            height: 105,
            width: 50,
            alignment: AlignmentDirectional.topCenter,
            child: SvgPicture.asset(
              'assets/svgs/bio_icon.svg',
              color: Color(0xFF929597),
            ),
          ),
        ),
      ),
      onTapButton: () {},
    );
  }
}
