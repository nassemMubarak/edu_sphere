import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/bread_crumb_widget.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_advertisement/course_advertisement_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/add_advertisements_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/advertisements_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/assessments_widgets/assessment_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/chapters_widgets/chapters_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/lectures_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quiz_widgets/quiz_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/edit_course_info_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseMainScreen extends StatelessWidget {
  const CourseMainScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final coursesModel = context
        .read<CourseMainCubit>()
        .coursesModel;

    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      body: SliverWidget(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back)),
        widget: BlocBuilder<CourseMainCubit,CourseMainState>(
          builder: (context, state) {
            if(state is EditCourseDescription){
              return Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(15),
                      BreadCrumbWidget(
                        items: ['Home', coursesModel.title],
                      ),
                      verticalSpace(24),
                      SectionCard(
                        onTapEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditCourseInfoDialog(
                              isShowTitleEdit: false,
                              indexCourse:context
                                  .read<CourseMainCubit>()
                                  .indexCourseInList,
                              coursesModel: coursesModel,
                            ),
                          );
                        },
                        showAddButton: false,
                        title: state.coursesModel.title,
                        icon: 'assets/svgs/message_icon.svg',
                        infoDialog: AddAdvertisementsInfoDialog(idCourse: coursesModel.id,),
                        widget: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            state.coursesModel.description,
                          ),
                        ),
                      ),
                      verticalSpace(24),
                      AdvertisementsWidget(idCourse: coursesModel.id),
                      verticalSpace(24),
                      LecturesWidget(idCourse: coursesModel.id),
                      verticalSpace(24),
                      QuizeWidget(),
                      verticalSpace(24),
                      SectionCard(
                        title: 'Assessment',
                        icon: 'assets/svgs/annual_assessment_icon.svg',
                        infoDialog: AddAdvertisementsInfoDialog(idCourse: coursesModel.id),
                        widget:  ImageAndTextEmptyData(
                          message: 'You have not added any Assessment yet.',
                        ),
                      ),
                      verticalSpace(24),
                    ],
                  ),
                ),
              );
            }else{
             return Container(
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      verticalSpace(15),
                      BreadCrumbWidget(
                        items: ['Home', coursesModel.title],
                      ),
                      verticalSpace(24),
                      SectionCard(
                        onTapEdit: () {
                          showDialog(
                            context: context,
                            builder: (context) => EditCourseInfoDialog(
                              isShowTitleEdit: false,
                              indexCourse:context
                                  .read<CourseMainCubit>()
                                  .indexCourseInList,
                              coursesModel: coursesModel,
                            ),
                          );
                        },
                        showAddButton: false,
                        title: coursesModel.title,
                        icon: 'assets/svgs/message_icon.svg',
                        infoDialog: AddAdvertisementsInfoDialog(idCourse: coursesModel.id,),
                        widget: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            coursesModel.description,
                          ),
                        ),
                      ),
                      verticalSpace(24),
                      AdvertisementsWidget(idCourse: coursesModel.id,),
                      verticalSpace(24),
                      LecturesWidget(idCourse: coursesModel.id),
                      verticalSpace(24),
                      ChaptersWidget(),
                      verticalSpace(24),
                      QuizeWidget(),
                      verticalSpace(24),
                      AssessmentWidget(),
                      verticalSpace(24),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
