import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SignUpFormTeacher extends StatefulWidget {
  const SignUpFormTeacher({super.key});

  @override
  State<SignUpFormTeacher> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<SignUpFormTeacher> {
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
  }

  List<String> especiallyTeacher = ['Especially teacher', 'Camp teacher'];
  bool isSelectedCamp = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<AuthCubit>().globalKeyTeacherScreen,
      child: Column(
        children: [
          LabelAndWidget(
            label: AppLocalizations.of(context)!.universityMajor,
            widget: AppTextFormField(
              textInputType: TextInputType.text,
              controller: context.read<AuthCubit>().teacherUniversityMajor,
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
              controller:
                  context.read<AuthCubit>().ageTeacherTextEditingController,
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
          BlocBuilder<AuthCubit, AuthState>(
            buildWhen: (previous, current) => current is GetAllCampsLoadedState,
            builder: (context, state) {
              if(state is GetAllCampsLoadedState){
                return LabelAndWidget(
                  label: AppLocalizations.of(context)!.camp,
                  widget: DropdownWidget(
                    onChanged: (value) {
                      if (value != null) {
                        for (var camp in state.camp) {
                          if(camp.name==value)
                          context.read<AuthCubit>().campTeacherId = camp.name==value?camp.id.toString():'';
                        }
                      }
                    },
                    hintText: AppLocalizations.of(context)!.campName,
                    items: state.camp.map((camp)=>camp.name).toList(),
                    prefixIcon: SvgPicture.asset('assets/svgs/camp.svg'),
                  ),
                );
              }else{
                return GestureDetector(
                  onTap: (){
                    context.read<AuthCubit>().emitGetAllCamp();
                  },
                  child: LabelAndWidget(
                    label: AppLocalizations.of(context)!.camp,
                    widget: DropdownWidget(
                      onChanged: (value) {
                        if (value != null) {
                          context.read<AuthCubit>().campTeacherId = value;
                        }
                      },
                      hintText: AppLocalizations.of(context)!.campName,
                      items: [],
                      prefixIcon: SvgPicture.asset('assets/svgs/camp.svg'),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
