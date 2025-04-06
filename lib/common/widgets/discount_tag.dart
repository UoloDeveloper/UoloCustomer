import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


// class DiscountTag extends StatelessWidget {
//   final double? discount;
//   final String? discountType;
//   final double fromTop;
//   final double? fontSize;
//   final bool inLeft;
//   final bool? freeDelivery;
//   final bool? isFloating;
//     final String? currency;
//   const DiscountTag({super.key,
//     required this.discount, required this.discountType, this.fromTop = 0, this.fontSize, this.freeDelivery = false,
//     this.inLeft = true, this.isFloating = true, this.currency,
//   });

//   @override
//   Widget build(BuildContext context) {
//     bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
//     bool isFood = Get.find<SplashController>().module!.moduleType.toString() == AppConstants.food;
//     String currencySymbol = Get.find<SplashController>().configModel!.currencySymbol!;

//     return (discount! > 0 || freeDelivery!) ? isFood ? SizedBox() : Positioned(
//       top: fromTop, left: inLeft ? isFloating! ? 0: 0 : null, right: inLeft ? null : 0,
//       child: 
      
//       //  Container(
//       //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       //   decoration: BoxDecoration(
//       //     color: Theme.of(context).colorScheme.error.withOpacity(0.8),
//       //     borderRadius: BorderRadius.horizontal(
//       //       right: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? Dimensions.radiusSmall : 0),
//       //       left: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? 0 : Dimensions.radiusSmall),
//       //     ),
//       //   ),
//       //   child: Text(
//       //     discount! > 0 ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%'
//       //         : isRightSide ? currencySymbol : ''} ${'off'.tr}' : 'free_delivery'.tr,
//       //     style: robotoMedium.copyWith(
//       //       color: Theme.of(context).cardColor,
//       //       fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
//       //     ),
//       //     textAlign: TextAlign.center,
//       //   ),
//       // ),


//       Stack(
//   children: [
//     // Background Container with decoration
//     // Container(
//     //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//     //   decoration: BoxDecoration(
//     //     color: Theme.of(context).colorScheme.error.withOpacity(0.8),
//     //     borderRadius: BorderRadius.horizontal(
//     //       right: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? Dimensions.radiusSmall : 0),
//     //       left: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? 0 : Dimensions.radiusSmall),
//     //     ),
//     //   ),
//     // ),
//       Image.asset("assets/image/icons/Subtract.png", width: 39, height: 38),
//     // SvgPicture.asset('assets/image/icons/Subtract.png', width: 39, height: 38),
//     // Positioned Text on top of the background
//     Positioned.fill(
//       child: Center(
//         child: Text(
//           discount! > 0 
//               ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}' 
//               : 'free_delivery'.tr,
//           style: robotoMedium.copyWith(
//             color: Theme.of(context).cardColor,
//             fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ),
//     ),
//   ],
// )
//     ) : const SizedBox();
//   }
// }



class DiscountTag extends StatelessWidget {
  final double? discount;
  final String? discountType;
  final double fromTop;
  final double? fontSize;
  final bool inLeft;
  final bool? freeDelivery;
  final bool? isFloating;
  final String? currency;

  const DiscountTag({
    super.key,
    required this.discount,
    required this.discountType,
    this.fromTop = 0,
    this.fontSize,
    this.freeDelivery = false,
    this.inLeft = true,
    this.isFloating = true,
    this.currency,
  });

  @override
  Widget build(BuildContext context) {
    final splashController = Get.find<SplashController>();
    final configModel = splashController.configModel;
    final module = splashController.module;

    final isRightSide = configModel?.currencySymbolDirection == 'right';
    final isFood = module?.moduleType.toString() == AppConstants.food;
    final currencySymbol = configModel?.currencySymbol ?? '';

    final hasDiscount = discount != null && discount! > 0;
    final hasFreeDelivery = freeDelivery ?? false;

    if (!hasDiscount && !hasFreeDelivery) {
      return const SizedBox();
    }

    if (isFood) {
      return const SizedBox();
    }

    return Positioned(
      top: fromTop,
      left: inLeft ? (isFloating ?? true) ? 0 : 0 : null,
      right: inLeft ? null : 0,
      child: Stack(
        children: [
          Image.asset(
            "assets/image/icons/Subtract.png",
            width: 39,
            height: 38,
          ),
          Positioned.fill(
            child: Center(
              child: Text(
                hasDiscount
                    ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                    : 'free_delivery'.tr,
                style: robotoMedium.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 8 : 12),
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class DiscountTag2 extends StatelessWidget {
  final double? discount;
  final String? discountType;
  final double fromTop;
  final double fromleft;
  final double? fontSize;
  final bool inLeft;
  final bool? freeDelivery;
  final bool? isFloating;
  const DiscountTag2({super.key,
    required this.discount, required this.discountType, this.fromTop = 10, this.fontSize, this.freeDelivery = false,
    this.inLeft = true, this.isFloating = true,  this.fromleft = -1,
  });

  @override
  Widget build(BuildContext context) {
    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    String currencySymbol = Get.find<SplashController>().configModel!.currencySymbol!;

    return (discount! > 0 || freeDelivery!) ? Positioned(
      top: fromTop,
       left: fromleft,
        right: inLeft ? null : 0,
      child: Container(
        height: 100,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
        decoration: BoxDecoration(
          // color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          borderRadius: BorderRadius.horizontal(
            right: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? Dimensions.radiusSmall : 0),
            left: Radius.circular(isFloating! ? Dimensions.radiusLarge : inLeft ? 0 : Dimensions.radiusSmall),
          ),
        ),
        child: Stack(
                 
          children: [

             Positioned(
             top: 0,
               child: Text(
             "UPTO",
                style: robotoMedium.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 15: 12),
                  fontWeight:FontWeight.w700
                           
                ),
                textAlign: TextAlign.center,
                           ),
             ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Text(
                      //   discount! > 0 
                      // ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}'
                      //   '${(discount! * 10).toInt()}${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                      // : 'free_delivery'.tr,
                      discount! > 0
                      ? '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}'
                        '${(discount! + 10).toInt() > 60 ? 60 : (discount! + 10).toInt()}${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} ${'off'.tr}'
                      : 'free_delivery'.tr,
                style: robotoMedium.copyWith(
                  color: Theme.of(context).cardColor,
                  fontSize: fontSize ?? (ResponsiveHelper.isMobile(context) ? 20: 12),
                  fontWeight:FontWeight.w900
              
                ),
                textAlign: TextAlign.center,
              ),
            ),

 
            
          ],
        ),
      ),
    ) : const SizedBox();
  }
}
