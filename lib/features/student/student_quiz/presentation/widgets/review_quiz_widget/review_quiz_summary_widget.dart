import 'dart:core';

import 'package:edu_sphere/core/theming/styles.dart';
import 'package:edu_sphere/features/student/student_quiz/presentation/bloc/student_quiz_cubit.dart';
import 'package:edu_sphere/features/teacher/teacher_main/presentation/widgets/section_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ReviewQuizSummaryWidget extends StatelessWidget {
  DateTime createdDateTime;
  DateTime updatedDateTime;
  Duration difference;
  int differenceInMinutes;
  int differenceInHours;
  String quizMark;
  ReviewQuizSummaryWidget({
    super.key,
    required this.createdDateTime,
    required this.updatedDateTime,
    required this.difference,
    required this.differenceInMinutes,
    required this.differenceInHours,
    required this.quizMark,
  });

  @override
  Widget build(BuildContext context) {
    var quizEstimate = context.read<StudentQuizCubit>().estimateStudentQuiz!;

    return SectionCard(
      title: 'Summary',
      icon: 'assets/svgs/summary.svg',
      widget: Column(
        children: [
          _buildListTile(
            title: 'Quiz mark',
            subTitle:
                '${quizEstimate.quizAttempts.first.grade!.result}/$quizMark',
            svgUrl: 'assets/svgs/quiz_score_icon.svg',
          ),
          _buildListTile(
            title: 'Quiz entry time',
            subTitle: DateFormat.jm().format(createdDateTime),
            svgUrl: 'assets/svgs/quiz_time.svg',
          ),
          _buildListTile(
            title: 'Quiz entry time',
            subTitle: DateFormat.jm().format(updatedDateTime),
            svgUrl: 'assets/svgs/quiz_time.svg',
          ),
          _buildListTile(
            title: 'Time it takes to solve quiz',
            subTitle:
                '${differenceInHours == 0 ? '' : "$differenceInHours hours - "}$differenceInMinutes minute',
            svgUrl: 'assets/svgs/quiz_time.svg',
          ),
        ],
      ),
    );
  }

  ListTile _buildListTile(
      {required String title,
      required String subTitle,
      required String svgUrl}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: SvgPicture.asset(svgUrl),
      title: Text(title, style: TextStyles.font14Black400Weight),
      trailing: Text(
        subTitle,
        style: TextStyles.font12Black400Weight,
      ),
    );
  }
}
