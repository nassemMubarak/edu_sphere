import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/features/signup/ui/widget/dropdown_button_hide_underline_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class SignUpFormEducationalAndCampStudent extends StatefulWidget {
  const SignUpFormEducationalAndCampStudent({super.key});

  @override
  State<SignUpFormEducationalAndCampStudent> createState() =>
      _SignUpFormEducationalAndCampStudentState();
}

class _SignUpFormEducationalAndCampStudentState
    extends State<SignUpFormEducationalAndCampStudent> {
  final formKey = GlobalKey<FormState>();

  bool hasMinLength = false;
  late TextEditingController universityMajorTextEditingController;
  late TextEditingController ageTextEditingController;
  late TextEditingController typeOfTeachingTextEditingController;

  @override
  void initState() {
    super.initState();
    universityMajorTextEditingController = TextEditingController();
    ageTextEditingController = TextEditingController();
    typeOfTeachingTextEditingController = TextEditingController();
  }

  List<String> campName = [
    'Nassem',
    'Ahmed',
    'Foad',
  ];
  List<String> stageEducational = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndWidget(
            label: AppLocalizations.of(context)!.lastEducationalStage,
            widget: DropdownButtonHideUnderlineWidget(
              onChanged: (value){

              },
              items: stageEducational,
              hintText: AppLocalizations.of(context)!.lastEducationalStage,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset('assets/svgs/educational.svg'),
              ),
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24,
                color: ColorsManager.neutralGray,
              ),
            ),
          ),
          LabelAndWidget(
            label: AppLocalizations.of(context)!.camp,
            widget: DropdownButtonHideUnderlineWidget(
              onChanged: (value){

              },
              items: campName,
              hintText: AppLocalizations.of(context)!.campName,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset('assets/svgs/camp.svg'),
              ),
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24,
                color: ColorsManager.neutralGray,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
