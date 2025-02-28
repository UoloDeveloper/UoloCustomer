import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// class ConfirmationDialog extends StatelessWidget {
//   final String icon;
//   final String? title;
//   final String description;
//   final Function onYesPressed;
//   final bool isLogOut;
//   final Function? onNoPressed;
//   const ConfirmationDialog({super.key, required this.icon, this.title, required this.description, required this.onYesPressed,
//     this.isLogOut = false, this.onNoPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
//       insetPadding: const EdgeInsets.all(30),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: PointerInterceptor(
//         child: SizedBox(width: 500, child: Padding(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [

//             Padding(
//               padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//               child: Image.asset(icon, width: 50, height: 50, color: Theme.of(context).primaryColor),
//             ),

//             title != null ? Padding(
//               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
//               child: Text(
//                 title!, textAlign: TextAlign.center,
//                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.red),
//               ),
//             ) : const SizedBox(),

//             Padding(
//               padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//               child: Text(description, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textAlign: TextAlign.center),
//             ),
//             const SizedBox(height: Dimensions.paddingSizeLarge),

//             GetBuilder<OrderController>(builder: (orderController) {
//               return !orderController.isLoading ? Row(children: [
//                 Expanded(child: TextButton(
//                   onPressed: () => isLogOut ? onYesPressed() : onNoPressed != null ? onNoPressed!() : Get.back(),
//                   style: TextButton.styleFrom(
//                     backgroundColor: Theme.of(context).disabledColor  , minimumSize: const Size(Dimensions.webMaxWidth, 50), padding: EdgeInsets.zero,
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
//                   ),
//                   child: Text(
//                     isLogOut ? 'yes'.tr : 'no'.tr, textAlign: TextAlign.center,
//                     style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
//                   ),
//                 )),
//                 const SizedBox(width: Dimensions.paddingSizeLarge),

//                 Expanded(child: CustomButton(
//                   buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
//                   onPressed: () => isLogOut ? Get.back() : onYesPressed(),
//                   radius: Dimensions.radiusSmall, height: 50,
//                 )),
//               ]) : const Center(child: CircularProgressIndicator());
//             }),

//           ]),
//         )),
//       ),
//     );
//   }
// }



import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class ConfirmationDialog extends StatelessWidget {
  final String? icon;
  final String? title;
  final String description;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;

  const ConfirmationDialog({
    super.key,
    this.icon,
    this.title,
    required this.description,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(20),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 8,
      backgroundColor: Colors.white,
      child: PointerInterceptor(
        child: Stack(
          children: [
            SizedBox(
              width: 400,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start, // Left-align content
                  children: [
                    if (icon != null) Padding(
                      padding: const EdgeInsets.all(16),
                      child: Center(
                        child: Image.asset(
                          icon!,
                          width: 60,
                          height: 60,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),

                    if (title != null) Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        title!,
                        style: robotoBold.copyWith( // Increased font weight and bold style
                          fontSize: Dimensions.fontSizeExtraLarge,
                          color: Colors.black, // Title color set to black
                        ),
                        textAlign: TextAlign.left, // Left-aligned title
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(
                        description,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Colors.grey[700],
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),

                    const SizedBox(height: Dimensions.paddingSizeLarge),

                    GetBuilder<OrderController>(
                      builder: (orderController) {
                        return GetBuilder<CartController>(
                      builder: (cartcontroller) {
                            return !orderController.isLoading
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: TextButton(
                                          onPressed: () => isLogOut
                                              ? onYesPressed()
                                              : onNoPressed != null
                                                  ? onNoPressed!()
                                                  : Get.back(),
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.grey[200],
                                            minimumSize: const Size(50, 50),
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Text(
                                            isLogOut ? 'yes'.tr : 'no'.tr,
                                            style: robotoBold.copyWith(
                                              color: Colors.grey[800],
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                            
                                      Expanded(
                                        child: CustomButton(
                                           isLoading: cartcontroller.isLoading,
                                          buttonText: isLogOut ? 'no'.tr : 'yes'.tr,
                                          onPressed: () => isLogOut ? Get.back() : onYesPressed(),
                                          radius: 12,
                                          height: 50,
                                        ),
                                      ),
                                    ],
                                  )
                                : const Center(child: CircularProgressIndicator());
                          }
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Close Button at the top-right corner
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                // color: Colors.white70,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(100),
                  // boxShadow: [
                  //   BoxShadow(
                  //     color: Colors.grey[300]!,
                  //     blurRadius: 4,
                  //     offset: const Offset(0, 0),
                  //   ),
                  // ],
                ),
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black), // Black close icon
                  onPressed: () => Get.back(), // Close dialog action
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
