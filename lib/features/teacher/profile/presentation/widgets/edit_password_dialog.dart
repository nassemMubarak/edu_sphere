import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/password_validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
class EditPasswordDialog extends StatefulWidget {
  EditPasswordDialog({super.key});

  @override
  State<EditPasswordDialog> createState() => _EditPasswordDialogState();
}

class _EditPasswordDialogState extends State<EditPasswordDialog> {
  TextEditingController oldPasswordTextEditingController = TextEditingController();
  TextEditingController newPasswordTextEditingController = TextEditingController();
  TextEditingController confirmPewPasswordTextEditingController = TextEditingController();
  bool isVisiblePasswordValidator = false;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool isObscureText = true;
  bool isNewObscureText = true;
  bool isObscureTextConfirm = true;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    setupPasswordControllerListener();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Reset Password',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(24),
            LabelAndWidget(
              label: AppLocalizations.of(context)!.password,
              widget: AppTextFormField(
                isObscureText: isObscureText,
                controller: oldPasswordTextEditingController,
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
              label: AppLocalizations.of(context)!.password,
              widget: AppTextFormField(
                isObscureText: isNewObscureText,
                controller: newPasswordTextEditingController,
                hintText: '**************',
                validator: (value) {
                  if (value == null || value.isEmpty|| !AppRegex.isPasswordValid(value)) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid Password';
                    }
                  }
                },
                prefixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      isNewObscureText = !isNewObscureText;
                    });
                  },
                  child: Icon(
                    isNewObscureText ? Icons.visibility_off : Icons.visibility,
                    color: ColorsManager.neutralGray,
                  ),
                ),
              ),
            ),
            LabelAndWidget(
              label: AppLocalizations.of(context)!.confirmPassword,
              widget: AppTextFormField(
                isObscureText: isObscureTextConfirm,
                controller: confirmPewPasswordTextEditingController,
                hintText: '**************',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Confirm Password';
                  } else if (value.isNotEmpty &&
                      newPasswordTextEditingController.text !=
                          confirmPewPasswordTextEditingController.text) {
                    return 'Please enter confirm password not same password';
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
            verticalSpace(24),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      if(formKey.currentState!.validate()){

                      }
                      // context.pop();
                    },
                    buttonText: 'Edit',
                    textStyle: TextStyles.font12White400Weight,
                    buttonWidth: 160,
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.pop();
                    },
                    buttonText: AppLocalizations.of(context)!.cancel,
                    buttonWidth: 147,
                    backgroundColor: Colors.white,
                    textStyle: TextStyles.font12Black500Weight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  void setupPasswordControllerListener() {
    newPasswordTextEditingController.addListener(() {
      setState(() {
        isVisiblePasswordValidator = true;
      });
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(newPasswordTextEditingController.text);
        hasUppercase = AppRegex.hasUpperCase(newPasswordTextEditingController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(newPasswordTextEditingController.text);
        hasNumber = AppRegex.hasNumber(newPasswordTextEditingController.text);
        hasMinLength = AppRegex.hasMinLength(newPasswordTextEditingController.text);
      });
    });
  }

}
