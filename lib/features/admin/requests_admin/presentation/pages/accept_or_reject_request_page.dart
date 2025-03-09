import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/admin/requests_admin/data/model/request_model.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/bloc/request_admin_cubit.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/widgets/accept_request_info_dialog.dart';
import 'package:edu_sphere/features/admin/requests_admin/presentation/widgets/reject_request_info_dialog.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AcceptOrRejectRequestPage extends StatelessWidget {
  const AcceptOrRejectRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    RequestModel requestModel =
        context.read<RequestAdminCubit>().requestModelSelected!;
    bool isTeacher = requestModel.data.model.contains('Teacher');
    return SliverWidget(
      leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back)),
      widget: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            BreadCrumbWidget(
              items: [
                isTeacher ? 'Teacher Request' : 'Student Request',
                requestModel.requestable.name
              ],
            ),
            verticalSpace(24),
            SectionCard(
              title: isTeacher ? 'Teacher Information' : 'Student Information',
              icon: 'assets/svgs/your_information_icon.svg',
              widget: Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/person_icon_outline.svg',
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(requestModel.requestable.name),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/email_icon.svg',
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(requestModel.requestable.email),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/mail_icon.svg',
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(requestModel.requestable.sex),
                  ),
                  if (isTeacher)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svgs/university_teacher.svg',
                        color: ColorsManager.mainBlue,
                      ),
                      title: Text(requestModel.requestable.specialization!),
                    ),
                  if (!isTeacher)
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: SvgPicture.asset(
                        'assets/svgs/educational.svg',
                        color: ColorsManager.mainBlue,
                      ),
                      title: Text('level ${requestModel.requestable.level}'),
                    ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: SvgPicture.asset(
                      'assets/svgs/quiz_score_icon.svg',
                      color: ColorsManager.mainBlue,
                    ),
                    title: Text(requestModel.requestable.age.toString()),
                  ),
                ],
              ),
            ),
            verticalSpace(24),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(buttonText: 'Accept Request',
                  onPressed: (){
                    showDialog(context: context, builder: (context) => AcceptRequestInfoDialog(requestModel: requestModel),);
                  },
                  ),
                ),
                horizontalSpace(16),
                Expanded(
                  child: AppTextButton(buttonText: 'Reject',backgroundColor: Colors.white,textStyle: TextStyles.font16Black500Weight,
                    onPressed: (){
                      showDialog(context: context, builder: (context) => RejectRequestInfoDialog(requestModel: requestModel),);
                    },),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
