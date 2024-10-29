import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/features/login/ui/widget/lable_and_text_form_field.dart';
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
            LableAndTextFormField(
                lable: 'Email',
                hintText: 'edusphere@gmail.com',
                prefixIcon:const Icon(
                  Icons.email_outlined,
                  color: ColorsManager.neutralGray,
                )),
            LableAndTextFormField(
              lable: 'Password',
              hintText: '**********',
              isObsecure:isObsecure,
              prefixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObsecure = !isObsecure;
                    });
                  },
                  child: Icon(
                    isObsecure ? Icons.visibility_off : Icons.visibility,
                    color: ColorsManager.neutralGray,
                  )),
            ),
          ],
        ));
  }
}
