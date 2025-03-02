import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/loading_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class EditUserNameDialog extends StatelessWidget {
  User user;
  EditUserNameDialog({super.key,required this.user});
  TextEditingController nameTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nameTextEditingController = TextEditingController(text: user.name);
    return AlertDialogWidget(
        title: 'Edit User Name',
        textButton: 'Edit',
        widget: Form(
          key: globalKey,
          child: Column(
            children: [
              LoadingProfileWidget(message: 'Update Name Successfully'),
              LabelAndWidget(
                label: 'User Name',
                widget: AppTextFormField(
                  controller: nameTextEditingController,
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
        ),
        onTapButton: () {
          if(user.name!=nameTextEditingController.text&&globalKey.currentState!.validate())
              context.read<ProfileCubit>().emitUpdateUser(data: {'name':nameTextEditingController.text},type: user.type!);
        }
        );
  }
}
