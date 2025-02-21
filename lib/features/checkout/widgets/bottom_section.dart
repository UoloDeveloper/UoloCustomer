import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/address_widget.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/checkout/widgets/prescription_image_picker_widget.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/common/models/config_model.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/checkout/widgets/condition_check_box.dart';
import 'package:sixam_mart/features/checkout/widgets/coupon_section.dart';
import 'package:sixam_mart/features/checkout/widgets/note_prescription_section.dart';
import 'package:sixam_mart/features/checkout/widgets/partial_pay_view.dart';

class BottomSection extends StatelessWidget {
  final CheckoutController checkoutController;
  final AddressModel SelectedAddress;
  final double total;
  final Module module;
  final double subTotal;
  final double discount;
  final CouponController couponController;
  final bool taxIncluded;
  final double tax;
  final double deliveryCharge;
  final bool todayClosed;
  final bool tomorrowClosed;
  final double orderAmount;
  final double? maxCodOrderAmount;
  final int? storeId;
  final double? taxPercent;
  final  double price;
  final double addOns;
  final Widget? checkoutButton;
  final bool isPrescriptionRequired;
  final double referralDiscount;
  final double variationPrice;
  final double distance;
  final double dicount;

  const BottomSection({super.key, required this.checkoutController, required this.total, required this.module, required this.subTotal,
    required this.discount, required this.couponController, required this.taxIncluded, required this.tax,
    required this.deliveryCharge, required this.todayClosed, required this.tomorrowClosed,
    required this.orderAmount, this.maxCodOrderAmount, this.storeId, this.taxPercent, required this.price,
    required this.addOns, this.checkoutButton, required this.isPrescriptionRequired, required this.referralDiscount, required this.variationPrice, required this.distance, required this.dicount, required this.SelectedAddress});

  @override
  Widget build(BuildContext context) {
    bool takeAway = checkoutController.orderType == 'take_away';
    bool isDesktop = ResponsiveHelper.isDesktop(context);
    bool isGuestLoggedIn = AuthHelper.isGuestLoggedIn();
    return Container(
      decoration: !ResponsiveHelper.isDesktop(context) ? BoxDecoration(
        // color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
        // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
      ) : null,
      padding: const EdgeInsets.symmetric(vertical: 0),
      child: Column(children: [

        // isDesktop ? pricingView(context: context, takeAway: takeAway) : const SizedBox(),

        // const SizedBox(height: Dimensions.paddingSizeSmall),

        /// Coupon
        // isDesktop && !isGuestLoggedIn ? CouponSection(
        //   storeId: storeId, checkoutController: checkoutController, total: total, price: price,
        //   discount: discount, addOns: addOns, deliveryCharge: deliveryCharge, variationPrice: variationPrice,
        // ) : const SizedBox(),

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.05), blurRadius: 10)],
            borderRadius: BorderRadius.circular(Dimensions.radiusLarge)
          ),
          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeLarge),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

            ///Additional Note & prescription..
            // NoteAndPrescriptionSection(checkoutController: checkoutController, storeId: storeId),

            // isDesktop && !isGuestLoggedIn ? PartialPayView2(totalPrice: total, isPrescription: storeId != null, currency: '',) : const SizedBox(),

            // !isDesktop ? pricingView(context: context, takeAway: takeAway) : const SizedBox(),
            // const SizedBox(height: Dimensions.paddingSizeLarge),

            ///ToDo : Prescription Image Picker
            PrescriptionImagePickerWidget(checkoutController: checkoutController, storeId: storeId, isPrescriptionRequired: isPrescriptionRequired),

            // const CheckoutCondition(),
      //  const Divider(),
  Padding(
                                          padding: const EdgeInsets.only(
                                              top: 10.0,
                                              bottom: 10,
                                              left: 3,
                                              right: 10),
                                          child: Row(
                                            children: [
                                              SvgPicture.asset(
                                                Images.dltime,
                                                width: 20,
                                                height: 20,
                                              ),
                                              const SizedBox(width: 5),
                                              const Text('Deliver in '),
                                              Text('30 mins ',
                                                  style: robotoBold),
                                            ],
                                          ),
                                        ),
                                           const Divider(),

                                           AddressWidget(address: SelectedAddress, fromAddress: false),
                                             const Divider(),
                         GetBuilder<ProfileController>(builder: (profileController) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 3.0, top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      Images.dlcall,
                                      width: 19,
                                      height: 19,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                        '${profileController.userInfoModel?.fName} ${profileController.userInfoModel?.lName ?? ''}'),
                                    Text(
                                        '${profileController.userInfoModel?.phone} ',
                                        style: robotoBold),
                                  ],
                                ),
                              );
                            }
                          ),
                          const Divider(),
                          //  !isDesktop && !isGuestLoggedIn ? PartialPayView(totalPrice: widget.subTotal, isPrescription: widget.Storeid != null) : const SizedBox(),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, top: 10, bottom: 10),
                            child: InkWell(
                              onTap: () {
                                // showPricingBottomSheet(context, false

                                // );
                                showPricingBottomSheet(
                                    context,
                                    takeAway,
                                    checkoutController,
                                    tax,
                                    couponController,
                                    distance,
                                    deliveryCharge,
                                    dicount,
                                    subTotal);
                              },
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        Images.dlbill,
                                        width: 19,
                                        height: 19,
                                      ),
                                      const SizedBox(width: 5),
                                      Column(
                                        children: [
                                          Text(checkoutController.isPartialPay
                                              ? 'due_payment'.tr
                                              : 'Total Bill '),
                                        ],
                                      ),
                                      // Text(PriceConverter.convertPrice(subTotal), style: robotoMedium, textDirection: TextDirection.ltr),
                                      PriceConverter.convertAnimationPrice(
                                        checkoutController.viewTotalPrice,
                                        textStyle: robotoBold.copyWith(),
                                      ),

                                      const Expanded(child: SizedBox()),

                                      Container(
                                        decoration: BoxDecoration(
                                            color: const Color(0xFFD7E5FF),
                                            borderRadius:
                                                BorderRadius.circular(9)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(7.0),
                                          child: Text(
                                            "Order Summary",
                                            style: robotoRegular.copyWith(
                                                fontSize: 10,
                                                color: const Color(0xFF366BC9),
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 4,
                                      ),
                                      const Icon(Icons.arrow_forward_ios_sharp,
                                          size: 15, color: Colors.black),
                                      // Padding(
                                      //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
                                      //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                      //     Text(
                                      //       checkoutController.isPartialPay ? 'due_payment'.tr : 'Total Bill '
                                      //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                                      //     ),
                                      //     PriceConverter.convertAnimationPrice(
                                      //       checkoutController.viewTotalPrice,
                                      //       textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                                      //     ),
                                      //   ]),
                                      // ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 25),
                                        child: Text(
                                          "Incl.taxes & delivery charges",
                                          style: robotoRegular.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeSmall,
                                              color: Colors.grey),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      
                      
            // const SizedBox(height: Dimensions.paddingSizeLarge),
            ResponsiveHelper.isDesktop(context) ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                       Text( 'total_amount'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                      storeId == null ? const SizedBox()
                          : Text(
                          'Once_your_order_is_confirmed_you_will_receive'.tr,
                          style: robotoRegular.copyWith(
                              fontSize: Dimensions.fontSizeOverSmall, color: Theme.of(context).disabledColor,
                          ),
                      ),
                    ],
                  ),
                  storeId == null ? const SizedBox()
                      : Text(
                    'a_notification_with_your_bill_total'.tr,
                    style: robotoRegular.copyWith(
                      fontSize: Dimensions.fontSizeOverSmall, color: Theme.of(context).disabledColor,
                    ),
                  ),
                ],
              ),
              PriceConverter.convertAnimationPrice(
                checkoutController.viewTotalPrice,
                textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: checkoutController.isPartialPay ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor,),
                currency:   Get.find<CartController>().getCurrncyForUi()
              ),
            ]) : const SizedBox(),
          ]),
        ),

        ResponsiveHelper.isDesktop(context) ? Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
          child: checkoutButton,
        ) : const SizedBox(),

      ]),
    );
  }

  Widget pricingView({required BuildContext context, required bool takeAway}) {
    return Column(children: [

      ResponsiveHelper.isDesktop(context) ? Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSmall),
          child: Text('order_summary'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
        ),
      ) : const SizedBox(),

      Padding(
        padding: EdgeInsets.symmetric(horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : 0),
        child: Column(
          children: [
            storeId == null ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(module.addOn! ? 'subtotal'.tr : 'item_price'.tr, style: robotoMedium),
              Text(PriceConverter.convertPrice(subTotal,currency: Get.find<CartController>().getCurrncyForUi() ), style: robotoMedium, textDirection: TextDirection.ltr),
            ]) : const SizedBox(),
            SizedBox(height: storeId == null ? Dimensions.paddingSizeSmall : 0),

            storeId == null ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('discount'.tr, style: robotoRegular),
              Text('(-) ${PriceConverter.convertPrice(discount,currency: Get.find<CartController>().getCurrncyForUi())}', style: robotoRegular, textDirection: TextDirection.ltr),
            ]) : const SizedBox(),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            (couponController.discount! > 0 || couponController.freeDelivery) ? Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('coupon_discount'.tr, style: robotoRegular),
                (couponController.coupon != null && couponController.coupon!.couponType == 'free_delivery') ? Text(
                  'free_delivery'.tr, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),
                ) : Text(
                  '(-) ${PriceConverter.convertPrice(couponController.discount,currency: Get.find<CartController>().getCurrncyForUi())}',
                  style: robotoRegular, textDirection: TextDirection.ltr,
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            ]) : const SizedBox(),

            referralDiscount > 0 ? Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text('referral_discount'.tr, style: robotoRegular),

                Text(
                  '(-) ${PriceConverter.convertPrice(referralDiscount,currency: Get.find<CartController>().getCurrncyForUi())}',
                  style: robotoRegular, textDirection: TextDirection.ltr,
                ),
              ]),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            ]) : const SizedBox(),

            storeId == null ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('${'vat_tax'.tr} ${taxIncluded ? 'tax_included'.tr : ''} ($taxPercent%)', style: robotoRegular),
              Text((taxIncluded ? '' : '(+) ') + PriceConverter.convertPrice(tax,currency: Get.find<CartController>().getCurrncyForUi()), style: robotoRegular, textDirection: TextDirection.ltr),
            ]) : const SizedBox(),
            SizedBox(height: storeId == null ? Dimensions.paddingSizeSmall : 0),

            (!takeAway && Get.find<SplashController>().configModel!.dmTipsStatus == 1) ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('delivery_man_tips'.tr, style: robotoRegular),
                Text('(+) ${PriceConverter.convertPrice(checkoutController.tips,currency: Get.find<CartController>().getCurrncyForUi())}', style: robotoRegular, textDirection: TextDirection.ltr),
              ],
            ) : const SizedBox.shrink(),
            SizedBox(height: !takeAway && Get.find<SplashController>().configModel!.dmTipsStatus == 1 ? Dimensions.paddingSizeSmall : 0.0),

            (checkoutController.store!.extraPackagingStatus! && Get.find<CartController>().needExtraPackage) ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('extra_packaging'.tr, style: robotoRegular),
                Text('(+) ${PriceConverter.convertPrice(checkoutController.store!.extraPackagingAmount!,currency: Get.find<CartController>().getCurrncyForUi())}', style: robotoRegular, textDirection: TextDirection.ltr),
              ],
            ) : const SizedBox.shrink(),
            SizedBox(height: checkoutController.store!.extraPackagingStatus! && Get.find<CartController>().needExtraPackage ? Dimensions.paddingSizeSmall : 0.0),

            (AuthHelper.isGuestLoggedIn() && checkoutController.guestAddress == null)
            ? const SizedBox() : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('delivery_fee'.tr, style: robotoRegular),
              checkoutController.distance == -1 ? Text(
                'calculating'.tr, style: robotoRegular.copyWith(color: Colors.red),
              ) : (deliveryCharge == 0 || (couponController.coupon != null && couponController.coupon!.couponType == 'free_delivery')) ? Text(
                'free'.tr, style: robotoRegular.copyWith(color: Theme.of(context).primaryColor),
              ) : Text(
                '(+) ${PriceConverter.convertPrice(deliveryCharge,currency: Get.find<CartController>().getCurrncyForUi())}', style: robotoRegular, textDirection: TextDirection.ltr,
              ),
            ]),

            SizedBox(height: Get.find<SplashController>().configModel!.additionalChargeStatus! && !(AuthHelper.isGuestLoggedIn() && checkoutController.guestAddress == null) ? Dimensions.paddingSizeSmall : 0),

            Get.find<SplashController>().configModel!.additionalChargeStatus! ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(Get.find<SplashController>().configModel!.additionalChargeName!, style: robotoRegular),
              Text(
                '(+) ${PriceConverter.convertPrice(Get.find<SplashController>().configModel!.additionCharge,currency: Get.find<CartController>().getCurrncyForUi())}',
                style: robotoRegular, textDirection: TextDirection.ltr,
              ),
            ]) : const SizedBox(),
            SizedBox(height: checkoutController.isPartialPay ? Dimensions.paddingSizeSmall : 0),

            checkoutController.isPartialPay ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('paid_by_wallet'.tr, style: robotoRegular),
              Text('(-) ${PriceConverter.convertPrice(Get.find<ProfileController>().userInfoModel!.walletBalance!)}', style: robotoRegular, textDirection: TextDirection.ltr),
            ]) : const SizedBox(),
            SizedBox(height: checkoutController.isPartialPay ? Dimensions.paddingSizeSmall : 0),

            checkoutController.isPartialPay ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(
                'due_payment'.tr,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor),
              ),
              PriceConverter.convertAnimationPrice(
                checkoutController.viewTotalPrice,
                textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor),
                currency: Get.find<CartController>().getCurrncyForUi()
              )
            ]) : const SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
              child: Divider(thickness: 1, color: Theme.of(context).hintColor.withOpacity(0.5)),
            ),
          ],
        ),
      ),


    ]);
  }



}


void showPricingBottomSheet(BuildContext context, bool takeAway , CheckoutController  checkoutController, tax,  CouponController couponController,distance,deliveryCharge,discount,subtotal) {
   String currency = Get.find<CartController>().getCurrncyForUi();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
    ),
    builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Close button
            Container(
              width: 40,
              height: 40,
              margin: const EdgeInsets.only(top: 10),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            // Content
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Color(0xFFF4F5FA),
                borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
              ),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   const SizedBox(height: 10),
                  Container(
                    decoration: const BoxDecoration(color: Color(0xFFF4F5FA)),
                    child: const Text(
                      "mary",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/image/icons/Vector (2).svg", height: 17, width: 17, color: Colors.black87),
                                  const SizedBox(width: 5),
                                   Text(
                                    "Sub Total",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              discount < 0 ?     Text(
                                PriceConverter.convertPrice(subtotal,currency: currency ),
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ) : Row(
                                children: [
                                   Text(
                                   "₹${subtotal}",
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w500,
                                       decoration: TextDecoration.lineThrough,
        decorationColor:  Colors.grey,
                                      
                                    ),
                                  ),

                                  SizedBox(width: 5),
                                  Text(
                                   "₹${subtotal - discount}",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),


                            ],
                          ),
                          const SizedBox(height: 10,),
                         discount < 0 ?   Row(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.discount_sharp, size: 17, color: Colors.black87),
                                  const SizedBox(width: 5),
                                 Text(
                                    "Discount",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                               Text(
                                discount != null ? PriceConverter.convertPrice(discount ,currency: currency) : discount ??0,
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                  // color: Colors.red
                                ),
                              ),
                            ],
                          ) : const SizedBox(),
                         // const SizedBox(height: 5,),
                          // const SizedBox(height: 10),
                           Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/image/icons/Group 14459.svg", height: 17, width: 17, color: Colors.black87),
                                  const SizedBox(width: 5),
                                   Text(
                                    "GST and restaurant charge",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                               Text(
                                PriceConverter.convertPrice(tax,currency: currency),
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                              const SizedBox(height: 10,),
                           Row(
                            children: [
                              Row(
                                children: [
                                 const Icon(Icons.payments, size: 17),
                                  const SizedBox(width: 5),
                                   Text(
                                    "Delivery Man Tip",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                               Text(
                                PriceConverter.convertPrice(checkoutController.tips,currency: currency),
                                style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                             const SizedBox(height: 10,),

                        
                           Row(
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset("assets/image/icons/Group.svg", height: 14, width: 14),
                                  const SizedBox(width: 5),
                                   Text(
                                    "Delivery Partner fee",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                               distance == -1 ? Text(
                'calculating'.tr, style:  TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ) : (deliveryCharge == 0 || (couponController.coupon != null && couponController.coupon!.couponType == 'free_delivery')) ? Text(
                'free'.tr, style:  TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                ),
              ) : Text(
                ' ${PriceConverter.convertPrice(deliveryCharge,currency: currency)}',  
                   style: TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,),
                 textDirection: TextDirection.ltr,
              ),


                  
                            ],
                          ),
 const SizedBox(height: 10,),
                         checkoutController.isPartialPay ?  Row(children: [
                               Row(
                                children: [
                                 const Icon(Icons.wallet, size: 17),
                                  const SizedBox(width: 5),
                                   Text(
                                    "Paid By wallet",
                                    style: TextStyle(
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                               checkoutController.isPartialPay ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              // Text('paid_by_wallet'.tr, style: robotoRegular),
              Text('${PriceConverter.convertPrice(Get.find<ProfileController>().userInfoModel!.walletBalance!,currency: currency)}', style:TextStyle(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,), textDirection: TextDirection.ltr),
            ]) : const SizedBox(),
                          ],) : SizedBox(),
                          checkoutController.isPartialPay ? Row(
                            children: [
                           
            // SizedBox(height: checkoutController.isPartialPay ? Dimensions.paddingSizeSmall : 0),

//             checkoutController.isPartialPay ? Row(
//               children: [
//                 Row( children: [
//                   Text(
//                     'due_payment'.tr,
//                     style: TextStyle(
//                        fontSize: Dimensions.fontSizeDefault,
//                                           fontWeight: FontWeight.w400,
//                     )
                    
//                     // robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor),
//                   ),
                
//                     // Spacer(),
                
                   
//                   // PriceConverter.convertAnimationPrice(
//                   //   checkoutController.viewTotalPrice,
//                   //   textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: !ResponsiveHelper.isDesktop(context) ? Theme.of(context).textTheme.bodyMedium!.color : Theme.of(context).primaryColor),
//                   //   currency: Get.find<CartController>().getCurrncyForUi()
//                   // )
//                 ]),



//                   Text('${PriceConverter.convertPrice(  checkoutController.viewTotalPrice,currency: currency)}', style:TextStyle(
//                                       fontSize: Dimensions.fontSizeDefault,
//                                       fontWeight: FontWeight.w500,), textDirection: TextDirection.ltr),
//               ],
//             ) : const SizedBox(),

// //                                Text(
// "₹-${checkoutController.viewpartialpayPrice}",

//                                 // PriceConverter.convertPrice(checkoutController.viewpartialpayPrice,),
//                                 style: TextStyle(
//                                   fontSize: Dimensions.fontSizeDefault,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                               ),
                            ],
                          ) : const SizedBox(),
                          
                           SizedBox(height: Get.find<SplashController>().configModel!.additionalChargeStatus! && !(AuthHelper.isGuestLoggedIn() && checkoutController.guestAddress == null) ? Dimensions.paddingSizeSmall : 0),

            Get.find<SplashController>().configModel!.additionalChargeStatus! ? Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text(Get.find<SplashController>().configModel!.additionalChargeName!, style: robotoRegular),
              Text(
                ' ${PriceConverter.convertPrice(Get.find<SplashController>().configModel!.additionCharge,currency: currency)}',
                style: robotoRegular, textDirection: TextDirection.ltr,
              ),
            ]) : const SizedBox(),
                          const Divider(),
                          Row(
                            children: [
                             Text(
                                "Grand Total",
                                style: TextStyle(
                                  fontSize:   Dimensions.fontSizeLarge,
                 
              
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const Spacer(),
                               Text(
                                PriceConverter.convertPrice(checkoutController.viewTotalPrice,currency: currency),
                                style: TextStyle(
                                   fontSize: Dimensions.fontSizeLarge,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      WaveTopSection(
                      discount: discount ,
                      ),

                      
                    ],
                  ),
                
                    const SizedBox(  height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:  [
                      Text("PAYMENT PREFERENCES",style: TextStyle(
                         color:  const Color(0xFF868686),
                         fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400
                      ),),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width /2.5,
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cash on Delivery Preferred",style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600
                              ),),
                                  Text("We prefer cash on delivery, even though the delivery personnel have all online UPI payment options",style: TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF868686)
                                  ),),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        child: Stack(
                          children: [
                            SvgPicture.asset("assets/image/freepik--background-complete--inject-31.svg", width: 106, height: 121),
                            Positioned(
                              left: 40,
                              top: 50,
                              child: Image.asset("assets/image/Indian-shopkeeper-is-holding-money-in-hand-10-small 1.png", height: 84, width: 84)),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      color: Colors.white,
                       
                    ),

                    child:const Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment:   MainAxisAlignment.center ,
                        children: [
                      
                          Paymenticoncard(image: "assets/image/paytmlogo.png"),
                          SizedBox(width: 10,),
                          Paymenticoncard(image: "assets/image/gpayicon.png"),
                          SizedBox(width: 10,),
                          Paymenticoncard(image: "assets/image/png-transparent-phonepe-india-unified-payments-interface-india-purple-violet-text 1.png"),
                          SizedBox(width: 10,),
                          Paymenticoncard(image: "assets/image/bharat-interface-for-money-bhim-logo-vector 1.png"),
                          SizedBox(width: 10,),
                          Paymenticoncard(image: "assets/image/5968269 1.png")
                        
                        ],
                      ),
                    )
                  ),
              
              SizedBox(height: 80,)
              
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

class WaveTopSection extends StatelessWidget {
  final double discount;

  const WaveTopSection({super.key, required this.discount});
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFFD8E6FF),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipPath(
            clipper: WaveClipper(),
            child: Container(
              height: 150,
              color: Colors.white,
            ),
          ),
          Positioned(
            child: discount > 0
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "🥳",
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'You saved ${PriceConverter.convertPrice(discount)} on delivery',
                      style: robotoBold.copyWith(
                        color: const Color(0xFF366BC9),
                        fontSize: Dimensions.fontSizeDefault,
                      ),
                    ),
                  ],
                )
              : Text(
                  "Thank You For Shopping With Us",
                  style: robotoBold.copyWith(
                    color: const Color(0xFF366BC9),
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 0); // Start from the top-left corner
    for (int i = 0; i < size.width.toInt(); i += 20) {
      var controlPointX = (i + 10).toDouble();
      var controlPointY = (i % 40 == 0 ? 10 : 20).toDouble();
      var endPointX = (i + 20).toDouble();
      var endPointY = (i % 40 == 0 ? 20 : 10).toDouble();
      path.lineTo(i.toDouble(), controlPointY);
      path.cubicTo(
        controlPointX,
        controlPointY,
        controlPointX,
        endPointY,
        endPointX,
        endPointY,
        
      );
    }
    path.lineTo(size.width, 0); // End at the top-right corner
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

