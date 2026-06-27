import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ReadMoreTextWidget extends StatefulWidget {
  final String text;
  final int trimLines;
  final TextStyle textStyle;
  final TextStyle actionTextStyle;

  const ReadMoreTextWidget({
    super.key,
    required this.text,
    this.trimLines = 2, // Matches the 2-line standard layout from the mockup
    required this.textStyle,
    this.actionTextStyle = const TextStyle(
      fontSize: 12,
      color: Color(0xFF0F2D5C), // Navy bold actionable hyperlink text color
      fontWeight: FontWeight.bold,
    ),
  });

  @override
  State<ReadMoreTextWidget> createState() => _ReadMoreTextWidgetState();
}

class _ReadMoreTextWidgetState extends State<ReadMoreTextWidget> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    // 1. Set up text triggers matching your layout design precisely
    final String linkText = _isExpanded ? ' Show less' : 'Read more';
    final String collapseEllipsis = _isExpanded ? '' : '.....';

    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;

        // 2. Use TextPainter to calculate if text physically overflows the layout constraints
        final TextSpan textSpan = TextSpan(
          text: widget.text,
          style: widget.textStyle,
        );
        final TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          maxLines: widget.trimLines,
        )..layout(maxWidth: maxWidth);

        // If the text fits completely within the line limit, render it simply without actions
        if (!textPainter.didExceedMaxLines) {
          return Text(widget.text, style: widget.textStyle);
        }

        // 3. Find the exact character index position to truncate the string cleanly
        final int position = textPainter
            .getPositionForOffset(Offset(maxWidth, textPainter.height))
            .offset;

        // Calculate a safe substring length leaving enough room for our custom ellipsis + action link text
        final int endPosition =
            (position - (linkText.length + collapseEllipsis.length + 4)).clamp(
              0,
              widget.text.length,
            );

        final String adjustedText = _isExpanded
            ? widget.text
            : widget.text.substring(0, endPosition).trim();

        return Text.rich(
          TextSpan(
            children: [
              TextSpan(text: adjustedText, style: widget.textStyle),
              if (!_isExpanded)
                TextSpan(text: collapseEllipsis, style: widget.textStyle),
              TextSpan(
                text: linkText,
                style: widget.actionTextStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
              ),
            ],
          ),
        );
      },
    );
  }
}
