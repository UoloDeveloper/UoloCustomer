import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_divider%20copy.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';


 class BottomCartWidget extends StatelessWidget {
  final bool fromgroccery;
   BottomCartWidget({super.key,  this.fromgroccery = false});
 double percentage = 0;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      

       
        return GetBuilder<CartController>(builder: (cartController) {
           if(Get.find<StoreController>().store != null && !Get.find<StoreController>().store!.freeDelivery! && Get.find<SplashController>().configModel!.freeDeliveryOver != null){
            percentage = cartController.subTotal/Get.find<SplashController>().configModel!.freeDeliveryOver!;
          }
            return !fromgroccery ?
             Container(
              height: GetPlatform.isIOS ? 100 :         (storeController.store != null && !storeController.store!.freeDelivery! && Get.find<SplashController>().configModel!.freeDeliveryOver != null && percentage < 1) ||  (storeController.store != null && !storeController.store!.freeDelivery! && Get.find<SplashController>().configModel!.freeDeliveryOver != null && percentage > 1) ? 140 : 100, width: Get.width,
              // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge,/* vertical: Dimensions.PADDING_SIZE_SMALL*/),
              decoration: BoxDecoration(
                  color:  Theme.of(context).cardColor,
                   boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                  borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)
              ),
              // child:
              
                         child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                   (storeController.store != null && !storeController.store!.freeDelivery! && Get.find<SplashController>().configModel!.freeDeliveryOver != null && percentage < 1)
              ? Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(children: [
                    // Row(children: [
                    //   Image.asset("assets/image/icons/food_16399658.png", height: 30, width: 30),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                   
                    //   Text(
                    //    "${ "Shop for " + PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal)}",
                    //     style: robotoMedium.copyWith(color: Theme.of(context).primaryColor), textDirection: TextDirection.ltr,
                    //   ),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                   
                    //   Text('more to unlock free delivery'.tr, style: robotoMedium.copyWith(color: Theme.of(context).disabledColor)),
                    // ]),

                    Row(
  children: [
    Stack(
      alignment: Alignment.center,
      children: [
        GradientCircularProgressIndicator (
          value: percentage,
          strokeWidth: 6,
          backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
          gradient: LinearGradient(
            colors: [
              Colors.deepPurple,
              Colors.purple,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // SizedBox(
        //   height: 40, 
        //   width: 40, 
        //   child: CircularProgressIndicator(
        //     value: cartController.subTotal / Get.find<SplashController>().configModel!.freeDeliveryOver!,
        //     strokeWidth: 6, 
        //     backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), 
        //     valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), 
        //   ),
        // ),
      
        Image.asset(
          "assets/image/icons/food_16399658.png",
          height: 28,
          width: 28,
        ),
      ],
    ),
  
    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
    // RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: "Shop for ",
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontSize: Dimensions.fontSizeDefault,
    //           fontWeight: FontWeight.w500
    //         ),
    //       ),
    //       TextSpan(
    //         text: PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal),
    //         style:   TextStyle(
    //           color: Colors.black,
    //           fontSize: Dimensions.fontSizeDefault,
    //           fontWeight: FontWeight.w500
    //         ),
    //         //  robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    //       ),
    //     ],
    //   ),
    // ),
    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
    // Text(
    //   'more to unlock free delivery'.tr,
    //   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor),
    // ),
     RichText(
      text: TextSpan(
        children: [
            TextSpan(
            text: "Shop for ",
            style: TextStyle(
              color: Colors.black,
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w500
            ),
          ),
          TextSpan(
            text: PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal) ,
            style:   TextStyle(
              color: Colors.black,
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w500
            ),
            //  robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          ),
          
          TextSpan(
            text: " more to unlock".tr,
            style:    TextStyle(
              color: Colors.black,
              fontSize: Dimensions.fontSizeDefault,
              fontWeight: FontWeight.w500
            ),
          ),
          TextSpan(
            text: " FREE DELIVERY".tr,
            style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,fontSize: 15),
          ),
        ],
      ),
    )
  ],
),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Divider(),
               const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  // LinearProgressIndicator(
                  //   backgroundColor: Theme.of(context).primaryColor  ,
                  //   value: percentage,
                  // ),
                ]),
              ) : const SizedBox(),
            
                (storeController.store != null && !storeController.store!.freeDelivery! && Get.find<SplashController>().configModel!.freeDeliveryOver != null && percentage > 1)
              ? Padding(
                padding: const EdgeInsets.only(left: 10,right: 10),
                child: Column(children: [
                    // Row(children: [
                    //   Image.asset("assets/image/icons/food_16399658.png", height: 30, width: 30),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                   
                    //   Text(
                    //    "${ "Shop for " + PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal)}",
                    //     style: robotoMedium.copyWith(color: Theme.of(context).primaryColor), textDirection: TextDirection.ltr,
                    //   ),
                    //   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                   
                    //   Text('more to unlock free delivery'.tr, style: robotoMedium.copyWith(color: Theme.of(context).disabledColor)),
                    // ]),

                    Row(
  children: [
    // Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     GradientCircularProgressIndicator (
    //       value: percentage,
    //       strokeWidth: 6,
    //       backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3),
    //       gradient: LinearGradient(
    //         colors: [
    //           Colors.deepPurple,
    //           Colors.purple,
    //         ],
    //         begin: Alignment.topLeft,
    //         end: Alignment.bottomRight,
    //       ),
    //     ),
    //     // SizedBox(
    //     //   height: 40, 
    //     //   width: 40, 
    //     //   child: CircularProgressIndicator(
    //     //     value: cartController.subTotal / Get.find<SplashController>().configModel!.freeDeliveryOver!,
    //     //     strokeWidth: 6, 
    //     //     backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), 
    //     //     valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor), 
    //     //   ),
    //     // ),
    //     // Image
    //     Image.asset(
    //       "assets/image/icons/food_16399658.png",
    //       height: 30,
    //       width: 30,
    //     ),
    //   ],
    // ),
  
    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
    // RichText(
    //   text: TextSpan(
    //     children: [
    //       TextSpan(
    //         text: "Shop for ",
    //         style: TextStyle(
    //           color: Colors.black,
    //           fontSize: Dimensions.fontSizeDefault,
    //           fontWeight: FontWeight.w500
    //         ),
    //       ),
    //       TextSpan(
    //         text: PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal),
    //         style:   TextStyle(
    //           color: Colors.black,
    //           fontSize: Dimensions.fontSizeDefault,
    //           fontWeight: FontWeight.w500
    //         ),
    //         //  robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
    //       ),
    //     ],
    //   ),
    // ),
    const SizedBox(width: Dimensions.paddingSizeExtraSmall),
    // Text(
    //   'more to unlock free delivery'.tr,
    //   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor),
    // ),
     RichText(
      text: TextSpan(
        children: [
          //   TextSpan(
          //   text: "Shop for ",
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontSize: Dimensions.fontSizeDefault,
          //     fontWeight: FontWeight.w500
          //   ),
          // ),
          // TextSpan(
          //   text: PriceConverter.convertPrice(Get.find<SplashController>().configModel!.freeDeliveryOver! - cartController.subTotal) ,
          //   style:   TextStyle(
          //     color: Colors.black,
          //     fontSize: Dimensions.fontSizeDefault,
          //     fontWeight: FontWeight.w500
          //   ),
          //   //  robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
          // ),
          
          // TextSpan(
          //   text: " more to unlock".tr,
          //   style:    TextStyle(
          //     color: Colors.black,
          //     fontSize: Dimensions.fontSizeDefault,
          //     fontWeight: FontWeight.w500
          //   ),
          // ),
          TextSpan(
            text: " FREE DELIVERY".tr,
            style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold,fontSize: 16),
          ),
        ],
      ),
    )
  ],
),
                  const SizedBox(height: Dimensions.paddingSizeExtraSmall),
              Divider(),
               const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                  // LinearProgressIndicator(
                  //   backgroundColor: Theme.of(context).primaryColor  ,
                  //   value: percentage,
                  // ),
                ]),
              ) : const SizedBox(),
            
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: InkWell(
                    onTap: () {
                      //    if(cartController.cartList.first.item!.scheduleOrder!) {
                              
                      //     print(!cartController.cartList.first.item!.scheduleOrder!);
                      //   showCustomSnackBar('one_or_more_product_unavailable'.tr);
                      // } 
                      
                      /*else if(AuthHelper.isGuestLoggedIn() && !Get.find<SplashController>().configModel!.guestCheckoutStatus!) {
                        showCustomSnackBar('currently_your_zone_have_no_permission_to_place_any_order'.tr);
                      // }*/
                      // if (cartController.cartList.isEmpty) {
                        if(Get.find<SplashController>().module == null) {
                          int i = 0;
                          for(i = 0; i < Get.find<SplashController>().moduleList!.length; i++){
                            if(cartController.cartList[0].item!.moduleId == Get.find<SplashController>().moduleList![i].id){
                              break;
                            }
                          }
                          // Get.find<SplashController>().setModule(Get.find<SplashController>().moduleList![i]);
                          // HomeScreen.loadData(true);
                        }
                        Get.find<CouponController>().removeCouponData(false);
                     // Get.toNamed(RouteHelper.getCartRoute());
                     Get.toNamed(RouteHelper.getCheckoutRoute('cart'));
                      // }
                      
                      },
                    
                    child: Container(
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(Dimensions.radiusLarge ),
                         boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                         gradient: LinearGradient(
              colors: [
                Colors.deepPurple.shade800, 
                Colors.purple.shade400,     
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
                         ),
                         // shape: BoxShape.circle, // Make it circular
                       ),
                      // decoration: BoxDecoration(
                      //   color:  Theme.of(context).primaryColor,
                        
                      //   // const Color.fromARGB(255, 28, 166, 114),
                      //   borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      //   boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                      // ),
                    
                      child: Row(
                        children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(" ${cartController.cartList.length} ${"Item Added"}",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeExtraLarge,
                            fontWeight: FontWeight.w600
                          ),),
                        ),
                       const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Text("View Cart", style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w600
                            ) ),
                             const Icon(Icons.arrow_forward_ios,color: Colors.white , size: 20,grade: 10,)
                            ],
                          ),
                        )
                        ],
                      ),
                    ),
                  ),
                )
              ],
                         )
                         ) : 
            
            
            
            
            
            
            
            
            
             Container(
              height: GetPlatform.isIOS ? 100 : 100, width: Get.width,
              // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge,/* vertical: Dimensions.PADDING_SIZE_SMALL*/),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  //  boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                  // borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)
              ),
              // child:
              
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
          Padding(
        padding: const EdgeInsets.only(left: 40, bottom: 50),
        child: InkWell(
          onTap: () => Get.toNamed(RouteHelper.getCheckoutRoute('cart')),
          child: Container(
            width: 221,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(50), 
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                   
                  //  Builder(
                  //    builder: (context) {
                       
                  //      return Image.network(
                  //       cartController.cartList[0].item!.imageFullUrl!,);
                  //    }
                  //  ),
          
                  Padding(
                    padding: const EdgeInsets.all(6),
                    child: Container(
                      height: 38,
                      width: 80,
                                    decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(50), 
                                  ),
                      child: Stack(
                        children: [
                        
                              for (int index = 0;
                              //  index < cartController.cartList.length  ; 
                              index < min(cartController.cartList.length, 3);
                              //  index < min(cartController.cartList.length, 3);
                                  index++) ...[
                                Positioned(
                                  left: index * 20,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                    
                                    child: CustomImage(
                                      image:cartController.cartList[index].item!.imageFullUrl ?? "" ,
                                      
                                      height: 38,
                                      width: 38,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ]
                             
                          //  Positioned(child: Image.network(cartController.cartList[].item!.imageFullUrl!,height: 50,width: 50,fit: BoxFit.fill,),) 
                        ],
                      ),
                    ),
                  ),
                
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("View Cart", style: robotoRegular.copyWith(color: Colors.white, fontSize: 15)),
                    Text(
                      "${cartController.cartList.length} Items",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
          
          
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    height: 38,
                    width: 38,
                    decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(100),
                      color:  const Color(0xFF27093C)
                  ),
                   child:  const Center(child: Icon(CupertinoIcons.right_chevron, color: Colors.white,),),
                  ),
                )
          
              ],
            ),
          ),
        ),
          ),
          
               
              ],
            )
            ) ;
          });
      }
    );
  }
}



// class GradientCircularProgressIndicator extends StatelessWidget {
//   final double value;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Gradient gradient;

//   const GradientCircularProgressIndicator({
//     Key? key,
//     required this.value,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.gradient,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: Size(35, 35), 
//       painter: GradientCircularProgressPainter(
//         value: value,
//         strokeWidth: strokeWidth,
//         backgroundColor: backgroundColor,
//         gradient: gradient,
//       ),
//     );
//   }
// }

// class GradientCircularProgressPainter extends CustomPainter {
//   final double value;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Gradient gradient;

//   GradientCircularProgressPainter({
//     required this.value,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.gradient,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = backgroundColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

//     // Draw the background circle
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       (size.width / 2) - (strokeWidth / 2),
//       paint,
//     );

//     // Draw the gradient arc
//     final rect = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height / 2),
//       radius: (size.width / 2) - (strokeWidth / 2),
//     );

//     paint.shader = gradient.createShader(rect);
//     paint.strokeCap = StrokeCap.round;

//     // Draw the arc based on the value
//     canvas.drawArc(
//       rect,
//       -90 * (3.14 / 180), // Start angle in radians
//       2 * 3.14 * value, // Sweep angle in radians
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }




// class AnimatedGradientCircularProgressIndicator extends StatefulWidget {
//   final double value;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Gradient gradient;
//   final Duration animationDuration;

//   const AnimatedGradientCircularProgressIndicator({
//     Key? key,
//     required this.value,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.gradient,
//     this.animationDuration = const Duration(milliseconds: 10), 
//   }) : super(key: key);

//   @override
//   _AnimatedGradientCircularProgressIndicatorState createState() =>
//       _AnimatedGradientCircularProgressIndicatorState();
// }

// class _AnimatedGradientCircularProgressIndicatorState
//     extends State<AnimatedGradientCircularProgressIndicator>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: widget.animationDuration,
//     );
//     _animation = Tween<double>(begin: widget.value, end: widget.value).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad), 
//     );
//     _controller.forward(from: 0.0);
//   }

//   @override
//   void didUpdateWidget(AnimatedGradientCircularProgressIndicator oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     if (oldWidget.value != widget.value) {
//       _animation = Tween<double>(
//         begin: _animation.value,
//         end: widget.value,
//       ).animate(
//         CurvedAnimation(parent: _controller, curve: Curves.easeInOutQuad),
//       );
//       _controller.forward(from: 0.0);
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _animation,
//       builder: (context, child) {
//         return GradientCircularProgressIndicator(
//           value: _animation.value,
//           strokeWidth: widget.strokeWidth,
//           backgroundColor: widget.backgroundColor,
//           gradient: widget.gradient,
//         );
//       },
//     );
//   }
// }

// class GradientCircularProgressIndicator extends StatelessWidget {
//   final double value;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Gradient gradient;

//   const GradientCircularProgressIndicator({
//     Key? key,
//     required this.value,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.gradient,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       size: const Size(35, 35),
//       painter: GradientCircularProgressPainter(
//         value: value,
//         strokeWidth: strokeWidth,
//         backgroundColor: backgroundColor,
//         gradient: gradient,
//       ),
//     );
//   }
// }

// class GradientCircularProgressPainter extends CustomPainter {
//   final double value;
//   final double strokeWidth;
//   final Color backgroundColor;
//   final Gradient gradient;

//   GradientCircularProgressPainter({
//     required this.value,
//     required this.strokeWidth,
//     required this.backgroundColor,
//     required this.gradient,
//   });

//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint()
//       ..color = backgroundColor
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = strokeWidth;

  
//     canvas.drawCircle(
//       Offset(size.width / 2, size.height / 2),
//       (size.width / 2) - (strokeWidth / 2),
//       paint,
//     );

//     final rect = Rect.fromCircle(
//       center: Offset(size.width / 2, size.height / 2),
//       radius: (size.width / 2) - (strokeWidth / 2),
//     );

//     paint.shader = gradient.createShader(rect);
//     paint.strokeCap = StrokeCap.round;

  
//     canvas.drawArc(
//       rect,
//       -90 * (3.14159 / 180), 
//       2 * 3.14159 * value.clamp(0.0, 1.0), 
//       false,
//       paint,
//     );
//   }

//   @override
//   bool shouldRepaint(covariant GradientCircularProgressPainter oldDelegate) {
//     return oldDelegate.value != value ||
//         oldDelegate.strokeWidth != strokeWidth ||
//         oldDelegate.backgroundColor != backgroundColor ||
//         oldDelegate.gradient != gradient;
//   }
// }




class AnimatedGradientCircularProgressIndicator extends StatefulWidget {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient gradient;
  final Duration animationDuration;

  const AnimatedGradientCircularProgressIndicator({
    Key? key,
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradient,
    this.animationDuration = const Duration(milliseconds: 100),
  }) : super(key: key);

  @override
  _AnimatedGradientCircularProgressIndicatorState createState() =>
      _AnimatedGradientCircularProgressIndicatorState();
}

class _AnimatedGradientCircularProgressIndicatorState
    extends State<AnimatedGradientCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = Tween<double>(
      begin: widget.value.clamp(0.0, 1.0),
      end: widget.value.clamp(0.0, 1.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward(from: 0.0);
  }

  @override
  void didUpdateWidget(AnimatedGradientCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.reset();
      _animation = Tween<double>(
        begin: _animation.value,
        end: widget.value.clamp(0.0, 1.0),
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
      );
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return GradientCircularProgressIndicator(
          value: _animation.value,
          strokeWidth: widget.strokeWidth,
          backgroundColor: widget.backgroundColor,
          gradient: widget.gradient,
        );
      },
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient gradient;

  const GradientCircularProgressIndicator({
    Key? key,
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(35, 35),
      painter: GradientCircularProgressPainter(
        value: value,
        strokeWidth: strokeWidth,
        backgroundColor: backgroundColor,
        gradient: gradient,
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  final double value;
  final double strokeWidth;
  final Color backgroundColor;
  final Gradient gradient;

  GradientCircularProgressPainter({
    required this.value,
    required this.strokeWidth,
    required this.backgroundColor,
    required this.gradient,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      (size.width / 2) - (strokeWidth / 2),
      paint,
    );

    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: (size.width / 2) - (strokeWidth / 2),
    );

    paint.shader = gradient.createShader(rect);
    paint.strokeCap = StrokeCap.round;

    canvas.drawArc(
      rect,
      -90 * (3.14159 / 180),
      2 * 3.14159 * value.clamp(0.0, 1.0),
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant GradientCircularProgressPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.backgroundColor != backgroundColor ||
        oldDelegate.gradient != gradient;
  }
}