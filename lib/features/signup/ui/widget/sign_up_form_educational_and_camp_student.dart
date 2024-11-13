import 'package:edu_sphere/features/signup/ui/widget/dropdown_widget.dart';
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
            widget: DropdownWidget(
              onChanged: (value){

              },
              items: stageEducational,
              hintText: AppLocalizations.of(context)!.lastEducationalStage,
              prefixIcon: SvgPicture.asset('assets/svgs/educational.svg'),

            ),
          ),
          LabelAndWidget(
            label: AppLocalizations.of(context)!.camp,
            widget: DropdownWidget(
              onChanged: (value){

              },
              items: campName,
              hintText: AppLocalizations.of(context)!.campName,
              prefixIcon: SvgPicture.asset('assets/svgs/camp.svg'),

            ),
          ),
        ],
      ),
    );
  }
}
