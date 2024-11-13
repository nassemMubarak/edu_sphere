import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/signup/ui/widget/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
            label: AppLocalizations.of(context)!.universityMajor,
            widget: AppTextFormField(
              textInputType: TextInputType.number,
              controller: universityMajorTextEditingController,
              hintText: AppLocalizations.of(context)!.universityMajor,
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
            label: AppLocalizations.of(context)!.age,
            widget: AppTextFormField(
              textInputType: TextInputType.number,
              controller: ageTextEditingController,
              hintText: AppLocalizations.of(context)!.theAge,
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
            label: AppLocalizations.of(context)!.typeOfTeaching,
            widget: DropdownWidget(
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
              hintText: AppLocalizations.of(context)!.especiallyTeacher,
              prefixIcon: SvgPicture.asset('assets/svgs/type_of_teaching.svg'),

            ),
          ),
          Visibility(
            visible: isSelectedCamp,
            child: LabelAndWidget(
              label: AppLocalizations.of(context)!.camp,
              widget: DropdownWidget(
                hintText: AppLocalizations.of(context)!.campName,
                items: campName,
                prefixIcon: SvgPicture.asset('assets/svgs/camp.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
