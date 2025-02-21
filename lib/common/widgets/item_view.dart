import 'package:sixam_mart/common/widgets/card_design/store_card_with_distance.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/store_card_widget.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/common/widgets/item_shimmer.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemsView extends StatefulWidget {
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
    final bool isHome;
  final bool? isFoodOrGrocery;
  const ItemsView({super.key, required this.stores, required this.items, required this.isStore, this.isScrollable = false,
    this.shimmerLength = 20, this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault), this.noDataText,
    this.isCampaign = false, this.inStorePage = false, this.isFeatured = false,
    this.isFoodOrGrocery = true,  this.isHome = false});

  @override
  State<ItemsView> createState() => _ItemsViewState();
}

class _ItemsViewState extends State<ItemsView> {
  @override
  Widget build(BuildContext context) {
    bool isNull = true;
    int length = 0;
    if(widget.isStore) {
      isNull = widget.stores == null;
      if(!isNull) {
        length = widget.stores!.length;
      }
    }else {
      isNull = widget.items == null;
      if(!isNull) {
        length = widget.items!.length;
      }
    }



  //    bool isOpen = false;

  // void toggleContainer() {
  //   setState(() {
  //     isOpen = !isOpen; 
  //   });
  // }

    return Column(
      
      children: [
  widget.isHome ?
  
  //  ListView.builder(
  //     itemCount: widget.stores!.length,  
  //     // shrinkWrap: true,
  //      physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
  //       shrinkWrap: widget.isScrollable ? false : true,
  //   itemBuilder: 
  //   (context, index) {

  //      if (index == 3) {
  //        return   VisitAgainView(fromFood: true);
  //       //  StoreCardWidget2(store: widget.stores![index]);
  //      } else if (index == 7) {
  //        return  
  //            const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false);
  //       //  StoreCardWidget2(store: widget.stores![index]);
  //      } 
       
  //       else {
  //        return StoreCardWidget2(store: widget.stores![index]);
  //      }
  //     // return StoreCardWidget2(store:  widget.stores![index]);
  //   },
  //  ) : 
     
     ListView.builder(
  itemCount: widget.stores != null ? widget.stores!.length : 10, 
  physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
  shrinkWrap: widget.isScrollable ? false : true,
  itemBuilder: (context, index) {

    if (widget.stores == null) {
      return const StoreCardShimmer2();
    }

  
    if (index -3 % 7 == 1) { 
      return VisitAgainView(fromFood: true,itemsview: true,);
    } else if (index -3 % 7 == 5) { 
      return const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false,itemsview: true,);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: 180,
          child: StoreCardWidget2(store: widget.stores![index])),
        ),
      );
    }
  },
)  :


      !isNull ? length > 0 ? 
       widget.inStorePage ? 
       Column(
         children: [
          GetBuilder<StoreController>(builder: (storeController) {
             ;
               return storeController.recommendedItemModel!.items!.isEmpty ?  SizedBox() : Padding(
                 padding: const EdgeInsets.all(8.0),
                 child: SizedBox(
                 
                  child:
                   Container(
                    decoration: BoxDecoration(
                      color:  Color(0xFFECF3F9),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)
                      )
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap:  (){
                            // print("Trying to toggle");
                       storeController.togglerecommendedContainer();
                            // logic for close  recommended container
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            color: Colors.transparent,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20,top: 10),
                                  child: Text("Recommended", style: TextStyle(
                                    fontSize: 16,fontWeight: FontWeight.w700
                                  )),
                                ),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(!storeController.isopen ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_down, color: Theme.of(context).primaryColor,size: 30,weight: 35,),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: 10,),
                    if (storeController.isopen)
                      ListView.builder(
                          padding: EdgeInsets.all(0),
                          // separatorBuilder: (context, index) => const Divider(),
                          physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: storeController.recommendedItemModel!.items!.length ?? 1,
                          itemBuilder: (context, index) {
                          
                          return 
                          //  Container(
                          //   color: Theme.of(context).primaryColor,
                          //   child: Text("Recommended $index",)
                          // );
                          Padding(
                            padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                            child: ItemWidget(item:storeController.recommendedItemModel!.items![index] , isStore: false, store: null, index: index, length: length,Recomended: true,),
                          );
                        }),
                 
                        // SizedBox(height: 10,)
                      ],
                    ),
                 
                    
                  ),
                    
                    
                           ),
               );
             }
           ),
          
           GridView.builder(
            key: UniqueKey(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(

              crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeLarge,
              mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null && widget.isStore ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
              // childAspectRatio: ResponsiveHelper.isDesktop(context) && widget.isStore ? (1/0.6)
              //     : ResponsiveHelper.isMobile(context) ? widget.stores != null && widget.isStore ? 2 : 3.8
              //     : 3.3,
              mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore ? 220
                  : ResponsiveHelper.isMobile(context) ? widget.stores != null && widget.isStore ? 170 : 206
                  : 122,
              crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isDesktop(context) && widget.stores != null  ? 3 : 3,
            ),
            physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
            shrinkWrap: widget.isScrollable ? false : true,
            itemCount: length,
            padding: widget.padding,
            itemBuilder: (context, index) {
             
             //         bool  itemAvailable = DateConverter.isAvailable(widget.items![index]!.availableTimeStarts, widget.items![index]!.availableTimeEnds);
             // final List<Item?>? filterditems = widget.items!.where((element) => element!.storeId == widget.stores![index]!.id).toList();
             
                List<Item?> availableItems = [];
           List<Item?> notAvailableItems = [];
           if (widget.items != null ) {
            
             for (var item in widget.items!) {
               if (item != null) { 
                 bool isAvailable = DateConverter.isAvailable(item.availableTimeStarts, item.availableTimeEnds);
                 if (isAvailable) {
            availableItems.add(item);
                 } else {
            notAvailableItems.add(item);
                 }
               }
             }
           }
           
           
           final List<Item?> sortedFilteredItems = [...availableItems, ...notAvailableItems];
           
           
             // if (index  == 0) {
             // print("showing recommended items");
             //  return  GetBuilder<StoreController>(builder: (storeController) {
           
           
             //      return  ItemWidget(
             //           isStore: widget.isStore, item: storeController.recommendedItemModel?.items?[index], isFeatured: widget.isFeatured,
             //           store: widget.isStore ? widget.stores![index] : null, index: index, length: length, isCampaign: widget.isCampaign,
             //           inStore: widget.inStorePage,
             //         );
                 
                                            
             //    }
             //  );
             // }
              return widget.stores != null && widget.isStore ?  widget.isFoodOrGrocery! && widget.isStore
                  ?
                  
                  StoreCardWidget2(store: widget.stores![index])
                  : StoreCardWithDistance(store: widget.stores![index]!, fromAllStore: true)
                  :
                  
                   
                   Column(
                     children: [
                       ItemWidget(
                                       isStore: widget.isStore, item: widget.isStore ? null :sortedFilteredItems[index], isFeatured: widget.isFeatured,
                                       store: widget.isStore ? widget.stores![index] : null, index: index, length: length, isCampaign: widget.isCampaign,
                                       inStore: widget.inStorePage,
                                     ),

                                     Divider()
                     ],
                   );
            },
                 ),
         ],
       ) :
   
   
   
      GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null && widget.isStore ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
          // childAspectRatio: ResponsiveHelper.isDesktop(context) && widget.isStore ? (1/0.6)
          //     : ResponsiveHelper.isMobile(context) ? widget.stores != null && widget.isStore ? 2 : 3.8
          //     : 3.3,
          mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore ? 220
              : ResponsiveHelper.isMobile(context) ? widget.stores != null && widget.isStore ? 170 : 190
              : 122,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isDesktop(context) && widget.stores != null  ? 3 : 3,
        ),
        physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: widget.isScrollable ? false : true,
        itemCount: length,
        padding: widget.padding,
        itemBuilder: (context, index) {
         
  //         bool  itemAvailable = DateConverter.isAvailable(widget.items![index]!.availableTimeStarts, widget.items![index]!.availableTimeEnds);
  // final List<Item?>? filterditems = widget.items!.where((element) => element!.storeId == widget.stores![index]!.id).toList();
         
     List<Item?> availableItems = [];
List<Item?> notAvailableItems = [];
if (widget.items != null ) {
 
  for (var item in widget.items!) {
    if (item != null) { 
      bool isAvailable = DateConverter.isAvailable(item.availableTimeStarts, item.availableTimeEnds);
      if (isAvailable) {
        availableItems.add(item);
      } else {
        notAvailableItems.add(item);
      }
    }
  }
}


final List<Item?> sortedFilteredItems = [...availableItems, ...notAvailableItems];


  // if (index  == 0) {
  // print("showing recommended items");
  //  return  GetBuilder<StoreController>(builder: (storeController) {
  //      return  Container(
  //       color: Theme.of(context).primaryColor,
  //      );
      
                                        
  //    }
  //  );
  // }
          return widget.stores != null && widget.isStore ?  widget.isFoodOrGrocery! && widget.isStore
              ?
              
              StoreCardWidget2(store: widget.stores![index])
              : StoreCardWithDistance(store: widget.stores![index]!, fromAllStore: true)
              :
              
               
               ItemWidget(
            isStore: widget.isStore, item: widget.isStore ? null :sortedFilteredItems[index], isFeatured: widget.isFeatured,
            store: widget.isStore ? widget.stores![index] : null, index: index, length: length, isCampaign: widget.isCampaign,
            inStore: widget.inStorePage,
          );
        },
      ) : NoDataScreen(
        text: widget.noDataText ?? (widget.isStore ? Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
            ? 'no_restaurant_available'.tr : 'no_store_available'.tr : 'no_item_available'.tr),
      ) : GridView.builder(
        key: UniqueKey(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeLarge,
          mainAxisSpacing: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeLarge : widget.stores != null ? Dimensions.paddingSizeLarge : Dimensions.paddingSizeSmall,
          // childAspectRatio: ResponsiveHelper.isDesktop(context) && widget.isStore ? (1/0.6)
          //     : ResponsiveHelper.isMobile(context) ? widget.isStore ? 2 : 3.8
          //     : 3,
          mainAxisExtent: ResponsiveHelper.isDesktop(context) && widget.isStore ? 220
              : ResponsiveHelper.isMobile(context) ? widget.isStore ? 200 : 200
              : 110,
          crossAxisCount: ResponsiveHelper.isMobile(context) ? 1 : ResponsiveHelper.isDesktop(context) ? 3 : 3,
        ),
        physics: widget.isScrollable ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
        shrinkWrap: widget.isScrollable ? false : true,
        itemCount: widget.shimmerLength,
        padding: widget.padding,
        itemBuilder: (context, index) {
          return widget.isStore ? widget.isFoodOrGrocery!
              ? const StoreCardShimmer2()
              : const NewOnShimmerView()
              : ItemShimmer(isEnabled: isNull, isStore: widget.isStore, hasDivider: index != widget.shimmerLength-1);
        },
      ),

    ]);
  }
}

class NewOnShimmerView extends StatelessWidget {
  const NewOnShimmerView({super.key, });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.zero,
      child: Stack(children: [
        Container(
          // width: fromAllStore ?  MediaQuery.of(context).size.width : 260,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          ),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault), topRight: Radius.circular(Dimensions.radiusDefault)),
                child: Stack(clipBehavior: Clip.none, children: [
                  Container(
                    height: double.infinity, width: double.infinity,
                    color: Theme.of(context).primaryColor  ,
                  ),

                  Positioned(
                    top: 15, right: 15,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Theme.of(context).cardColor   ,
                      ),
                      child: Icon(Icons.favorite_border, color: Theme.of(context).primaryColor, size: 20),
                    ),
                  ),
                ]),
              ),
            ),

            Expanded(
              flex: 1,
              child: Column(children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 95),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Expanded(
                        child: Container(
                          height: 5, width: 100,
                          color: Theme.of(context).cardColor,
                        ),
                      ),
                      const SizedBox(height: 2),

                      Row(children: [
                        const Icon(Icons.location_on_outlined, color: Colors.blue, size: 15),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                        Expanded(
                          child: Container(
                            height: 10, width: 100,
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                      ]),
                    ]),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      Container(
                        height: 10, width: 70,
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor  ,
                          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                        ),
                      ),

                      Container(
                        height: 20, width: 65,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                        ),
                      ),
                    ]),
                  ),
                ),
              ]),
            ),
          ]),
        ),

        Positioned(
          top: 60, left: 15,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 65, width: 65,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}














  //  (storeController.categoryList!.isNotEmpty)  &&  (!ResponsiveHelper.isDesktop(context) &&
  //                               storeController.recommendedItemModel != null &&
  //                               storeController.recommendedItemModel!.items!.isNotEmpty)
    
  //                       ? SliverPersistentHeader(
  //                         floating: false,
  //                           // pinned: true,
  //                           delegate: SliverDelegate(
  //                               height: 240,
  //                               child: Center(
  //                                   child: Container(
  //                                 width: Dimensions.webMaxWidth,
  //                                 decoration: BoxDecoration(
  //                                   color: Theme.of(context).cardColor,
  //                                   // boxShadow: const [
  //                                   //   BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
  //                                   // ],
  //                                 ),
  //                                 padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
  //                                 child: Column(
  //                                   children: [
    
  //                                     //  const SizedBox(height: Dimensions.paddingSizeLarge),
  //                       (!ResponsiveHelper.isDesktop(context) &&
  //                               storeController.recommendedItemModel != null &&
  //                               storeController.recommendedItemModel!.items!.isNotEmpty)
  //                           ? Padding(
  //                             padding: const EdgeInsets.only(left: 10),
  //                             child: Column(
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   Padding(
  //                                      padding: const EdgeInsets.only(left: 10),
  //                                     child: Text('recommended'.tr, style: TextStyle(
  //                                       fontSize: 16,fontWeight: FontWeight.w700
  //                                     )),
  //                                   ),
  //                                   const SizedBox(height: Dimensions.paddingSizeExtraSmall),
  //                                   SizedBox(
  //                                     height: ResponsiveHelper.isDesktop(context) ? 150 : 185,
  //                                     child: ListView.builder(
  //                                       scrollDirection: Axis.horizontal,
  //                                       itemCount: storeController.recommendedItemModel!.items!.length,
  //                                       physics: const BouncingScrollPhysics(),
  //                                       itemBuilder: (context, index) {
  //                                         return Padding(
  //                                           padding: ResponsiveHelper.isDesktop(context)
  //                                               ? const EdgeInsets.symmetric(vertical: 20)
  //                                               : const EdgeInsets.symmetric(vertical: 10),
  //                                           child: Container(
  //                                             width: ResponsiveHelper.isDesktop(context) ? 500 : 300,
  //                                             padding: const EdgeInsets.only(
  //                                                 right: Dimensions.paddingSizeSmall,
  //                                                 left: Dimensions.paddingSizeExtraSmall),
  //                                             margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
  //                                             child: ItemWidget(
  //                                               // notinStore: true,
  //                                               // Recomended: true,
  //                                               isStore: false,
  //                                               item: storeController.recommendedItemModel!.items![index],
  //                                               store: null,
  //                                               index: index,
  //                                               length: storeController.recommendedItemModel!.items!.length,
  //                                               isCampaign: false,
  //                                               inStore: true,
  //                                             ),
  //                                           ),
  //                                         );
  //                                       },
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                           )
  //                           : const SizedBox(),
                                  
  //                                   ],
  //                                 ),
  //                               ))),
  //                         )
  //                       : const SliverToBoxAdapter(child: SizedBox()),