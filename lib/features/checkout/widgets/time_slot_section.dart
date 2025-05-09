import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/common/models/config_model.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/checkout/widgets/time_slot_bottom_sheet.dart';

import 'package:flutter/material.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/common/models/config_model.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/checkout/widgets/time_slot_bottom_sheet.dart';

class TimeSlotSection extends StatelessWidget {
  final int? storeId;
  final CheckoutController checkoutController;
  final List<CartModel?>? cartList;
  final JustTheController tooltipController2;
  final bool tomorrowClosed;
  final bool todayClosed;
  final Module? module;

  const TimeSlotSection({
    super.key,
    this.storeId,
    required this.checkoutController,
    this.cartList,
    required this.tooltipController2,
    required this.tomorrowClosed,
    required this.todayClosed,
    this.module,
  });

  @override
  Widget build(BuildContext context) {
    bool isGuestLoggedIn = AuthHelper.isGuestLoggedIn();
    return Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
      child: Container(
    
        decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(
      Dimensions.radiusSmall + 4
    )
        ),
        child: Column(
          children: [

       !isGuestLoggedIn &&
                    storeId == null &&
                    checkoutController.store!.scheduleOrder! &&
                    cartList!.isNotEmpty &&
                    cartList![0]!.item!.availableDateStarts == null ?      SizedBox(
              height: Dimensions.paddingSizeSmall,
            ) : const SizedBox(),
            // Display time slot with a design similar to coupon section
            !isGuestLoggedIn &&
                    storeId == null &&
                    checkoutController.store!.scheduleOrder! &&
                    cartList!.isNotEmpty &&
                    cartList![0]!.item!.availableDateStarts == null
                ? GestureDetector(
                    onTap: () {
                      if (ResponsiveHelper.isDesktop(context)) {
                        showDialog(
                          context: context,
                          builder: (con) => Dialog(
                            child: TimeSlotBottomSheet(
                              tomorrowClosed: tomorrowClosed,
                              todayClosed: todayClosed,
                              module: module,
                            ),
                          ),
                        );
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (con) => TimeSlotBottomSheet(
                            tomorrowClosed: tomorrowClosed,
                            todayClosed: todayClosed,
                            module: module,
                          ),
                        );
                      }
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Padding(
                           padding: const EdgeInsets.symmetric(
                                        horizontal: Dimensions.paddingSizeLarge),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  child: const Icon(Icons.access_time),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Prefered Time',
                                  style: robotoMedium,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  // Ensure preferableTime is showing the correct selected time, otherwise show 'Select time'
                                  checkoutController.preferableTime.isNotEmpty
                                      ? checkoutController.preferableTime
                                      : 'Instance',
                                  style: robotoMedium,
                                ),
                                const SizedBox(width: 5),
                                const Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  size: 15,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
        
            // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            // const Padding(
            //   padding: EdgeInsets.only(left: Dimensions.paddingSizeLarge,right: Dimensions.paddingSizeLarge),
      
            //   // SizedBox(height: Dimensions.paddingSizeSmall,)
            //   // child: DottedDivider(
                
            //   // ),
      
            //   // SizedBox(height: Dimensions.paddingSizeSmall,)
            // ),
         !isGuestLoggedIn &&
                    storeId == null &&
                    checkoutController.store!.scheduleOrder! &&
                    cartList!.isNotEmpty &&
                    cartList![0]!.item!.availableDateStarts == null ?    const SizedBox(height: Dimensions.paddingSizeSmall,) : const SizedBox(),
            // const SizedBox(height: Dimensions.paddingSizeExtraLarge),
          ],
        ),
      ),
    );
  }
}
