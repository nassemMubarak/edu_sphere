import 'package:edu_sphere/core/widgets/alert_dialog_widget.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/user.dart';
import 'package:edu_sphere/features/profile/presentation/bloc/profile_cubit.dart';
import 'package:edu_sphere/features/profile/presentation/widgets/loading_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMajorDialog extends StatelessWidget {
  User user;

  EditMajorDialog({super.key, required this.user});

  TextEditingController majorTextEditingController = TextEditingController();
  final globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: 'Edit Major',
      textButton: 'Edit',
      widget: Form(
        key: globalKey,
        child: Column(
          children: [
            LoadingProfileWidget(message: 'Update specialization Successfully'),
            LabelAndWidget(
              label: 'University Major',
              widget: AppTextFormField(
                  controller: majorTextEditingController,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child:
                        SvgPicture.asset('assets/svgs/university_teacher.svg'),
                  ),
                  textInputType: TextInputType.text,
                  hintText: 'University Major',
                  validator: (value) {
                    if (value == null) {
                      return 'University Major';
                    }
                  }),
            ),
          ],
        ),
      ),
      onTapButton: () {
        if (user.specialization != majorTextEditingController.text &&
            globalKey.currentState!.validate())
          context.read<ProfileCubit>().emitUpdateUser(
              data: {'specialization': majorTextEditingController.text},
              type: user.type!);
      },
    );
  }
}
