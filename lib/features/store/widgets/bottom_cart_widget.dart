import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';


 class BottomCartWidget extends StatelessWidget {
  final bool fromgroccery;
  const BottomCartWidget({super.key,  this.fromgroccery = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(builder: (cartController) {
        return !fromgroccery ?
         Container(
          height: GetPlatform.isIOS ? 100 : 100, width: Get.width,
          // padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraLarge,/* vertical: Dimensions.PADDING_SIZE_SMALL*/),
          decoration: BoxDecoration(
              color: Theme.of(context).cardColor, boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
              borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)
          ),
          // child:
          
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

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
                    color:  Theme.of(context).primaryColor,
                    
                    // const Color.fromARGB(255, 28, 166, 114),
                    borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                    boxShadow: [BoxShadow(color: const Color(0xFF2A2A2A).withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -5))],
                  ),
                
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
                
                                child: Image.network(
                                  cartController.cartList[index].item!.imageFullUrl!,
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
}


 