

// class GrocceryItemBottomSheet extends StatefulWidget {
//   const GrocceryItemBottomSheet({super.key});

//   @override
//   State<GrocceryItemBottomSheet> createState() => _ItemBottomSheetState();
// }

// class _ItemBottomSheetState extends State<GrocceryItemBottomSheet> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//    width: MediaQuery.of(context).size.width,
//    height: MediaQuery.of(context).size.height,
   
//       // margin: EdgeInsets.only(top: GetPlatform.isWeb ? 0 : 30),
//       decoration: BoxDecoration(
//         color: Colors.transparent.withOpacity(0),

//         // borderRadius: GetPlatform.isWeb ? const BorderRadius.all(Radius.circular(Dimensions.radiusDefault)) : const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusExtraLarge)),
//       ),
//  child:  Column(
//   children: [

//   ],
//  ),
//     );
//   }
// }



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/common/widgets/cart_snackbar.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/checkout/domain/models/place_order_body_model.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/item/widgets/item_image_view_widget.dart';
import 'package:sixam_mart/features/item/widgets/item_title_view_widget.dart';
// import 'package:sixam_mart/features/item/widgets/item_title_view_widget_bottomsheet.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

class GrocceryItemBottomSheet extends StatefulWidget {
   final Item? item;
  final bool inStorePage;
  final bool? isCampaign;
  const GrocceryItemBottomSheet({super.key, this.item, required this.inStorePage, this.isCampaign});

  @override
  State<GrocceryItemBottomSheet> createState() => _GrocceryItemBottomSheetState();
}


class _GrocceryItemBottomSheetState extends State<GrocceryItemBottomSheet> {
  @override

  
  void initState() {
    super.initState();

    Get.find<ItemController>().getProductDetails(widget.item!);
    Get.find<ItemController>().setSelect(0, false);
  }
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.transparent.withOpacity(0),
      ),
      child:GetBuilder<CartController>(
      builder: (cartController) {
          return GetBuilder<ItemController>(
              builder: (itemController) {
                   int? stock = 0;
                CartModel? cartModel;
                OnlineCart? cart;
                double priceWithAddons = 0;
                int? cartId = cartController.getCartId(itemController.cartIndex);
                if(itemController.item != null && itemController.variationIndex != null){
                  List<String> variationList = [];
                  for (int index = 0; index < itemController.item!.choiceOptions!.length; index++) {
                    variationList.add(itemController.item!.choiceOptions![index].options![itemController.variationIndex![index]].replaceAll(' ', ''));
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
                  
          
                  double? price = itemController.item!.price;
                  Variation? variation;
                  stock = itemController.item!.stock ?? 0;
                  for (Variation v in itemController.item!.variations!) {
                    if (v.type == variationType) {
                      price = v.price;
                      variation = v;
                      stock = v.stock;
                      break;
                    }
                  }
          
                  double? discount = (itemController.item!.availableDateStarts != null || itemController.item!.storeDiscount == 0) ? itemController.item!.discount ?? 0 : itemController.item!.storeDiscount?? 0;
                  String? discountType = (itemController.item!.availableDateStarts != null || itemController.item!.storeDiscount == 0) ? itemController.item!.discountType : 'percent';
                  double priceWithDiscount = PriceConverter.convertWithDiscount(price, discount, discountType)!;
                  double priceWithQuantity = priceWithDiscount * itemController.quantity!;
                  double addonsCost = 0;
                  List<AddOn> addOnIdList = [];
                  List<AddOns> addOnsList = [];
                  for (int index = 0; index < itemController.item!.addOns!.length; index++) {
                    if (itemController.addOnActiveList[index]) {
                      addonsCost = addonsCost + (itemController.item!.addOns![index].price! * itemController.addOnQtyList[index]!);
                      addOnIdList.add(AddOn(id: itemController.item!.addOns![index].id, quantity: itemController.addOnQtyList[index]));
                      addOnsList.add(itemController.item!.addOns![index]);
                    }
                  }
          
                  cartModel = CartModel(
                      null, price, priceWithDiscount, variation != null ? [variation] : [], [],
                      (price! - PriceConverter.convertWithDiscount(price, discount, discountType)!),
                      itemController.quantity, addOnIdList, addOnsList, itemController.item!.availableDateStarts != null, stock, itemController.item,
                      itemController.item?.quantityLimit
                  );
          
                  List<int?> listOfAddOnId = _getSelectedAddonIds(addOnIdList: addOnIdList);
                  List<int?> listOfAddOnQty = _getSelectedAddonQtnList(addOnIdList: addOnIdList);
          
                  cart = OnlineCart(
                      cartId, widget.item!.id, null, priceWithDiscount.toString(), '',
                      variation != null ? [variation] : [], null,
                      itemController.cartIndex != -1 ? cartController.cartList[itemController.cartIndex].quantity
                          : itemController.quantity, listOfAddOnId, addOnsList, listOfAddOnQty, 'Item'
                  );
                  priceWithAddons = priceWithQuantity + (Get.find<SplashController>().configModel!.moduleConfig!.module!.addOn! ? addonsCost : 0);
                }
              return Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Add your widgets here
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 460,
                    color: Colors.transparent,
                    child:  Column(
                      children: [
                        Container(
                       height: 50,
                       width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent
                          ),
                          child:  Center(
                            child:  InkWell(
                              onTap: () {
                                Get.back();
              
                              },
                              child: Container(
                                width: 45,
                                height: 45,
                                decoration:  BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(100)
                              
                                ),
                              
                                child:  Icon(Icons.close,color: Colors.white,),
                                
                              ),
                            ),
                          ),
                        ),
                      SizedBox(height: 5,)
                       , Expanded(
                         child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                   Dimensions.radiusLarge
                                ),
                                topRight: Radius.circular(
                                   Dimensions.radiusLarge
                                )
                          ),
                           child: Container(
                            width:  MediaQuery.of(context).size.width,
                            // height: 300,
                            decoration:  BoxDecoration(
                              color:Color(0xFFF5FEFD),
                              borderRadius: BorderRadius.only(
                                topLeft:  Radius.circular(
                                   Dimensions.radiusLarge
                                ),
                                topRight:  Radius.circular(
                                   Dimensions.radiusLarge
                                )
                              )
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.only(left: 15, top: 10),
                                  child: Text("${itemController.item!.name}",style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),),
                                ),
                                // Container(
                                //   height: 100,
                                //   width:  MediaQuery.of(context).size.width,
                                //   color: Colors.amber,
                                         
                                //   child: Row(
                                //     children: [
                                //       Image.network()
                                //     ],
                                //   ),
                                // )
                                         
                                // ItemImageViewWidget(item: itemController.item, ),
                                  // const SizedBox(height: 20),
                                         
                                  // Builder(
                                  //     builder: (context) {
                                  //       return ItemTitleViewBottomsheetWidget (
                                  //         item: itemController.item, isCampaign: itemController.item!.availableDateStarts != null,
                                  //         inStock: (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock! <= 0),
                                  //       );
                                  //     }
                                  // ),
                                  // const Divider(height: 20, thickness: 2),
                           
                                     Container(
                                      // width: 400,
                                      height: 270,
                                       child: ListView.builder(
                                                                   shrinkWrap: true,
                                                                   itemCount: itemController.item!.choiceOptions!.length,
                                                                   // physics: const NeverScrollableScrollPhysics(),
                                                                   itemBuilder: (context, index) {
                                                                     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                       // Text(itemController.item!.choiceOptions![index].title!, style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                                                                       const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                                                       ListView.separated(
                                                                        separatorBuilder: (context, index) {
                                                                          return  SizedBox(height: 5,);
                                                                        },
                                                                         shrinkWrap: true,
                                                                         physics: const NeverScrollableScrollPhysics(),
                                                                         itemCount: itemController.item!.choiceOptions![index].options!.length,
                                                                         itemBuilder: (context, i) {
                                                                           return Padding(
                                        padding: const EdgeInsets.symmetric( horizontal: 10),
                                        child: Container(
                                        
                                          //  width: 00,
                                          //  height: 40,
                                          decoration:  BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Row(
                                              // crossAxisAlignment: C ,
                                              mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                              children: [
                                                  ClipRRect(
                                                            borderRadius: BorderRadius.circular(100),
                                                            child: CustomImage(
    image: itemController.item?.imagesFullUrl?.isNotEmpty == true
        ? itemController.item!.imagesFullUrl!.first ?? ""
        : "",
    height: 60,
    width: 60,
    fit: BoxFit.contain,
  ),
                                                            
                                                            //  Container(
                                                            //   height: 80,
                                                            //   width: 80,
                                                            //   child: 
                                                            //   // Image.network(item!.imagesFullUrl!.first.toString()
                                                              
                                                            //   // ),
                                                            // )
                                                            
                                                            ),
                                                Text("${itemController.item!.choiceOptions![index].options![i].trim().toUpperCase() ?? ""}", style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w300,
                                                  color: Colors.grey[500]
                                                ),),
                                            
                                                Text(" ₹ ${ max(itemController.item!.variations![i].price!.toDouble() - itemController.item!.discount!.toDouble(), 1)}", style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600
                                                ),),
                                            
                                                //  Text("${ itemController.item!.discount }", style: TextStyle(
                                                //   fontSize: 16,
                                                //   fontWeight: FontWeight.bold
                                                // ),),
                                                itemController.variationIndex![index] != i  ?    InkWell(
                                                  onTap: () {
                                                    itemController.setCartVariationIndex(index, i, itemController.item);
                                                  },
                                                  child: Container(
                                                    width: 73,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                                    decoration: BoxDecoration(
                                                                       
                                                      // color: itemController.variationIndex![index] != i ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border:   Border.all(color: Color(0xFF1A9E6A),width: 1),
                                                      //  itemController.variationIndex![index] != i ? Border.all(color: Theme.of(context).disabledColor, width: 2) : null,
                                                    ),
                                                    child: Text(
                                                      // itemController.item!.choiceOptions![index].options![i].trim()
                                                       "${ "ADD" }"
                                                      , maxLines: 1, overflow: TextOverflow.ellipsis,
                                                      style:  TextStyle(
                                                        color: Color(0xFF1A9E6A),
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ),
                                                ) :    GetBuilder<CartController>(
                                                                    builder: (cartController) {
                                                                      return     Container(
                                                                          decoration: BoxDecoration( borderRadius: BorderRadius.circular(5),
                                                                          border:  Border.all(color:Color(0xFF1A9E6A),),
                                                                          ),
                                                                          child: Row(children: [
                                                                                  InkWell(
                                            onTap: cartController.isLoading ? null : () {
                                              if(itemController.cartIndex != -1) {
                                                if(cartController.cartList[itemController.cartIndex].quantity! > 1) {
                                                  cartController.setQuantity(false, itemController.cartIndex, stock, cartController.cartList[itemController.cartIndex].quantity);
                                                }
                                              }else {
                                                if(itemController.quantity! > 1) {
                                                  itemController.setQuantity(false, stock, itemController.item!.quantityLimit);
                                                }
                                              }
                                            },
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                              child: Icon(Icons.remove, size: 14,color: Color(0xFF1A9E6A),),
                                            ),
                                                                                  ),
                                                                                  
                                                                                  !cartController.isLoading ? Text(
                                            itemController.cartIndex != -1 ? cartController.cartList[itemController.cartIndex].quantity.toString()
                                                : itemController.quantity.toString(),
                                            style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,color: Color(0xFF1A9E6A)),
                                                                                  ) : const SizedBox(height: 20, width: 20, child: CircularProgressIndicator()),
                                                                                  
                                                                                  InkWell(
                                            onTap: cartController.isLoading ? null : () => itemController.cartIndex != -1
                                                ? cartController.setQuantity(true, itemController.cartIndex, stock, cartController.cartList[itemController.cartIndex].quantityLimit)
                                                : itemController.setQuantity(true, stock, itemController.item!.quantityLimit),
                                            child: const Padding(
                                              padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                                              child: Icon(Icons.add, size: 14,color: Color(0xFF1A9E6A),),
                                            ),
                                                                                  ),
                                                                          ]));
                                                                        
                                                                  
                                                                    }
                                                                  ),
                                                              
                                              ],
                                            ),
                                          ),
                                        ),
                                                                           );
                                                                         },
                                                                       ),
                                                                       SizedBox(height: index != itemController.item!.choiceOptions!.length-1 ? Dimensions.paddingSizeLarge : 0),
                                                                     ]);
                                                                   },
                                                     ),
                                     ),
                                                  //  itemController.item!.choiceOptions!.isNotEmpty ? const SizedBox(height: Dimensions.paddingSizeLarge) : const SizedBox(),
                                                   Row(children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text('${'total_amount'.tr}:', style:robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge)),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                           
                            Text(
                              PriceConverter.convertPrice(itemController.cartIndex != -1
                                  ? _getItemDetailsDiscountPrice(cart: Get.find<CartController>().cartList[itemController.cartIndex])
                                  : priceWithAddons), textDirection: TextDirection.ltr,
                              style:robotoBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeLarge),
                            ),
                                                   ]),
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           
                           
                                 GetBuilder<CartController>(
                                             builder: (cartController) {
                                               return Container(
                                                 width: 1170,
                                                 padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                                 child: CustomButton(
                                                   isLoading: cartController.isLoading,
                                                   buttonText: (Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! && stock! <= 0) ? 'out_of_stock'.tr
                              : itemController.item!.availableDateStarts != null ? 'order_now'.tr : itemController.cartIndex != -1 ? 'update_in_cart'.tr : 'add_to_cart'.tr,
                                                   onPressed: (!Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! || stock! > 0) ?  () async {
                            if(!Get.find<SplashController>().configModel!.moduleConfig!.module!.stock! || stock! > 0) {
                              if(itemController.item!.availableDateStarts != null) {
                                Get.toNamed(RouteHelper.getCheckoutRoute('campaign'), arguments: CheckoutScreen(
                                  storeId: null,
                                   fromCart: false, cartList: [cartModel],
                                ));
                              }else {
                                if (cartController.existAnotherStoreItem(cartModel!.item!.storeId, Get.find<SplashController>().module == null ? Get.find<SplashController>().cacheModule!.id : Get.find<SplashController>().module!.id)) {
                                  Get.dialog(ConfirmationDialog(
                                    icon: Images.warning,
                                    title: 'are_you_sure_to_reset'.tr,
                                    description: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                                        ? 'if_you_continue'.tr : 'if_you_continue_without_another_store'.tr,
                                    onYesPressed: () {
                                      Get.back();
                                      cartController.clearCartOnline().then((success) async {
                                        if(success) {
                                          await cartController.addToCartOnline(cart!);
                                          itemController.setExistInCart(widget.item, null);
                                          showCartSnackBar();
                                        }
                                      });
                           
                                    },
                                  ), barrierDismissible: false);
                                } else {
                                  if(itemController.cartIndex == -1) {
                                    await cartController.addToCartOnline(cart!).then((success) {
                                      if(success){
                                        itemController.setExistInCart(widget.item, null);
                                        showCartSnackBar();
                                        // _key.currentState!.shake();
                                           Get.back();
                                      }
                                    });
                                  } else {
                                    await cartController.updateCartOnline(cart!).then((success) {
                                      if(success) {
                                        showCartSnackBar();
                                           Get.back();
                                        // _key.currentState!.shake();
                                      }
                                    });
                                  }
                           
                                }
                              }
                            }
                                                   } : null,
                                                 ),
                                               );
                                             }
                                           ),
                           
                               ],
                            ),
                           ),
                         ),
                       )
                      ],
                    ),
                  )
                ],
              );
            }
          );
        }
      ),
    );
  }
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

  double _getItemDetailsDiscountPrice({required CartModel cart}) {
    double discountedPrice = 0;

    double? discount = cart.item!.storeDiscount == 0 ? cart.item!.discount! : cart.item!.storeDiscount!;
    String? discountType = (cart.item!.storeDiscount == 0) ? cart.item!.discountType : 'percent';
    String variationType = cart.variation != null && cart.variation!.isNotEmpty ? cart.variation![0].type! : '';

    if(cart.variation != null && cart.variation!.isNotEmpty){
      for (Variation variation in cart.item!.variations!) {
        if (variation.type == variationType) {
          discountedPrice = (PriceConverter.convertWithDiscount(variation.price!, discount, discountType)! * cart.quantity!);
          break;
        }
      }
    } else {
      discountedPrice = (PriceConverter.convertWithDiscount(cart.item!.price!, discount, discountType)! * cart.quantity!);
    }

    return discountedPrice;
  }



class QuantityButton extends StatelessWidget {
  final bool isIncrement;
  final int? quantity;
  final bool isCartWidget;
  final int? stock;
  final bool isExistInCart;
  final int cartIndex;
  final int? quantityLimit;
  final CartController cartController;
  const QuantityButton({super.key,
    required this.isIncrement,
    required this.quantity,
    required this.stock,
    required this.isExistInCart,
    required this.cartIndex,
    this.isCartWidget = false,
    this.quantityLimit,
    required this.cartController,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: cartController.isLoading ? null : () {
        if(isExistInCart) {
          if (!isIncrement && quantity! > 1) {
            Get.find<CartController>().setQuantity(false, cartIndex, stock, quantityLimit);
          } else if (isIncrement && quantity! > 0) {
            if(quantity! < stock! || !Get.find<SplashController>().configModel!.moduleConfig!.module!.stock!) {
              Get.find<CartController>().setQuantity(true, cartIndex, stock, quantityLimit);
            }else {
              showCustomSnackBar('out_of_stock'.tr);
            }
          }
        } else {
          if (!isIncrement && quantity! > 1) {
            Get.find<ItemController>().setQuantity(false, stock, quantityLimit);
          } else if (isIncrement && quantity! > 0) {
            if(quantity! < stock! || !Get.find<SplashController>().configModel!.moduleConfig!.module!.stock!) {
              Get.find<ItemController>().setQuantity(true, stock, quantityLimit);
            }else {
              showCustomSnackBar('out_of_stock'.tr);
            }
          }

        }
      },
      child: Container(
        height: 30, width: 30,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: (quantity! == 1 && !isIncrement) || cartController.isLoading ? Theme.of(context).disabledColor : Theme.of(context).primaryColor,
        ),
        child: Center(
          child: Icon(
            isIncrement ? Icons.add : Icons.remove,
            color: isIncrement ? Colors.white : quantity! == 1 ? Colors.black : Colors.white,
            size: isCartWidget ? 26 : 20,
          ),
        ),
      ),
    );
  }
}














