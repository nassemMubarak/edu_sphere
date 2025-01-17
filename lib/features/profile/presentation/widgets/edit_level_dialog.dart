import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/loading_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
class EditLevelDialog extends StatelessWidget {
  User user;
  EditLevelDialog({super.key,required this.user});
  TextEditingController levelTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    levelTextEditingController = TextEditingController(text: user.level);

    return AlertDialogWidget(title: 'Edit Level', textButton: 'Edit',
      widget: Form(
        key: globalKey,
        child: Column(
          children: [
            LoadingProfileWidget(message: 'Update level Successfully'),
            LabelAndWidget(
                    label: 'Level',
                    widget: AppTextFormField(
                      controller: levelTextEditingController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/educational.svg'),
                      ),
                        textInputType: TextInputType.number,
                        hintText: 'Level', validator: (value){
                      if(value==null){
                        return 'enter level';
                      }
                    }),
                  ),
          ],
        ),
      ),
       onTapButton: (){
      Logger().e(user.age);
         if(user.level!=levelTextEditingController.text&&globalKey.currentState!.validate())
           context.read<ProfileCubit>().emitUpdateUser(data: {'level':levelTextEditingController.text},type: user.type!);

       },
    );

  }
}
