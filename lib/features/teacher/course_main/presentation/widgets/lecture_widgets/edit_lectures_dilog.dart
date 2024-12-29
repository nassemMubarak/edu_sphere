import 'package:edu_sphere/core/helpers/app_regex.dart';
import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/core/widgets/app_text_button.dart';
import 'package:edu_sphere/core/widgets/app_text_form_field.dart';
import 'package:edu_sphere/core/widgets/label_and_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_lecture/course_lecture_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/add_or_update_or_delete_lecture_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditLecturesDilog extends StatelessWidget {
  int index;
  int indexLecture;
  int idLecture;
  int idCourse;
  EditLecturesDilog({super.key, required this.index,required this.idLecture,required this.indexLecture,required this.idCourse});

  @override
  Widget build(BuildContext context) {
    context.read<CourseLectureCubit>().lectureLinkTextEditionController =
        TextEditingController(
      text: context.read<CourseLectureCubit>().lectureList[index].link,
    );
    context.read<CourseLectureCubit>().lectureDescriptionTextEditionController =
        TextEditingController(
      text: context.read<CourseLectureCubit>().lectureList[index].description,
    );
    context.read<CourseLectureCubit>().lectureTitleTextEditionController =
        TextEditingController(
      text: context.read<CourseLectureCubit>().lectureList[index].title,
    );
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      insetPadding: EdgeInsets.all(16),
      backgroundColor: Colors.white,
      scrollable: true,
      title: Text(
        'Edit Lecture',
        style: TextStyles.font16Black600Weight,
        textAlign: TextAlign.center,
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Form(
            key: context.read<CourseMainCubit>().globalLectureKey,
            child: Column(
              children: [
                LabelAndWidget(
                  label: 'Lecture Title',
                  widget: AppTextFormField(
                    controller: context
                        .read<CourseLectureCubit>()
                        .lectureTitleTextEditionController,
                    textStyle: TextStyles.font12Black700Weight,
                    hintText: 'Lecture title',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter Lecture Title';
                      }
                    },
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(15),
                      child: SvgPicture.asset(
                        'assets/svgs/video_icon.svg',
                        color: ColorsManager.neutralGray,
                        width: 25,
                        height: 25,
                      ),
                    ),
                  ),
                ),
                LabelAndWidget(
                  label: 'Lecture Link Youtube',
                  widget: AppTextFormField(
                    textInputType: TextInputType.url,
                    controller: context
                        .read<CourseLectureCubit>()
                        .lectureLinkTextEditionController,
                    textStyle: TextStyles.font14MainBlue400Weight,
                    hintText: 'Lecture link youtube',
                    validator: (value) {
                      if (value!.isEmpty||!AppRegex.isYouTubeUrl(value)) {
                        return 'Please enter a valid link. The link must be a proper and functional URL.';
                      }
                    },
                    prefixIcon: Icon(
                      Icons.link,
                      size: 24,
                      color: ColorsManager.neutralGray,
                    ),
                  ),
                ),
                AddOrUpdateOrDeleteLectureLoading(message: 'The Lecture has been updated successfully.',),

                LabelAndWidget(
                  label: 'Lecture Description',
                  widget: AppTextFormField(
                    controller: context
                        .read<CourseLectureCubit>()
                        .lectureDescriptionTextEditionController,
                    textStyle: TextStyles.font12Black700Weight,
                    maxLines: 5,
                    hintText: 'Lecture description',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter lecture description';
                      }
                    },
                    prefixIcon: Container(
                      height: 100,
                      width: 50,
                      alignment: AlignmentDirectional.topCenter,
                      child: Icon(
                        Icons.message_outlined,
                        size: 25,
                        color: ColorsManager.neutralGray,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpace(24),
          Row(
            children: [
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                     if (context
                        .read<CourseMainCubit>()
                        .globalLectureKey
                        .currentState!
                        .validate()) {
                      context.read<CourseLectureCubit>().emitUpdateLecture(idCourse: idCourse, idLecture: idLecture, indexLecture: indexLecture);
                    }
                    
                  },
                  buttonText: 'Save',
                  buttonWidth: 147,
                ),
              ),
              horizontalSpace(16),
              Expanded(
                child: AppTextButton(
                  onPressed: () {
                    context.pop();
                    context
                            .read<CourseMainCubit>()
                            .lectureLinkTextEditionController =
                        TextEditingController();
                    context
                            .read<CourseMainCubit>()
                            .lectureDescriptionTextEditionController =
                        TextEditingController();
                    context
                            .read<CourseMainCubit>()
                            .lectureTitleTextEditionController =
                        TextEditingController();
                  },
                  buttonText: 'Cancel',
                  buttonWidth: 147,
                  backgroundColor: Colors.white,
                  textStyle: TextStyles.font14Black600Weight,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
