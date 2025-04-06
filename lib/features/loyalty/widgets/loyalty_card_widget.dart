import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/loyalty/widgets/loyalty_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';

// class LoyaltyCardWidget extends StatelessWidget {
//   final JustTheController tooltipController;
//   const LoyaltyCardWidget({super.key, required this.tooltipController});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       builder: (profileController) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 230,
//               padding: EdgeInsets.all( ResponsiveHelper.isDesktop(context) ? 35 : Dimensions.paddingSizeExtraLarge),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                 color: Theme.of(context).disabledColor  ,
//               ),
//               child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [

//                 Image.asset(Images.loyal , height: 60, width: 60),
//                 const SizedBox(width: Dimensions.paddingSizeExtraLarge),

//                 Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

//                   ResponsiveHelper.isDesktop(context) ? const SizedBox() : Text(
//                     '${'convertible_points'.tr} !',
//                     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
//                   ),

//                   Text(
//                     profileController.userInfoModel!.loyaltyPoint == null ? '0' : profileController.userInfoModel!.loyaltyPoint.toString(),
//                     style: robotoBold.copyWith(fontSize: Dimensions.fontSizeOverLarge, color: Theme.of(context).textTheme.bodyLarge!.color),
//                   ),

//                   ResponsiveHelper.isDesktop(context) ? Text(
//                     '${'convertible_points'.tr} !',
//                     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).textTheme.bodyLarge!.color),
//                   ) : const SizedBox(),

//                   const SizedBox(height: Dimensions.paddingSizeSmall),
//                 ]),
//               ]),
//             ),

//             ResponsiveHelper.isDesktop(context) ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),

//             ResponsiveHelper.isDesktop(context) ? Text('how_to_use'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)) : const SizedBox(),
//             ResponsiveHelper.isDesktop(context) ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),

//             !ResponsiveHelper.isDesktop(context) ? const SizedBox() : const LoyaltyStepper(),
//           ],
//         );
//       }
//     );
//   }
// }

// class LoyaltyCardWidget extends StatelessWidget {
//   final JustTheController tooltipController;
//   const LoyaltyCardWidget({super.key, required this.tooltipController});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ProfileController>(
//       builder: (profileController) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Loyalty Card Container
//             Container(
//               height: 230,
//               padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context) ? 35 : Dimensions.paddingSizeExtraLarge),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                 gradient: LinearGradient(
//                   colors: [Colors.blue.shade800, Colors.blue.shade400],
//                   begin: Alignment.topLeft,
//                   end: Alignment.bottomRight,
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     blurRadius: 10,
//                     offset: const Offset(0, 4),
//                   ),
//                 ],
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Loyalty Icon
//                   Image.asset(
//                     Images.loyal,
//                     height: 80,
//                     width: 80,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(width: Dimensions.paddingSizeExtraLarge),

//                   // Loyalty Points Information
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       // Convertible Points Text (Mobile)
//                       if (!ResponsiveHelper.isDesktop(context))
//                         Text(
//                           '${'convertible_points'.tr} !',
//                           style: robotoRegular.copyWith(
//                             fontSize: Dimensions.fontSizeSmall,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),

//                       // Loyalty Points Value
//                       Text(
//                         profileController.userInfoModel!.loyaltyPoint == null
//                             ? '0'
//                             : profileController.userInfoModel!.loyaltyPoint.toString(),
//                         style: robotoBold.copyWith(
//                           fontSize: Dimensions.fontSizeOverLarge + 10,
//                           color: Colors.white,
//                         ),
//                       ),

//                       // Convertible Points Text (Desktop)
//                       if (ResponsiveHelper.isDesktop(context))
//                         Text(
//                           '${'convertible_points'.tr} !',
//                           style: robotoRegular.copyWith(
//                             fontSize: Dimensions.fontSizeSmall,
//                             color: Colors.white.withOpacity(0.8),
//                           ),
//                         ),

//                       const SizedBox(height: Dimensions.paddingSizeSmall),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Spacing
//             SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeDefault : 0),

//             // How to Use Section (Desktop)
//             if (ResponsiveHelper.isDesktop(context))
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'how_to_use'.tr,
//                     style: robotoBold.copyWith(
//                       fontSize: Dimensions.fontSizeLarge,
//                       color: Theme.of(context).textTheme.bodyLarge!.color,
//                     ),
//                   ),
//                   const SizedBox(height: Dimensions.paddingSizeDefault),
//                   const LoyaltyStepper(),
//                 ],
//               ),
//           ],
//         );
//       },
//     );
//   }
// }


class LoyaltyCardWidget extends StatelessWidget {
  final JustTheController tooltipController;
  const LoyaltyCardWidget({super.key, required this.tooltipController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Loyalty Card (Debit Card Style)
            Container(
              height: 250,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  colors: [Colors.deepPurple.shade800, Colors.purple.shade400],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Card Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Loyalty Card',
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeLarge + 10,
                          color: Colors.white,
                        ),
                      ),
                  
                       

                      Image.asset(
                        "assets/image/icons/card_7186351.png",
                        height: 60,
                        width: 60,
                        // color: Colors.white,
                      ),
                    ],
                  ),

                  // Loyalty Points
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Points',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall + 5,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        profileController.userInfoModel!.loyaltyPoint == null
                            ? '0'
                            : profileController.userInfoModel!.loyaltyPoint.toString(),
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge + 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Card Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Convertible Points',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeSmall + 5,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      // Text(
                      //   'Valid Thru: 12/25',
                      //   style: robotoRegular.copyWith(
                      //     fontSize: Dimensions.fontSizeSmall,
                      //     color: Colors.white.withOpacity(0.8),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: Dimensions.paddingSizeDefault),

            // How to Use Section
            if (ResponsiveHelper.isDesktop(context))
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'How to Use',
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  const LoyaltyStepper(), // Modern Stepper Widget
                ],
              ),
          ],
        );
      },
    );
  }
}
class LoyaltyStepper extends StatelessWidget {
  const LoyaltyStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 70,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                    ),
                  ),

                  Expanded(
                    child: VerticalDivider(
                      thickness: 3,
                      color: Theme.of(context).primaryColor  ,
                    ),
                  ),

                  Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).primaryColor, width: 2)
                    ),
                  ),
                ],
              ),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('convert_your_loyalty_point_to_wallet_money'.tr, style: robotoRegular),
                    Text('${'minimun'.tr} ${Get.find<SplashController>().configModel!.loyaltyPointExchangeRate} ${'points_required_to_convert_into_currency'.tr}', style: robotoRegular),
                  ],
                ),
              ),

            ],
          ),
        ),
        const SizedBox(height: Dimensions.paddingSizeDefault),
        CustomButton(
          radius: Dimensions.radiusSmall,
          isBold: true,
          buttonText: 'convert_to_currency_now'.tr,
          onPressed: () {
            Get.dialog(
              Dialog(backgroundColor: Colors.transparent, child: LoyaltyBottomSheetWidget(
                amount: Get.find<ProfileController>().userInfoModel!.loyaltyPoint == null
                  ? '0' : Get.find<ProfileController>().userInfoModel!.loyaltyPoint.toString(),
              )),
            );
          },
        ),
      ],
    );
  }
}

