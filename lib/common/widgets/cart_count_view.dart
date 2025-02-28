import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

// class CartCountView extends StatefulWidget {
//   final Item item;
//   final Widget? child;
//   final int? index;
//   const CartCountView({super.key, required this.item, this.child, this.index = -1});

//   @override
//   State<CartCountView> createState() => _CartCountViewState();
// }

// class _CartCountViewState extends State<CartCountView> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CartController>(builder: (cartController) {
//       int cartQty = cartController.cartQuantity(widget.item.id!);
//       int cartIndex = cartController.isExistInCart(widget.item.id, cartController.cartVariant(widget.item.id!), false, null);
//       return
//        cartQty != 0 ? Center(
//         child:
//          Container(
//      width:  110,
//                                             height: 40,
//               decoration: BoxDecoration(
//                                         color: Colors.white,
//                                         borderRadius: BorderRadius.circular(10),
//                                         boxShadow: [
//                                           BoxShadow(
//                                             color: Colors.grey.withOpacity(0.2),
//                                             spreadRadius: 2,
//                                             blurRadius: 5,
//                                           ),
//                                         ],
//                                       ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//               InkWell(
//                 onTap: cartController.isLoading ? null : () {
//                   if (cartController.cartList[cartIndex].quantity! > 1) {
//                     cartController.setDirectlyAddToCartIndex(widget.index);
//                     cartController.setQuantity(false, cartIndex, cartController.cartList[cartIndex].stock, cartController.cartList[cartIndex].item!.quantityLimit);
//                   }else {
//                     cartController.removeFromCart(cartIndex);
//                   }
//                 },
//                 child: Container(
//                   // decoration: BoxDecoration(
//                   //   color: Theme.of(context).cardColor,
//                   //   shape: BoxShape.circle,
//                   //   border: Border.all(color: Colors.green),
//                   // ),
//                   // padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                   child: Center(
//                     child: Icon(
//                       Icons.remove, size: 25, color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ),
            
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                 child: cartController.isLoading && cartController.directAddCartItemIndex == widget.index
//                     ? SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.green))
//                     : Text(cartQty.toString(),
//                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Colors.green,fontWeight: FontWeight.w700),
//                 ) ,
//               ),
            
//               InkWell(
//                 onTap: cartController.isLoading ? null : () {
//                   cartController.setDirectlyAddToCartIndex(widget.index);
//                   cartController.setQuantity(true, cartIndex, cartController.cartList[cartIndex].stock, cartController.cartList[cartIndex].quantityLimit);
//                 },
//                 child: Container(
//                   // decoration: BoxDecoration(
//                   //   // color: Theme.of(context).cardColor,
//                   //   // shape: BoxShape.circle,
//                   //   // border: Border.all(color: Colors.green),
//                   // ),
//                   // padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                   child: Center(
//                     child: Icon(
//                       Icons.add, size: 25, color: Colors.green,
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//         ),
//       ) : 
      
//       InkWell(
//         onTap: () {
          
//           Get.find<ItemController>().itemDirectlyAddToCart(widget.item, context);
//         },
//         child: widget.child ??  Container(
//                                             width:  110,
//                                             height: 40,
//                                             margin: const EdgeInsets.all(0),
//                                             decoration: BoxDecoration(
//                                               color: Colors.white,
//                                               borderRadius: BorderRadius.circular(10),
//                                               boxShadow: [
//                                                 BoxShadow(
//                                                   color: Colors.grey.withOpacity(0.2),
//                                                   spreadRadius: 2,
//                                                   blurRadius: 5,
//                                                 ),
//                                               ],
//                                             ),
//                                             child:  Center(
//                                               child: Text("ADD" , style: TextStyle(
//                                                 color: Colors.green,
//                                                     fontSize:  18,
//                                                      fontWeight: FontWeight.w600
//                                               )),
//                                             ),
//                                           ),
//       );
   
   
   
//     });
//   }
// }
class CartCountView extends StatefulWidget {
  final Item item;
  final Widget? child;
  final int? index;
  const CartCountView({super.key, required this.item, this.child, this.index = -1});

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
                              size: 25,
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                        child: cartController.isLoading && cartController.directAddCartItemIndex == widget.index
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(color: Colors.green),
                              )
                            : Text(
                                cartQty.toString(),
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeLarge,
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
                              size: 25,
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
                  _isAdded = true; // Update the state when the button is clicked
                });
                Get.find<ItemController>().itemDirectlyAddToCart(widget.item, context);
              },
              child: widget.child ??
                  Container(
                    width: 110,
                    height: 40,
                    margin: const EdgeInsets.all(0),
                    decoration: BoxDecoration(
                      color: _isAdded ? Colors.green : Colors.white, // Change color based on the state
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "ADD",
                        style: TextStyle(
                          color: _isAdded ? Colors.white : Colors.green, // Change text color based on the state
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
            );
    });
  }
}