import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/category/domain/models/category_model.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/hover/on_hover.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';

// class StoreCardWidget extends StatelessWidget {
//   final Store? store;
//   const StoreCardWidget({super.key, required this.store});

//   @override
//   Widget build(BuildContext context) {
//     double? discount = store!.discount != null ? store!.discount!.discount : 0;
//     String? discountType = store!.discount != null ? store!.discount!.discountType : 'percent';
//     bool isAvailable = store!.open == 1 && store!.active!;
//     return OnHover(
//       isItem: true,
//       child: TextHover(
//         builder: (hovered) {
//           return Stack(
//             children: [
//               Container(
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                   border: Border.all(color: Theme.of(context).disabledColor  ),
//                   boxShadow: ResponsiveHelper.isDesktop(context) ? [] : const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
//                 ),
//                 child: CustomInkWell(
//                   onTap: () {
//                     if(store != null) {
//                       if(Get.find<SplashController>().moduleList != null) {
//                         for(ModuleModel module in Get.find<SplashController>().moduleList!) {
//                           if(module.id == store!.moduleId) {
//                             Get.find<SplashController>().setModule(module);
//                             break;
//                           }
//                         }
//                       }
//                       Get.toNamed(
//                         RouteHelper.getStoreRoute(id: store!.id, page: 'item'),
//                         arguments: StoreScreen(store: store, fromModule: false),
//                       );
//                     }
//                   },
//                   radius: Dimensions.radiusDefault,
//                   padding: const EdgeInsets.all(1),
//                   child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

//                     Stack(clipBehavior: Clip.none, children: [
//                       ClipRRect(
//                         borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusDefault)),
//                         child: CustomImage(
//                           isHovered: hovered,
//                           image: '${store!.coverPhotoFullUrl}',
//                           height: 120, width: double.infinity, fit: BoxFit.cover,
//                         ),
//                       ),
//                       DiscountTag(
//                         discount: discount, discountType: discountType,
//                       ),
//                       isAvailable ? const SizedBox() : NotAvailableWidget(isStore: true, store: store, fontSize: Dimensions.fontSizeExtraSmall, isAllSideRound: false),
//                       Positioned(
//                         top: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall,
//                         child: GetBuilder<FavouriteController>(builder: (favouriteController) {
//                           bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
//                           return InkWell(
//                             onTap: () {
//                               if(AuthHelper.isLoggedIn()) {
//                                 isWished ? favouriteController.removeFromFavouriteList(store!.id, true)
//                                     : favouriteController.addToFavouriteList(null, store?.id, true);
//                               }else {
//                                 showCustomSnackBar('you_are_not_logged_in'.tr);
//                               }
//                             },
//                             child: Icon(
//                               isWished ? Icons.favorite : Icons.favorite_border,  size: 24,
//                               color: isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
//                             ),
//                           );
//                         }),
//                       ),

//                       store!.ratingCount! > 0 ? Positioned(
//                         bottom: -15,
//                         left: Get.find<LocalizationController>().isLtr ? null : 10,
//                         right: Get.find<LocalizationController>().isLtr ? 10 : null,
//                         child: Container(
//                           padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).cardColor,
//                             borderRadius: const BorderRadius.all(Radius.circular(100)),
//                             boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
//                           ),
//                           child: Row(children: [
//                             Icon(Icons.star, size: 15, color: Theme.of(context).primaryColor),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               store!.avgRating!.toStringAsFixed(1),
//                               style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               '(${store!.ratingCount})',
//                               style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).disabledColor),
//                             ),
//                           ]),
//                         ),
//                       ) : const SizedBox(),
//                     ]),

//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                         child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
//                           SizedBox(
//                             width: context.width * 0.7,
//                             child: Text(
//                               store!.name ?? '',
//                               style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
//                               maxLines: 1, overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                           Row(children: [
//                             Icon(Icons.location_on_outlined, size: 15, color: Theme.of(context).primaryColor),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Flexible(
//                               child: Text(
//                                 store!.address ?? '',
//                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                                 maxLines: 1, overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ]),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                           Row(children: [
//                             store!.freeDelivery! ? Row(children: [
//                               Image.asset(Images.deliveryIcon, height: 15, width: 15, color: Theme.of(context).primaryColor),
//                               const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                               Text(
//                                 'free_delivery'.tr,
//                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                               ),
//                             ]) : const SizedBox(),
//                             SizedBox(width: store!.freeDelivery! ? Dimensions.paddingSizeSmall : 0),

//                             Row(children: [
//                               Icon(Icons.timer, size: 15, color: Theme.of(context).primaryColor),
//                               const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                               Text(
//                                 '${store!.deliveryTime}',
//                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                               ),
//                             ]),
//                           ]),
//                         ]),
//                       ),
//                     ),
//                   ]),
//                 ),
//               ),
//             ],
//           );
//         }
//       ),
//     );
//   }
// }


// class StoreCardShimmer extends StatelessWidget {
//   const StoreCardShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//       width: 500,
//       decoration: BoxDecoration(
//         color: Theme.of(context).cardColor,
//         borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//       ),
//       child: Shimmer(
//         duration: const Duration(seconds: 2),
//         child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [

//           Container(
//             height: 120, width: 120,
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)),
//               color: Theme.of(context).shadowColor,
//             ),
//           ),
//           const SizedBox(width: Dimensions.paddingSizeSmall),

//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [
//                 Container(height: 15, width: 200, color: Theme.of(context).shadowColor),
//                 const SizedBox(height: 5),

//                 Container(height: 10, width: 130, color: Theme.of(context).shadowColor),
//                 const SizedBox(height: 5),

//                 Row(
//                   children: List.generate(5, (index) {
//                     return Icon(Icons.star, color: Theme.of(context).shadowColor, size: 15);
//                   }),
//                 ),

//               ]),
//             ),
//           ),

//         ]),
//       ),
//     );
//   }
// }




class StoreCardWidget2 extends StatelessWidget {
  final Store? store;
  const StoreCardWidget2({super.key, required this.store});

  @override
  Widget build(BuildContext context) {
    double? discount = store!.discount != null ? store!.discount!.discount : 0;
    String? discountType = store!.discount != null ? store!.discount!.discountType : 'percent';
    bool isAvailable = store!.open == 1 && store!.active!;
double distance = (store!.distance! / 1000);
    return Padding(
      padding: const EdgeInsets.only(top: 0,bottom: 0),
      child: OnHover(
        isItem: true,
        child: Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: CustomInkWell(
            onTap: () {
              if (store != null) {
                if (Get.find<SplashController>().moduleList != null) {
                  for (ModuleModel module in Get.find<SplashController>().moduleList!) {
                    if (module.id == store!.moduleId) {
                      Get.find<SplashController>().setModule(module);
                      break;
                    }
                  }
                }
                Get.toNamed(
                  RouteHelper.getStoreRoute(id: store!.id, page: 'item'),
                  arguments: StoreScreen(store: store, fromModule: false),
                );
              }
            },
            radius: Dimensions.radiusDefault,
            padding: const EdgeInsets.all(1),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start ,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                
                Expanded(
                  flex: 7, 
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(Dimensions.radiusDefault + 7),
                          topRight: Radius.circular(Dimensions.radiusDefault +7),
                          topLeft: Radius.circular(Dimensions.radiusDefault +7),
                          bottomLeft: Radius.circular(Dimensions.radiusDefault +7),
                        ),
                        child: CustomImage(
                          // fromstore: true,
                          image: '${store!.coverPhotoFullUrl}',
                          height: 170,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
      
                      // Discount Tag
                      DiscountTag(
                        fromTop: 80,
                        discount: discount,
                        discountType: discountType, currency: store?.currency,
                      ),
      
                      // Not Available Indicator
                      isAvailable
                          ? const SizedBox()
                          : NotAvailableWidget(
                            radius: Dimensions.radiusDefault ,
                              isStore: true,
                              store: store,
                              fontSize: Dimensions.fontSizeExtraSmall,
                              isAllSideRound: true,
                            ),
      
                      // Favorite Icon
                      Positioned(
                        top: 10,
                        right: 5,
                        child: SizedBox(
                            width: 30,  // Set explicit width
                            height: 20,
                          child: GetBuilder<FavouriteController>(
                            builder: (favouriteController) {
                              bool isWished =
                                  favouriteController.wishStoreIdList.contains(
                                      store!.id);
                              return InkWell(
                                onTap: () {
                                  if (AuthHelper.isLoggedIn()) {
                                    isWished
                                        ? favouriteController
                                            .removeFromFavouriteList(store!.id, true)
                                        : favouriteController.addToFavouriteList(
                                            null, store?.id, true);
                                  } else {
                                    showCustomSnackBar(
                                        'you_are_not_logged_in'.tr);
                                  }
                                },
      
                                ////Add to Favourite
                                child: Icon(
                                  isWished
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  size: 24,
                                  color: isWished
                                      ? Colors.red
                                      : Colors.white,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
      
                // Right side: Store details
                Expanded(
                  flex: 12, // Adjust the space for the details
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeSmall,
                      // right: Dimensions.paddingSizeExtraSmall,
                      bottom: Dimensions.paddingSizeSmall,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // Store Name and Rating
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const SizedBox(height: 10,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        child: Text(
                                          store!.name ?? '',
                                          style: robotoBold.copyWith(
                                              fontWeight: FontWeight.values[5],
                                              fontSize: Dimensions.fontSizeExtraLarge,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
      
                                        const Padding(
                                          padding: EdgeInsets.only(right: 0),
                                          child: PopupMenu(),
                                        ),
                                    ],
                                  ),
                                    Row(
                              children: [
      
      //                           const Icon(Icons.stars_rounded,
      //                               size: 20, color: Color(0xFF085B42)),
      
                                const Icon(Icons.stars_rounded,
                                    size: 20, color: Color(0xFF085B42)),
                                const SizedBox(
                                    width: 2),
                                Text(
                                  store!.avgRating!.toStringAsFixed(1),
                                  style: robotoBold.copyWith(
                                    fontWeight: FontWeight.w500,
                                      fontSize: 15,
                                    color: const Color.fromARGB(255, 33, 33, 33), ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${store!.deliveryTime}s',
                                  style: robotoBold.copyWith(
                                     fontWeight: FontWeight.w500,
                                      fontSize:15,
                                      color: const Color(0xFF3D3D3D),
                                ),
                                ),
                              ],
                            ),
                                ],
                              ),
                            ),
                            const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                            
                          ],
                        ),
                        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                     
                        // Free Delivery and Delivery Time
                        Row(
                          children: [
                            if (store!.freeDelivery!)
                              Row(
                                children: [
                                  Image.asset(
                                    Images.deliveryIcon,
                                    height: 15,
                                    width: 15,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  const SizedBox(
                                      width: Dimensions.paddingSizeExtraSmall),
                                  Text(
                                    'free_delivery'.tr,
                                    style: robotoMedium.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                        color: Theme.of(context).disabledColor),
                                  ),
                                ],
                              ),
      
                            Flexible(
                              child: Text(
                                Get.find<CategoryController>().categoryList == null
                                    ? 'Loading...' 
                                    : store!.categoryIds != null
                                    ? (store!.categoryIds!..shuffle()) 
                                    .take(3) 
                                    .map((id) {
                                  var category = Get.find<CategoryController>().categoryList!.firstWhere(
                                        (category) => category.id == id,
                                    orElse: () => CategoryModel(id: 2, name: 'food'), 
                                  );
                                  return category.name;
                                }).join(', ') 
                                    : 'No Categories', 
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeSmall + 2,
                                     color: Colors.black45,
                                  // color: Theme.of(context).disabledColor,
                                  // color: Colors.grey,
                              fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
      
      
      
      
                          ],
                        ),
                        const SizedBox(width: Dimensions.paddingSizeSmall),
                        // Text(
                        //   '${store!.address}',
                        //   style: robotoMedium.copyWith(
                        //       fontSize: Dimensions.fontSizeSmall + 2,
                        //       color: Colors.black45,
                        //       fontWeight: FontWeight.w500
                        //       ),
                        // ),

                 Expanded(
                  child: RichText(
                    maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                  text: store!.address ?? '',
                  style: robotoRegular.copyWith(color: Colors.grey[600], fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w500 ),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,,
                                ),
                                TextSpan(
                  text: '  ', // Space between address and distance
                                ),
                                TextSpan(
                  text: ' ${ distance > 100 ? '100+' :  distance.toStringAsFixed(2)} km',
                  style: robotoRegular.copyWith(
                    color:Colors.grey[600],
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w500
                  ),
                                ),
                              ],
                            )),
                ),
            //  Flexible(child: Expanded(child: SizedBox())),
            Spacer(),

                       Padding(
                         padding: const EdgeInsets.only(left: 0, right: 0,bottom: 0),
                         child: Container(
                         
                          height: 32,
                          // width: 300,
                          // color: Colors.amber,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: 
                                Colors.green.shade100.withOpacity(0.2),
                                spreadRadius: .2,
                                blurRadius: 10,
                                offset: const Offset(0, 3), // changes position of shadow
                              )
                            ],
                            borderRadius: BorderRadius.circular(50),
                             gradient: LinearGradient(colors: [Color.fromARGB(0, 199, 134, 245), Color.fromARGB(19, 140, 9, 233)],begin:  Alignment.topRight, end: Alignment.bottomLeft),
                            //  gradient: LinearGradient(
                         
                            //    // stops:  ,
                            //    colors: [
                            //      Colors.white,
                            //              const Color.fromARGB(101, 255, 255, 255),
                            //      // Colors.lightBlue.shade100,
                            //      // Colors.blue,
                            //      //  Colors.green.shade100,
                            //       //  Colors.white,
                            //         //  Color(0xFFD3605D),
                            //              Color.fromARGB(17, 250, 174, 170),
                            //      Color.fromARGB(73, 250, 174, 170),
                            //      //  Colors.white,
                            //    ],
                               
                            //     tileMode: TileMode.clamp,
                            //      stops: [0.0, 0.4, 0.8, 1.0], // Optional: Define where each color starts
                            //            // center: Alignment(0.0, 0.0), // Center of the gradient
                            //            // radius: 10, // Radius of the gradient
                            //            // tileMode: TileMode.decal, 
                            //    begin: Alignment.centerLeft,
                            //    end: Alignment.centerRight,
                            //  ),
                          ),
                           child: Padding(
                             padding: const EdgeInsets.all(0.0),
                             child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                               children: [

                                  Image.asset("assets/image/icons/icons8-gold-coin-96[1].png",width: 30,height:30,),
                                //  Padding(
                                //    padding: const EdgeInsets.all(10),
                                //    child: Container(
                                //      // width: 100,
                                //      height: 25,
                                //      width: 120,
                                //      decoration: BoxDecoration(
                                //        border: const GradientBoxBorder(
                                //          gradient: LinearGradient(colors: [
                                //            // Colors.blue, Colors.red
                                //               Color(0xFFFFD700), // Gold
                                //        Color(0xFFFFA500), // Orange-Gold
                                //       //  Color(0xFFDAA520)
                                //             Color(0xFFFFD700), // Gold
                                //            ]),
                                //          width: 2,
                                //        ),
                                //        borderRadius: BorderRadius.circular(16)
                                //      ),
                                   
                                //      child:  Center(child: Row(
                                //          mainAxisAlignment: MainAxisAlignment.center,
                                //        children: [
                                //           Image.asset("assets/image/icons/icons8-gold-coin-96[1].png",width: 20,height:20,),
                                //          Text('Earn UoloCoins', style: TextStyle(color:Color(0xFFBFA100),  fontSize: 11,fontWeight: FontWeight.w600),),
                                //        ],
                                //      ))
                                //    ),
                                //  ),
                                  SizedBox(width: 5,)  ,                  
                                Text("EARN UOLOCOINS",style:
                                 TextStyle(color:Color.fromARGB(202, 52, 4, 87),  fontSize: 10,fontWeight: FontWeight.w800),)
                                 ,
                             
                                   
                               ],
                             ),
                           ),
                         ),
                       ),
                    
                    // SizedBox(height: 15,)
                    
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}





class PopupMenu extends StatelessWidget {
  const PopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      color: Colors.white,
      onSelected: (String value) {

        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('You selected: $value')),
        // );
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'Share',
          child: Text('Share'),
        ),
        const PopupMenuItem<String>(
          value: 'Add to Favorite',
          child: Text('Add to Favorite'),
        ),
        // const PopupMenuItem<String>(
        //   value: 'Option 3',
        //   child: Text('Option 3'),
        // ),
      ],
      child: const Icon(Icons.more_vert),
    );
  }
}
















class StoreCardShimmer2 extends StatelessWidget {
  const StoreCardShimmer2({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Expanded(
              flex: 5,
              child: Container(
                height: 170,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(Dimensions.radiusDefault),
                    topRight: Radius.circular(Dimensions.radiusDefault),
                    topLeft: Radius.circular(Dimensions.radiusDefault),
                    bottomLeft: Radius.circular(Dimensions.radiusDefault),
                  ),
                ),
              ),
            ),
      
            // Shimmer for Store Details
            Expanded(
              flex: 9,
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Shimmer for Store Name
                    Container(
                      height: 20,
                      width: 150,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
      
                    // Shimmer for Store Rating and Delivery Time
                    Row(
                      children: [
                        Container(
                          height: 15,
                          width: 15,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Container(
                          height: 15,
                          width: 50,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Container(
                          height: 15,
                          width: 50,
                          color: Colors.grey[300],
                        ),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
      
                    // Shimmer for Free Delivery and Category
                    Container(
                      height: 15,
                      width: 200,
                      color: Colors.grey[300],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
      
                    // Shimmer for Store Address
                    Container(
                      height: 15,
                      width: 250,
                      color: Colors.grey[300],
                    ),
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
