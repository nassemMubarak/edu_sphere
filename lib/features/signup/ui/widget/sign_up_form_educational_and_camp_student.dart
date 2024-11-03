import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/features/signup/ui/widget/dropdown_button_hide_underline_widget.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
            label: 'last educational stage completed',
            widget: DropdownButtonHideUnderlineWidget(
              items: stageEducational,
              hintText: 'last educational stage completed',
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
            label: 'Camp',
            widget: DropdownButtonHideUnderlineWidget(
              items: campName,
              hintText: 'Camp Name',
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
