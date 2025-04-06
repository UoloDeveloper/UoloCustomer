import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
// class CongratulationDialogue extends StatelessWidget {
//   const CongratulationDialogue({super.key});

//   @override
//   Widget build(BuildContext context) { 
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Center(
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Container(
//               width: 300,
//               padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//               ),
//               child: Column(mainAxisSize: MainAxisSize.min, children: [
//                 Image.asset(Get.find<ThemeController>().darkTheme ? Images.congratulationDark : Images.congratulationLight, width: 100, height: 100),

//                 Text('congratulations'.tr , style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
//                 const SizedBox(height: Dimensions.paddingSizeSmall),

//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                   child: Text(
//                     '${'you_will_earn'.tr} ${Get.find<AuthController>().getEarningPint()} ${'points_after_completing_this_order'.tr}',
//                     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).disabledColor),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeLarge),

//                 CustomButton(
//                   buttonText: 'visit_loyalty_points'.tr,
//                   onPressed: (){
//                     Get.find<AuthController>().saveEarningPoint('');
//                     Get.back();
//                     Get.toNamed(RouteHelper.getLoyaltyRoute());
//                   },
//                 )
//               ]),
//             ),

//             Positioned(
//               top: 5, right: 5,
//                 child: InkWell(
//                   onTap: (){
//                     Get.find<AuthController>().saveEarningPoint('');
//                     Get.back();
//                   },
//                     child: const Icon(Icons.clear, size: 18),
//                 ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
// class CongratulationDialogue extends StatelessWidget {
//   const CongratulationDialogue({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent, // Set the dialog background to transparent
//       elevation: 0, // Remove the default shadow
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             width: 300,
//             padding: const EdgeInsets.all(Dimensions.paddingSizeExtraLarge),
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   Get.find<ThemeController>().darkTheme
//                       ? Images.congratulationDark
//                       : Images.congratulationLight,
//                   width: 100,
//                   height: 100,
//                 ),
//                 Text(
//                   'congratulations'.tr,
//                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeSmall),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                   child: Text(
//                     '${'you_will_earn'.tr} ${Get.find<AuthController>().getEarningPint()} ${'points_after_completing_this_order'.tr}',
//                     style: robotoRegular.copyWith(
//                       fontSize: Dimensions.fontSizeLarge,
//                       color: Theme.of(context).disabledColor,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeLarge),
//                 CustomButton(
//                   buttonText: 'visit_loyalty_points'.tr,
//                   onPressed: () {
//                     Get.find<AuthController>().saveEarningPoint('');
//                     Get.back();
//                     Get.toNamed(RouteHelper.getLoyaltyRoute());
//                   },
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 5,
//             right: 5,
//             child: InkWell(
//               onTap: () {
//                 Get.find<AuthController>().saveEarningPoint('');
//                 Get.back();
//               },
//               child: const Icon(Icons.clear, size: 18),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class CongratulationDialogue extends StatelessWidget {
//   const CongratulationDialogue({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             width: 320,
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               gradient: LinearGradient(
//                 colors: [
//                   // Theme.of(context).primaryColor.withOpacity(0.8),
//                   // Colors.accents[8],
//                     Color.fromARGB(15, 148, 148, 148),
//                   Color.fromARGB(164, 139, 9, 233)
//                 ],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black26,
//                   blurRadius: 10,
//                   offset: Offset(0, 5),
//                 ),
//               ],
//             ),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Image.asset(
//                   Get.find<ThemeController>().darkTheme
//                       ? Images.congratulationDark
//                       : Images.congratulationLight,
//                   width: 120,
//                   height: 120,
//                 ),
//                 const SizedBox(height: 15),
//                 Text(
//                   'congratulations'.tr,
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   child: Text(
//                     '${'you_will_earn'.tr} ${Get.find<AuthController>().getEarningPint()} ${'points_after_completing_this_order'.tr}',
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white70,
//                       fontStyle: FontStyle.italic,
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//                 CustomButton(
//                   buttonText: 'visit_loyalty_points'.tr,
//                   onPressed: () {
//                     Get.find<AuthController>().saveEarningPoint('');
//                     Get.back();
//                     Get.toNamed(RouteHelper.getLoyaltyRoute());
//                   },
//                   color : Colors.white,
//                   textColor: Theme.of(context).primaryColor,
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 10,
//             right: 10,
//             child: InkWell(
//               onTap: () {
//                 Get.find<AuthController>().saveEarningPoint('');
//                 Get.back();
//               },
//               child: const Icon(Icons.clear, size: 24, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CongratulationDialogue extends StatelessWidget {
  const CongratulationDialogue({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: TweenAnimationBuilder(
        duration: const Duration(milliseconds: 500),
        tween: Tween(begin: 0.0, end: 1.0),
        builder: (context, value, child) {
          return Transform.scale(
            scale: value,
            child: child,
          );
        },
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 320,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Animated Image
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Lottie.asset(
                      'assets/animations/Animation - 1739344852266.json',
                      width: 200,
                      height: 100,
                    ),
                    
                    //  Image.asset(
                    //   Get.find<ThemeController>().darkTheme
                    //       ? Images.congratulationDark
                    //       : Images.congratulationLight,
                    //   width: 120,
                    //   height: 120,
                    // ),
                  ),
                  const SizedBox(height: 0),
                  // Title with Animation
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 600),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Text(
                      'congratulations'.tr,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 0),
                  // Description with Animation
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 700),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        '${'you_will_earn'.tr} ${Get.find<AuthController>().getEarningPint()} ${'points_after_completing_this_order'.tr}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  // Custom Button with Animation
                  TweenAnimationBuilder(
                    duration: const Duration(milliseconds: 800),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      );
                    },
                    child: CustomButton(
                              gradient: LinearGradient(
          colors:   [
            Colors.deepPurple.shade800 ,
            Colors.purple.shade400  
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
                      buttonText: 'visit_loyalty_points'.tr, onPressed: () {
                      Get.find<AuthController>().saveEarningPoint('');
                      Get.back();
                      Get.toNamed(RouteHelper.getLoyaltyRoute());

                    })
                    
                    // ElevatedButton(
                    //   style: ElevatedButton.styleFrom(
                    //     backgroundColor: Theme.of(context).primaryColor,
                    //     shape: RoundedRectangleBorder(
                    //       borderRadius : BorderRadius.circular(20),
                    //     ),
                    //   ),
                    //   onPressed: () {
                    //     Get.find<AuthController>().saveEarningPoint('');
                    //     Get.back();
                    //     Get.toNamed(RouteHelper.getLoyaltyRoute());
                    //   },
                    //   child: Text(
                    //     'visit_loyalty_points'.tr,
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 16,
                    //     ),
                    //   ),
                    // ),
                  ),
                ],
              ),
            ),
            // Close Button with Animation
            Positioned(
              top: 10,
              right: 10,
              child: TweenAnimationBuilder(
                duration: const Duration(milliseconds: 900),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: Opacity(
                      opacity: value,
                      child: child,
                    ),
                  );
                },
                child: IconButton(
                  icon: const Icon(Icons.close, size: 24, color: Colors.black54),
                  onPressed: () {
                    Get.find<AuthController>().saveEarningPoint('');
                    Get.back();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}