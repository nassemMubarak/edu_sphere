import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/auth/presentation/widgets/signup_widgets/gender_widget.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/loading_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
class EditGender extends StatelessWidget {
  User user;
  EditGender({super.key,required this.user});
 
  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(title: 'Edit Gender', textButton: 'Edit', widget: Column(
      children: [
        LoadingProfileWidget(message: 'Update password Successfully'),

        GenderWidget(
          onSelectGender: (isMale){
            Logger().e(isMale);
            context.read<ProfileCubit>().genderIsMale = isMale;
          },
        ),
      ],
    ), onTapButton: (){
      context.read<ProfileCubit>().emitUpdateUser(data: {'sex':context.read<ProfileCubit>().genderIsMale?'male':'female'.toString()},type: user.type!);

    });
  }
}

