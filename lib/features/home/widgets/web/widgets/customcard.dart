
import 'package:flutter/material.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';

class Customcard extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final String title;
   final Color titlecolor;
    final Color titlecolor2;
  final double? width;
  final double? height;
  final String image;
  final double? imageHeight;
  final double? imagewidth;
  final double? imageTopPosition;
  final double? imageLeftPosition;
  final double? imageBottomPosition;
  final double? imageRightPosition;
  final String title2;
  final ontap;
    final Color color;

  const Customcard({super.key, 
     this.alignment,
    required this.title,
    this.width,
    this.height,
    required this.image,
    this.imageHeight,
    this.imagewidth,
    this.imageTopPosition,
    this.imageLeftPosition,
    this.imageBottomPosition,
    this.imageRightPosition,
    required this.title2,
     this.ontap, required this.color, required this.titlecolor, required this.titlecolor2,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration:  BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(19)),
          boxShadow: [
            // BoxShadow(
            //   color: Color.fromARGB(31, 0, 0, 0),
            //   blurRadius: 4,
            //   offset: Offset(0, 0),
            // ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title,
                  style:  TextStyle(
                    color: titlecolor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  title2,
                  style:  TextStyle(
                    color: titlecolor2,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            Positioned(
              top: imageTopPosition,
              left: imageLeftPosition,
              bottom: imageBottomPosition,
              right: imageRightPosition,
              child: Align(
                alignment: alignment ?? Alignment.center,
                child: Image.asset(
                  image,
                  height: imageHeight,
                  width: imagewidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}