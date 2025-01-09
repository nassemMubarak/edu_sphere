import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/colors.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';

class ShowStudentQuizWidget extends StatelessWidget {
  const ShowStudentQuizWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 4,
                color: ColorsManager.shadowColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(
                  number: '1',
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(24),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 4,
                color: ColorsManager.shadowColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(
                  number: '1',
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(24),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 4,
                color: ColorsManager.shadowColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(
                  number: '1',
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(24),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 4,
                color: ColorsManager.shadowColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(
                  number: '1',
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(24),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
              ],
            ),
          ),
        ),
        verticalSpace(24),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 4,
                color: ColorsManager.shadowColor.withOpacity(0.3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildQuestionRow(
                  number: '1',
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                  isFirstRow: true,
                ),
                verticalSpace(24),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: true,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
                verticalSpace(16),
                _buildQuestionRow(
                  text:
                  'Lorem ipsum dolor sit amet, Loreb ipsum dolor sit amet, cons ecte tur co nsec tetu?',
                  isSelected: false,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildQuestionRow({
    String? number,
    required String text,
    required bool isSelected,
    bool isFirstRow = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: isFirstRow
              ? CircleAvatar(
            radius: 12,
            backgroundColor: ColorsManager.mainBlue,
            child: Text(
              number ?? '',
              style: TextStyles.font15White500Weight,
            ),
          )
              : Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.blue, width: 2),
              shape: BoxShape.circle,
            ),
            child: CircleAvatar(
              radius: 8,
              backgroundColor:
              isSelected ? ColorsManager.mainBlue : Colors.transparent,
            ),
          ),
        ),
        horizontalSpace(8),
        Expanded(
          child: Text(
            text,
            style: isFirstRow
                ? TextStyles.font14Black500Weight
                : TextStyles.font14Black400Weight,
          ),
        ),
      ],
    );
  }
}
