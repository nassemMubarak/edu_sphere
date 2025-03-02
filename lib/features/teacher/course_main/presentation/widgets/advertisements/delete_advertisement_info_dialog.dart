import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/util/toast_notification_message.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:edu_sphere/l10n/app_localizations.dart';

class DeleteAdvertisementInfoDialog extends StatelessWidget {
  int indexAdvertisement;
  int idAdvertisement;
  int idCourse;

  DeleteAdvertisementInfoDialog(
      {super.key,
      required this.indexAdvertisement,
      required this.idAdvertisement,
      required this.idCourse});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(8),
          ),
        ),
        insetPadding: EdgeInsets.all(16),
        backgroundColor: Colors.white,
        scrollable: true,
        title: Text(
          'Delete Advertisements',
          style: TextStyles.font16Black600Weight,
          textAlign: TextAlign.center,
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            verticalSpace(24),
            Text(
              'Do you really want to delete the ads ?',
              style: TextStyles.font14Red600Weight,
              textAlign: TextAlign.center,
            ),
            verticalSpace(24),
            Row(
              children: [
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context
                          .read<CourseAdvertisementCubit>()
                          .emitDeleteAdvertisement(
                              idCourse: idCourse,
                              idAdvertisement: idAdvertisement,
                              indexAdvertisement: indexAdvertisement);
                    },
                    buttonText: 'Delete Ads',
                    buttonWidth: 147,
                  ),
                ),
                horizontalSpace(16),
                BlocConsumer<CourseAdvertisementCubit,
                        CourseAdvertisementState>(
                    builder: (context, state) => SizedBox.shrink(),
                    listener: (context, state) {
                      if (state is AddOrUpdateOrDeleteLoadingState) {
                        context.loading();
                      } else if (state is AdvertisementMessageErrorState) {
                        ToastNotificationMessage().showToastNotificationError(
                            message: state.message, context: context);
                        context.pop();
                      } else if (state is GetAllAdvertisementLoadedState) {
                        ToastNotificationMessage().showNotificationSuccess(
                            message: 'The advertisement has been successfully deleted.', context: context);
                        context.pop();
                        context.pop();
                      }
                    }),
                Expanded(
                  child: AppTextButton(
                    onPressed: () {
                      context.pop();
                    },
                    buttonText: AppLocalizations.of(context)!.cancel,
                    buttonWidth: 147,
                    backgroundColor: Colors.white,
                    textStyle: TextStyles.font14Black600Weight,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
