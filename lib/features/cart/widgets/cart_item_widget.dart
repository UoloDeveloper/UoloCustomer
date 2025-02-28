import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/item_bottom_sheet.dart';
import 'package:sixam_mart/common/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class CartItemWidget extends StatelessWidget {
//   final CartModel cart;
//   final int cartIndex;
//   final List<AddOns> addOns;
//   final bool isAvailable;
//   const CartItemWidget({super.key, required this.cart, required this.cartIndex, required this.isAvailable, required this.addOns});

//   @override
//   Widget build(BuildContext context) {

//     double? startingPrice = _calculatePriceWithVariation(item: cart.item);
//     double? endingPrice = _calculatePriceWithVariation(item: cart.item, isStartingPrice: false);
//     String? variationText = _setupVariationText(cart: cart);
//     String addOnText = _setupAddonsText(cart: cart) ?? '';

//     double? discount = cart.item!.storeDiscount == 0 ? cart.item!.discount : cart.item!.storeDiscount;
//     String? discountType = cart.item!.storeDiscount == 0 ? cart.item!.discountType : 'percent';
//     String genericName = '';

//     if(cart.item!.genericName != null && cart.item!.genericName!.isNotEmpty) {
//       for (String name in cart.item!.genericName!) {
//         genericName += name;
//       }
//     }

//     return Padding(
//       padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
//       child: Slidable(
//         key: UniqueKey(),
//         endActionPane: ActionPane(
//           motion: const ScrollMotion(),
//           extentRatio: 0.2,
//           children: [
//             SlidableAction(
//               onPressed: (context) {
//                 Get.find<CartController>().removeFromCart(cartIndex, item: cart.item);
//               },
//               backgroundColor: Theme.of(context).colorScheme.error,
//               borderRadius: BorderRadius.horizontal(right: Radius.circular(Get.find<LocalizationController>().isLtr ? Dimensions.radiusDefault : 0), left: Radius.circular(Get.find<LocalizationController>().isLtr ? 0 : Dimensions.radiusDefault)),
//               foregroundColor: Colors.white,
//               icon: Icons.delete_outline,
//             ),
//           ],
//         ),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//             borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             boxShadow: !ResponsiveHelper.isMobile(context) ? [const BoxShadow()] : [const BoxShadow(
//               color: Colors.black12, blurRadius: 5, spreadRadius: 1,
//             )],
//           ),
//           child: CustomInkWell(
//             onTap: () {
//               ResponsiveHelper.isMobile(context) ? showModalBottomSheet(
//                 context: context,
//                 isScrollControlled: true,
//                 backgroundColor: Colors.transparent,
//                 builder: (con) => ItemBottomSheet(item: cart.item, cartIndex: cartIndex, cart: cart),
//               ) : showDialog(context: context, builder: (con) => Dialog(
//                 child: ItemBottomSheet(item: cart.item, cartIndex: cartIndex, cart: cart),
//               ));
//             },
//             radius: Dimensions.radiusDefault,
//             padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeExtraSmall),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Stack(
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                         child: CustomImage(
//                           image: '${cart.item!.imageFullUrl}',
//                           height: ResponsiveHelper.isDesktop(context) ? 90 : 60, width: ResponsiveHelper.isDesktop(context) ? 90 : 60, fit: BoxFit.cover,
//                         ),
//                       ),
//                       isAvailable ? const SizedBox() : Positioned(
//                         top: 0, left: 0, bottom: 0, right: 0,
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.black  ),
//                           child: Text('not_available_now_break'.tr, textAlign: TextAlign.center, style: robotoRegular.copyWith(
//                             color: Colors.white, fontSize: 8,
//                           )),
//                         ),
//                       ),
//                     ],
//                   ),
//                   const SizedBox(width: Dimensions.paddingSizeSmall),

//                   Expanded(
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
//                       Row(children: [
//                         Flexible(
//                           child: Text(
//                             cart.item!.name!,
//                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
//                             maxLines: 2, overflow: TextOverflow.ellipsis,
//                           ),
//                         ),
//                         const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                         ((Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && cart.item!.unitType != null && !Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!)
//                             || (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!))
//                             ? !Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! ? CustomAssetImageWidget(
//                           cart.item!.veg == 0 ? Images.nonVegImage : Images.vegImage,
//                           height: 11, width: 11,
//                         ) : Container(
//                           padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                             color: Theme.of(context).primaryColor  ,
//                           ),
//                           child: Text(
//                             cart.item!.unitType ?? '',
//                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
//                           ),
//                         ) : const SizedBox(),

//                         SizedBox(width: cart.item!.isStoreHalalActive! && cart.item!.isHalalItem! ? Dimensions.paddingSizeExtraSmall : 0),

//                         cart.item!.isStoreHalalActive! && cart.item!.isHalalItem! ? const CustomAssetImageWidget(
//                          Images.halalTag, height: 13, width: 13) : const SizedBox(),

//                       ]),

//                       (genericName.isNotEmpty) ? Padding(
//                         padding: const EdgeInsets.only(top: 2.0),
//                         child: Row(children: [
//                           Flexible(
//                             child: Text(
//                               genericName,
//                               style: robotoMedium.copyWith(
//                                 fontSize: Dimensions.fontSizeSmall,
//                                 color: Theme.of(context).disabledColor,
//                               ),
//                               maxLines: 1, overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ]),
//                       ) : const SizedBox(),

//                       const SizedBox(height: 2),

//                       Wrap(children: [
//                         Text(
//                           '${PriceConverter.convertPrice(startingPrice, discount: discount, discountType: discountType)}'
//                               '${endingPrice!= null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: discount, discountType: discountType)}' : ''}',
//                           style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall), textDirection: TextDirection.ltr,
//                         ),
//                         SizedBox(width: discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),

//                         discount > 0 ? Text(
//                           '${PriceConverter.convertPrice(startingPrice)}'
//                               '${endingPrice!= null ? ' - ${PriceConverter.convertPrice(endingPrice)}' : ''}',
//                           textDirection: TextDirection.ltr,
//                           style: robotoRegular.copyWith(
//                             color: Theme.of(context).disabledColor, decoration: TextDecoration.lineThrough,
//                             fontSize: Dimensions.fontSizeExtraSmall,
//                           ),
//                         ) : const SizedBox(),
//                       ]),

//                       cart.item!.isPrescriptionRequired! ? Padding(
//                         padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 2),
//                         child: Text(
//                           '* ${'prescription_required'.tr}',
//                           style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).colorScheme.error),
//                         ),
//                       ) : const SizedBox(),

//                       addOnText.isNotEmpty ? Padding(
//                         padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
//                         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                           Text('${'addons'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
//                           Flexible(child: Text(
//                             addOnText,
//                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                           )),
//                         ]),
//                       ) : const SizedBox(),

//                       variationText!.isNotEmpty ? Padding(
//                         padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
//                         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                           Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
//                           Flexible(child: Text(
//                             variationText,
//                             style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                           )),
//                         ]),
//                       ) : const SizedBox(),
//                     ]),
//                   ),

//                   GetBuilder<CartController>(
//                     builder: (cartController) {
//                       return Padding(
//                         padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault+2),
//                         child: Row(children: [
//                           QuantityButton(
//                             onTap: cartController.isLoading ? null : () {
//                               if (cart.quantity! > 1) {
//                                 Get.find<CartController>().setQuantity(false, cartIndex, cart.stock, cart.quantityLimit);
//                               }else {
//                                 Get.find<CartController>().removeFromCart(cartIndex, item: cart.item);
//                               }
//                             },
//                             isIncrement: false,
//                             showRemoveIcon: cart.quantity! == 1,
//                           ),

//                           Text(
//                             cart.quantity.toString(),
//                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge),
//                           ),

//                           QuantityButton(
//                             onTap: cartController.isLoading ? null : () {
//                               Get.find<CartController>().forcefullySetModule(Get.find<CartController>().cartList[0].item!.moduleId!);
//                               Get.find<CartController>().setQuantity(true, cartIndex, cart.stock, cart.quantityLimit);
//                             },
//                             isIncrement: true,
//                             color: cartController.isLoading ? Theme.of(context).disabledColor : null,
//                           ),
//                         ]),
//                       );
//                     }
//                   ),
//                 ]),

//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   double? _calculatePriceWithVariation({required Item? item, bool isStartingPrice = true}) {
//     double? startingPrice;
//     double? endingPrice;
//     bool newVariation = Get.find<SplashController>().getModuleConfig(item!.moduleType).newVariation ?? false;

//     if(item.variations!.isNotEmpty && !newVariation) {
//       List<double?> priceList = [];
//       for (var variation in item.variations!) {
//         priceList.add(variation.price);
//       }
//       priceList.sort((a, b) => a!.compareTo(b!));
//       startingPrice = priceList[0];
//       if(priceList[0]! < priceList[priceList.length-1]!) {
//         endingPrice = priceList[priceList.length-1];
//       }
//     }else {
//       startingPrice = item.price;
//     }
//     if(isStartingPrice) {
//       return startingPrice;
//     } else {
//       return endingPrice;
//     }
//   }

//   String? _setupVariationText({required CartModel cart}) {
//     String? variationText = '';

//     if(Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!) {
//       if(cart.foodVariations!.isNotEmpty) {
//         for(int index=0; index<cart.foodVariations!.length; index++) {
//           if(cart.foodVariations![index].contains(true)) {
//             variationText = '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${cart.item!.foodVariations![index].name} (';
//             for(int i=0; i<cart.foodVariations![index].length; i++) {
//               if(cart.foodVariations![index][i]!) {
//                 variationText = '${variationText!}${variationText.endsWith('(') ? '' : ', '}${cart.item!.foodVariations![index].variationValues![i].level}';
//               }
//             }
//             variationText = '${variationText!})';
//           }
//         }
//       }
//     }else {
//       if(cart.variation!.isNotEmpty) {
//         List<String> variationTypes = cart.variation![0].type!.split('-');
//         if(variationTypes.length == cart.item!.choiceOptions!.length) {
//           int index0 = 0;
//           for (var choice in cart.item!.choiceOptions!) {
//             variationText = '${variationText!}${(index0 == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index0]}';
//             index0 = index0 + 1;
//           }
//         }else {
//           variationText = cart.item!.variations![0].type;
//         }
//       }
//     }
//     return variationText;
//   }

//   String? _setupAddonsText({required CartModel cart}) {
//     String addOnText = '';
//     int index0 = 0;
//     List<int?> ids = [];
//     List<int?> qtys = [];
//     for (var addOn in cart.addOnIds!) {
//       ids.add(addOn.id);
//       qtys.add(addOn.quantity);
//     }
//     for (var addOn in cart.item!.addOns!) {
//       if (ids.contains(addOn.id)) {
//         addOnText = '$addOnText${(index0 == 0) ? '' : ',  '}${addOn.name} (${qtys[index0]})';
//         index0 = index0 + 1;
//       }
//     }
//     return addOnText;
//   }
// }
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:sixam_mart/common/widgets/cart_count_view.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/item_bottom_sheet%20copy.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/item_bottom_sheet.dart';
import 'package:sixam_mart/common/widgets/quantity_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartItemWidget extends StatelessWidget {
  final CartModel cart;
  final item;
  final int cartIndex;
  final List<AddOns> addOns;
  final bool isAvailable;
  final bool fromcheckout;
  // final bool fromcheckout;
  const CartItemWidget({super.key, required this.cart, required this.cartIndex, required this.isAvailable, required this.addOns,  this.fromcheckout = false, this.item});

  @override
  Widget build(BuildContext context) {
double? variationprice =  getSelectedOptionPrice(cart.toJson());
    double? startingPrice =
     _calculatePriceWithVariation(item: cart.item);
    double? endingPrice = _calculatePriceWithVariation(item: cart.item, isStartingPrice: false);
    String? variationText = _setupVariationText(cart: cart);
    String addOnText = _setupAddonsText(cart: cart) ?? '';

    double? discount = cart.item!.storeDiscount == 0 ? cart.item!.discount : cart.item!.storeDiscount;
    String? discountType = cart.item!.storeDiscount == 0 ? cart.item!.discountType : 'percent';
    String genericName = '';

    if(cart.item!.genericName != null && cart.item!.genericName!.isNotEmpty) {
      for (String name in cart.item!.genericName!) {
        genericName += name;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: Slidable(
        key: UniqueKey(),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
              onPressed: (context) {
                Get.find<CartController>().removeFromCart(cartIndex, item: cart.item);
              },
              backgroundColor: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.horizontal(right: Radius.circular(Get.find<LocalizationController>().isLtr ? Dimensions.radiusDefault : 0), left: Radius.circular(Get.find<LocalizationController>().isLtr ? 0 : Dimensions.radiusDefault)),
              foregroundColor: Colors.white,
              icon: Icons.delete_outline,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            // boxShadow: !ResponsiveHelper.isMobile(context) ? [const BoxShadow()] : [const BoxShadow(
            //   color: Colors.black12, blurRadius: 5, spreadRadius: 1,
            // )],
          ),
          child: CustomInkWell(
            onTap: () {
              ResponsiveHelper.isMobile(context) ? showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (con) => ItemBottomSheet(item: cart.item, cartIndex: cartIndex, cart: cart),
              ) : showDialog(context: context, builder: (con) => Dialog(
                child: ItemBottomSheet(item: cart.item, cartIndex: cartIndex, cart: cart),
              ));
            },
            radius: Dimensions.radiusDefault,
            padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeExtraSmall),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault + 2),
                        child: CustomImage(
                          image: '${cart.item!.imageFullUrl}',
                          height: ResponsiveHelper.isDesktop(context) ? 90 : 40, width: ResponsiveHelper.isDesktop(context) ? 90 : 40, fit: BoxFit.cover,
                        ),
                      ),
                      isAvailable ? const SizedBox() : Positioned(
                        top: 0, left: 0, bottom: 0, right: 0,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Colors.black.withOpacity(0.6)),
                          child: Text('not_available_now_break'.tr, textAlign: TextAlign.center, style: robotoRegular.copyWith(
                            color: Colors.white, fontSize: 8,
                          )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),

                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

                    
                      Row(children: [

                                    ((Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && cart.item!.unitType != null && !Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!)
                            || (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!))
                            ? !Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! ? CustomAssetImageWidget(
                          cart.item!.veg == 0 ? Images.nonVegImage : Images.vegImage,
                          height: 11, width: 11,
                        ) : Container(
                          padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                          ),
                          child: Text(
                            cart.item!.unitType ?? '',
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor, ),
                          ),
                        ) : const SizedBox(),

                                const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                        Flexible(
                          child: Text(
                            cart.item!.name!,
                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w700,color: Colors.grey[700] ),
                            maxLines: 2, overflow: TextOverflow.ellipsis,

                          ),
                        ),
                
            

                        SizedBox(width: cart.item!.isStoreHalalActive! && cart.item!.isHalalItem! ? Dimensions.paddingSizeExtraSmall : 0),

                        cart.item!.isStoreHalalActive! && cart.item!.isHalalItem! ? const CustomAssetImageWidget(
                         Images.halalTag, height: 13, width: 13) : const SizedBox(),

                      ]),

                   cart.item!.choiceOptions == null ?  
                     Wrap(children: [

                          ( discount ?? 0) > 0 ? Text(
                          '${PriceConverter.convertPrice( startingPrice,)}'
                              '${endingPrice!= null ? ' - ${PriceConverter.convertPrice(endingPrice,)}' : ''}',
                          textDirection: TextDirection.ltr,
                          style: robotoRegular.copyWith(
                            color: Theme.of(context).disabledColor, decoration: TextDecoration.lineThrough,
                            fontSize: Dimensions.fontSizeExtraSmall,
                          ),
                        ) : const SizedBox(),

                              SizedBox(width: (discount?? 0) > 0 ? Dimensions.paddingSizeExtraSmall : 0),
                        Text(
                          '${PriceConverter.convertPrice(startingPrice, discount: discount, discountType: discountType,)}'
                              '${endingPrice!= null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: discount, discountType: discountType)}' : ''}',
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall), textDirection: TextDirection.ltr,
                        ),
                  

                     
                      ]) : Wrap(
                        children: [
                            Text(
                          '${PriceConverter.convertPrice(variationprice ?? cart.price, discount: discount, discountType: discountType,)}'
                              ,
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall), textDirection: TextDirection.ltr,
                        )
                        ],
                      ),
                     
                     
                      (genericName.isNotEmpty) ? Padding(
                        padding: const EdgeInsets.only(top: 2.0),
                        child: Row(children: [
                          Flexible(
                            child: Text(
                              genericName,
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                                color: Theme.of(context).disabledColor,
                              ),
                              maxLines: 1, overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ]),
                      ) : const SizedBox(),

                      const SizedBox(height: 2),

                 

                      cart.item!.isPrescriptionRequired! ? Padding(
                        padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 2),
                        child: Text(
                          '* ${'prescription_required'.tr}',
                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).colorScheme.error),
                        ),
                      ) : const SizedBox(),

                      addOnText.isNotEmpty ? Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${'addons'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                          Flexible(child: Text(
                            addOnText,
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          )),
                        ]),
                      ) : const SizedBox(),

                      variationText!.isNotEmpty ? Padding(
                        padding: const EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
                        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${'variations'.tr}: ', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                          Flexible(child: Text(
                            variationText,
                            style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                          )),
                        ]),
                      ) : const SizedBox(),
                    ]),
                  ),

                  GetBuilder<CartController>(
                    builder: (cartController) {
                      return  Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          //  width:  100,
                                            height: 35,
              decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                          ),
                                        ],
                                      ),
                          child: Row(children: [
                            QuantityButton(
                              
                              onTap: cartController.isLoading ? null : () {
                                if (cart.quantity! > 1) {
                                  Get.find<CartController>().setQuantity(false, cartIndex, cart.stock, cart.quantityLimit);
                                  // fromcheckout ? CheckoutScreenState().initCall() : null;
                                }else {
                                  Get.find<CartController>().removeFromCart(cartIndex, item: cart.item);
                                }
                              },
                              isIncrement: false,
                              showRemoveIcon: cart.quantity! == 1,
                            ),
                          
                            Text(
                              cart.quantity.toString(),
                              style: robotoMedium.copyWith(fontSize:   cart.quantity.toString().length < 2 ?Dimensions.fontSizeDefault : Dimensions.fontSizeDefault -2,color: Colors.green),
                            ),
                          
                            QuantityButton(
                              onTap: cartController.isLoading ? null : () {
                                Get.find<CartController>().forcefullySetModule(Get.find<CartController>().cartList[0].item!.moduleId!);
                                Get.find<CartController>().setQuantity(true, cartIndex, cart.stock, cart.quantityLimit);
                                  // fromcheckout ? CheckoutScreenState().initCall() : null;
                              },
                              isIncrement: true,
                              color: cartController.isLoading ? Theme.of(context).disabledColor : null,
                            ),
                          ]),
                        ),
                      );
                    }
                  ),





                ]),

              ],
            ),
          ),
        ),
      ),
    );
  }

  double? _calculatePriceWithVariation({required Item? item, bool isStartingPrice = true}) {
    double? startingPrice;
    double? endingPrice;
    bool newVariation = Get.find<SplashController>().getModuleConfig(item!.moduleType).newVariation ?? false;

    if(item.variations!.isNotEmpty && !newVariation) {
      List<double?> priceList = [];
      for (var variation in item.variations!) {
        priceList.add(variation.price);
      }
      priceList.sort((a, b) => a!.compareTo(b!));
      startingPrice = priceList[0];
      if(priceList[0]! < priceList[priceList.length-1]!) {
        endingPrice = priceList[priceList.length-1];
      }
    }else {
      startingPrice = item.price;
    }
    if(isStartingPrice) {
      return startingPrice;
    } else {
      return endingPrice;
    }
  }

  String? _setupVariationText({required CartModel cart}) {
    String? variationText = '';

    if(Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!) {
      if(cart.foodVariations!.isNotEmpty) {
        for(int index=0; index<cart.foodVariations!.length; index++) {
          if(cart.foodVariations![index].contains(true)) {
            variationText = '${variationText!}${variationText.isNotEmpty ? ', ' : ''}${cart.item!.foodVariations![index].name} (';
            for(int i=0; i<cart.foodVariations![index].length; i++) {
              if(cart.foodVariations![index][i]!) {
                variationText = '${variationText!}${variationText.endsWith('(') ? '' : ', '}${cart.item!.foodVariations![index].variationValues![i].level}';
              }
            }
            variationText = '${variationText!})';
          }
        }
      }
    }else {
      if(cart.variation!.isNotEmpty) {
        List<String> variationTypes = cart.variation![0].type!.split('-');
        if(variationTypes.length == cart.item!.choiceOptions!.length) {
          int index0 = 0;
          for (var choice in cart.item!.choiceOptions!) {
            variationText = '${variationText!}${(index0 == 0) ? '' : ',  '}${choice.title} - ${variationTypes[index0]}';
            index0 = index0 + 1;
          }
        }else {
          variationText = cart.item!.variations![0].type;
        }
      }
    }
    return variationText;
  }

  String? _setupAddonsText({required CartModel cart}) {
    String addOnText = '';
    int index0 = 0;
    List<int?> ids = [];
    List<int?> qtys = [];
    for (var addOn in cart.addOnIds!) {
      ids.add(addOn.id);
      qtys.add(addOn.quantity);
    }
    for (var addOn in cart.item!.addOns!) {
      if (ids.contains(addOn.id)) {
        addOnText = '$addOnText${(index0 == 0) ? '' : ',  '}${addOn.name} (${qtys[index0]})';
        index0 = index0 + 1;
      }
    }
    return addOnText;
  }


double? getSelectedOptionPrice(Map<String, dynamic> cart) {
  if (cart['item'] != null && cart['item']['food_variations'] != null) {
    for (var variation in cart['item']['food_variations']) {
      var values = variation['values'] as List<dynamic>?;
      if (values != null) {
        for (var value in values) {
          if (value['isSelected'] == true) {
            return (value['optionPrice'] as num?)?.toDouble();
          }
        }
      }
    }
  }
  return null;
}
}
