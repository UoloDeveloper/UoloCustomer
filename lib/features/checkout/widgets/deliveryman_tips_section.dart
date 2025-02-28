import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/custom_text_field.dart';
import 'package:sixam_mart/features/checkout/widgets/tips_widget.dart';

class DeliveryManTipsSection extends StatefulWidget {
  final bool takeAway;
  final Currency;
  final JustTheController tooltipController3;
  final double totalPrice;
  final Function(double x) onTotalChange;
  final int? storeId;
  const DeliveryManTipsSection({ super.key, required this.takeAway, required this.tooltipController3, required this.totalPrice, required this.onTotalChange, this.storeId, this.Currency});

  @override
  State<DeliveryManTipsSection> createState() => _DeliveryManTipsSectionState();
}

class _DeliveryManTipsSectionState extends State<DeliveryManTipsSection> {
  bool canCheckSmall = false;

  @override
  Widget build(BuildContext context) {
    double total = widget.totalPrice;
    return GetBuilder<CheckoutController>(
      builder: (checkoutController) {
        return Column(
          children: [
            (!widget.takeAway && Get.find<SplashController>().configModel!.dmTipsStatus == 1)
                ? Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(    Dimensions.radiusDefault)),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).primaryColor.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                                ),
                                padding: const EdgeInsets.only(
                                 top: 8,
                                 left: 15
                                ),
                                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                        children: [
                          Expanded( 
                            child: Text(
                              'Day & night, our delivery partner brings your favorite meals. Thank them with a tip.',
                              style: TextStyle(
                                 fontSize: Dimensions.fontSizeSmall + 1,
                                 fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          const SizedBox(width: 15),
                          SizedBox(
                            height: 70,
                            width: 90,
                            child: Image.asset(Images.dlperson),
                          ),
                        ],
                      ),
                  // const SizedBox(height: Dimensions.paddingSizeSmall),
                  const SizedBox(height: Dimensions.paddingSizeDefault),
                  // const SizedBox(height: Dimensions.paddingSizeDefault),
                          
                  SizedBox(
                    height: (checkoutController.selectedTips == AppConstants.tips.length-1) && checkoutController.canShowTipsField
                        ? 0 : ResponsiveHelper.isDesktop(context) ? 80 : 60,
                    child: (checkoutController.selectedTips == AppConstants.tips.length-1) && checkoutController.canShowTipsField
                    ? const SizedBox() : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: AppConstants.tips.length,
                      itemBuilder: (context, index) {
                        return TipsWidget(
                          title: AppConstants.tips[index] == '0'
                              ? 'not_now'.tr
                              : (index != AppConstants.tips.length - 1)
                              ? PriceConverter.convertPrice(double.parse(AppConstants.tips[index].toString()), forDM: true,currency:widget.Currency )
                              : AppConstants.tips[index].tr,
                          isSelected: checkoutController.selectedTips == index,
                          // Change isSuggested to check if index is 2
                          isSuggested: index == 2,
                          onTap: () async {
                            total = total - checkoutController.tips;
                            checkoutController.updateTips(index);
                            if (checkoutController.selectedTips != AppConstants.tips.length - 1) {
                              checkoutController.addTips(double.parse(AppConstants.tips[index]));
                            }
                            if (checkoutController.selectedTips == AppConstants.tips.length - 1) {
                              checkoutController.showTipsField();
                            }
                            checkoutController.tipController.text = checkoutController.tips.toString();
                          
                            if (checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1) {
                              checkoutController.checkBalanceStatus((total + checkoutController.tips), 0);
                            }
                          },
                        );
                          
                      },
                    ),
                  ),
                  SizedBox(height: (checkoutController.selectedTips == AppConstants.tips.length-1) && checkoutController.canShowTipsField ? Dimensions.paddingSizeExtraSmall : 0),
                          //Save For Later Option
                  // checkoutController.selectedTips == AppConstants.tips.length-1 ? const SizedBox() : ListTile(
                  //   onTap: () => checkoutController.toggleDmTipSave(),
                  //   leading: Checkbox(
                  //     visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                  //     activeColor: Theme.of(context).primaryColor,
                  //     value: checkoutController.isDmTipSave,
                  //     onChanged: (bool? isChecked) => checkoutController.toggleDmTipSave(),
                  //   ),
                    // title: Text('save_for_later'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                  //   contentPadding: EdgeInsets.zero,
                  //   visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                  //   dense: true,
                  //   horizontalTitleGap: 0,
                  // ),
                  SizedBox(height: checkoutController.selectedTips == AppConstants.tips.length-1 ? Dimensions.paddingSizeDefault : 0),
                          
                  checkoutController.selectedTips == AppConstants.tips.length-1 ? Row(children: [
                    Expanded(
                      child: CustomTextField(
                        titleText: 'enter_amount'.tr,
                        controller: checkoutController.tipController,
                        inputAction: TextInputAction.done,
                        inputType: TextInputType.number,
                        onChanged: (String value) async {
                          if(value.isNotEmpty) {
                            try {
                              if(double.parse(value) >= 0){
                                if(AuthHelper.isLoggedIn()) {
                                  total = total - checkoutController.tips;
                                  await checkoutController.addTips(double.parse(value));
                                  total = total + checkoutController.tips;
                                  widget.onTotalChange(total);
                                  if(Get.find<ProfileController>().userInfoModel!.walletBalance! < total && checkoutController.paymentMethodIndex == 1){
                                    checkoutController.checkBalanceStatus(total, 0);
                                    canCheckSmall = true;
                                  } else if(Get.find<ProfileController>().userInfoModel!.walletBalance! > total && canCheckSmall && checkoutController.isPartialPay){
                                    checkoutController.checkBalanceStatus(total, 0);
                                  }
                                } else {
                                  checkoutController.addTips(double.parse(value));
                                }
                          
                              }else{
                                showCustomSnackBar('tips_can_not_be_negative'.tr);
                              }
                            }catch(e) {
                              showCustomSnackBar('invalid_input'.tr);
                              checkoutController.addTips(0.0);
                              checkoutController.tipController.text = checkoutController.tipController.text.substring(0, checkoutController.tipController.text.length-1);
                              checkoutController.tipController.selection = TextSelection.collapsed(offset: checkoutController.tipController.text.length);
                            }
                          }else {
                            checkoutController.addTips(0.0);
                          }
                        },
                          
                      ),
                    ),
                    // const SizedBox(width: Dimensions.paddingSizeSmall),
                    const SizedBox(height: Dimensions.paddingSizeDefault),
                          
                    InkWell(
                      onTap: () {
                        checkoutController.updateTips(0);
                        checkoutController.showTipsField();
                        if(checkoutController.isPartialPay) {
                          checkoutController.changePartialPayment();
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withOpacity(0.5),
                        ),
                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                        child: const Icon(Icons.clear),
                      ),
                    ),
                          
                  ]) : const SizedBox(),
                          
                                ]),
                              ),
                ) : const SizedBox.shrink(),
        
            SizedBox(height: (!widget.takeAway && widget.storeId == null && Get.find<SplashController>().configModel!.dmTipsStatus == 1)
                ? Dimensions.paddingSizeSmall : 0),
          ],
        );
      }
    );
  }
}
