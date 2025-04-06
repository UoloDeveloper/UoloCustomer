import 'package:carousel_slider/carousel_slider.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/basic_campaign_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

// class BannerView extends StatelessWidget {
//   final bool isFeatured;
//     final bool Grocery;
//   const BannerView({super.key, required this.isFeatured,  this.Grocery = false});

//   @override
//   Widget build(BuildContext context) {

//     return GetBuilder<BannerController>(builder: (bannerController) {
//       List<String?>? bannerList = isFeatured ? bannerController.featuredBannerList : bannerController.bannerImageList;
//       List<dynamic>? bannerDataList = isFeatured ? bannerController.featuredBannerDataList : bannerController.bannerDataList;

//       return (bannerList != null && bannerList.isEmpty) ? const SizedBox() : Container(
//         width: MediaQuery.of(context).size.width,
//         height: GetPlatform.isDesktop ? 500 : !isFeatured ? MediaQuery.of(context).size.width * 0.55 :  MediaQuery.of(context).size.width * 0.75,
//         padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
//         child: bannerList != null ? Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Expanded(
//               child: CarouselSlider.builder(

//                 options: CarouselOptions(
                  
//                   autoPlay: true,
//                   // enlargeCenterPage: true,
//                   disableCenter: true,
//                   viewportFraction: 0.90,


//                   autoPlayInterval: const Duration(seconds: 5),
//                   onPageChanged: (index, reason) {
//                     bannerController.setCurrentIndex(index, true);
//                   },
//                 ),
//                 itemCount: bannerList.isEmpty ? 1 : bannerList.length,
//                 itemBuilder: (context, index, _) {

//                   return InkWell(
//                     onTap: () async {
//                       if(bannerDataList![index] is Item) {
//                         Item? item = bannerDataList[index];
//                         if (Grocery) {
//                                   showGroceryItemBottomSheet(
//         context,
//         item,
//         false

//       );
                          
//                         }else {
//                           Get.find<ItemController>().navigateToItemPage(item, context);
//                         }
                 
//                         // Get.find<ItemController>().navigateToItemPage(item, context);
//                       }else if(bannerDataList[index] is Store) {
//                         Store? store = bannerDataList[index];
//                         if(isFeatured && (AddressHelper.getUserAddressFromSharedPref()!.zoneData != null && AddressHelper.getUserAddressFromSharedPref()!.zoneData!.isNotEmpty)) {
//                           for(ModuleModel module in Get.find<SplashController>().moduleList!) {
//                             if(module.id == store!.moduleId) {
//                               Get.find<SplashController>().setModule(module);
//                               break;
//                             }
//                           }
//                           ZoneData zoneData = AddressHelper.getUserAddressFromSharedPref()!.zoneData!.firstWhere((data) => data.id == store!.zoneId);

//                           Modules module = zoneData.modules!.firstWhere((module) => module.id == store!.moduleId);
//                           Get.find<SplashController>().setModule(ModuleModel(id: module.id, moduleName: module.moduleName, moduleType: module.moduleType, themeId: module.themeId, storesCount: module.storesCount));
//                         }
//                         Get.toNamed(
//                           RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'banner'),
//                           arguments: StoreScreen(store: store, fromModule: isFeatured),
//                         );
//                       }else if(bannerDataList[index] is BasicCampaignModel) {
//                         BasicCampaignModel campaign = bannerDataList[index];
//                         Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
//                       }else {
//                         String url = bannerDataList[index];
//                         if (await canLaunchUrlString(url)) {
//                           await launchUrlString(url, mode: LaunchMode.externalApplication);
//                         }else {
//                           showCustomSnackBar('unable_to_found_url'.tr);
//                         }
//                       }
//                     },
//                     child: Padding(
//                       padding: !isFeatured ?  EdgeInsets.only(right:  20) : EdgeInsets.all(6),
//                       child: Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).cardColor,
//                           borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                           // boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 0)],
//                         ),
//                         margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                           child: GetBuilder<SplashController>(builder: (splashController) {
//                             return CustomImage(
//                               image: '${bannerList[index]}',
//                               fit: BoxFit.cover,
//                             );
//                           }),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.center,
//             //   children: bannerList.map((bnr) {
//             //     int index = bannerList.indexOf(bnr);
//             //     int totalBanner = bannerList.length;
//             //     return Padding(
//             //       padding: const EdgeInsets.symmetric(horizontal: 3),
//             //       child: index == bannerController.currentIndex ? Container(
//             //         decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
//             //         padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
//             //         child: Text('${(index) + 1}/$totalBanner', style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: 12)),
//             //       ) : Container(
//             //         height: 5, width: 6,
//             //         decoration: BoxDecoration(color: Theme.of(context).primaryColor.withOpacity(0.5), borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
//             //       ),
//             //     );
//             //   }).toList(),
//             // ),

//             Row(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: bannerList.map((bnr) {
//     int index = bannerList.indexOf(bnr);
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 3),
//       child: index == bannerController.currentIndex
//           ? Container(
//               height: 5, // Line height
//               width: 20, // Line width for the active indicator
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault), // Slightly rounded edges for the line
//               ),
//             )
//           : Container(
//               height: 5,
//               width: 20,
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//               ),
//             ),
//     );
//   }).toList(),
// )


//           ],
//         ) :  isFeatured ? const SizedBox() :
//          Shimmer(
//           duration: const Duration(seconds: 2),
//           enabled: bannerList == null,
//           child: Padding(
//             padding: const EdgeInsets.only(left: 8,right: 8),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//               child: CustomImage(image: Images.placeholder, height: 200, width: double.infinity, fit: BoxFit.cover)),
//           ),
//           //  Container(margin: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(
//           //   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//           //   color: Colors.grey[300],
//           // )),
//         ),
//       );
//     });
//   }

// }


// class BannerView extends StatelessWidget {
//   final bool isFeatured;
//   final bool Grocery;
//   const BannerView({super.key, required this.isFeatured, this.Grocery = false});

//   @override
//   Widget build(BuildContext context) {
//     debugPrint('BannerView - isFeatured: $isFeatured');
//     debugPrint('BannerView - Grocery: $Grocery');

//     return GetBuilder<BannerController>(builder: (bannerController) {
//       List<String?>? bannerList = isFeatured ? bannerController.featuredBannerList : bannerController.bannerImageList;
//       List<dynamic>? bannerDataList = isFeatured ? bannerController.featuredBannerDataList : bannerController.bannerDataList;

//       debugPrint('BannerView - bannerList: $bannerList');
//       debugPrint('BannerView - bannerDataList: $bannerDataList');

//       return (bannerList != null && bannerList.isEmpty)
//           ? const SizedBox()
//           : Container(
//               width: MediaQuery.of(context).size.width,
//               height: GetPlatform.isDesktop
//                   ? 500
//                   : !isFeatured
//                       ? MediaQuery.of(context).size.width * 0.55
//                       : MediaQuery.of(context).size.width * 0.75,
//               padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
//               child: bannerList != null
//                   ? Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Expanded(
//                           child: CarouselSlider.builder(
//                             options: CarouselOptions(
//                               autoPlay: true,
//                               disableCenter: true,
//                               viewportFraction: 0.90,
//                               autoPlayInterval: const Duration(seconds: 5),
//                               onPageChanged: (index, reason) {
//                                 bannerController.setCurrentIndex(index, true);
//                               },
//                             ),
//                             itemCount: bannerList.isEmpty ? 1 : bannerList.length,
//                             itemBuilder: (context, index, _) {
//                               return InkWell(
//                                 onTap: () async {
//                                   if (bannerDataList![index] is Item) {
//                                     Item? item = bannerDataList[index];
//                                     if (Grocery) {
//                                       showGroceryItemBottomSheet(context, item, false);
//                                     } else {
//                                       Get.find<ItemController>().navigateToItemPage(item, context);
//                                     }
//                                   } else if (bannerDataList[index] is Store) {
//                                     Store? store = bannerDataList[index];
//                                     if (isFeatured &&
//                                         (AddressHelper.getUserAddressFromSharedPref()!.zoneData != null &&
//                                             AddressHelper.getUserAddressFromSharedPref()!.zoneData!.isNotEmpty)) {
//                                       for (ModuleModel module in Get.find<SplashController>().moduleList!) {
//                                         if (module.id == store!.moduleId) {
//                                           Get.find<SplashController>().setModule(module);
//                                           break;
//                                         }
//                                       }
//                                       ZoneData zoneData = AddressHelper.getUserAddressFromSharedPref()!
//                                           .zoneData!
//                                           .firstWhere((data) => data.id == store!.zoneId);

//                                       Modules module = zoneData.modules!
//                                           .firstWhere((module) => module.id == store!.moduleId);
//                                       Get.find<SplashController>().setModule(ModuleModel(
//                                           id: module.id,
//                                           moduleName: module.moduleName,
//                                           moduleType: module.moduleType,
//                                           themeId: module.themeId,
//                                           storesCount: module.storesCount));
//                                     }
//                                     Get.toNamed(
//                                       RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'banner'),
//                                       arguments: StoreScreen(store: store, fromModule: isFeatured),
//                                     );
//                                   } else if (bannerDataList[index] is BasicCampaignModel) {
//                                     BasicCampaignModel campaign = bannerDataList[index];
//                                     Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
//                                   } else {
//                                     String url = bannerDataList[index];
//                                     if (await canLaunchUrlString(url)) {
//                                       await launchUrlString(url, mode: LaunchMode.externalApplication);
//                                     } else {
//                                       showCustomSnackBar('unable_to_found_url'.tr);
//                                     }
//                                   }
//                                 },
//                                 child: Padding(
//                                   padding: !isFeatured ? EdgeInsets.only(right: 20) : EdgeInsets.all(6),
//                                   child: Container(
//                                     decoration: BoxDecoration(
//                                       color: Theme.of(context).cardColor,
//                                       borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                                     ),
//                                     margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                                     child: ClipRRect(
//                                       borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                                       child: GetBuilder<SplashController>(builder: (splashController) {
//                                         return CustomImage(
//                                           image: '${bannerList[index]}',
//                                           fit: BoxFit.cover,
//                                         );
//                                       }),
//                                     ),
//                                   ),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: bannerList.map((bnr) {
//                             int index = bannerList.indexOf(bnr);
//                             return Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: 3),
//                               child: index == bannerController.currentIndex
//                                   ? Container(
//                                       height: 5,
//                                       width: 20,
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor.withOpacity(0.7),
//                                         borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                       ),
//                                     )
//                                   : Container(
//                                       height: 5,
//                                       width: 20,
//                                       decoration: BoxDecoration(
//                                         color: Theme.of(context).primaryColor.withOpacity(0.1),
//                                         borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                       ),
//                                     ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                     )
//                   : isFeatured
//                       ? const SizedBox()
//                       : Shimmer(
//                           duration: const Duration(seconds: 2),
//                           enabled: bannerList == null,
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8, right: 8),
//                             child: ClipRRect(
//                               borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
//                               child: CustomImage(
//                                 image: Images.placeholder,
//                                 height: 200,
//                                 width: double.infinity,
//                                 fit: BoxFit.cover,
//                               ),
//                             ),
//                           ),
//                         ),
//             );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BannerView extends StatelessWidget {
  final bool isFeatured;
  final bool Grocery;

  const BannerView({super.key, required this.isFeatured, this.Grocery = false});

  @override
  Widget build(BuildContext context) {
    debugPrint('BannerView - isFeatured: $isFeatured');
    debugPrint('BannerView - Grocery: $Grocery');

    return GetBuilder<BannerController>(builder: (bannerController) {
      // Determine which banner list to use
      List<String?>? bannerList = isFeatured
          ? bannerController.featuredBannerList
          : bannerController.bannerImageList;

      List<dynamic>? bannerDataList = isFeatured
          ? bannerController.featuredBannerDataList
          : bannerController.bannerDataList;

      debugPrint('BannerView - bannerList: $bannerList');
      debugPrint('BannerView - bannerDataList: $bannerDataList');

      // If no banners are available, return an empty SizedBox
      if (bannerList == null || bannerList.isEmpty) {
        return const SizedBox();
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        height: GetPlatform.isDesktop
            ? 500
            : !isFeatured
                ? MediaQuery.of(context).size.width * 0.55
                : MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CarouselSlider.builder(
                options: CarouselOptions(
                  autoPlay: true,
                  disableCenter: true,
                  viewportFraction: 0.95,
                  autoPlayInterval: const Duration(seconds: 5),
                  onPageChanged: (index, reason) {
                    bannerController.setCurrentIndex(index, true);
                  },
                ),
                itemCount: bannerList.length,
                itemBuilder: (context, index, _) {
                  return InkWell(
                    onTap: () async {
                        if (bannerDataList![index] is Item) {
                                    Item? item = bannerDataList[index];
                                    if (Grocery) {
                                      showGroceryItemBottomSheet(context, item, false);
                                    } else {
                                      Get.find<ItemController>().navigateToItemPage(item, context);
                                    }
                                  } else if (bannerDataList[index] is Store) {
                                    Store? store = bannerDataList[index];
                                    if (isFeatured &&
                                        (AddressHelper.getUserAddressFromSharedPref()!.zoneData != null &&
                                            AddressHelper.getUserAddressFromSharedPref()!.zoneData!.isNotEmpty)) {
                                      for (ModuleModel module in Get.find<SplashController>().moduleList!) {
                                        if (module.id == store!.moduleId) {
                                          Get.find<SplashController>().setModule(module);
                                          break;
                                        }
                                      }
                                      ZoneData zoneData = AddressHelper.getUserAddressFromSharedPref()!
                                          .zoneData!
                                          .firstWhere((data) => data.id == store!.zoneId);

                                      Modules module = zoneData.modules!
                                          .firstWhere((module) => module.id == store!.moduleId);
                                      Get.find<SplashController>().setModule(ModuleModel(
                                          id: module.id,
                                          moduleName: module.moduleName,
                                          moduleType: module.moduleType,
                                          themeId: module.themeId,
                                          storesCount: module.storesCount));
                                    }
                                    Get.toNamed(
                                      RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'banner'),
                                      arguments: StoreScreen(store: store, fromModule: isFeatured),
                                    );
                                  } else if (bannerDataList[index] is BasicCampaignModel) {
                                    BasicCampaignModel campaign = bannerDataList[index];
                                    Get.toNamed(RouteHelper.getBasicCampaignRoute(campaign));
                                  } else {
                                    String url = bannerDataList[index];
                                    if (await canLaunchUrlString(url)) {
                                      await launchUrlString(url, mode: LaunchMode.externalApplication);
                                    } else {
                                      showCustomSnackBar('unable_to_found_url'.tr);
                                    }
                                  }
                                
                      // await _handleBannerTap(bannerDataList, index, context);
                    },
                    child: Padding(
                      padding: !isFeatured ? EdgeInsets.only(right: 20) : EdgeInsets.all(6),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                        ),
                        margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                          child: CustomImage(
                            image: '${bannerList[index]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: bannerList.map((bnr) {
                int index = bannerList.indexOf(bnr);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: index == bannerController.currentIndex
                      ? Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          ),
                        )
                      : Container(
                          height: 5,
                          width: 20,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          ),
                        ),
                );
              }).toList(),
            ),
          ],
        ),
      );
    });
  }
}