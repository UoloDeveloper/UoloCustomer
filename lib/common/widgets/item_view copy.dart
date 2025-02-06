import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/card_design/store_card_with_distance.dart';
import 'package:sixam_mart/common/widgets/custom_divider.dart';

import 'package:sixam_mart/features/home/widgets/views/best_store_nearby_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/store_card_widget.dart';

import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/common/widgets/item_shimmer.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




// class ItemsView2 extends StatefulWidget {
//   final List<Item?>? singleitems;
//   final List<Item?>? items;
//   final List<Store?>? stores;
//   final bool isStore;
//   final EdgeInsetsGeometry padding;
//   final bool isScrollable;
//   final int shimmerLength;
//   final String? noDataText;
//   final bool isCampaign;
//   final bool inStorePage;
//   final bool isFeatured;
//   final bool? isFoodOrGrocery;
//   final bool notinStore;

//   const ItemsView2({

//     super.key,
//     required this.stores,
//     required this.items,
//     required this.isStore,
//     this.isScrollable = false,
//     this.shimmerLength = 20,
//     this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault),
//     this.noDataText,
//     this.isCampaign = false,
//     this.inStorePage = false,
//     this.isFeatured = false,
//     this.isFoodOrGrocery = true,
//     this.singleitems,
//     this.notinStore = false,
//   });

//   @override
//   State<ItemsView2> createState() => _ItemsViewState();
// }

// class _ItemsViewState extends State<ItemsView2> {
//   @override
//   Widget build(BuildContext context) {
//     bool isNull = true;
//     int length = 0;

//     if (widget.isStore) {
//       isNull = widget.stores == null;
//       if (!isNull) {
//         length = widget.stores?.length ?? 0;
//       }
//     } else {
//       isNull = widget.items == null;
//       if (!isNull) {
//         length = widget.items?.length ?? 0;
//       }
//     }

//     return Column(
//       children: [
//         !isNull
//             ? length > 0
//                 ? GridView.builder(
//                     key: UniqueKey(),
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeLarge,
//                       mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null && widget.isStore ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
//                       mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore ? 210
//                           : ResponsiveHelper.isMobile(context) ? widget.stores != null && widget.isStore ? 190 : 216
//                           : 122,
//                       crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isDesktop(context) && widget.stores != null  ? 3 : 3,
//                     ),
//                     physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
//                     shrinkWrap: widget.isScrollable ? false : true,
//                     itemCount: length,
//                     padding: const EdgeInsets.only(left: 10,right:0 ),
//                     itemBuilder: (context, index) {
//                       if (widget.stores != null && widget.isStore) {
//                         return widget.isFoodOrGrocery!

                            
//                             ?  index == 3 ? 
//                       const BestStoreNearbyView(): StoreCardWidget2(store: widget.stores![index]) 
//                             : StoreCardWithDistance(store: widget.stores![index]!, fromAllStore: true);
//                       } else {
//                         return Column(
//                           children: [
//                             ItemWidget(
//                               notinStore:widget.notinStore ,
//                               // fromitemview: widget.isStore ? false : true,
//                               isStore: widget.isStore,
//                               item: widget.isStore ? null : widget.items?[index],
//                               isFeatured: widget.isFeatured,
//                               store: widget.isStore ? widget.stores![index] : null,
//                               index: index,
//                               length: length,
//                               isCampaign: widget.isCampaign,
//                               inStore: widget.inStorePage,
//                             ),
//         //                      Divider(
//         //   thickness: .5,  // Adjust the thickness of the divider
//         //   color: Colors.black.withOpacity(0.04),  // Adjust the color of the divider
//         // )

//         // const DottedDivider()
//                           ],
//                         );
//                       }
//                     },
//                   )
//                 : NoDataScreen(
//                     text: widget.noDataText ??
//                         (widget.isStore
//                             ? Get.find<SplashController>().configModel!
//                                     .moduleConfig!.module!.showRestaurantText!
//                                 ? 'no_restaurant_available'.tr
//                                 : 'no_store_available'.tr
//                             : 'no_item_available'.tr),
//                   )
//             : GridView.builder(
//                 key: UniqueKey(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeLarge,
//                   mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
//                   mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore ? 220
//                       : ResponsiveHelper.isMobile(context) ? widget.stores != null ? 300 : 200
//                       : 110,
//                   crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isDesktop(context) ? 3 : 3,
//                 ),
//                 physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
//                 shrinkWrap: widget .isScrollable ? false : true,
//                 itemCount: widget.shimmerLength,
//                 padding: widget.padding,
//                 itemBuilder: (context, index) {
//                   if (widget.isStore) {
//                     return widget.isFoodOrGrocery!
//                         ? 
//                         //  StoreCardShimmer()
//                         Transform.flip(
//                           flipX: true,
//                           child: const ItemShimmer 
//                                               (
                                                
//                                               ),
//                         )
//                         : const NewOnShimmerView();
//                   } else {
//                     return  const ItemShimmer 
//                     (
                      
//                     );
                    
//                   //   ItemShimmer(
//                   //     isEnabled: isNull,
//                   //     isStore: widget.isStore,
//                   //     hasDivider: index != widget.shimmerLength-1);
//                   }
//                 },
//               ),
//       ],
//     );
//   }
// }
















class NewOnShimmerView extends StatelessWidget {
  const NewOnShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.04),
              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
            ),
            child: Column(
              children: [
                // Top shimmer (image placeholder)
                Container(
                  height: 150, // Adjust the height as needed
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
                const SizedBox(height: 5),
                
                // Title shimmer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: 100,
                        color: Colors.black.withOpacity(0.04),
                      ),
                      const SizedBox(height: 5),
                      
                      // Subtitle shimmer
                      Row(
                        children: [
                          const Icon(Icons.location_on_outlined, color: Colors.blue, size: 15),
                          const SizedBox(width: 5),
                          Container(
                            height: 15,
                            width: 150,
                            color: Colors.black.withOpacity(0.04),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                
                // Footer shimmer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 10,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                        ),
                      ),
                      Container(
                        height: 20,
                        width: 65,
                        color: Colors.black.withOpacity(0.04),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
          
          // Positioned logo shimmer
          Positioned(
            top: 60, // Adjust the position as needed
            left: 15,
            child: Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
















class ItemShimmer extends StatelessWidget {
  const ItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Shimmer(
        child: Container(
          height: 200,
          margin: const EdgeInsets.all(0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                spreadRadius: 2,
                blurRadius: 5,
              ),
            ],
          ),
          child: Row(
            children: [
              // Image placeholder
              
              // Content placeholder
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title placeholder
                    const SizedBox(height: 26,),
                    Container(
                      width: 180,
                      height: 20,
                      margin: const EdgeInsets.only(bottom: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
      
                    // Description placeholder
                    Container(
                      width: 50,
                      height: 20,
                      margin: const EdgeInsets.only(bottom: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
      
                    // Price placeholder
                    Container(
                      width: 150,
                      height: 30,
                      margin: const EdgeInsets.only(bottom: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
      
                    Container(
                      width: 80,
                      height: 20,
                      margin: const EdgeInsets.only(bottom: 10,left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.04),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
      
              Container(
                width: 150,
                height: 150,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
      
            ],
          ),
        ),
      ),
    );
  }
}






















class ItemsView2 extends StatefulWidget {
  final List<Item?>? singleitems;
  final List<Item?>? items;
  final List<Store?>? stores;
  final bool isStore;
  final EdgeInsetsGeometry padding;
  final bool isScrollable;
  final int shimmerLength;
  final String? noDataText;
  final bool isCampaign;
  final bool inStorePage;
  final bool isFeatured;
  final bool? isFoodOrGrocery;
  final bool notinStore;
  final bool isfashion;

  const ItemsView2({
    super.key,
    required this.stores,
    required this.items,
    required this.isStore,
    this.isScrollable = false,
    this.shimmerLength = 20,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault),
    this.noDataText,
    this.isCampaign = false,
    this.inStorePage = false,
    this.isFeatured = false,
    this.isFoodOrGrocery = true,
    this.singleitems,
    this.notinStore = false,  required this.isfashion,
  });

  @override
  State<ItemsView2> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView2> {
  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;

    if (widget.isStore) {
      isNull = widget.stores == null;
      if (!isNull) {
        length = widget.stores?.length ?? 0;
      }
    } else {
      isNull = widget.items == null;
      if (!isNull) {
        length = widget.items?.length ?? 0;
      }
    }

    return Column(
      children: [
        !isNull
            ? length > 0
                ?      Container(
                
                
                  child:
                  
                 
        
                  
               ListView.separated(
                      physics: widget.isScrollable
                          ? const BouncingScrollPhysics()
                          : const NeverScrollableScrollPhysics(),
                      shrinkWrap: !widget.isScrollable,
                      itemCount: length,
                      // padding: widget.padding,
                      padding: EdgeInsets.only(), 
                      itemBuilder: (context, index) {
                        if (widget.stores != null && widget.isStore) {
                          return widget.isFoodOrGrocery!
                  
                          
                              ? (index == 3
                                  ? Padding(
                         padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 350,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 236, 234, 234),
                                        // borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          // BoxShadow(
                                          //   color: Colors.black.withOpacity(0.04),
                                          //   spreadRadius: 2,
                                          //   blurRadius: 5,
                                          // ),
                                        ],  
                                      ),
                                      child:  BestStoreNearbyView(
                                        // fromitemlist: true,
                                      )),
                                  ) : index == 7 ?  
                               Padding(
                         padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 370,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 236, 234, 234),
                                        // borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          // BoxShadow(
                                          //   color: Colors.black.withOpacity(0.04),
                                          //   spreadRadius: 2,
                                          //   blurRadius: 5,
                                          // ),
                                        ],  
                                      ),
                                      child: const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false)),
                                  ) :
                              index == 10 ?  
                               Padding(
                         padding: const EdgeInsets.only(bottom: 20),
                                    child: Container(
                                      height: 340,
                                      decoration: BoxDecoration(
                                        color: const Color.fromARGB(255, 236, 234, 234),
                                        // borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          // BoxShadow(
                                          //   color: Colors.black.withOpacity(0.04),
                                          //   spreadRadius: 2,
                                          //   blurRadius: 5,
                                          // ),
                                        ],  
                                      ),
                                      child:   BestStoreNearbyView(
                                        // fromitemlist: true,
                                      )),
                                  ) 
                                  : Padding(
                                    padding: const EdgeInsets.only(left: 10,right:0 ),
                                    child: StoreCardWidget2(
                                        store: widget.stores![index],
                                      ),
                                  ))
                              : StoreCardWithDistance(
                                  store: widget.stores![index]!,
                                  fromAllStore: true,
                                );
                        } else {
                          return Column(
                            children: [
                              ItemWidget(
                                // notinStore: widget.notinStore,
                                isStore: widget.isStore,
                                item: widget.isStore ? null : widget.items?[index],
                                // isFeatured: widget.isFeatured,
                                store:
                                    widget.isStore ? widget.stores![index] : null,
                                index: index,
                                length: length,
                                isCampaign: widget.isCampaign,
                                inStore: widget.inStorePage,
                              ),
                            ],
                          );
                        }
                      }, separatorBuilder: (BuildContext context, int index) { 
                        return Column(
                          children: [
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20,right: 20),
                              child: CustomDivider(),
                            ),
                             SizedBox(height: 20,),
                          ],
                        );
                       },
                    ),
                )
                : NoDataScreen(
                    text: widget.noDataText ??
                        (widget.isStore
                            ? Get.find<SplashController>()
                                    .configModel!
                                    .moduleConfig!
                                    .module!
                                    .showRestaurantText!
                                ? 'no_restaurant_available'.tr
                                : 'no_store_available'.tr
                            : 'no_item_available'.tr),
                  )
            : ListView.builder(
                physics: widget.isScrollable
                    ? const BouncingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                shrinkWrap: !widget.isScrollable,
                itemCount: widget.shimmerLength,
                padding: widget.padding,
                itemBuilder: (context, index) {
                  if (widget.isStore) {
                    return widget.isFoodOrGrocery!
                        ? Transform.flip(
                            flipX: true,
                            child: const ItemShimmer(),
                          )
                        : const NewOnShimmerView();
                  } else {
                    return const ItemShimmer();
                  }
                },
              ),
      ],
    );
  }
}


// class ItemsView2 extends StatefulWidget {
//   final List<Item?>? singleitems;
//   final List<Item?>? items;
//   final List<Store?>? stores;
//   final bool isStore;
//   final EdgeInsetsGeometry padding;
//   final bool isScrollable;
//   final int shimmerLength;
//   final String? noDataText;
//   final bool isCampaign;
//   final bool inStorePage;
//   final bool isFeatured;
//   final bool? isFoodOrGrocery;
//   final bool notinStore;

//   const ItemsView2({
//     super.key,
//     required this.stores,
//     required this.items,
//     required this.isStore,
//     this.isScrollable = false,
//     this.shimmerLength = 20,
//     this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault),
//     this.noDataText,
//     this.isCampaign = false,
//     this.inStorePage = false,
//     this.isFeatured = false,
//     this.isFoodOrGrocery = true,
//     this.singleitems,
//     this.notinStore = false,
//   });

//   @override
//   State<ItemsView2> createState() => _ItemsViewState();
// }

// class _ItemsViewState extends State<ItemsView2> {
//   @override
//   Widget build(BuildContext context) {
//     bool isNull = true;
//     int length = 0;

//     if (widget.isStore) {
//       isNull = widget.stores == null;
//       if (!isNull) {
//         length = widget.stores?.length ?? 0;
//       }
//     } else {
//       isNull = widget.items == null;
//       if (!isNull) {
//         length = widget.items?.length ?? 0;
//       }
//     }

//     return Column(
//       children: [
//         !isNull
//             ? length > 0
//                 ? ListView.builder(
//                     physics: widget.isScrollable
//                         ? const BouncingScrollPhysics()
//                         : const NeverScrollableScrollPhysics(),
//                     shrinkWrap: !widget.isScrollable,
//                     itemCount: length,
//                     padding: widget.padding,
//                     itemBuilder: (context, index) {
//                       // Logic to insert widgets every 4th card
//                       if (index % index == 3) {
//                         // Choose the widget to display at specific positions
//                         if (index == 3 || index == 11) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 20),
//                             child: Container(
//                               height: 330,
//                               decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 236, 234, 234),
//                               ),
//                               child: const BestStoreNearbyView(),
//                             ),
//                           );
//                         } else if (index == 7) {
//                           return Padding(
//                             padding: const EdgeInsets.only(bottom: 20),
//                             child: Container(
//                               height: 340,
//                               decoration: BoxDecoration(
//                                 color: const Color.fromARGB(255, 236, 234, 234),
//                               ),
//                               child: const NewOnMartView(
//                                   isNewStore: true,
//                                   isPharmacy: false,
//                                   isShop: false),
//                             ),
//                           );
//                         }
//                       }

//                       // Default Store Card
//                       return Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 0),
//                         child: StoreCardWidget2(
//                           store: widget.stores![index],
//                         ),
//                       );
//                     },
//                   )
//                 : NoDataScreen(
//                     text: widget.noDataText ??
//                         (widget.isStore
//                             ? Get.find<SplashController>()
//                                     .configModel!
//                                     .moduleConfig!
//                                     .module!
//                                     .showRestaurantText!
//                                 ? 'no_restaurant_available'.tr
//                                 : 'no_store_available'.tr
//                             : 'no_item_available'.tr),
//                   )
//             : ListView.builder(
//                 physics: widget.isScrollable
//                     ? const BouncingScrollPhysics()
//                     : const NeverScrollableScrollPhysics(),
//                 shrinkWrap: !widget.isScrollable,
//                 itemCount: widget.shimmerLength,
//                 padding: widget.padding,
//                 itemBuilder: (context, index) {
//                   if (widget.isStore) {
//                     return widget.isFoodOrGrocery!
//                         ? Transform.flip(
//                             flipX: true,
//                             child: const ItemShimmer(),
//                           )
//                         : const NewOnShimmerView();
//                   } else {
//                     return const ItemShimmer();
//                   }
//                 },
//               ),
//       ],
//     );
//   }
// }











// class ItemsView2 extends StatefulWidget {
//   final List<Item?>? singleitems;
//   final List<Item?>? items;
//   final List<Store?>? stores;
//   final bool isStore;
//   final EdgeInsetsGeometry padding;
//   final bool isScrollable;
//   final int shimmerLength;
//   final String? noDataText;
//   final bool isCampaign;
//   final bool inStorePage;
//   final bool isFeatured;
//   final bool? isFoodOrGrocery;
//   final bool notinStore;

//   const ItemsView2({
//     super.key,
//     required this.stores,
//     required this.items,
//     required this.isStore,
//     this.isScrollable = false,
//     this.shimmerLength = 20,
//     this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault),
//     this.noDataText,
//     this.isCampaign = false,
//     this.inStorePage = false,
//     this.isFeatured = false,
//     this.isFoodOrGrocery = true,
//     this.singleitems,
//     this.notinStore = false,
//   });

//   @override
//   State<ItemsView2> createState() => _ItemsViewState();
// }

// class _ItemsViewState extends State<ItemsView2> {
//   @override
//   Widget build(BuildContext context) {
//     bool isNull = true;
//     int length = 0;

//     if (widget.isStore) {
//       isNull = widget.stores == null;
//       if (!isNull) {
//         length = widget.stores?.length ?? 0;
//       }
//     } else {
//       isNull = widget.items == null;
//       if (!isNull) {
//         length = widget.items?.length ?? 0;
//       }
//     }

//     // Build the list of widgets using a for loop
//     List<Widget> widgetList = [];
//     if (!isNull && length > 0) {
//       for (int index = 0; index < length; index++) {
//         // Insert special widgets every 4 cards (index 3, 7, 11, ...)
//         if (index % 6 == 3) {
//           widgetList.add(
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Container(
//                 height: 330,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 236, 234, 234),
//                 ),
//                 child: const BestStoreNearbyView(),
//               ),
//             ),
//           );
//         } else if (index % 6 == 7) {
//           widgetList.add(
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Container(
//                 height: 340,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 236, 234, 234),
//                 ),
//                 child: const NewOnMartView(
//                     isNewStore: true, isPharmacy: false, isShop: false),
//               ),
//             ),
//           );
//         } else if (index % 6 == 11) {
//           widgetList.add(
//             Padding(
//               padding: const EdgeInsets.only(bottom: 20),
//               child: Container(
//                 height: 330,
//                 decoration: BoxDecoration(
//                   color: const Color.fromARGB(255, 236, 234, 234),
//                 ),
//                 child: const BestStoreNearbyView(),
//               ),
//             ),
//           );
//         }

//         // Add the default store card
//         widgetList.add(
//           Padding(
//             padding: const EdgeInsets.only(left: 10, right: 0),
//             child: StoreCardWidget2(
//               store: widget.stores![index],
//             ),
//           ),
//         );
//       }
//     }

//     return Column(
//       children: [
//         !isNull
//             ? widgetList.isNotEmpty
//                 ? ListView(
//                     physics: widget.isScrollable
//                         ? const BouncingScrollPhysics()
//                         : const NeverScrollableScrollPhysics(),
//                     shrinkWrap: !widget.isScrollable,
//                     children: widgetList,
//                   )
//                 : NoDataScreen(
//                     text: widget.noDataText ??
//                         (widget.isStore
//                             ? Get.find<SplashController>()
//                                     .configModel!
//                                     .moduleConfig!
//                                     .module!
//                                     .showRestaurantText!
//                                 ? 'no_restaurant_available'.tr
//                                 : 'no_store_available'.tr
//                             : 'no_item_available'.tr),
//                   )
//             : ListView.builder(
//                 physics: widget.isScrollable
//                     ? const BouncingScrollPhysics()
//                     : const NeverScrollableScrollPhysics(),
//                 shrinkWrap: !widget.isScrollable,
//                 itemCount: widget.shimmerLength,
//                 padding: widget.padding,
//                 itemBuilder: (context, index) {
//                   if (widget.isStore) {
//                     return widget.isFoodOrGrocery!
//                         ? Transform.flip(
//                             flipX: true,
//                             child: const ItemShimmer(),
//                           )
//                         : const NewOnShimmerView();
//                   } else {
//                     return const ItemShimmer();
//                   }
//                 },
//               ),
//       ],
//     );
//   }
// }


