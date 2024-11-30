import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/password_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class EmailAndPasswordWidget extends StatefulWidget {
  const EmailAndPasswordWidget({super.key});

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  final formKey = GlobalKey<FormState>();
  bool isVisiblePasswordValidator = false;
  bool hasLowercase = false;

  bool hasUppercase = false;

  bool hasSpecialCharacters = false;

  bool hasNumber = false;

  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    emailController = TextEditingController();
    setupPasswordControllerListener();
  }

  late TextEditingController passwordController;
  late TextEditingController emailController;
  bool isObscureText = true;

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            LabelAndWidget(
              label: AppLocalizations.of(context)!.email,
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
              label: AppLocalizations.of(context)!.password,
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
