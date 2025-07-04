import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/hover/on_hover.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';

import '../../../../../common/widgets/custom_ink_well.dart';

// class RecomendedStoreCardWidget extends StatelessWidget {
//   final Store? store;

//   const RecomendedStoreCardWidget({super.key, required this.store});

//   @override
//   Widget build(BuildContext context) {
//     double discount = store?.discount?.discount ?? 0;
//     String discountType = store?.discount?.discountType ?? 'percent';
//     bool isAvailable = store?.open == 1 && store?.active == true;
//     double containerWidth = MediaQuery.of(context).size.width * 0.40;

//     return OnHover(
//       isItem: true,
//       child: Stack(
//         children: [
//           Container(
//             width: containerWidth,
//             decoration: BoxDecoration(
//               color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             ),
//             child: CustomInkWell(
//               onTap: () {
//                 if (store != null) {
//                   Get.find<SplashController>().setModule(
//                     Get.find<SplashController>().moduleList?.firstWhere(
//                       (module) => module.id == store!.moduleId,
//                       // orElse: () => null,
//                     ),
//                   );
//                   Get.toNamed(
//                     RouteHelper.getStoreRoute(id: store!.id, page: 'store'),
//                     arguments: StoreScreen(store: store, fromModule: false),
//                   );
//                 }
//               },
//               radius: Dimensions.radiusDefault,
//               padding: const EdgeInsets.all(0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     clipBehavior: Clip.none,
//                     children: [
//                       ClipRRect(
//                         borderRadius: BorderRadius.vertical(
//                           top: Radius.circular(Dimensions.radiusDefault),
//                           bottom: Radius.circular(Dimensions.radiusDefault),
//                         ),
//                         child: CustomImage(
//                           fromstore: true,
//                           image: store?.coverPhotoFullUrl ?? '',
//                           height: 165,
//                           width: double.infinity,
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                       DiscountTag2(
//                         fromTop: 80,
//                         discount: discount,
//                         discountType: discountType,
//                       ),
//                       if (!isAvailable)
//                         NotAvailableWidget(
//                           isStore: true,
//                           store: store,
//                           fontSize: Dimensions.fontSizeExtraSmall,
//                           isAllSideRound: true,
//                           radius: Dimensions.radiusLarge,
//                         ),
//                       Positioned(
//                         top: Dimensions.paddingSizeSmall,
//                         right: Dimensions.paddingSizeSmall,
//                         child: GetBuilder<FavouriteController>(
//                           builder: (favouriteController) {
//                             bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
//                             return InkWell(
//                               onTap: () {
//                                 if (AuthHelper.isLoggedIn()) {
//                                   isWished
//                                       ? favouriteController.removeFromFavouriteList(store!.id, true)
//                                       : favouriteController.addToFavouriteList(null, store?.id, true);
//                                 } else {
//                                   showCustomSnackBar('you_are_not_logged_in'.tr);
//                                 }
//                               },
//                               child: Icon(
//                                 isWished ? Icons.favorite : Icons.favorite_border,
//                                 size: 24,
//                                 color: isWished ? Colors.red : Colors.white,
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             store?.name ?? '',
//                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
//                             maxLines: 1,
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                           Row(
//                             children: [
//                               if (store?.freeDelivery == true)
//                                 Row(
//                                   children: [
//                                     Image.asset(Images.deliveryIcon, height: 15, width: 15, color: Theme.of(context).primaryColor),
//                                     const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//                                     Text(
//                                       'free_delivery'.tr,
//                                       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                                     ),
//                                   ],
//                                 ),
//                               const SizedBox(width: Dimensions.paddingSizeSmall),
//                               Row(
//                                 children: [
//                                   const Icon(Icons.stars_rounded, size: 20, color: Color(0xFF085B42)),
//                                   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//                                   Text(
//                                     store?.avgRating?.toStringAsFixed(1) ?? '0.0',
//                                     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                                   ),
//                                   const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//                                   Text(
//                                     '${store?.deliveryTime}s',
//                                     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                           Text(
//                             store?.address ?? '',
//                             style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class StoreCardShimmer extends StatelessWidget {
//   const StoreCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width * 0.40,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//       ),
//       child: Shimmer(
//         duration: const Duration(seconds: 2),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               height: 150,
//               width: MediaQuery.of(context).size.width * 0.40,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
//                 color: Colors.grey[300],
//               ),
//             ),
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(height: 15, width: 100, color: Colors.grey[300]),
//                     const SizedBox(height: 5),
//                     Row(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             color: Colors.grey[300],
//                           ),
//                           child: const Padding(
//                             padding: EdgeInsets.all(2.0),
//                             child: Icon(Icons.star, color: Colors.white, size: 15),
//                           ),
//                         ),
//                         const SizedBox(width: 5),
//                         Container(height: 10, width: 80, color: Colors.grey[300]),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class RecomendedStoreCardWidget extends StatelessWidget {
  final Store? store;

  const RecomendedStoreCardWidget({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    double discount = store?.discount?.discount ?? 0;
    String discountType = store?.discount?.discountType ?? 'percent';
    bool isAvailable = store?.open == 1 && store?.active == true;
    double containerWidth = MediaQuery.of(context).size.width * 0.40;
bool isbusy = store?.zone?.isbusy == 1 ?? false;
    return OnHover(
      isItem: true,
      child: Container(
        width: containerWidth,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          boxShadow: [
            // BoxShadow(
            //   color: Colors.black.withOpacity(0.1),
            //   blurRadius: 8,
            //   spreadRadius: 2,
            //   offset: const Offset(0, 4),
            // ),
          ],
        ),
        child: CustomInkWell(
          onTap: () {
            if (store != null) {
              Get.find<SplashController>().setModule(
                Get.find<SplashController>().moduleList?.firstWhere(
                  (module) => module.id == store!.moduleId,
                ),
              );
           isbusy ? showCustomSnackBar('store busy'.tr) :   Get.toNamed(
                RouteHelper.getStoreRoute(id: store!.id, page: 'store'),
                arguments: StoreScreen(store: store, fromModule: false),
              );
            }
          },
          radius: Dimensions.radiusDefault,
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(Dimensions.radiusDefault),
                      bottom: Radius.circular(Dimensions.radiusDefault),
                    ),
                    child: CustomImage(
                      // fromstore: true,
                      image: store?.coverPhotoFullUrl ?? '',
                      height: 165,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  DiscountTag2(
                    fromTop: 80,
                    discount: discount,
                    discountType: discountType,
                  ),

                  Positioned(
                    top: 8,
                    left: -3,
                    child: Container(
                      height: 30,
                      width: 110,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(Dimensions.radiusSmall),
                          topLeft: Radius.circular(Dimensions.radiusSmall)
                        ),

                        gradient: LinearGradient(colors: [
                          // Color.fromARGB(255, 255, 106, 0),
                          Color.fromARGB(255, 222, 68, 34),
                           Color.fromARGB(255, 222, 68, 34),
                            // Color.fromARGB(255, 239, 55, 49),
                            Color.fromARGB(255, 247, 74, 109)
                           ], begin: Alignment.topLeft, end: Alignment.bottomRight),
                      ),

                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Recomended", style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w500),),
                        ],
                      ),
                    ),
                  ),
                     if (isbusy && isAvailable)
                    NotAvailableWidget(
                      // isStore: true,
                      // store:
                      //  store,
                      fontSize: Dimensions.fontSizeExtraSmall,
                      isAllSideRound: true,
                      radius: Dimensions.radiusLarge,
                    ),
                  if (!isAvailable)
                    NotAvailableWidget(
                      isStore: true,
                      store:
                       store,
                      fontSize: Dimensions.fontSizeExtraSmall,
                      isAllSideRound: true,
                      radius: Dimensions.radiusLarge,
                    ),
               
                  Positioned(
                    top: Dimensions.paddingSizeSmall,
                    right: Dimensions.paddingSizeSmall,
                    child: GetBuilder<FavouriteController>(
                      builder: (favouriteController) {
                        bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
                        return InkWell(
                          onTap: () {
                            if (AuthHelper.isLoggedIn()) {
                              isWished
                                  ? favouriteController.removeFromFavouriteList(store!.id, true)
                                  : favouriteController.addToFavouriteList(null, store?.id, true);
                            } else {
                              showCustomSnackBar('you_are_not_logged_in'.tr);
                            }
                          },
                          child: Icon(
                            isWished ? Icons.favorite : Icons.favorite_border,
                            size: 24,
                            color: isWished ? Colors.red : Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  // left: Dimensions.paddingSizeSmall,
                 right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store?.name ?? '',
                      style:  robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w600 ,color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Row(
                      children: [
                        if (store?.freeDelivery == true)
                          Row(
                            children: [
                              Image.asset(Images.deliveryIcon, height: 15, width: 15, color: Theme.of(context).primaryColor),
                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                              Text(
                                'free_delivery'.tr,
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                              ),
                            ],
                          ),
                        // const SizedBox(width: Dimensions.paddingSizeSmall),
                        Row(
                          children: [
                            const Icon(Icons.stars_rounded, size: 20, color: Color(0xFF085B42)),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            Text(
                              store?.avgRating?.toStringAsFixed(1) ?? '0.0',
                              style:  robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600,color:  Colors.black),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            Text(
                              '${store?.deliveryTime}s',
                              style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600,color:  Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                    Text(
                      store?.address ?? '',
                      style: robotoRegular.copyWith(color: Colors.grey[600], fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w500 ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class StoreCardShimmer extends StatelessWidget {
  const StoreCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
      ),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                color: Colors.grey[300],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(height: 15, width: 100, color: Colors.grey[300]),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.grey[300],
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2.0),
                            child: Icon(Icons.star, color: Colors.white, size: 15),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Container(height: 10, width: 80, color: Colors.grey[300]),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Container(height: 15, width: 200, color: Colors.grey[300]),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}