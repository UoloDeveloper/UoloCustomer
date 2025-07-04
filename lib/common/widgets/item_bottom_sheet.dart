







import 'package:sixam_mart/common/widgets/cart_snackbar.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_tool_tip_widget.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';

import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/checkout/domain/models/place_order_body_model.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/module_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/quantity_button.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemBottomSheet extends StatefulWidget {
  final Item? item;
  final bool isCampaign;
  final CartModel? cart;
  final int? cartIndex;
  final bool inStorePage;
  const ItemBottomSheet({super.key, required this.item, this.isCampaign = false, this.cart, this.cartIndex, this.inStorePage = false});

  @override
  State<ItemBottomSheet> createState() => _ItemBottomSheetState();
}

class _ItemBottomSheetState extends State<ItemBottomSheet> {
  bool _newVariation = false;

  bool isMultiSelect = false;

  @override
  void initState() {
    super.initState();

    if(Get.find<SplashController>().module == null) {
      if(Get.find<SplashController>().cacheModule != null) {
        Get.find<SplashController>().setCacheConfigModule(Get.find<SplashController>().cacheModule);
      }
    }
    _newVariation = Get.find<SplashController>().getModuleConfig(widget.item!.moduleType).newVariation ?? false;
    Get.find<ItemController>().initData(widget.item, widget.cart);
  Get.find<ItemController>().setItem( widget.item);
   isMultiSelect = widget.item!.foodVariations!.any((element) => element.multiSelect == true);
      !isMultiSelect ? Get.find<ItemController>().setItem( widget.item) : null;

  }
     
 String currency = Get.find<CartController>().getCurrncyForUi();
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      margin: EdgeInsets.only(top: GetPlatform.isWeb ? 0 : 30),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: GetPlatform.isWeb ? const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)) : const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      child: GetBuilder<ItemController>(builder: (itemController) {
        // double? startingPrice;
        // double? endingPrice;
        // if (widget.item!.choiceOptions!.isNotEmpty && widget.item!.foodVariations!.isEmpty) {
        //   List<double?> priceList = [];
        //   for (var variation in widget.item!.variations!) {
        //     priceList.add(variation.price);
        //   }
        //   priceList.sort((a, b) => a!.compareTo(b!));
        //   startingPrice = priceList[0];
        //   if (priceList[0]! < priceList[priceList.length - 1]!) {
        //     endingPrice = priceList[priceList.length - 1];
        //   }
        // } else {
        //   startingPrice = widget.item!.price;
        // }

        // double? price = widget.item!.price;
        // double variationPrice = 0;
        // Variation? variation;
        // double? initialDiscount = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discount : widget.item!.storeDiscount;
        // double? discount = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discount : widget.item!.storeDiscount;
        // String? discountType = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discountType : 'percent';
        // int? stock = widget.item!.stock ?? 0;

        // if(discountType == 'amount'){
        //   discount = discount! * itemController.quantity!;
        // }

        // if(_newVariation) {
        //   for(int index = 0; index< widget.item!.foodVariations!.length; index++) {
        //     for(int i=0; i<widget.item!.foodVariations![index].variationValues!.length; i++) {
        //       if(itemController.selectedVariations[index][i]!) {
        //         variationPrice += widget.item!.foodVariations![index].variationValues![i].optionPrice!;
        //       }
        //     }
        //   }
        // }else {
        //   List<String> variationList = [];
        //   for (int index = 0; index < widget.item!.choiceOptions!.length; index++) {
        //     variationList.add(widget.item!.choiceOptions![index].options![itemController.variationIndex![index]].replaceAll(' ', ''));
        //   }
        //   String variationType = '';
        //   bool isFirst = true;
        //   for (var variation in variationList) {
        //     if (isFirst) {
        //       variationType = '$variationType$variation';
        //       isFirst = false;
        //     } else {
        //       variationType = '$variationType-$variation';
        //     }
        //   }

        //   for (Variation variations in widget.item!.variations!) {
        //     if (variations.type == variationType) {
        //       price = variations.price;
        //       variation = variations;
        //       stock = variations.stock;
        //       break;
        //     }
        //   }
        // }

        // price = price! + variationPrice;
        // double priceWithDiscount = PriceConverter.convertWithDiscount(price, discount, discountType)!;
        // double addonsCost = 0;
        // List<AddOn> addOnIdList = [];
        // List<AddOns> addOnsList = [];
        // for (int index = 0; index < widget.item!.addOns!.length; index++) {
        //   if (itemController.addOnActiveList[index]) {
        //     addonsCost = addonsCost + (widget.item!.addOns![index].price! * itemController.addOnQtyList[index]!);
        //     addOnIdList.add(AddOn(id: widget.item!.addOns![index].id, quantity: itemController.addOnQtyList[index]));
        //     addOnsList.add(widget.item!.addOns![index]);
        //   }
        // }
        // priceWithDiscount = priceWithDiscount;
        // double? priceWithDiscountAndAddons = priceWithDiscount + addonsCost;
        // bool isAvailable = DateConverter.isAvailable(widget.item!.availableTimeStarts, widget.item!.availableTimeEnds);
        // final  String currency = widget.item!.currency!.currencyCode!;
double? startingPrice;
double? endingPrice;
if (widget.item!.choiceOptions!.isNotEmpty && widget.item!.foodVariations!.isEmpty) {
  List<double?> priceList = [];
  for (var variation in widget.item!.variations!) {
    priceList.add(variation.price);
  }
  priceList.sort((a, b) => a!.compareTo(b!));
  startingPrice = priceList[0];
  if (priceList[0]! < priceList[priceList.length - 1]!) {
    endingPrice = priceList[priceList.length - 1];
  }
} else {
  startingPrice = widget.item!.price;
}

double? price = widget.item!.price;
double variationPrice = 0;
Variation? variation;
double? initialDiscount = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discount  : widget.item!.storeDiscount;
double? discount = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discount : widget.item!.storeDiscount;
String? discountType = (widget.isCampaign || widget.item!.storeDiscount == 0) ? widget.item!.discountType : 'percent';
int? stock = widget.item!.stock ?? 0;

if (discountType == 'amount' && discount != null && itemController.quantity != null) {
  discount = discount * itemController.quantity!;
}

if (_newVariation) {
  for (int index = 0; index < widget.item!.foodVariations!.length; index++) {
    for (int i = 0; i < widget.item!.foodVariations![index].variationValues!.length; i++) {
      if (itemController.selectedVariations[index][i]!) {
        variationPrice += widget.item!.foodVariations![index].variationValues![i].optionPrice ?? 0;
      }
    }
  }
} else {
  List<String> variationList = [];
  for (int index = 0; index < widget.item!.choiceOptions!.length; index++) {
    variationList.add(widget.item!.choiceOptions![index].options![itemController.variationIndex![index]].replaceAll(' ', ''));
  }
  String variationType = '';
  bool isFirst = true;
  for (var variation in variationList) {
    if (isFirst) {
      variationType = '$variationType$variation';
      isFirst = false;
    } else {
      variationType = '$variationType-$variation';
    }
  }

  for (Variation variations in widget.item!.variations!) {
    if (variations.type == variationType) {
      price = variations.price;
      variation = variations;
      stock = variations.stock;
      break;
    }
  }
}

price = (price ?? 0) + variationPrice;
double priceWithDiscount = PriceConverter.convertWithDiscount(price, discount, discountType) ?? 0;
double addonsCost = 0;
List<AddOn> addOnIdList = [];
List<AddOns> addOnsList = [];
for (int index = 0; index < widget.item!.addOns!.length; index++) {
  if (itemController.addOnActiveList[index]) {
    addonsCost = addonsCost + (widget.item!.addOns![index].price ?? 0) * (itemController.addOnQtyList[index] ?? 0);
    addOnIdList.add(AddOn(id: widget.item!.addOns![index].id, quantity: itemController.addOnQtyList[index]));
    addOnsList.add(widget.item!.addOns![index]);
  }
}
priceWithDiscount = priceWithDiscount;
double? priceWithDiscountAndAddons = priceWithDiscount + addonsCost;
bool isAvailable = DateConverter.isAvailable(widget.item!.availableTimeStarts, widget.item!.availableTimeEnds);
final String currency = widget.item!.currency?.currencyCode ?? '₹ '; 
        return ConstrainedBox(

          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: Stack(
            children: [

              Column(
                mainAxisSize: MainAxisSize.min, 
                children: [
               Container(
                color: Colors.transparent,
                height: 50,
                width: MediaQuery.of(context).size.width,
               ),
                // const SizedBox(height: Dimensions.paddingSizeLarge),

                Flexible(
                  child: Container(
                 
                    decoration: BoxDecoration(
                         color: const Color(0xFFF4F5FA)
,
                              borderRadius: GetPlatform.isWeb ? const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)) : const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
                    ),
                    child: SingleChildScrollView(
                      // padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeDefault),
                      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.end, children: [
                    
                        Padding(
                          padding: const EdgeInsets.all(0),
                          // padding: EdgeInsets.only(
                          //   right: Dimensions.paddingSizeDefault, top: ResponsiveHelper.isDesktop(context) ? 0 : 25,
                          // ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
                    
                          //Product
                          Container(
                            width: 550,
                            decoration: BoxDecoration(
                              color: Colors.white,
                                      borderRadius: GetPlatform.isWeb ? const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)) : const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                              
                                InkWell(
                                  onTap: widget.isCampaign ? null : () {
                                    if(!widget.isCampaign) {
                                      Get.toNamed(RouteHelper.getItemImagesRoute(widget.item!));
                                    }
                                  },
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(19),
                                      child: CustomImage(
                                        image: '${widget.item!.imageFullUrl ?? ""}',
                                        width: ResponsiveHelper.isMobile(context) ? 80 : 140,
                                        height: ResponsiveHelper.isMobile(context) ? 80 : 140,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    DiscountTag(discount: initialDiscount  , discountType: discountType, fromTop: 20, currency: currency ,),
                                  ]),
                                ),
                                const SizedBox(width: 10),
                              
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                    
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 0),
                                      child: Text(
                                        widget.item!.name!, style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 2, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        if(widget.inStorePage) {
                                          Get.back();
                                        }else {
                                          Get.back();
                                          Get.find<CartController>().forcefullySetModule(widget.item!.moduleId!);
                                          Get.toNamed(
                                            RouteHelper.getStoreRoute(id: widget.item!.storeId, page: 'item'),
                                          );
                                          Get.offNamed(RouteHelper.getStoreRoute(id: widget.item!.storeId, page: 'item'));
                                        }
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 5, 5, 5),
                                        child: Text(
                                          widget.item!.storeName!,
                                          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600, color: Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ),
                                    !widget.isCampaign ? RatingBar(rating: widget.item!.avgRating, size: 15, ratingCount: widget.item!.ratingCount) : const SizedBox(),
                             widget.item!.price! > 2 ?     Text(
                                      '${PriceConverter.convertPrice(startingPrice, discount: initialDiscount, discountType: discountType)}'
                                          '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice, discount: initialDiscount,
                                          discountType: discountType)}' : ''}',
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge), textDirection: TextDirection.ltr,
                                    ) : SizedBox(),
                                   widget.item!.price! > priceWithDiscount&&  widget.item!.price! > 2 ? Text(
                                      '${PriceConverter.convertPrice(startingPrice)}'
                                          '${endingPrice != null ? ' - ${PriceConverter.convertPrice(endingPrice)}' : ''}', textDirection: TextDirection.ltr,
                                      style: robotoMedium.copyWith(color: Theme.of(context).disabledColor, decoration: TextDecoration.lineThrough),
                                    ) : const SizedBox(),
                                  ]),
                                ),
                              
                                Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.end, children: [
                              
                                  widget.isCampaign ? const SizedBox(height: 25) : GetBuilder<FavouriteController>(builder: (wishList) {
                                    return InkWell(
                                      onTap: () {
                                        if(AuthHelper.isLoggedIn()) {
                                          wishList.wishItemIdList.contains(widget.item!.id) ? wishList.removeFromFavouriteList(widget.item!.id, false, getXSnackBar: true)
                                              : wishList.addToFavouriteList(widget.item, null, false, getXSnackBar: true);
                                        }else {
                                          showCustomSnackBar('you_are_not_logged_in'.tr, getXSnackBar: true);
                                        }
                                      },
                                      child: Container(

                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                            color: Theme.of(context).cardColor
                                        ),
                                        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                        margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                                        child: Icon(
                                          wishList.wishItemIdList.contains(widget.item!.id) ? Icons.favorite : Icons.favorite_border,
                                          color: wishList.wishItemIdList.contains(widget.item!.id) ? Colors.redAccent
                                              : Colors.redAccent,
                                        ),
                                      ),
                                    );
                                  }),
                                  const SizedBox(height: Dimensions.paddingSizeDefault),
                              
                                  widget.item!.isStoreHalalActive! && widget.item!.isHalalItem! ? Padding(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall, horizontal: Dimensions.paddingSizeExtraSmall),
                                    child: CustomToolTip(
                                      message: 'this_is_a_halal_food'.tr,
                                      preferredDirection: AxisDirection.up,
                                      child: const CustomAssetImageWidget(Images.halalTag, height: 35, width: 35),
                                    ),
                                  ) : const SizedBox(),
                              
                                ]),
                              
                              ]),
                            ),
                          ),
                    
                          const SizedBox(height: Dimensions.paddingSizeLarge),
                    
                          (widget.item!.description != null && widget.item!.description!.isNotEmpty) ? Padding(
                            padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                                    
                                  Text('description'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                                    
                                  ((Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && widget.item!.unitType != null)
                                || (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!)) ? Container(
                                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall, horizontal: Dimensions.paddingSizeSmall),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                                        color: Colors.transparent,
                                        // boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.2), blurRadius: 5)]
                                    ),
                                    child: Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! ? Text(
                                      widget.item!.unitType ?? '',
                                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).primaryColor),
                                    ) : Row(children: [
                                      Image.asset(
                                widget.item!.veg == 0
                                    ? Images.nonVegImage
                                    : Images.vegImage,
                                height:  15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                                      // Icon(
                                        // widget.item!.veg == 1 ? Icons.eco : Icons.fastfood,color:widget.item!.veg == 1 ?  ,),
                                      // Image.asset(widget.item!.veg == 1 ? Images.vegLogo : Images.nonVegLogo, height: 20, width: 20),
                                      const SizedBox(width: Dimensions.paddingSizeSmall),
                                                    
                                      Text(widget.item!.veg == 1 ? 'veg'.tr : 'non_veg'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
                                    ]),
                                  ) : const SizedBox(),
                                                    
                                ]),
                                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                                
                                Text(widget.item!.description!, style: robotoRegular.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color?.withOpacity(0.5))),
                                const SizedBox(height: Dimensions.paddingSizeLarge),
                              ],
                            ),
                          ) : const SizedBox(),
                    
                          // Variation
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,top: 1,bottom: 1),
                            child: _newVariation ? 
                            NewVariationView(
                              item: widget.item, itemController: itemController,
                              discount: initialDiscount, discountType: discountType, showOriginalPrice: (price > priceWithDiscount) && (discountType == 'percent'), currency: currency,
                            ) 
                            :  
                            // SizedBox(),
                            VariationView(
                              item: widget.item, itemController: itemController,
                            ),
                          ),
                          SizedBox(height: (Get.find<SplashController>().configModel!.moduleConfig!.module!.addOn! && widget.item!.addOns!.isNotEmpty) ? 0 : 0),
                    
                          // Addons
                          (Get.find<SplashController>().configModel!.moduleConfig!.module!.addOn! && widget.item!.addOns!.isNotEmpty)
                              ? Padding(
                           padding: const EdgeInsets.only(left: 10,right: 10,top: 1,bottom: 10),
                                child: AddonView(itemController: itemController, item: widget.item!, currency: currency,),
                              ): const SizedBox(),
                    
                    
                          isAvailable ? const SizedBox() : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                            margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              color: Theme.of(context).primaryColor.withOpacity(0.1),
                            ),
                            child: Column(children: [
                              Text('not_available_now'.tr, style: robotoMedium.copyWith(
                                color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge,
                              )),
                              Text(
                                '${'available_will_be'.tr} ${DateConverter.convertTimeToTime(widget.item!.availableTimeStarts!)} '
                                    '- ${DateConverter.convertTimeToTime(widget.item!.availableTimeEnds!)}',
                                style: robotoRegular,
                              ),
                            ]),
                          ),
                        ]),
                      ),
                      ]),
                    ),
                  ),
                ),

                ///Bottom side..
        !isAvailable ? SizedBox() :      (!widget.item!.scheduleOrder! && !isAvailable) ? const SizedBox() : Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: GetPlatform.isWeb ? const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(40)) : const BorderRadius.all(Radius.circular(0)),
                    boxShadow: ResponsiveHelper.isDesktop(context) ? null : const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(children: [

                    // Builder(
                    //   builder: (context) {
                    //    double? cost = PriceConverter.convertWithDiscount((price! * itemController.quantity!), discount, discountType);
                    //    double withAddonCost = cost! + addonsCost;
                    //     return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    //       // Text('${'total_amount'.tr}:', style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor)),
                    //       const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                    //       // Row(children: [
                    //       //   discount! > 0 ? PriceConverter.convertAnimationPrice(
                    //       //     (price * itemController.quantity!) + addonsCost,
                    //       //     currency: currency ,
                    //       //     textStyle: robotoMedium.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall, decoration: TextDecoration.lineThrough),
                    //       //   ) : const SizedBox(),
                    //       //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                    //       //   PriceConverter.convertAnimationPrice(
                    //       //     currency: currency ,
                    //       //     withAddonCost,
                    //       //     textStyle: robotoBold.copyWith(color: Theme.of(context).primaryColor),
                    //       //   ),
                    //       // ]),
                    //     ]);
                    //   }
                    // ),
                    // const SizedBox(height: Dimensions.paddingSizeSmall),

                    SafeArea(
                      child: Row(children: [
                          // Quantity
                       isMultiSelect ? SizedBox() :   Container(
                            decoration:  BoxDecoration(

                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              border: Border.all(color: Theme.of(context).primaryColor),
                            ),
                            width: 110,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 8,bottom: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                children: [
                                QuantityButton(
                                  onTap: () {
                                    if (itemController.quantity! > 1) {
                                      itemController.setQuantity(false, stock, widget.item!.quantityLimit, getxSnackBar: true);
                                    }
                                  },
                                  isIncrement: false,
                                  fromSheet: true,
                                ),
                                Text(itemController.quantity.toString(), style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                QuantityButton(
                                  onTap: () => itemController.setQuantity(true, stock, widget.item!.quantityLimit, getxSnackBar: true),
                                  isIncrement: true,
                                  fromSheet: true,
                                ),
                              ]),
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Expanded(child: 
                          GetBuilder<CartController>(
                            builder: (cartController) {
                              return Builder(
                                  builder: (context) {
                          double? cost = PriceConverter.convertWithDiscount((price! * itemController.quantity!), discount, discountType, );
                          double withAddonCost = cost! + addonsCost;
                                  
                                  return 
                                  CustomButton(
                                    width: ResponsiveHelper.isDesktop(context) ? MediaQuery.of(context).size.width / 2.0 : null,
                                    /*buttonText: isCampaign ? 'order_now'.tr : isExistInCart ? 'already_added_in_cart'.tr : fromCart
                                              ? 'update_in_cart'.tr : 'add_to_cart'.tr,*/
                                    isLoading: cartController.isLoading,
                                    buttonText: (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock! <= 0)
                                        ? 'out_of_stock'.tr : widget.isCampaign ? 'order_now'.tr
                                        : (widget.cart != null || itemController.cartIndex != -1) ? 'update_in_cart'.tr : withAddonCost.toInt() == 0 ? 'Add item'.tr :  'Add Item'.tr,
                                    onPressed: 
                                     isMultiSelect ? (){
                                      Get.back();
                                     }:   (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock! <= 0) ? null : () async {
                                      String? invalid;
                                      if(_newVariation) {
                                        for(int index=0; index<widget.item!.foodVariations!.length; index++) {
                                          if(!widget.item!.foodVariations![index].multiSelect! && widget.item!.foodVariations![index].required!
                                              && !itemController.selectedVariations[index].contains(true)) {
                                            invalid = '${'choose_a_variation_from'.tr} ${widget.item!.foodVariations![index].name}';
                                            break;
                                          }else if(widget.item!.foodVariations![index].multiSelect! && (widget.item!.foodVariations![index].required!
                                              || itemController.selectedVariations[index].contains(true)) && widget.item!.foodVariations![index].min!
                                              > itemController.selectedVariationLength(itemController.selectedVariations, index)) {
                                            invalid = '${'select_minimum'.tr} ${widget.item!.foodVariations![index].min} '
                                                '${'and_up_to'.tr} ${widget.item!.foodVariations![index].max} ${'options_from'.tr}'
                                                ' ${widget.item!.foodVariations![index].name} ${'variation'.tr}';
                                            break;
                                          }
                                        }
                                      }
                                  
                                      if(Get.find<SplashController>().moduleList != null) {
                                        for(ModuleModel module in Get.find<SplashController>().moduleList!) {
                                          if(module.id == widget.item!.moduleId) {
                                            Get.find<SplashController>().setModule(module);
                                            break;
                                          }
                                        }
                                      }
                                  
                                      if(invalid != null) {
                                        showCustomSnackBar(invalid, getXSnackBar: true);
                                      }else 
                                      {
                                  
                                  
                                        CartModel cartModel = CartModel(
                                          null, price, priceWithDiscountAndAddons, variation != null ? [variation] : [], itemController.selectedVariations,
                                          (price! - PriceConverter.convertWithDiscount(price, discount, discountType)!),
                                          itemController.quantity, addOnIdList, addOnsList, widget.isCampaign, stock, widget.item,  widget.item?.quantityLimit
                                        );
                                  
                                        List<OrderVariation> variations = _getSelectedVariations(
                                          isFoodVariation: Get.find<SplashController>().getModuleConfig(widget.item!.moduleType).newVariation!,
                                          foodVariations: widget.item!.foodVariations!, selectedVariations: itemController.selectedVariations,
                                        );
                                        List<int?> listOfAddOnId = _getSelectedAddonIds(addOnIdList: addOnIdList);
                                        List<int?> listOfAddOnQty = _getSelectedAddonQtnList(addOnIdList: addOnIdList);
                                  
                                        OnlineCart onlineCart = OnlineCart(
                                          (widget.cart != null || itemController.cartIndex != -1) ? widget.cart?.id ?? cartController.cartList[itemController.cartIndex].id : null,
                                          widget.isCampaign ? null : widget.item!.id, widget.isCampaign ? widget.item!.id : null,
                                          priceWithDiscountAndAddons.toString(), '', variation != null ? [variation] : null,
                                          Get.find<SplashController>().getModuleConfig(widget.item!.moduleType).newVariation! ? variations : null,
                                          itemController.quantity, listOfAddOnId, addOnsList, listOfAddOnQty, 'Item',
                                        );
                                  
                                        if(widget.isCampaign) {
                                          Get.toNamed(RouteHelper.getCheckoutRoute('campaign'), arguments: CheckoutScreen(
                                            storeId: null,
                                             fromCart: false, cartList: [cartModel],
                                          ));
                                        }else {
                                          if (Get.find<CartController>().existAnotherStoreItem(
                                              cartModel.item!.storeId, Get.find<SplashController>().module != null
                                              ? Get.find<SplashController>().module!.id : Get.find<SplashController>().cacheModule!.id,
                                          )) {
                                            Get.dialog(ConfirmationDialog(
                                              icon: Images.warning,
                                              title: 'are_you_sure_to_reset'.tr,
                                              description: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                                                  ? 'if_you_continue'.tr : 'if_you_continue_without_another_store'.tr,
                                              onYesPressed: () {
                                                Get.back();
                                                Get.find<CartController>().clearCartOnline().then((success) async {
                                                  if(success) {
                                                    await Get.find<CartController>().addToCartOnline(onlineCart);
                                                    Get.back();
                                                    //showCartSnackBar();
                                                  }
                                                });
                                  
                                              },
                                            ), barrierDismissible: false);
                                          } else {
                                            if(widget.cart != null || itemController.cartIndex != -1){
                                              await Get.find<CartController>().updateCartOnline(onlineCart).then((success) {
                                                if(success) {
                                                  Get.back();
                                                }
                                              });
                                            } else {
                                              await Get.find<CartController>().addToCartOnline(onlineCart).then((success) {
                                                if(success) {
                                                  Get.back();
                                                }
                                              });
                                            }
                                  
                                            // showCartSnackBar();
                                          }
                                        }
                                    
                                    
                                    
                                    
                                    
                                      }
                                    },
                                                               
                                                               
                                                               
                                  );
                          
                          
                                }
                              );
                            }
                          )),
                     
                     
                        ]),
                    ),
                  ]),
                ),
              ]),

              Positioned(
                top: 0, right: 10,left: 10,
                child: InkWell(
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                    onTap: () => Get.back(),
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
              ),
            ],
          ),
        );
      }),
    );
  }

  List<OrderVariation> _getSelectedVariations({required bool isFoodVariation, required List<FoodVariation>? foodVariations, required List<List<bool?>> selectedVariations}) {
    List<OrderVariation> variations = [];
    if(isFoodVariation) {
      for(int i=0; i<foodVariations!.length; i++) {
        if(selectedVariations[i].contains(true)) {
          variations.add(OrderVariation(name: foodVariations[i].name, values: OrderVariationValue(label: [])));
          for(int j=0; j<foodVariations[i].variationValues!.length; j++) {
            if(selectedVariations[i][j]!) {
              variations[variations.length-1].values!.label!.add(foodVariations[i].variationValues![j].level);
            }
          }
        }
      }
    }
    return variations;
  }

  List<int?> _getSelectedAddonIds({required List<AddOn> addOnIdList }) {
    List<int?> listOfAddOnId = [];
    for (var addOn in addOnIdList) {
      listOfAddOnId.add(addOn.id);
    }
    return listOfAddOnId;
  }

  List<int?> _getSelectedAddonQtnList({required List<AddOn> addOnIdList }) {
    List<int?> listOfAddOnQty = [];
    for (var addOn in addOnIdList) {
      listOfAddOnQty.add(addOn.quantity);
    }
    return listOfAddOnQty;
  }

}

class AddonView extends StatelessWidget {
  final Item item;
  final ItemController itemController;
  final String currency;
  const AddonView({super.key, required this.item, required this.itemController, required this.currency});

  @override
  Widget build(BuildContext context) {
    return Container(
    
       decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: itemController.selectedVariations[index].contains(true) ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Extra'.tr, style: robotoMedium),
            
              Text(
                'Select up to 1 option'.tr,
                style: robotoRegular.copyWith(color: Theme.of(context).hintColor, fontSize: Dimensions.fontSizeSmall),
              ),
            ]),
            // const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        
            ListView.builder(
        
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: item.addOns!.length,
              itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      if (!itemController.addOnActiveList[index]) {
                        itemController.addAddOn(true, index);
                      } else if (itemController.addOnQtyList[index] == 1) {
                        itemController.addAddOn(false, index);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                      child: Row(children: [
        
                        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        
                          Checkbox(
                            value: itemController.addOnActiveList[index],
                            activeColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                            onChanged:(bool? newValue) {
                              if (!itemController.addOnActiveList[index]) {
                                itemController.addAddOn(true, index);
                              } else if (itemController.addOnQtyList[index] == 1) {
                                itemController.addAddOn(false, index);
                              }
                            },
                            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                            side: BorderSide(width: 2, color: Theme.of(context).hintColor),
                          ),
        
                          Text(
                            item.addOns![index].name!,
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style:  const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
  ),
                          ),
        
                        ]),
        
                        const Spacer(),
        
                        Text(
                          item.addOns![index].price! > 0 ? PriceConverter.convertPrice(item.addOns![index].price) : 'free'.tr,
                          maxLines: 1, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,
                          style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
  ),
                        ),
        
                        itemController.addOnActiveList[index] ? Container(
                          height: 25, width: 90,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), color: Theme.of(context).cardColor),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  if (itemController.addOnQtyList[index]! > 1) {
                                    itemController.setAddOnQuantity(false, index);
                                  } else {
                                    itemController.addAddOn(false, index);
                                  }
                                },
                                child: Center(child: Icon(
                                    (itemController.addOnQtyList[index]! > 1) ? Icons.remove : Icons.delete_outline_outlined, size: 18,
                                  color: (itemController.addOnQtyList[index]! > 1) ? Theme.of(context).primaryColor : Theme.of(context).colorScheme.error,
                                )),
                              ),
                            ),
                            Text(
                              itemController.addOnQtyList[index].toString(),
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () => itemController.setAddOnQuantity(true, index),
                                child: Center(child: Icon(Icons.add, size: 18, color: Theme.of(context).primaryColor)),
                              ),
                            ),
                          ]),
                        ) : const SizedBox(),
        
                      ]),
                    ),
                  );
        
              },
            ),
           
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          ],
        ),
      ),
    ) ;
  }
}


// class VariationView extends StatelessWidget {
//   final Item? item;
//   final ItemController itemController;
//   const VariationView({super.key, required this.item, required this.itemController});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: item!.choiceOptions!.length,
//       physics: const NeverScrollableScrollPhysics(),
//       padding: EdgeInsets.only(bottom: item!.choiceOptions!.isNotEmpty ? Dimensions.paddingSizeLarge : 0),
//       itemBuilder: (context, index) {
//         return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Text(item!.choiceOptions![index].title!, style: robotoMedium),
//           const SizedBox(height: Dimensions.paddingSizeSmall),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//               color: Theme.of(context).cardColor,
//             ),
//             padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//             child: ListView.builder(
//               shrinkWrap: true,
//               physics: const NeverScrollableScrollPhysics(),
//               padding: EdgeInsets.zero,
//               itemCount: item!.choiceOptions![index].options!.length,
//               itemBuilder: (context, i) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
//                   child: InkWell(
//                     onTap: () {
//                       itemController.setCartVariationIndex(index, i, item);
//                     },
//                     child: Row(children: [
//                       Expanded(child: Text(
//                         item!.choiceOptions![index].options![i].trim(),
//                         maxLines: 1,
//                         overflow: TextOverflow.ellipsis,
//                         style: robotoRegular,
//                       )),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),
//                       Radio<int>(
//                         value: i,
//                         groupValue: itemController.variationIndex![index],
//                         onChanged: (int? value) => itemController.setCartVariationIndex(index, i, item),
//                         materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                         activeColor: Theme.of(context).primaryColor,
//                       ),
//                     ]),
//                   ),
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: index != item!.choiceOptions!.length - 1 ? Dimensions.paddingSizeLarge : 0),
//         ]);
//       },
//     );
//   }
// }
class VariationView extends StatelessWidget {
  final Item? item;
  final ItemController itemController;
  const VariationView({super.key, required this.item, required this.itemController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: item!.choiceOptions!.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: item!.choiceOptions!.isNotEmpty ? Dimensions.paddingSizeLarge : 0),
      itemBuilder: (context, index) {
        //  itemController.setCartVariationIndex(0, 0, item);
        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item!.choiceOptions![index].title!, style: robotoMedium),
          const SizedBox(height: Dimensions.paddingSizeSmall),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              color: Theme.of(context).cardColor,
            ),
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: item!.choiceOptions![index].options!.length,
              itemBuilder: (context, i) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeExtraSmall),
                  child: InkWell(
                    onTap: () {
                      itemController.setCartVariationIndex(index, i, item);
                    },
                    child: Row(children: [
                      Expanded(child: Text(
                        item!.choiceOptions![index].options![i].trim(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: robotoRegular,
                      )),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Radio<int>(
                        value: i,
                        groupValue: itemController.variationIndex![index],
                        onChanged: (int? value) => itemController.setCartVariationIndex(index, i, item),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ]),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: index != item!.choiceOptions!.length - 1 ? Dimensions.paddingSizeLarge : 0),
        ]);
      },
    );
  }
}
class NewVariationView extends StatelessWidget {
  final Item? item;
  final ItemController itemController;
  final double? discount;
  final String? discountType;
  final bool showOriginalPrice;
  final String currency;
  const NewVariationView({super.key, required this.item, required this.itemController, required this.discount, required this.discountType, required this.showOriginalPrice, required this.currency});

  @override
  Widget build(BuildContext context) {
    return item!.foodVariations != null ? ListView.builder(
      shrinkWrap: true,
      itemCount: item!.foodVariations!.length,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(bottom: (item!.foodVariations != null && item!.foodVariations!.isNotEmpty) ? Dimensions.paddingSizeLarge : 0),
      itemBuilder: (context, index) {
        int selectedCount = 0;
        if(item!.foodVariations![index].required!){
          for (var value in itemController.selectedVariations[index]) {
            if(value == true){
              selectedCount++;
            }
          }
        }
        return Container(

          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          margin: EdgeInsets.only(bottom: index != item!.foodVariations!.length - 1 ? Dimensions.paddingSizeLarge : 0),
          decoration: BoxDecoration(
            color: Colors.white,
            // border: Border.all(color: itemController.selectedVariations[index].contains(true) ? Theme.of(context).primaryColor : Theme.of(context).disabledColor, width: 0.5),
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                
            Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text("Quantity", style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),),
              // Text(item!.foodVariations![index].name!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                   const SizedBox(width: Dimensions.paddingSizeSmall),
              Row(
                children: [
                  Text(
                    item!.foodVariations![index].required!
                        ? (item!.foodVariations![index].multiSelect! ? item!.foodVariations![index].min! : 1) <= selectedCount ? 'completed'.tr : 'required'.tr
                        : 'optional'.tr,
                    style: const TextStyle(
                       fontSize: 13,
                       color: Color(0xFF868686)

                    
                     
                    ),
                  ), const SizedBox(width: 5,),
                    item!.foodVariations![index].multiSelect! ? Text(
              '${'select_minimum'.tr} ${'${item!.foodVariations![index].min}'
                  ' ${'and_up_to'.tr} ${item!.foodVariations![index].max} ${'options'.tr}'}',
              style:  const TextStyle(
                       fontSize: 13,
                       color: Color(0xFF868686)

                    
                     
                    ),
            ) : Text(
              'select any one 1 option'.tr,
              style:  const TextStyle(
                       fontSize: 13,
                       color: Color(0xFF868686)

                    
                     
                    ),
            ),
                ],
              ),
                const SizedBox(width: Dimensions.paddingSizeSmall),
            ]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

          
            SizedBox(height: item!.foodVariations![index].multiSelect! ? Dimensions.paddingSizeExtraSmall : 0),

            !item!.foodVariations![index].multiSelect! ?     ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: itemController.collapseVariation[index] ? item!.foodVariations![index].variationValues!.length > 4
                  ? 5 : item!.foodVariations![index].variationValues!.length : item!.foodVariations![index].variationValues!.length,
              itemBuilder: (context, i) {
              // itemController.setNewCartVariationIndex(0, 0, item! );
                if(i == 4 && itemController.collapseVariation[index]){
                return Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                  child: InkWell(
                    onTap: ()=> itemController.showMoreSpecificSection(index),
                    child: Row(children: [
                      Icon(Icons.expand_more, size: 18, color: Theme.of(context).primaryColor),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      Text(
                        '${'view'.tr} ${item!.foodVariations![index].variationValues!.length - 4} ${'more_option'.tr}',
                        style: robotoMedium.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ]),
                  ),
                );

                } else{
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0),
                    child: InkWell(
                      onTap: () {
                        itemController.setNewCartVariationIndex(index, i, item!,notify: true);
                      },
                      child: Row(children: [

                        Row(crossAxisAlignment: CrossAxisAlignment.center, children: [

                         

                          Text(
                            item!.foodVariations![index].variationValues![i].level!.trim(),
                            maxLines: 1, overflow: TextOverflow.ellipsis,
                            style:  const TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500
                              
                            ) 
                          ),

                        ]),

                        const Spacer(),

                        showOriginalPrice ? Text(
                          PriceConverter.convertPrice(item!.foodVariations![index].variationValues![i].optionPrice),
                          maxLines: 1, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,
                          style: robotoRegular.copyWith(fontSize: 15, color: Theme.of(context).disabledColor, decoration: TextDecoration.lineThrough),
                        ) : const SizedBox(),
                        SizedBox(width: showOriginalPrice ? Dimensions.paddingSizeExtraSmall : 0),

                        Text(
                          PriceConverter.convertPrice(item!.foodVariations![index].variationValues![i].optionPrice, discount: discount, discountType: discountType, isFoodVariation: true, currency: currency),
                          maxLines: 1, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,
                          style: itemController.selectedVariations[index][i]! ? const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
  )
                              : const TextStyle(
                                fontSize: 15,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),  
                        ),

                         item!.foodVariations![index].multiSelect! ? Checkbox(
                            value: itemController.selectedVariations[index][i],
                            
                            activeColor: Theme.of(context).primaryColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                            onChanged:(bool? newValue) {
                              itemController.setNewCartVariationIndex(index, i, item!,notify: true);
                            },
                            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
                            side: BorderSide(width: 2, color: Theme.of(context).hintColor),
                          ) : Radio(
                            value: i,
                            groupValue: itemController.selectedVariations[index].indexOf(true),
                            onChanged: (dynamic value) {
                              itemController.setNewCartVariationIndex(index, i, item!,notify: true);
                            },
                            activeColor: Theme.of(context).primaryColor,
                            toggleable: false,
                            visualDensity: const VisualDensity(horizontal: -3, vertical: -3),

                          ),

                      ]),
                    ),
                  );
                }

              },
            ) :   ListView.builder(
  
  
  
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: item?.foodVariations?.length ?? 0, 
  itemBuilder: (context, variationIndex) {
    return GetBuilder<CartController>(builder: (cartController) {
      return Container(
        child: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: item?.foodVariations?[variationIndex].variationValues?.length ?? 0, 
              itemBuilder: (context, valueIndex) {
                final variationValue = item?.foodVariations?[variationIndex].variationValues?[valueIndex];
                if (variationValue == null) return SizedBox();
  
double priceWithDiscount = PriceConverter.convertWithDiscount(  variationValue.optionPrice, discount, discountType)!;
            
                       List<CartModel> matchingItems = cartController.cartList.where(
  (element) => 
  element.item!.id == item!.id &&
  element.item!.foodVariations!.any(
        
    (variation) =>  
    
     variation.variationValues!.any(
      (value) => value.level == variationValue.level && value.isSelected == true  ,
    ),
  ), 
).toList();
   int findindex;
    if (cartController.cartList.isNotEmpty){
 findindex = cartController.cartList.indexWhere(
   
  (element) =>   element.item!.id == item!.id && element.item!.foodVariations!.any(
    (variation) => variation.variationValues!.any(
      (value) => value.level == variationValue.level && value.isSelected == true ,
    ),
  ),
);
    } else {
      findindex = -1;
    }
               
CartModel? cart =  findindex != -1 ? cartController.cartList[findindex] :  null;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        
                        children: [
                                   const SizedBox(height: 10),
                          Text(variationValue.level ?? '',style: robotoMedium.copyWith(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600)), 
                          const SizedBox(height: 8),
                          if (showOriginalPrice)
                            Row(
                              children: [
                                Text(
                                  '+${PriceConverter.convertPrice(variationValue.optionPrice,)}',
                                  style: robotoRegular.copyWith(
                                    fontSize: Dimensions.fontSizeExtraSmall,
                                    color: Theme.of(context).disabledColor,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                                SizedBox(width: Dimensions.paddingSizeExtraSmall),
                              ],
                            ),
                         
                        ],
                      ),
                      Spacer(),
                   
                  cartController.cartList.any(
                    (element) => element.item!.id == item!.id,
                  ) && cartController.cartList.any(
                    (element) => element.item!.foodVariations!.any(
                      (variation) => variation.variationValues!.any(
                        (value) => value.level == variationValue.level && value.isSelected == true ,
                      ),
                    ), 
                  )
                  
                       &&  cart != null  && cart.item!.id == item!.id              ?
                  
                   GetBuilder<CartController>(
                      builder: (cartController) {
                        return  Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                                  Text(
                            '${PriceConverter.convertPrice(
                              variationValue.optionPrice,
                              discount: discount,
                              discountType: discountType,
                              isFoodVariation: true,
                              // currency: item?.currency?.currencyCode,
                            )}',
                            style: itemController.selectedVariations[variationIndex][valueIndex] ?? false
                                ? robotoMedium.copyWith(   fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600)
                                : robotoRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600
                                  ),
                          ),

                          SizedBox(width: Dimensions.paddingSizeExtraSmall+ 3),
                              Container(
                                //  width:  100,
                                                  // height: 35,
                                                       width: 110,
                              height: 40,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  QuantityButton(
                                    
                                    onTap: cartController.isLoading ? null : () {
                                      
                                                
                                      if (cart.quantity! > 1) {
                                        Get.find<CartController>().setQuantity(false, findindex, cart.stock, cart.quantityLimit);
                                        // fromcheckout ? CheckoutScreenState().initCall() : null;
                                      }else {
                                        Get.find<CartController>().removeFromCart(findindex, item: cart.item);
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
                                      Get.find<CartController>().setQuantity(true, findindex, cart.stock, cart.quantityLimit);
                                        // fromcheckout ? CheckoutScreenState().initCall() : null;
                                    },
                                    isIncrement: true,
                                    color: cartController.isLoading ? Theme.of(context).disabledColor : null,
                                  ),
                                ]),
                              ),
                            ],
                          ),
                        );
                      }
                    )
                  
                  
                     
                    
                      : 
                      InkWell(
                        onTap: ()
                         async {
                          double? price = variationValue.optionPrice;
                          int? quantity = 1;
                  
                          OrderVariation orderVariation = OrderVariation(
                            name: item!.foodVariations![variationIndex].name!,
                            values: OrderVariationValue(label: [variationValue.level]),
                          );
                  
                           OnlineCart onlineCart = OnlineCart(
                                         null,
                                        item!.id, null,
                                        priceWithDiscount.toString()
                                        , 
                                        ''
                                        , null,
                                         [orderVariation],
                                        quantity, [], [], [], 'Item',
                                      );
                  

                       if (Get.find<CartController>().existAnotherStoreItem(item!.storeId, ModuleHelper.getModule() != null
          ? ModuleHelper.getModule()?.id : ModuleHelper.getCacheModule()?.id)) {


        Get.dialog(
          
          ConfirmationDialog(

          icon: Images.warning,
          title: 'are_you_sure_to_reset'.tr,
          description: 
          Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! 
             
              ? 'if_you_continue'.tr : 'if_you_continue_without_another_store'.tr,
                 
          onYesPressed: () {
            Get.find<CartController>().clearCartOnline().then((success) async {
                 Get.back();
              if (success) {
                await Get.find<CartController>().addToCartOnline(onlineCart);
             
                             showCartSnackBar();
              }
            });
          },
        ),
        
         barrierDismissible: false);

                          
                        
                        } else {
                            await Get.find<CartController>().addToCartOnline(onlineCart).then((success) {
                              if (success) {
                                // showCartSnackBar();

                              }
                            });
                          }
                          
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Text(
                            '${PriceConverter.convertPrice(
                              variationValue.optionPrice,
                              discount: discount,
                              discountType: discountType,
                              isFoodVariation: true,
                               currency: currency,
                              // currency: item?.currency?.currencyCode,
                            )}',
                            style: itemController.selectedVariations[variationIndex][valueIndex] ?? false
                                ? robotoRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600
                                  )
                                : robotoRegular.copyWith(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600
                                  ),
                          ),

                          SizedBox(width: Dimensions.paddingSizeExtraSmall+ 3),
                            Container(
                              width: 110,
                              height: 40,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  "ADD",
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      );
    });
  },
)
,
          ]),
        );
      },
    ) : const SizedBox();
  }
}

