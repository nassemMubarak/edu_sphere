import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordWidget extends StatefulWidget {
  const EmailAndPasswordWidget({super.key});

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  final formKey = GlobalKey<FormState>();
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            LabelAndWidget(label: 'Email', widget: AppTextFormField(
                hintText: 'edusphere@gmail.com',
                validator: (v){},
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: ColorsManager.neutralGray,
                ),
            ),

            ),
            LabelAndWidget(label: 'Password', widget: AppTextFormField(
              hintText: '**************',
              validator: (v){},
              prefixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                  child: Icon(
                    isObsecure ? Icons.visibility_off : Icons.visibility,
                    color: ColorsManager.neutralGray,
                  ),),
            ),

            ),

          ],
        ));
  }
}
