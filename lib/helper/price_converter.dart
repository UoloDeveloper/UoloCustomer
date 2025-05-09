import 'dart:developer';

import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/styles.dart';

class PriceConverter {
  // static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false,String? currency}) {
  //   if(discount != null && discountType != null){
  //     if(discountType == 'amount' && !isFoodVariation) {
  //       price = price! - discount;
  //     }else if(discountType == 'percent') {
  //       price = price! - ((discount / 100) * price);
  //     }
  //   }

  //   if(currency != null){

  //     if (currency == 'INR') {

  //       currency = '₹ ';
  //     }
  //       log( Get.find<SplashController>().configModel!.digitAfterDecimalPoint!.toString()) ;
  //      log( Get.find<SplashController>().configModel!.digitAfterDecimalPoint!.toString()) ;
  //      log(price.toString());

  //         bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
  //   log(Get.find<SplashController>().configModel!.toString());
  //   return '${isRightSide ? ' ' : currency}'
  //   "$price"
  //       // '${toFixed(price!).toStringAsFixed(forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)
  //       // .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
  //       '${isRightSide ? ' ${currency} ' : ''}';
  //   }


  //   bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
  //   log(Get.find<SplashController>().configModel!.toString());
  //   return '${isRightSide ? '' : '${Get.find<SplashController>().configModel!.currencySymbol!} '}'
  //     "$price"
  //       // '${toFixed(price!).toStringAsFixed(forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)
  //       // .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
  //       '${isRightSide ? ' ${Get.find<SplashController>().configModel!.currencySymbol!}' : ''}';
  // } 
  
// static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false, String? currency, String? surcharge}) {
//    double?  surcharge = surcharge?.toDouble();
//     if (discount != null && discountType != null) {
//         if (discountType == 'amount' && !isFoodVariation) {
//             price = price! - discount;
//         } else if (discountType == 'percent') {
//             price = price! - ((discount / 100) * price);
//         }
//     }

//     // Round the price to the nearest integer and remove decimal points
//     int roundedPrice = price?.round() ?? 0;

//     if (currency != null) {
//         if (currency == 'INR') {
//             currency = '₹ ';
//         }

//         bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
//         log(Get.find<SplashController>().configModel!.toString());
//         return '${isRightSide ? ' ' : currency}'
//             "$roundedPrice"
//             '${isRightSide ? ' ${currency} ' : ''}';
//     }

//     bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
//     log(Get.find<SplashController>().configModel!.toString());
//     return '${isRightSide ? '' : '${Get.find<SplashController>().configModel!.currencySymbol!} '}'
//         "$roundedPrice"
//         '${isRightSide ? ' ${Get.find<SplashController>().configModel!.currencySymbol!}' : ''}';
// }
 
 
 static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false, String? currency, String? surcharge}) {
  // Initialize price if null
  price ??= 0;

  // Apply discount if provided
  if (discount != null && discountType != null) {
    if (discountType == 'amount' && !isFoodVariation) {
      price = price - discount;
    } else if (discountType == 'percent') {
      price = price - ((discount / 100) * price);
    }
  }

  // Apply surcharge if provided (surcharge is a percentage in string format, e.g., "40" for 40%)
  if (surcharge != null && surcharge.isNotEmpty) {
    double surchargePercentage = double.tryParse(surcharge) ?? 0;
    double surchargeAmount = (surchargePercentage / 100) * price;
    price += surchargeAmount;
  }

  // Round the price to the nearest integer and remove decimal points
  int roundedPrice = price.round();

  // Handle currency formatting
  if (currency != null) {
    if (currency == 'INR') {
      currency = '₹ ';
    }

    bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
    log(Get.find<SplashController>().configModel!.toString());
    return '${isRightSide ? '' : currency}'
        "$roundedPrice"
        '${isRightSide ? ' $currency' : ''}';
  }

  bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
  log(Get.find<SplashController>().configModel!.toString());
  return '${isRightSide ? '' : '${Get.find<SplashController>().configModel!.currencySymbol!} '}'
      "$roundedPrice"
      '${isRightSide ? ' ${Get.find<SplashController>().configModel!.currencySymbol!}' : ''}';
}
  // static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle,String? currency}) {
  //   if(discount != null && discountType != null){
  //     if(discountType == 'amount') {
  //       price = price! - discount;
  //     }else if(discountType == 'percent') {
  //       price = price! - ((discount / 100) * price);
  //     }
  //   }

  //   if(currency != null){
  //   bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
  //       return Directionality(
  //     textDirection: TextDirection.ltr,
  //     child: AnimatedFlipCounter(
  //       duration: const Duration(milliseconds: 500),
  //       value: toFixed(price!),
  //       textStyle: textStyle ?? robotoMedium,
  //       fractionDigits: forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!,
  //       prefix: isRightSide ? '' : '$currency ',
  //       suffix: isRightSide ? '$currency ' : '',
  //     ),
  //     );
  //   }

  //   bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';
  //   return Directionality(
  //     textDirection: TextDirection.ltr,
  //     child: AnimatedFlipCounter(
  //       duration: const Duration(milliseconds: 500),
  //       value: toFixed(price!),
  //       textStyle: textStyle ?? robotoMedium,
  //       fractionDigits: forDM ? 0 : Get.find<SplashController>().configModel!.digitAfterDecimalPoint!,
  //       prefix: isRightSide ? '' : '${Get.find<SplashController>().configModel!.currencySymbol!} ',
  //       suffix: isRightSide ? '${Get.find<SplashController>().configModel!.currencySymbol!} ' : '',
  //     ),
  //   );
  // }
static Widget convertAnimationPrice(double? price, {
  double? discount,
  String? discountType,
  bool forDM = false,
  TextStyle? textStyle,
  String? currency
}) {

  if (discount != null && discountType != null) {
    if (discountType == 'amount') {
      price = price! - discount;
    } else if (discountType == 'percent') {
      price = price! - ((discount / 100) * price);
    }
  }

 
  String formattedPrice = toFixed(price!).toString();


  bool isRightSide = Get.find<SplashController>().configModel!.currencySymbolDirection == 'right';

 
  String priceText;
  // if (currency != null) {
    
  // }
  if (currency != null) {

    
      if (currency == 'INR') {
            currency = '₹';

        }
    priceText = isRightSide ? '$formattedPrice $currency' : '$currency $formattedPrice';
  } else {
    priceText = isRightSide 
        ? '$formattedPrice ${Get.find<SplashController>().configModel!.currencySymbol!}' 
        : '${Get.find<SplashController>().configModel!.currencySymbol!} $formattedPrice';
  }

  return Directionality(
    textDirection: TextDirection.ltr,
    child: Text(
      priceText,
      style: textStyle ?? robotoMedium,
    ),
  );
}
  static double? convertWithDiscount(double? price, double? discount, String? discountType, {bool isFoodVariation = false}) {
    if(discountType == 'amount' && !isFoodVariation) {
      price = price! - discount!;
    }else if(discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount') {
      calculatedAmount = discount! * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    return '$discount${discountType == 'percent' ? '%' : Get.find<SplashController>().configModel!.currencySymbol} OFF';
  }

  static double toFixed(double val) {
    num mod = power(10, Get.find<SplashController>().configModel!.digitAfterDecimalPoint!);
    return (((val * mod).toPrecision(Get.find<SplashController>().configModel!.digitAfterDecimalPoint!)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }

}