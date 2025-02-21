import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';



class WalletBalanceWidget extends StatelessWidget {
  final double walletBalance;
  final bool isPartialPay;
  final Function(bool?) onChanged;
     final String currency;

  const WalletBalanceWidget({
    Key? key,
    required this.walletBalance,
    required this.isPartialPay,
    required this.onChanged, required this.currency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        // boxShadow:  
        // [
        //   BoxShadow(
        //     color: Colors.grey.withOpacity(0.5),
        //     spreadRadius: 5,
        //     blurRadius: 7,
        //     offset: const Offset(0, 3),
        //   ),
        // ],
      ),
      height: 40,
      width: double.infinity,
      // color: Colors.white,
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [
          Row(
            children: [
              Checkbox(
              
                value: isPartialPay,
                onChanged: onChanged,
              ),
                Text( 
           " wallet balance ${PriceConverter.convertPrice(walletBalance,currency: currency)}",
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor),
          ),
            ],
          ),
       
          GetBuilder<ProfileController>(builder: (profileController) {
              return Row(
                children: [
                   profileController.userInfoModel?.loyaltyPoint != null?   Container(
                      child: Row(
                        children: [
                          Image.asset("assets/image/icons/icons8-gold-coin-96[1].png",width: 25,height:25,),
              
                          Text("${profileController.userInfoModel?.loyaltyPoint != null ? profileController.userInfoModel!.loyaltyPoint.toString() : ''}",
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),
                          ),
                        ],
                      )) :SizedBox(),
              
                     SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                ],
              );
            }
          )
          
        ],
      ),
    );
  }
}

// class PartialPayView2 extends StatelessWidget {
//   final double totalPrice;
//   final bool isPrescription;
//     final String currency;

//   const PartialPayView2({
//     super.key,
//     required this.totalPrice,
//     required this.isPrescription, required this.currency,
//   });

//   @override
//   Widget build(BuildContext context) {
    
//     return GetBuilder<CheckoutController>(
//       builder: (checkoutController) {
//         final splashController = Get.find<SplashController>();
//         final profileController = Get.find<ProfileController>();
//         final walletBalance = profileController.userInfoModel!.walletBalance!;
//         // checkoutController = walletBalance;

//         return splashController.configModel!.partialPaymentStatus! &&
//                 splashController.configModel!.customerWalletStatus == 1 &&
//                 walletBalance > 0
//             ? WalletBalanceWidget(
//                 walletBalance: walletBalance,
//                 isPartialPay: checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
//                 onChanged: (value) {
//                   if (value != null) {
//                     if (walletBalance < totalPrice) {
//                       checkoutController.changePartialPayment();
//                     } else {
//                       checkoutController.setPaymentMethod(value ? 1 : -1);
//                     }
//                   }
//                 }, currency: currency,
//               )
//             :   WalletBalanceWidget(
//                 walletBalance: walletBalance,
//                 isPartialPay: checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
//                 onChanged: (value) {
//                   if (value != null) {
//                     if (walletBalance < totalPrice) {
//                       checkoutController.changePartialPayment();
//                     } else {
//                       checkoutController.setPaymentMethod(value ? 1 : -1);
//                     }
//                   }
//                 }, currency: currency,
//               );
//       },
//     );
//   }
// }


class PartialPayView2 extends StatelessWidget {
  final double totalPrice;
  final bool isPrescription;
  final String currency;

  const PartialPayView2({
    super.key,
    required this.totalPrice,
    required this.isPrescription,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckoutController>(
      builder: (checkoutController) {
        final splashController = Get.find<SplashController>();
        final profileController = Get.find<ProfileController>();

        // Check if userInfoModel is not null before accessing its properties
        final walletBalance = profileController.userInfoModel?.walletBalance ?? 0.0;

        return  walletBalance > 0 ? splashController.configModel!.partialPaymentStatus! &&
                splashController.configModel!.customerWalletStatus == 1 &&
                walletBalance > 0
            ? WalletBalanceWidget(
                walletBalance: walletBalance,
                isPartialPay: checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
                onChanged: (value) {
                  if (value != null) {
                    if (walletBalance < totalPrice) {
                      checkoutController.changePartialPayment();
                    } else {
                      checkoutController.setPaymentMethod(value ? 1 : -1);
                    }
                  }
                },
                currency: currency,
              )
            : WalletBalanceWidget(
                walletBalance: walletBalance,
                isPartialPay: checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
                onChanged: (value) {
                  if (value != null) {
                    if (walletBalance < totalPrice) {
                      checkoutController.changePartialPayment();
                    } else {
                      checkoutController.setPaymentMethod(value ? 1 : -1);
                    }
                  }
                },
                currency: currency,
              ) : SizedBox();
      },
    );
  }
}