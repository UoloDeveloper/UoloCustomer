import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryInstructionView extends StatefulWidget {
  const DeliveryInstructionView({super.key});

  @override
  State<DeliveryInstructionView> createState() => _DeliveryInstructionViewState();
}

class _DeliveryInstructionViewState extends State<DeliveryInstructionView> {
  ExpansionTileController controller = ExpansionTileController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(    Dimensions.radiusDefault) ,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).primaryColor.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 15.0,
        vertical: 0.0,
      ),
      child: GetBuilder<CheckoutController>(builder: (orderController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
              child: ExpansionTile(
                key: widget.key,
                controller: controller,
                title: Text(
                  'add_more_delivery_instruction'.tr,
                  style:  robotoMedium,
                ),
                trailing: Icon(
                  orderController.isExpanded ? Icons.arrow_downward : Icons.arrow_forward_ios,
                  size: 15,
                ),
                tilePadding: const EdgeInsets.all(0),
                // onExpansionChanged: (value) => orderController.expandedUpdate(value),
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: AppConstants.deliveryInstructionList.length,
                        itemBuilder: (context, index) {
                          bool isSelected = orderController.selectedInstruction == index;
                          return InkWell(
                            onTap: () {
                              orderController.setInstruction(index);
                              // if (controller.isExpanded) {
                              //   controller.collapse();
                              // }
                            },
                            child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).primaryColor.withOpacity(0.5)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                    
                                border: Border.all(
                                  color: Colors.black12
                                )
                              ),
                              padding: const EdgeInsets.all(8.0),
                              margin: const EdgeInsets.symmetric(horizontal: 4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(
                                    Icons.integration_instructions,
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Theme.of(context).disabledColor,
                                    size: 18,
                                  ),
                                  const SizedBox(height: 20,),
                                  Expanded(
                                    child: Text(
                                      AppConstants.deliveryInstructionList[index].tr,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.0,
                                        color: isSelected
                                            ? Theme.of(context).primaryColor
                                            :  Colors.grey[600],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
               
                ],
              ),
            ),
            // if (orderController.selectedInstruction != -1)
            //   Padding(
            //     padding: EdgeInsets.symmetric(
            //       vertical: orderController.isExpanded ? 8.0 : 0,
            //     ),
            //     child: Row(
            //       children: [
            //         Text(
            //           AppConstants.deliveryInstructionList[orderController.selectedInstruction].tr,
            //           style: TextStyle(
            //             fontWeight: FontWeight.w400,
            //             color: Theme.of(context).primaryColor,
            //           ),
            //         ),
            //         InkWell(
            //           onTap: () => orderController.setInstruction(-1),
            //           child: const Icon(
            //             Icons.clear,
            //             size: 16,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
          ],
        );
      }),
    );
  }
}
