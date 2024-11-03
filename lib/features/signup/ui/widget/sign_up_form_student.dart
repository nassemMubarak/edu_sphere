import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/password_validations.dart';
import 'package:flutter/material.dart';

class SignUpFormStudent extends StatefulWidget {
  bool? labelCamp;
  SignUpFormStudent({super.key, this.labelCamp});

  @override
  State<SignUpFormStudent> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<SignUpFormStudent> {
  final formKey = GlobalKey<FormState>();
  bool isVisiblePasswordValidator = false;
  bool hasLowercase = false;

  bool hasUppercase = false;

  bool hasSpecialCharacters = false;

  bool hasNumber = false;

  bool hasMinLength = false;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;
  late TextEditingController emailController;
  bool isObscureText = true;
  bool isObscureTextConfirm = true;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();

    setupPasswordControllerListener();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            LabelAndWidget(
              label: widget.labelCamp != null ? 'Camp Name' : 'User Name',
              widget: AppTextFormField(
                controller: nameController,
                hintText: 'full name ',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid name';
                  }
                },
                prefixIcon: const Icon(
                  Icons.person_2_outlined,
                  color: ColorsManager.neutralGray,
                ),
              ),
            ),
            LabelAndWidget(
              label: 'Email',
              widget: AppTextFormField(
                controller: emailController,
                hintText: 'edusphere@gmail.com',
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !AppRegex.isEmailValid(value)) {
                    return 'Please enter a valid email';
                  }
                },
                prefixIcon: const Icon(
                  Icons.email_outlined,
                  color: ColorsManager.neutralGray,
                ),
              ),
            ),
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
            LabelAndWidget(
              label: 'Confirm password',
              widget: AppTextFormField(
                isObscureText: isObscureTextConfirm,
                controller: confirmPasswordController,
                hintText: '**************',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Confirm Password';
                  } else if (value.isNotEmpty &&
                      confirmPasswordController.text !=
                          passwordController.text) {
                    return 'Please enter conferm password not same password';
                  }
                },
                prefixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscureTextConfirm = !isObscureTextConfirm;
                    });
                  },
                  child: Icon(
                    isObscureTextConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
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
                hasMinLength: hasMinLength,
              ),
            ),
            Visibility(
              visible: isVisiblePasswordValidator,
              child: verticalSpace(20),
            ),
          ],
        ));
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
