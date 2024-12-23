import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/dropdown_widget.dart';
import 'package:edu_sphere/features/auth/domain/entities/camp.dart';
import 'package:edu_sphere/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SignUpFormEducationalAndCampStudent extends StatefulWidget {
  const SignUpFormEducationalAndCampStudent({super.key});

  @override
  State<SignUpFormEducationalAndCampStudent> createState() =>
      _SignUpFormEducationalAndCampStudentState();
}

class _SignUpFormEducationalAndCampStudentState
    extends State<SignUpFormEducationalAndCampStudent> {
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();

  }

  List<Camp> campName = [];
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
      key: context.read<AuthCubit>().globalKeyStudentScreen,
      child: Column(
        children: [
          LabelAndWidget(
            label: AppLocalizations.of(context)!.lastEducationalStage,
            widget: DropdownWidget(
              onChanged: (value) {
                if (value != null) {
                  context.read<AuthCubit>().studentEducationStage = value;
                }
              },
              items: stageEducational,
              hintText: AppLocalizations.of(context)!.lastEducationalStage,
              prefixIcon: SvgPicture.asset('assets/svgs/educational.svg'),
            ),
          ),
          LabelAndWidget(
            label: AppLocalizations.of(context)!.age,
            widget: AppTextFormField(
              textInputType: TextInputType.number,
              controller:
                  context.read<AuthCubit>().ageStudentTextEditingController,
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
            buildWhen: (previous, current) => current is GetAllCampsLoadedState ,
            builder: (context, state) {
              if (state is GetAllCampsLoadedState) {
                Logger().e(state.camp);
                return LabelAndWidget(
                  label: AppLocalizations.of(context)!.camp,
                  widget: DropdownWidget(
                    onChanged: (value) {
                      if (value != null) {
                        for (var camp in state.camp) {
                          if(camp.name==value)
                            context.read<AuthCubit>().campStudentId = camp.name==value?camp.id.toString():'';
                        }

                      }
                    },
                    items: state.camp.map((e) => e.name).toList(),
                    hintText: AppLocalizations.of(context)!.campName,
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
                          context.read<AuthCubit>().campStudentId = value;
                        }
                      },

                      items: [],
                      hintText: AppLocalizations.of(context)!.campName,
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
