import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/password_validations.dart';
import 'package:edu_sphere/edu_sphere_app.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class SignUpFormStudent extends StatefulWidget {
  bool? labelCamp;
  SignUpFormStudent({super.key, this.labelCamp});

  @override
  State<SignUpFormStudent> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<SignUpFormStudent> {
  bool isVisiblePasswordValidator = false;
  bool hasLowercase = false;
  bool hasUppercase = false;
  bool hasSpecialCharacters = false;
  bool hasNumber = false;
  bool hasMinLength = false;
  bool isObscureText = true;
  bool isObscureTextConfirm = true;
  @override
  void initState() {
    super.initState();
    setupPasswordControllerListener();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: context.read<AuthCubit>().globalKeyRegisterScreen,
        child: Column(
          children: [
            LabelAndWidget(
              label: widget.labelCamp != null ? AppLocalizations.of(context)!.campName : AppLocalizations.of(context)!.userName,
              widget: AppTextFormField(
                controller: context.read<AuthCubit>().nameController,
                hintText: AppLocalizations.of(context)!.fullName,
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
              label: AppLocalizations.of(context)!.email,
              widget: AppTextFormField(
                controller: context.read<AuthCubit>().emailRegisterController,
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
                controller: context.read<AuthCubit>().passwordRegisterController,
                hintText: '**************',
                validator: (value) {
                  // if (value == null || value.isEmpty|| !AppRegex.isPasswordValid(value)) {
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
              label: AppLocalizations.of(context)!.confirmPassword,
              widget: AppTextFormField(
                isObscureText: isObscureTextConfirm,
                controller: context.read<AuthCubit>().confirmPasswordController,
                hintText: '**************',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid Confirm Password';
                  } else if (value.isNotEmpty &&
                      context.read<AuthCubit>().confirmPasswordController.text !=
                          context.read<AuthCubit>().passwordRegisterController.text) {
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
            Visibility(
              visible: isVisiblePasswordValidator,
              child: verticalSpace(20),
            ),
          ],
        ));
  }

  void setupPasswordControllerListener() {
    context.read<AuthCubit>().passwordRegisterController.addListener(() {
      setState(() {
        isVisiblePasswordValidator = true;
      });
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(context.read<AuthCubit>().passwordRegisterController.text);
        hasUppercase = AppRegex.hasUpperCase(context.read<AuthCubit>().passwordRegisterController.text);
        hasSpecialCharacters =
            AppRegex.hasSpecialCharacter(context.read<AuthCubit>().passwordRegisterController.text);
        hasNumber = AppRegex.hasNumber(context.read<AuthCubit>().passwordRegisterController.text);
        hasMinLength = AppRegex.hasMinLength(context.read<AuthCubit>().passwordRegisterController.text);
      });
    });
  }
}
