
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/coupon/widgets/coupon_card_widget.dart';

class CouponPage extends StatelessWidget {
  final int? storeId;
  final CheckoutController checkoutController;

  const CouponPage({super.key, required this.storeId, required this.checkoutController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('available_promo'.tr),
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: Icon(Icons.clear, color: Theme.of(context).disabledColor),
          )
        ],
      ),
      body: Container(
        width: Dimensions.webMaxWidth,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeLarge),
        child: GetBuilder<CouponController>(builder: (couponController) {
          List<CouponModel>? couponList;
          if (couponController.couponList != null) {
            couponList = [];
            for (CouponModel coupon in couponController.couponList!) {
              if (coupon.storeId == null ||
                  (coupon.couponType != 'store_wise' && coupon.couponType != 'default' && coupon.couponType != 'free_delivery' && coupon.storeId == null) ||
                  coupon.storeId == storeId)     {
                    if (!RegExp(r'^[0]+$').hasMatch(coupon.title.toString().trim())) {
         couponList.add(coupon);
}
         
              }
            }
          }

          return couponList != null
              ? couponList.isNotEmpty
              ? GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: ResponsiveHelper.isDesktop(context) ? 3 : ResponsiveHelper.isTab(context) ? 2 : 1,
              mainAxisSpacing: Dimensions.paddingSizeSmall,
              crossAxisSpacing: Dimensions.paddingSizeSmall,
              childAspectRatio: ResponsiveHelper.isMobile(context) ? 3 : 3,
            ),
            itemCount: couponList.length,
            padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (couponList![index].code != null) {
                    checkoutController.couponController.text = couponList[index].code.toString();
                  }
                  Get.back();
                },
                child: CouponCardWidget(coupon: couponList![index], index: index),
              );
            },
          )
              : Column(
            children: [
              // Image.asset(Images.noCoupon, height: 70),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Text('no_promo_available'.tr, style: robotoMedium),
              const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Text(
                '${'please_add_manually_or_collect_promo_from'.tr} ${Get.find<SplashController>().configModel!.businessName!}',
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
              ),
              const SizedBox(height: 50),
            ],
          )
              : const Center(child: CircularProgressIndicator());
        }),
      ),
    );
  }
}
