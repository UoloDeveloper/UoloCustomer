import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/features/review/screens/review_screen.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/widgets/readmorewidget.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreDescriptionViewWidget extends StatelessWidget {
  final Store? store;
  const StoreDescriptionViewWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    bool isAvailable = Get.find<StoreController>().isStoreOpenNow(store!.active!, store!.schedules);
    Color? textColor = ResponsiveHelper.isDesktop(context) ? Colors.white : null;
    // Module? moduleData;
    // for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
    //   for(Modules m in zData.modules!) {
    //     if(m.id == Get.find<SplashController>().module!.id) {
    //       moduleData = m as Module?;
    //       break;
    //     }
    //   }
    // }
    return Column(children: [

     Container(
      
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          Dimensions.radiusLarge,
          
        ),
        color: Theme.of(context).cardColor,
      ),
       child: Padding(
         padding: const EdgeInsets.only(left: 20,right: 10),
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
           children: [
         
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${store!.name}", style: robotoMedium.copyWith(fontSize: 20, color: textColor,fontWeight: FontWeight.w600)),
                      Row(
                        children: [
                          // Icon(Icons.timer, color: Theme.of(context).primaryColor, size: 18),
                          Text("${store!.deliveryTime}", style: robotoMedium.copyWith(fontSize: 13, color: textColor,fontWeight: FontWeight.w500)),
                          Text("'${(store!.distance! / 1000).toStringAsFixed(2)} km'", style: robotoMedium.copyWith(fontSize: 13, color: textColor,fontWeight: FontWeight.w500)),
             //  Text("'${(store!.address! )}'", style: robotoMedium.copyWith(fontSize: 10, color: textColor,fontWeight: FontWeight.w500)),
         
             SizedBox(width: 5,),
         AddressText(
           address: store!.address ?? "",
         )
                        ],
                      ),
                    ],
                  ),
                   
                   const Expanded(child: SizedBox()),
                   InkWell(
                                  onTap: () => Get.to(ReviewScreen(store: store, storeID: store!.id.toString(),)),
                                  //  Get.toNamed(RouteHelper.getStoreReviewRoute(store!.id, store!.name, store!))
                                  
                                  
                                  
                                  child: Column(children: [
                     Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                      color: const Color(0xFF0D7D41)
                    ),  
                       child: Padding(
                         padding: const EdgeInsets.all(3.0),
                         child: Row(children: [
                          Text(
                             store!.avgRating!.toStringAsFixed(1),
                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.white),
                           ),
                            const SizedBox(width: 2),
                           const Icon(Icons.star, color: Colors.white, size: 15),
                          
                           
                         ]),
                       ),
                     ),
                     const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                     Text(
                       '${store!.ratingCount} + ${'ratings'.tr}',
                       style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Colors.black54),
                     ),
                                  ]),
                                ),
                   
                ],
              ),
         
          const Divider(
         
          ),
        //  const SizedBox(height: 10,),
        store!.discount != null ?   const SizedBox(height: 10,) : const SizedBox(),
          store!.discount != null ?  Row(
            children: [
              SvgPicture.asset("assets/image/icons/Vector (1).svg", height: 20, width: 20),
              const SizedBox(width: 5,),
              Text('${store!.discount!.discountType == 'percent' ? '${'Flat'.tr} ${store!.discount!.discount}% ${'off'.tr}'
                                      : '${PriceConverter.convertPrice(store!.discount!.discount)} ${'off'.tr}'} '
                                      ' ${store!.discount!.minPurchase != 0 ? '${'above'.tr} ${  PriceConverter.convertPrice(store!.discount!.minPurchase)}' : ''} ',
                                      
                                    style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500
                                      ),
                                    
                                    textAlign: TextAlign.justify, maxLines: 2, overflow: TextOverflow.ellipsis,
                                  )
            ],
          ): const SizedBox(),

         store!.discount != null ?   const SizedBox(height: 10,) : const SizedBox(),
            //  Row(children: [
             
              
            //    const Expanded(child: SizedBox()),
            //    InkWell(
            //      onTap: () => Get.toNamed(RouteHelper.getStoreReviewRoute(store!.id, store!.name, store!)),
            //      child: Column(children: [
            //        Row(children: [
            //          Icon(Icons.star, color: Theme.of(context).primaryColor, size: 20),
            //          const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //          Text(
            //            store!.avgRating!.toStringAsFixed(1),
            //            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor),
            //          ),
            //        ]),
            //        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //        Text(
            //          '${store!.ratingCount} + ${'ratings'.tr}',
            //          style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor),
            //        ),
            //      ]),
            //    ),
            //    const Expanded(child: SizedBox()),
             
             
            //    InkWell(
            //      onTap: () => Get.toNamed(RouteHelper.getMapRoute(
            //        AddressModel(id: store!.id, address: store!.address, latitude: store!.latitude,
            //          longitude: store!.longitude, contactPersonNumber: '', contactPersonName: '', addressType: '',
            //        ), 'store', Get.find<SplashController>().getModuleConfig(Get.find<SplashController>().module!.moduleType!).newVariation!,
            //        storeName: store!.name,
            //      )),
            //      child: Column(children: [
            //        Icon(Icons.location_on, color: Theme.of(context).primaryColor, size: 20),
            //        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //        Text('location'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor)),
            //      ]),
            //    ),
            //    const Expanded(child: SizedBox()),
             
            //    Column(children: [
            //      Row(children: [
            //        Icon(Icons.timer, color: Theme.of(context).primaryColor, size: 20),
            //        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //        Text(
            //          store!.deliveryTime!,
            //          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor),
            //        ),
            //      ]),
            //      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //      Text('delivery_time'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor)),
            //    ]),
            //    (store!.delivery! && store!.freeDelivery!) ? const Expanded(child: SizedBox()) : const SizedBox(),
            //    (store!.delivery! && store!.freeDelivery!) ? Column(children: [
            //      Icon(Icons.money_off, color: Theme.of(context).primaryColor, size: 20),
            //      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
            //      Text('free_delivery'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: textColor)),
            //    ]) : const SizedBox(),
            //    const Expanded(child: SizedBox()),
            //  ]),
           
          //  SizedBox(height: 30,)
           ],
         ),
       ),
     ),


    ]);
  }
}
