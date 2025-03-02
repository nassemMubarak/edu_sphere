import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import '../theming/styles.dart';
import '../theming/colors.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasLowerCase;
  final bool hasUpperCase;
  final bool hasSpecialCharacters;
  final bool hasNumber;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasLowerCase,
    required this.hasUpperCase,
    required this.hasSpecialCharacters,
    required this.hasNumber,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow(AppLocalizations.of(context)!.atLeastOneLowerCase, hasLowerCase),
        verticalSpace(2),
        buildValidationRow(AppLocalizations.of(context)!.atLeastOneUpperCase, hasUpperCase),
        verticalSpace(2),
        buildValidationRow(AppLocalizations.of(context)!.atLeastOneSpecialCharacter, hasSpecialCharacters),
        verticalSpace(2),
        buildValidationRow(AppLocalizations.of(context)!.atLeastOneNumber, hasNumber),
        verticalSpace(2),
        buildValidationRow(AppLocalizations.of(context)!.atLeastEightCharacters, hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        const CircleAvatar(
          radius: 2.5,
          backgroundColor: ColorsManager.gray,
        ),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13DarkBlue400Weight.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? ColorsManager.gray : ColorsManager.darkBlue,
          ),
        )
      ],
    );
  }
}