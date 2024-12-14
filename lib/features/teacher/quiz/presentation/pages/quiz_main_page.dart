import 'package:edu_sphere/core/helpers/extenshions.dart';
import 'package:edu_sphere/core/widgets/sliver_widget.dart';
import 'package:flutter/material.dart';
class QuizMainPage extends StatelessWidget {
  const QuizMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverWidget(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: Icon(Icons.arrow_back)),
        widget: Container(),
    );
  }
}
