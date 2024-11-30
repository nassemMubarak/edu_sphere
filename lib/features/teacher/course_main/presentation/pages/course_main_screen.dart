import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/core/widgets/wave_top_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/bloc/course_main_cubit.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/add_advertisements_info_dialog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/advertisements/advertisements_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/lecture_widgets/lectures_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quize/quize_widget.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CourseMainScreen extends StatelessWidget {
  const CourseMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // elevation: 0,
        forceMaterialTransparency: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          const WaveTopWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(top: 200.h, left: 16.w, right: 16.w),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AdvertisementsWidget(),
                    verticalSpace(24),
                    LecturesWidget(),
                   
                    verticalSpace(24),
                    QuizeWidget(),
                    verticalSpace(24),
                    SectionCard(
                      title: 'Assessment',
                      icon: 'assets/svgs/annual_assessment_icon.svg',
                      infoDialog: AddAdvertisementsInfoDialog(),

                      widget: const ImageAndTextEmptyData(
                        message: 'You have not added any Assessment yet.',
                      ),
                    ),
                    verticalSpace(24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
