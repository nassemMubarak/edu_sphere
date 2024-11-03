import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/signup/ui/widget/dropdown_button_hide_underline_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpFormTeacher extends StatefulWidget {
  const SignUpFormTeacher({super.key});

  @override
  State<SignUpFormTeacher> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<SignUpFormTeacher> {
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
  List<String> especiallyTeacher = ['Especially teacher', 'Camp teacher'];
  bool isSelectedCamp = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          LabelAndWidget(
            label: 'University Major',
            widget: AppTextFormField(
              textInputType: TextInputType.number,
              controller: universityMajorTextEditingController,
              hintText: 'University Major ',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid university major';
                }
              },
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset(
                  'assets/svgs/university_teacher.svg',
                ),
              ),
            ),
          ),
          LabelAndWidget(
            label: 'Age',
            widget: AppTextFormField(
              textInputType: TextInputType.number,
              controller: ageTextEditingController,
              hintText: 'the age',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a valid age';
                }
              },
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset('assets/svgs/circular-word-age.svg'),
              ),
            ),
          ),
          LabelAndWidget(
            label: 'Type Of Teaching',
            widget: DropdownButtonHideUnderlineWidget(
              onChanged: (value) {
                setState(() {
                  if (value == 'Camp teacher') {
                    isSelectedCamp = true;
                  } else {
                    isSelectedCamp = false  ;
                  }
                });
              },
              items: especiallyTeacher,
              hintText: 'Especially teacher',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SvgPicture.asset('assets/svgs/type_of_teaching.svg'),
              ),
              suffixIcon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24,
                color: ColorsManager.neutralGray,
              ),
            ),
          ),
          Visibility(
            visible: isSelectedCamp,
            child: LabelAndWidget(
              label: 'Camp',
              widget: DropdownButtonHideUnderlineWidget(
                hintText: 'Camp Name',
                items: campName,
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
          ),
        ],
      ),
    );
  }
}
