import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/payment/widgets/offline_payment_button.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_button_new.dart';
class PaymentMethodBottomSheet extends StatefulWidget {
  final bool isCashOnDeliveryActive;
  final bool isDigitalPaymentActive;
  final bool isOfflinePaymentActive;
  final bool isWalletActive;
  final int? storeId;
  final double totalPrice;
  const PaymentMethodBottomSheet({super.key, required this.isCashOnDeliveryActive, required this.isDigitalPaymentActive,
    required this.isWalletActive, required this.storeId, required this.totalPrice, required this.isOfflinePaymentActive});

  @override
  State<PaymentMethodBottomSheet> createState() => _PaymentMethodBottomSheetState();
}

class _PaymentMethodBottomSheetState extends State<PaymentMethodBottomSheet> {
  bool canSelectWallet = true;
  bool notHideCod = true;
  bool notHideWallet = true;
  bool notHideDigital = true;
  final JustTheController tooltipController = JustTheController();

  @override
  void initState() {
    super.initState();

    print('=====digital payments : ${Get.find<SplashController>().configModel!.activePaymentMethodList!}');

    if(!AuthHelper.isGuestLoggedIn()) {
      double walletBalance = Get.find<ProfileController>().userInfoModel!.walletBalance!;
      if(walletBalance < widget.totalPrice){
        canSelectWallet = false;
      }
      if(Get.find<CheckoutController>().isPartialPay){
        notHideWallet = false;
        if(Get.find<SplashController>().configModel!.partialPaymentMethod! == 'cod'){
          notHideCod = true;
          notHideDigital = false;
        } else if(Get.find<SplashController>().configModel!.partialPaymentMethod! == 'digital_payment'){
          notHideCod = false;
          notHideDigital = true;
        } else if(Get.find<SplashController>().configModel!.partialPaymentMethod! == 'both'){
          notHideCod = true;
          notHideDigital = true;
        }
      }
    }

    print('=====check: ${widget.storeId == null} && ${widget.isDigitalPaymentActive} && ${notHideDigital}');
  }
  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();
    bool isDesktop = ResponsiveHelper.isDesktop(context);

    log("testing     //////////"+ widget.storeId.toString() + ' ' + widget.isWalletActive.toString());
    log(widget.isDigitalPaymentActive.toString());
    log(notHideDigital.toString());
    

    return SizedBox(
      width: 550,
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: Colors.transparent,
         
        ),
      
        child: Column(mainAxisSize: MainAxisSize.min, children: [

          CustomInkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
                      padding:  const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        shape: BoxShape.circle,
                        boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 5)],
                      ),
                      child: const Icon(Icons.close, size: 30,color: Colors.white,),
                  ),
          ),
          const SizedBox(height: Dimensions.paddingSizeSmall),

          Container(
            decoration: BoxDecoration(
                    color:Color(0xFFF0F0F5),
                    //  Theme.of(context).cardColor,
               borderRadius: BorderRadius.vertical(
            top: const Radius.circular(Dimensions.radiusLarge),
            bottom: Radius.circular(ResponsiveHelper.isDesktop(context) ? Dimensions.radiusLarge : 0),
          )
            ),
      
              padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeLarge),
            child: Column(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeDefault : 0),
                    child: GetBuilder<CheckoutController>(
                      builder: (checkoutController) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // const SizedBox(height: Dimensions.paddingSizeDefault),
            
                            // Align(alignment: Alignment.center, child: Text('payment_method'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge))),
                            const SizedBox(height: Dimensions.paddingSizeLarge),
            
                            notHideCod && (widget.isCashOnDeliveryActive && notHideCod) || (widget.storeId == null && widget.isWalletActive && notHideWallet && isLoggedIn)
                            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('choose_payment_method'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            
                              const SizedBox(height: Dimensions.paddingSizeLarge),
                            ]) : const SizedBox(),
            
                            Column(
                children: [
                  if (widget.isCashOnDeliveryActive && notHideCod)
                    Padding(
                      padding: EdgeInsets.only(
              bottom: widget.storeId == null && widget.isWalletActive && notHideWallet && isLoggedIn
                  ? Dimensions.paddingSizeSmall
                  : 0,
                      ),
                      child: PaymentButtonNew(
                        subtitle: "Pay cash or ask for QR code",
                        // assets\image\money2.png
              icon: "assets/image/money2.png",
              title: "Pay on Delivery (Cash/UPI)",
              isSelected: checkoutController.paymentMethodIndex == 0,
              onTap: () {
                checkoutController.setPaymentMethod(0);
                    Get.back();
              },
                      ),
                    ),
            
                  if (widget.storeId == null && widget.isWalletActive && notHideWallet && isLoggedIn)
                    Padding(
                      padding: EdgeInsets.only(
              top: widget.isCashOnDeliveryActive && notHideCod
                  ? 0
                  : 0,
                      ),
                      child: PaymentButtonNew(            
              icon: Images.partialWallet,
              // "assets/image/wallet2.png",
              title: 'pay_via_wallet'.tr,
              isSelected: checkoutController.paymentMethodIndex == 1,
              onTap: () {
                if (canSelectWallet) {
                  checkoutController.setPaymentMethod(1);
                  Get.back();
                  
                } else if (checkoutController.isPartialPay) {
                  showCustomSnackBar('you_can_not_user_wallet_in_partial_payment'.tr);
                  Get.back();
                } else {
                  showCustomSnackBar('your_wallet_have_not_sufficient_balance'.tr);
                  Get.back();
                }
              },
                      ),
                    ),
                ],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),
            
                            // widget.storeId == null && widget.isDigitalPaymentActive && notHideDigital ? Row(children: [
                            //   Text('pay_via_online'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
                            //   Text(
                            //     'faster_and_secure_way_to_pay_bill'.tr,
                            //     style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
                            //   ),
                            // ]) : const SizedBox(),
                            // SizedBox(height: widget.storeId == null && widget.isDigitalPaymentActive && notHideDigital ? Dimensions.paddingSizeLarge : 0),
            
                            widget.storeId == null && widget.isDigitalPaymentActive && notHideDigital ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                padding: EdgeInsets.zero,
                                itemCount: Get.find<SplashController>().configModel!.activePaymentMethodList!.length,
                                itemBuilder: (context, index) {
                                  bool isSelected = checkoutController.paymentMethodIndex == 2 && Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWay! == checkoutController.digitalPaymentName;
                                return  Padding(
                                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                                  child: PaymentButtonNew(isSelected: isSelected, icon: "${Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWayImageFullUrl!}", title: Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWayTitle!, onTap: (){
                                  
                                        checkoutController.setPaymentMethod(2);
                                       Get.back();
                                      checkoutController.changeDigitalPaymentName(Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWay!);
                                     
                                  
                                  },
                                  dynamic: true,
                                  ),
                                );
                                
                              //   InkWell(
                              //     onTap: (){
                              //       checkoutController.setPaymentMethod(2);
                              //        Get.back();
                              //       checkoutController.changeDigitalPaymentName(Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWay!);
                                   
                              //     },
                              //     child:
                                  
                              //      Container(
                              //       decoration: BoxDecoration(
                              //           color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
                              //           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              //         // border: Border.all(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, width: 0.5)
                              //       ),
                              //       padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeLarge),
                              //       margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                              //       child: Row(children: [

                              //          CustomImage(
                              //           height: 30, fit: BoxFit.contain,
                              //           image: Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWayImageFullUrl!,
                              //         ),
                                   
                              //         const SizedBox(width: Dimensions.paddingSizeDefault),
            
                              //         Expanded(
                              //           child: Text(
                              //             Get.find<SplashController>().configModel!.activePaymentMethodList![index].getWayTitle!,
                              //             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                              //             overflow: TextOverflow.ellipsis, maxLines: 1,
                              //           ),
                              //         ),
            
                              //           Container(
                              //           height: 20, width: 20,
                              //           decoration: BoxDecoration(
                              //               shape: BoxShape.circle, color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).cardColor,
                              //               border: Border.all(color: Theme.of(context).disabledColor)
                              //           ),
                              //           child: Icon(Icons.check, color: Theme.of(context).cardColor, size: 16),
                              //         ),
                              //         const SizedBox(width: Dimensions.paddingSizeSmall),
                              //       ]),
                              //     ),
                            
                            
                              // );
                              
                              
                                }) : const SizedBox(),
            
            
                            OfflinePaymentButton(
                              isSelected: checkoutController.paymentMethodIndex == 3,
                              offlineMethodList: checkoutController.offlineMethodList,
                              isOfflinePaymentActive: widget.isOfflinePaymentActive,
                              onTap: () {
                                checkoutController.setPaymentMethod(3);
                                    Get.back();
                              },
                              checkoutController: checkoutController, tooltipController: tooltipController,
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              ],
            ),
          ),

          // SafeArea(
          //   child: CustomButton(
          //     buttonText: 'select'.tr,
          //     onPressed: () => Get.back(),
          //   ),
          // ),

        ]),
      ),
    );
  }
}