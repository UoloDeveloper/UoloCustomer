import 'package:sixam_mart/features/search/controllers/search_controller.dart' as search;
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/features/search/widgets/filter_widget.dart';
import 'package:sixam_mart/features/search/widgets/item_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class SearchResultWidget extends StatefulWidget {
//   final String searchText;
//   final TabController? tabController;
//   const SearchResultWidget({super.key, required this.searchText, this.tabController});

//   @override
//   SearchResultWidgetState createState() => SearchResultWidgetState();
// }

// class SearchResultWidgetState extends State<SearchResultWidget> with TickerProviderStateMixin {
//   TabController? _tabController;

//   @override
//   void initState() {
//     super.initState();
//     // Get.find<search.SearchController>().
//     if(widget.tabController != null){
//       _tabController = widget.tabController;
//     } else {
//       _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

//       GetBuilder<search.SearchController>(builder: (searchController) {
//         bool isNull = true;
//         int length = 0;
//         if(searchController.isStore) {
//           isNull = searchController.searchStoreList == null;
//           if(!isNull) {
//             length = searchController.searchStoreList!.length;
//           }
//         }else {
//           isNull = searchController.searchItemList == null;
//           if(!isNull) {
//             length = searchController.searchItemList!.length;
//           }
//         }
//         return isNull ? const SizedBox() : Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Padding(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//           child: Row(children: [
//             // Text(
//             //   length.toString(),
//             //   style: robotoBold.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
//             // ),
//             // const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//             // Expanded(child: Text(
//             //   'results_found'.tr,
//             //   style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
//             // )),
//             // ( ResponsiveHelper.isMobile(context)  && widget.searchText.isNotEmpty) ? InkWell(
//             //   onTap: () {
//             //     List<double?> prices = [];
//             //     if(!Get.find<search.SearchController>().isStore) {
//             //       for (var product in Get.find<search.SearchController>().allItemList!) {
//             //         prices.add(product.price);
//             //       }
//             //       prices.sort();
//             //     }
//             //     double? maxValue = prices.isNotEmpty ? prices[prices.length-1] : 1000;
//             //     Get.dialog(FilterWidget(maxValue: maxValue, isStore: Get.find<search.SearchController>().isStore));
//             //   },
//             //   child: const Icon(Icons.filter_list),
//             // ) : const SizedBox(),
//           ]),
//         )));
//       }),

//       ResponsiveHelper.isDesktop(context) ? const SizedBox() :
//       Container(
//         // width: Dimensions.webMaxWidth,
//         color: Theme.of(context).cardColor,
//         child: TabBar(
      
//           controller: _tabController,
//           indicatorColor: Theme.of(context).primaryColor,
//           indicatorWeight: 3,
//           labelColor: Theme.of(context).primaryColor,
//           unselectedLabelColor: Theme.of(context).disabledColor,
//           unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
//           labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall + 3, color: Theme.of(context).primaryColor),
//       tabAlignment:  TabAlignment.start,
//           isScrollable: true,
//           tabs: [
       
//             Tab(text: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
//                 ? 'restaurants'.tr : 'stores'.tr),
//                      Tab(text: 'item'.tr),
//           ],
//         ),
//       ),

//       Expanded(child: NotificationListener(
//         onNotification: (dynamic scrollNotification) {
//           if (scrollNotification is ScrollEndNotification) {
//             Get.find<search.SearchController>().setStore(_tabController!.index == 1);
//             Get.find<search.SearchController>().searchData(widget.searchText, false);
//           }
//           return false;
//         },
//         child: TabBarView(
//           controller: _tabController,
//           children: const [
//             ItemViewWidget(isItem: true),
//             ItemViewWidget(isItem: false),
    
//           ],
//         ),
//       )),

//     ]);
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResultWidget extends StatefulWidget {
  final String searchText;
  final TabController? tabController;
  const SearchResultWidget({super.key, required this.searchText, this.tabController});

  @override
  SearchResultWidgetState createState() => SearchResultWidgetState();
}

class SearchResultWidgetState extends State<SearchResultWidget> with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    // Use provided tabController for desktop, otherwise create a new one
    _tabController = widget.tabController ??
        TabController(length: 2, initialIndex: 0, vsync: this);
  }

  @override
  void dispose() {
    // Dispose only if we created the tabController
    if (widget.tabController == null) {
      _tabController?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<search.SearchController>(builder: (searchController) {
      // Determine data availability and length
      final isStore = searchController.isStore;
      final dataList = isStore ? searchController.searchStoreList : searchController.searchItemList;
      final isNull = dataList == null;
      final length = isNull ? 0 : dataList.length;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Results Header
          // if (!isNull)
          //   Center(
          //     child: SizedBox(
          //       width: Dimensions.webMaxWidth,
          //       child: Padding(
          //         padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //           children: [
          //             Expanded(
          //               child: Text(
          //                 '$length ${'results_found'.tr}',
          //                 style: robotoRegular.copyWith(
          //                   color: Theme.of(context).disabledColor,
          //                   fontSize: Dimensions.fontSizeSmall,
          //                 ),
          //               ),
          //             ),
          //             if (ResponsiveHelper.isMobile(context) && widget.searchText.isNotEmpty)
          //               InkWell(
          //                 onTap: () => _showFilterDialog(searchController),
          //                 child: const Icon(Icons.filter_list),
          //               ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ),

          // TabBar for Mobile
          if (!ResponsiveHelper.isDesktop(context))
            Container(
              color: Theme.of(context).cardColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                indicatorWeight: 3,
                labelColor: Theme.of(context).primaryColor,
                unselectedLabelColor: Theme.of(context).disabledColor,
                unselectedLabelStyle: robotoRegular.copyWith(
                  color: Theme.of(context).disabledColor,
                  fontSize: Dimensions.fontSizeSmall,
                ),
                labelStyle: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeSmall + 3,
                  color: Theme.of(context).primaryColor,
                ),
                tabAlignment: TabAlignment.start,
                isScrollable: true,
                tabs: [
                  Tab(
                    text: Get.find<SplashController>()
                            .configModel!
                            .moduleConfig!
                            .module!
                            .showRestaurantText!
                        ? 'restaurants'.tr
                        : 'stores'.tr,
                  ),
                  Tab(text: 'item'.tr),
                ],
              ),
            ),

          // TabBarView
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  // Update store/item mode based on tab index
                  final isStoreTab = _tabController!.index == 0;
                  if (searchController.isStore != isStoreTab) {
                    searchController.setStore(isStoreTab);
                    searchController.searchData(widget.searchText, false);
                  }
                }
                return false;
              },
              child: TabBarView(
                controller: _tabController,
                children: [
                  ItemViewWidget(isItem: true),
                  ItemViewWidget(isItem: false),
             
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  void _showFilterDialog(search.SearchController searchController) {
    List<double?> prices = [];
    if (!searchController.isStore && searchController.allItemList != null) {
      for (var product in searchController.allItemList!) {
        prices.add(product.price);
      }
      prices.sort();
    }
    double? maxValue = prices.isNotEmpty ? prices[prices.length - 1] : 1000;
    Get.dialog(FilterWidget(maxValue: maxValue, isStore: searchController.isStore));
  }
}
