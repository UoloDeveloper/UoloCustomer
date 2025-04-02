import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  final double height;
  final Color color;

  const CustomDivider({super.key, this.height = 1, this.color = Colors.black, });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 5.0;
        final dashHeight = height;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}



class CustomDivider1 extends StatelessWidget {
  final String text;
  final double thickness;
  final double spaceAroundText;
  final Color color;
  final TextAlign textAlign;
    final double? fontsize ;

  const CustomDivider1({
    super.key,
    required this.text,
    this.thickness = 1.0,
    this.spaceAroundText = 8.0,
    this.color = Colors.black,
    this.textAlign = TextAlign.center, this.fontsize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (textAlign == TextAlign.left) ...[
          TextSection(text),
          DividerSection(),
        ],
        if (textAlign == TextAlign.center) ...[
          DividerSection(),
          TextSection(text),
          DividerSection(),
        ],
        if (textAlign == TextAlign.right) ...[
          DividerSection(),
          TextSection(text),
        ],
      ],
    );
  }

  Expanded DividerSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spaceAroundText),
        height: thickness,
        color: color,
      ),
    );
  }

  Widget TextSection(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize:   fontsize ??  14  ,
        color: color,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}





class CustomDivider2 extends StatelessWidget {
  final String text;
  final double thickness;
  final double spaceAroundText;
  final Color color;
    final Color dividercolor;
  final TextAlign textAlign;

  const CustomDivider2({
    super.key,
    required this.text,
    this.thickness = 1.0,
    this.spaceAroundText = 2.0,
    this.color = Colors.black,
    this.textAlign = TextAlign.center,  this.dividercolor = Colors.black ,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (textAlign == TextAlign.left) ...[
          TextSection(text),
          DividerSection(),
        ],
        if (textAlign == TextAlign.center) ...[
          DividerSection(),
          TextSection(text),
          DividerSection(),
        ],
        if (textAlign == TextAlign.right) ...[
          DividerSection(),
          TextSection(text),
        ],
      ],
    );
  }

  Expanded DividerSection() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: spaceAroundText),
        height: thickness,
        color: dividercolor,
      ),
    );
  }

  Widget TextSection(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14,
        color: color,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
