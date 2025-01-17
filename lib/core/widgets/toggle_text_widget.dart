import 'package:edu_sphere/core/helpers/spacing.dart';
import 'package:edu_sphere/core/theming/styles.dart';
import 'package:flutter/material.dart';

class ToggleText extends StatefulWidget {
  final String text;

  ToggleText({required this.text});

  @override
  _ToggleTextState createState() => _ToggleTextState();
}

class _ToggleTextState extends State<ToggleText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isExpanded = !_isExpanded;
        });
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
           widget.text,
            maxLines: _isExpanded ? null : 2,
            overflow: _isExpanded ? null : TextOverflow.fade,
            style: TextStyles.font12Black400Weight,
          ),
          verticalSpace(5),
          // Only show the toggle text if the text exceeds 2 lines
          Visibility(
            visible:_isTextTooLong(widget.text),
            child: Text(
              _isExpanded ? 'Show less' : 'Show more... ',
              style: TextStyles.font10Blue400Weight,
            ),
          ),
        ],
      ),
    );
  }
  // Function to check if the text exceeds 2 lines
  bool _isTextTooLong(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 12, color: Colors.black), // Same style as above
      ),
      maxLines: 2,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);
    // Assuming 12 is the height of each line (adjust as necessary)
    return textPainter.height > (15); // Return true if text height exceeds that of 2 lines
  }
}

