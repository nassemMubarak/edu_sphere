import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/password_validations.dart';
import 'package:flutter/material.dart';

class RestPasswordForm extends StatefulWidget {
  const RestPasswordForm({super.key});

  @override
  State<RestPasswordForm> createState() => _RestPasswordFormState();
}

class _RestPasswordFormState extends State<RestPasswordForm> {
    final formKey = GlobalKey<FormState>();
    bool isVisiblePasswordValidator = false;
  bool hasLowercase = false;

  bool hasUppercase = false;

  bool hasSpecialCharacters = false;

  bool hasNumber = false;

  bool hasMinLength = false;
    late TextEditingController passwordController;
    bool isObscureText = true;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    setupPasswordControllerListener();
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndWidget(
          label: 'Password',
          widget: AppTextFormField(
            isObscureText: isObscureText,
            controller: passwordController,
            hintText: '**************',
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a valid Password';
              }
            },
            prefixIcon: GestureDetector(
              onTap: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              child: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                color: ColorsManager.neutralGray,
              ),
            ),
          ),
        ),
           Visibility(
              visible: isVisiblePasswordValidator,
              child: PasswordValidations(
                  hasLowerCase: hasLowercase,
                  hasUpperCase: hasUppercase,
                  hasSpecialCharacters: hasSpecialCharacters,
                  hasNumber: hasNumber,
                  hasMinLength: hasMinLength),
            ),
        ]
      )
      
    );
  }
  void setupPasswordControllerListener() {

    passwordController.addListener(() {
      setState(() {
        isVisiblePasswordValidator = true;
      });
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(passwordController.text);
        hasNumber = AppRegex.hasNumber(passwordController.text);
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }
}
