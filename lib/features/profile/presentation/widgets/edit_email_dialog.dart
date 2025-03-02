import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/loading_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
class EditEmailDialog extends StatelessWidget {
  User user;
  EditEmailDialog({super.key,required this.user});
  TextEditingController emailTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    emailTextEditingController = TextEditingController(text: user.email);

    return AlertDialogWidget(title: 'Edit Email', textButton: 'Edit',
      widget: Form(
        key: globalKey,
        child: Column(
          children: [
            LoadingProfileWidget(message: 'Update email Successfully'),
            LabelAndWidget(
                    label: 'Email',
                    widget: AppTextFormField(
                      controller: emailTextEditingController,
                        textInputType: TextInputType.emailAddress,
                        hintText: 'email', validator: (value){
                      if(value==null){
                        return 'Enter User Email';
                      }
                    }),
                  ),
          ],
        ),
      ),
       onTapButton: (){
      Logger().e(user.email!=emailTextEditingController.text);
         if(user.email!=emailTextEditingController.text&&globalKey.currentState!.validate())
           context.read<ProfileCubit>().emitUpdateUser(data: {'email':emailTextEditingController.text},type: user.type!);

       },);

  }
}
