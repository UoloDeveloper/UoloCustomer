import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/features/cart/widgets/delivery_option_button_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';

class DeliveryOptionsWidget extends StatelessWidget {
  final int? storeId;
  final double originalCharge;
  final double deliveryCharge;
  final double badWeatherChargeForToolTip;
  final double extraChargeForToolTip;
  final double total;
  final String _deliveryChargeForView;
  final dynamic checkoutController;

  const DeliveryOptionsWidget({
    Key? key,
    this.storeId,
    required this.originalCharge,
    required this.deliveryCharge,
    required this.badWeatherChargeForToolTip,
    required this.extraChargeForToolTip,
    required this.total,
    required String deliveryChargeForView,
    required this.checkoutController,
  })  : _deliveryChargeForView = deliveryChargeForView,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(
            Dimensions.radiusLarge
          ),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).primaryColor.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Theme(
          data:  
          ThemeData(
            dividerColor: Colors.transparent,
             splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
          ),
          child: ExpansionTile(
            
            title: Text(
              "Delivery Type".tr,
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: [
              storeId != null
                  ? DeliveryOptionButtonWidget(
                      value: 'delivery',
                      title: 'Home delivery',
                      charge: originalCharge,
                      isFree: checkoutController.store!.freeDelivery,
                      fromWeb: true,
                      total: total,
                      deliveryChargeForView: _deliveryChargeForView,
                      badWeatherCharge: badWeatherChargeForToolTip,
                      extraChargeForToolTip: extraChargeForToolTip,
                    )
                  : Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        if (Get.find<SplashController>()
                                    .configModel!
                                    .homeDeliveryStatus ==
                                1 &&
                            checkoutController.store!.delivery!)
                          DeliveryOptionButtonWidget(
                            value: 'delivery',
                            title: 'Home delivery',
                            charge: originalCharge,
                            isFree: checkoutController.store!.freeDelivery,
                            fromWeb: true,
                            total: total,
                            deliveryChargeForView: _deliveryChargeForView,
                            badWeatherCharge: badWeatherChargeForToolTip,
                            extraChargeForToolTip: extraChargeForToolTip,
                          ),
                        if (Get.find<SplashController>()
                                    .configModel!
                                    .takeawayStatus ==
                                1 &&
                            checkoutController.store!.takeAway!)
                          DeliveryOptionButtonWidget(
                            value: 'take_away',
                            title: 'Take away',
                            charge: deliveryCharge,
                            isFree: true,
                            fromWeb: true,
                            total: total,
                            deliveryChargeForView: _deliveryChargeForView,
                            badWeatherCharge: badWeatherChargeForToolTip,
                            extraChargeForToolTip: extraChargeForToolTip,
                          ),
                      ],
                    ),

                    SizedBox(height: 10,)
            ],
          ),
        ),
      ),
    );
  }
}
