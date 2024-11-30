import 'package:edu_sphere/core/widgets/image_and_text_empty_data.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/quize/add_quize_dilog.dart';
import 'package:edu_sphere/features/teacher/course_main/presentation/widgets/section_card.dart';
import 'package:flutter/material.dart';

class QuizeWidget extends StatelessWidget {
  const QuizeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SectionCard(
      title: 'Quize',
      icon: 'assets/svgs/video_lecture_icon.svg',
      infoDialog: const AddQuizeDilog(),
      widget: const ImageAndTextEmptyData(
        message: 'You have not added any quizzes yet.',
      ),
    );
  }
}
