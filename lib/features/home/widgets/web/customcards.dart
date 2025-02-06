

import 'package:flutter/material.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';

// class Customcard2 extends StatelessWidget {
//   final AlignmentGeometry? alignment;
//   final String title;
//   final double? width;
//   final double? height;
//   final String image;
//   final double? imageHeight;
//   final double? imagewidth;
//   final double? imageTopPosition;
//   final double? imageLeftPosition;
//   final double? imageBottomPosition;
//   final double? imageRightPosition;
//   final String title2;
//   final ontap;
//   final bool isofferd;
//     final bool isdynamic;

//   const Customcard2({super.key, 
//      this.alignment,
//     required this.title,
//     this.width,
//     this.height,
//     required this.image,
//     this.imageHeight,
//     this.imagewidth,
//     this.imageTopPosition,
//     this.imageLeftPosition,
//     this.imageBottomPosition,
//     this.imageRightPosition,
//     required this.title2,
//      this.ontap, this.isofferd = false, required this.isdynamic,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomInkWell(
//       onTap: ontap,
//       child: Container(
//         decoration:  BoxDecoration(
//            borderRadius: BorderRadius.all(Radius.circular(19)),
//               boxShadow: [
//                 BoxShadow(
//                   // color: Color(0x40000000),
//                   // blurRadius: 2,
//                   // offset: Offset(0, 0),

//                       color: Theme.of(context).disabledColor.withOpacity(0.1),
//                    spreadRadius: 5,
//                    blurRadius:5,
//                 ),
//               ],
//         ),
//         child: ClipRRect(
          
//           borderRadius: BorderRadius.circular(19),
//           child: Container(
//             width: width,
//             height: height,
//             decoration: const BoxDecoration(
//               color: Colors.white,
             
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 0, ),
//               child: Stack(
//                 children: [
//                   isdynamic ? CustomImage(
//                     fit: BoxFit.fill,
//                     image: image) : SizedBox(),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 40, ),
//                     child: Align(
//                       alignment: Alignment.topLeft,
//                       child: Text(
//                         title,
//                         style: const TextStyle(
//                           color: Color(0xFF5B5B5B),
//                           fontSize: 14,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Visibility(
//                     visible: title2.isNotEmpty ,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: 55),
//                       child: Align(
//                         alignment: Alignment.topLeft,
//                         child: Text(
//                           title2,
//                           style: const TextStyle(
//                             color: Color(0xFF5B5B5B),
//                             fontSize: 8,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
              
//                       Visibility(
//                         visible: isofferd,
//                         child: Padding(
//                         padding: const EdgeInsets.only(top: 70),
//                           child: Align(
//                             alignment: FractionalOffset.topLeft,
//                             child: Container(
//                                       width: 55,
//                                       height: 15,
//                                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                                       decoration: ShapeDecoration(
//                                         color: const Color(0xFFFF5200),
//                                         shape: RoundedRectangleBorder(
//                                           borderRadius: BorderRadius.circular(32),
//                                         ),
//                                       ),
//                                       child: const Row(
//                                         // mainAxisSize: MainAxisSize.min,
//                                         // mainAxisAlignment: MainAxisAlignment.center,
//                                         // crossAxisAlignment: CrossAxisAlignment.center,
//                                         children: [
//                                           Center(
//                                             child: Text(
//                                               'Upto 50%',
//                                               style: TextStyle(
//                                                 color: Colors.white,
//                                                 fontSize: 7,
//                                                 fontFamily: 'Poppins',
//                                                 fontWeight: FontWeight.w400,
//                                                 height: 1,
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                           ),
//                         ),
//                       ),
//                isdynamic ? const SizedBox() :   Positioned(
//                     top: imageTopPosition,
//                     left: imageLeftPosition,
//                     bottom: imageBottomPosition,
//                     right: imageRightPosition,
//                     child: Align(
//                       alignment: alignment ?? Alignment.center,
//                       child: 
//                       Image.asset(
//                         image,
//                         height: imageHeight,
//                         width: imagewidth,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }






class Customcard2 extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final String title;
  final double? width;
  final double? height;
  final String image;
  final double? imageHeight;
  final double? imageWidth;
  final double? imageTopPosition;
  final double? imageLeftPosition;
  final double? imageBottomPosition;
  final double? imageRightPosition;
  final String title2;
  final VoidCallback? ontap;
  final bool isofferd;
  final bool isdynamic;

  const Customcard2({
    super.key,
    this.alignment,
    required this.title,
    this.width,
    this.height,
    required this.image,
    this.imageHeight,
    this.imageWidth,
    this.imageTopPosition,
    this.imageLeftPosition,
    this.imageBottomPosition,
    this.imageRightPosition,
    required this.title2,
    this.ontap,
    this.isofferd = false,  this.isdynamic = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: ontap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).disabledColor.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(19),
          child: Stack(
            children: [
              // Background Image
            isdynamic ? CustomImage(image: image,fit: BoxFit.cover,width: double.infinity,height: double.infinity) :  Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),

              // Content
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Color(0xFF5B5B5B),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (title2.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          title2,
                          style: const TextStyle(
                            color: Color(0xFF5B5B5B),
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    if (isofferd)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: 55,
                          height: 15,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFF5200),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Upto 50%',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 7,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w400,
                                height: 1,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}





class Customcard3 extends StatelessWidget {
  final AlignmentGeometry? alignment;
  final String title;
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
  final bool isofferd;

  const Customcard3({super.key, 
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
     this.ontap, this.isofferd = false,
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: ontap,
      child: Container(
        decoration:  BoxDecoration(
           borderRadius: BorderRadius.all(Radius.circular(19)),
              boxShadow: [
                BoxShadow(
                  // color: Color(0x40000000),
                  // blurRadius: 2,
                  // offset: Offset(0, 0),

                      color: Theme.of(context).disabledColor.withOpacity(0.1),
                   spreadRadius: 5,
                   blurRadius:5,
                ),
              ],
        ),
        child: ClipRRect(
          
          borderRadius: BorderRadius.circular(19),
          child: Container(
            width: width,
            height: height,
            decoration: const BoxDecoration(
              color: Colors.white,
             
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 40, ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF5B5B5B),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: title2.isNotEmpty ,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 55),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          title2,
                          style: const TextStyle(
                            color: Color(0xFF5B5B5B),
                            fontSize: 8,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
              
                      Visibility(
                        visible: isofferd,
                        child: Padding(
                        padding: const EdgeInsets.only(top: 70),
                          child: Align(
                            alignment: FractionalOffset.topLeft,
                            child: Container(
                                      width: 55,
                                      height: 15,
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      decoration: ShapeDecoration(
                                        color: const Color(0xFFFF5200),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32),
                                        ),
                                      ),
                                      child: const Row(
                                        // mainAxisSize: MainAxisSize.min,
                                        // mainAxisAlignment: MainAxisAlignment.center,
                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          Center(
                                            child: Text(
                                              'Upto 50%',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 7,
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w400,
                                                height: 1,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                      child:  Image.asset(
                        image,
                        height: imageHeight,
                        width: imagewidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// class FlashSaleBanner extends StatelessWidget {
//   const FlashSaleBanner({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 180,
//       width: double.maxFinite,
//       padding: EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         mainAxisSize: MainAxisSize.max,
//         children: [
//           Container(
//             margin: EdgeInsets.only(bottom: 12),
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: Color(0XFFFFFFFF),
//               borderRadius: BorderRadius.circular(
//                 14,
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   color: Color(0X3F000000),
//                   spreadRadius: 2,
//                   blurRadius: 2,
//                   offset: Offset(
//                     0,
//                     0,
//                   ),
//                 )
//               ],
//             ),
//             width: double.maxFinite,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   width: 154,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Flash sale on food!",
//                         style: TextStyle(
//                           color: Color(0XFF23241F),
//                           fontSize: 16,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       Text(
//                         "Feast on savinds,only until 29th\noctober",
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: Color(0XFF23241F),
//                           fontSize: 10,
//                           fontFamily: 'Poppins',
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                       _buildFlashSaleButton(context),
//                        SizedBox( height: MediaQuery.of(context).size.height * 0.02 ,)
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(0),
//                   child: Image.asset(
//                     "assets/image/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese-removebg-preview 1.png",
//                     height: 92,
//                     width: 112,
//                   ),
//                 ),

               
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildFlashSaleButton(BuildContext context) {
//     return Container(
//       width: double.maxFinite,
//       height: 34,
//       margin: EdgeInsets.only(top: 22),
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           elevation: 0,
//           backgroundColor: Color(0XFF000000),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(
//               16,
//             ),
//           ),
//           visualDensity: const VisualDensity(
//             vertical: -4,
//             horizontal: -4,
//           ),
//           padding: EdgeInsets.symmetric(
//             horizontal: 30,
//             vertical: 8,
//           ),
//         ),
//         onPressed: () {},
//         child: Text(
//           "Order Now",
//           style: TextStyle(
//             color: Color(0XFFFFFFFF),
//             fontSize: 12,
//             fontFamily: 'Poppins',
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class FlashSaleBanner extends StatelessWidget {
//   const FlashSaleBanner({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 155,
//       width: double.maxFinite,
//       padding: const EdgeInsets.symmetric(horizontal: 18),
//       child: Stack(
//         children: [
//           Container(
//             margin: const EdgeInsets.only(bottom: 12),
//             padding: const EdgeInsets.all(10),
//             decoration: BoxDecoration(
//               color: const Color(0XFFFFFFFF),
//               borderRadius: BorderRadius.circular(
//                 14,
//               ),
//               boxShadow: const [
//                 BoxShadow(
//                   color: Color(0X3F000000),
//                   spreadRadius: 2,
//                   blurRadius: 1,
//                   offset: Offset(
//                     0,
//                     0,
//                   ),
//                 )
//               ],
//             ),
//           ),
//           const Positioned(
//             left: 16,
//             top: 16,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Flash sale on food!",
//                   style: TextStyle(
//                     color: Color(0XFF23241F),
//                     fontSize: 18,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 Text(
//                   "Feast on savinds,only until 29th\noctober",
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: TextStyle(
//                     color: Color(0XFF23241F),
//                     fontSize: 10,
//                     fontFamily: 'Poppins',
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             right: 16,
//             top: 16,
//             child: Image.asset(
//               "assets/image/tasty-burger-isolated-white-background-fresh-hamburger-fastfood-with-beef-cheese-removebg-preview 1.png",
//               height: 92,
//               width: 112,
//             ),
//           ),
//           Positioned(
//             bottom: 30,
//             // right: 20,
//             left: 19,
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 elevation: 0,
//                 backgroundColor: const Color(0XFF000000),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(
//                     19,
//                   ),
//                 ),
//                 visualDensity: const VisualDensity(
//                   vertical: -4,
//                   horizontal: -4,
//                 ),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 30,
//                   vertical: 28,
//                 ),
//               ),
//               onPressed: () {},
//               child: const Text(
//                 "Order Now",
//                 style: TextStyle(
//                   color: Color(0XFFFFFFFF),
//                   fontSize: 12,
//                   fontFamily: 'Poppins',
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }