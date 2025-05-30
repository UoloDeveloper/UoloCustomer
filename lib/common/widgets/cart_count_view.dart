import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';



class CartCountView extends StatefulWidget {
  final Item item;
  final Widget? child;
  final int? index;
  final bool isgroccery;
  const CartCountView({super.key, required this.item, this.child, this.index = -1, 
  this.isgroccery = false
  });

  @override
  State<CartCountView> createState() => _CartCountViewState();
}

class _CartCountViewState extends State<CartCountView> {
  bool _isAdded = false; 

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
      int cartQty = cartController.cartQuantity(widget.item.id!);
      int cartIndex = cartController.isExistInCart(widget.item.id, cartController.cartVariant(widget.item.id!), false, null);
             if (cartIndex != -1) {
               _isAdded = false;
             }           
      return cartQty != 0
          ? Center(
              child: Container(
                width: widget.isgroccery ?88 : 110,
                height: widget.isgroccery ? 35 :40,
                decoration: BoxDecoration(
                  color: Colors.white,
                   border: widget.isgroccery ? Border.all(color: const Color(0xFF1A9E6A)) :null,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                if (cartController.cartList[cartIndex].quantity! > 1) {
                                  cartController.setDirectlyAddToCartIndex(widget.index);
                                  cartController.setQuantity(false, cartIndex, cartController.cartList[cartIndex].stock, cartController.cartList[cartIndex].item!.quantityLimit);
                                } else {
                                  cartController.removeFromCart(cartIndex);
                                }
                              },
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.remove,
                              size: widget.isgroccery ?18 : 25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: cartController.isLoading && cartController.directAddCartItemIndex == widget.index
                            ? SizedBox(
                                height: widget.isgroccery ?15 :  20,
                                width: widget.isgroccery ?15 :  20,
                                child: CircularProgressIndicator(color: Colors.green),
                              )
                            : Text(
                                cartQty.toString(),
                                style: robotoMedium.copyWith(
                                  fontSize: widget.isgroccery ? Dimensions.fontSizeSmall + 2 :  Dimensions.fontSizeLarge,
                                  color: Colors.green,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                      ),
                      InkWell(
                        onTap: cartController.isLoading
                            ? null
                            : () {
                                cartController.setDirectlyAddToCartIndex(widget.index);
                                cartController.setQuantity(true, cartIndex, cartController.cartList[cartIndex].stock, cartController.cartList[cartIndex].quantityLimit);
                              },
                        child: Container(
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: widget.isgroccery ?18 :  25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : InkWell(
              onTap: () {
                setState(() {
                  _isAdded = true;
                });
                Get.find<ItemController>().itemDirectlyAddToCart(widget.item, context);
                // var checkoutScreenState = Get.find<CheckoutScreen>().createState();
                // checkoutScreenState.initState();
              // checkoutScreenState.initState();
              setState(() {});
              },
              child:  Stack(
                children: [
                  widget.child ??
                      Container(
                        width: widget.isgroccery ?80 : 110,
                        height:  widget.isgroccery  ? 38 : 40,
                        margin: const EdgeInsets.all(0),
                        decoration: BoxDecoration(
                             border: widget.isgroccery ? Border.all(color: const Color(0xFF1A9E6A)) :null,
                          color: _isAdded ? widget.isgroccery ?Colors.white  : Colors.green : Colors.white, // Change color based on the state
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: widget.isgroccery ? 1 : 2,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "ADD",
                            style: TextStyle(
                              color: _isAdded ? widget.isgroccery ? Colors.green :  Colors.white : Colors.green, // Change text color based on the state
                              fontSize: widget.isgroccery ? 15 : 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                        Visibility(
        visible: widget. item.variations!.isNotEmpty,
        child: Positioned(
        bottom: -2,
        // left: 13, 
        right: 13,// Adjust the offset to place it above the button
        left: 13, // Center "Optional" if needed
        child: Container(
          // height: ,
          color: Colors.white,
          child: Text(
            " ${widget.item.variations!.length} Options",
            style: TextStyle(
              color: Theme.of(context).hintColor,
              fontSize: 10,
            ),
          ),
        ),
            ),
      ),
                ],
              ),
            );
    });
  }
}