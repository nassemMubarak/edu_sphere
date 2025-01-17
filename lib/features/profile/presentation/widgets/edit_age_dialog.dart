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
class EditAgeDialog extends StatelessWidget {
  User user;
  EditAgeDialog({super.key,required this.user});
  TextEditingController ageTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ageTextEditingController = TextEditingController(text: user.age);

    return AlertDialogWidget(title: 'Edit Age', textButton: 'Edit',
      widget: Form(
        key: globalKey,
        child: Column(
          children: [
            LoadingProfileWidget(message: 'Update age Successfully'),
            LabelAndWidget(
                    label: 'Age',
                    widget: AppTextFormField(
                      controller: ageTextEditingController,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: SvgPicture.asset('assets/svgs/circular-word-age.svg'),
                      ),
                        textInputType: TextInputType.number,
                        hintText: 'Age', validator: (value){
                      if(value==null){
                        return 'Age';
                      }
                    }),
                  ),
          ],
        ),
      ),
       onTapButton: (){
      Logger().e(user.age);
         if(user.age!=ageTextEditingController.text&&globalKey.currentState!.validate())
           context.read<ProfileCubit>().emitUpdateUser(data: {'age':ageTextEditingController.text},type: user.type!);

       },
    );

  }
}
