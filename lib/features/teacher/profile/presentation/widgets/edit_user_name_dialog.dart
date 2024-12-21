import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditUserNameDialog extends StatelessWidget {
  EditUserNameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
        title: 'Edit User Name',
        textButton: 'Edit',
        widget: Column(
          children: [
            LabelAndWidget(
              label: 'User Name',
              widget: AppTextFormField(
                hintText: 'User Name',
                validator: (value) {
                  if (value == null) {
                    return 'Enter User Name';
                  }
                },
              ),
            ),
          ],
        ),
        onTapButton: () {});
  }
}
