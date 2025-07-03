import 'package:flutter/rendering.dart';
import 'package:lottie/lottie.dart';
import 'package:sixam_mart/common/widgets/endscreendialog_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/category/domain/models/category_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/widgets/CoupenCarousal.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/veg_filter_widget.dart';
import 'package:sixam_mart/common/widgets/web_item_view.dart';
import 'package:sixam_mart/common/widgets/web_item_widget.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/search/widgets/custom_check_box_widget.dart';
import 'package:sixam_mart/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_banner_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_description_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/store/widgets/store_details_screen_shimmer_widget.dart';

import '../widgets/bottom_cart_widget.dart';
import 'dart:developer';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/ecommerse_card.dart';
import 'package:sixam_mart/common/widgets/item_shimmer.dart';
import 'package:sixam_mart/common/widgets/item_view%20copy.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/category/domain/models/category_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/veg_filter_widget.dart';
import 'package:sixam_mart/common/widgets/web_item_view.dart';
import 'package:sixam_mart/common/widgets/web_item_widget.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/checkout/screens/checkout_screen.dart';
import 'package:sixam_mart/features/search/widgets/custom_check_box_widget.dart';
import 'package:sixam_mart/features/store/widgets/customizable_space_bar_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_banner_widget.dart';
import 'package:sixam_mart/features/store/widgets/store_description_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/store/widgets/store_details_screen_shimmer_widget.dart';

import '../widgets/bottom_cart_widget.dart';

// class StoreScreen extends StatefulWidget {
//   final Store? store;
//   final bool fromModule;
//   final String slug;
//   const StoreScreen({super.key, required this.store, required this.fromModule, this.slug = ''});

//   @override
//   State<StoreScreen> createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   final ScrollController scrollController = ScrollController();
//   final TextEditingController _searchController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     initDataCall();
//   }

//   @override
//   void dispose() {
//     super.dispose();

//     scrollController.dispose();
//   }

//   Future<void> initDataCall() async {
//     if(Get.find<StoreController>().isSearching) {
//       Get.find<StoreController>().changeSearchStatus(isUpdate: false);
//     }
//     Get.find<StoreController>().hideAnimation();
//     await Get.find<StoreController>().getStoreDetails(Store(id: widget.store!.id), widget.fromModule, slug: widget.slug).then((value) {
//       Get.find<StoreController>().showButtonAnimation();
//     });
//     if(Get.find<CategoryController>().categoryList == null) {
//       Get.find<CategoryController>().getCategoryList(true);
//     }
//     Get.find<StoreController>().getStoreBannerList(widget.store!.id ?? Get.find<StoreController>().store!.id);
//     Get.find<StoreController>().getRestaurantRecommendedItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, false);
//     Get.find<StoreController>().getStoreItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, 1, 'all', false);

//     scrollController.addListener(() {
//       if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
//         if(Get.find<StoreController>().showFavButton){
//           Get.find<StoreController>().changeFavVisibility();
//           Get.find<StoreController>().hideAnimation();
//         }
//       }else{
//         if(!Get.find<StoreController>().showFavButton){
//           Get.find<StoreController>().changeFavVisibility();
//           Get.find<StoreController>().showButtonAnimation();
//         }
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
//       endDrawer: const MenuDrawer(),endDrawerEnableOpenDragGesture: false,
//       backgroundColor: Theme.of(context).colorScheme.surface,
//       body: GetBuilder<StoreController>(builder: (storeController) {
//         return GetBuilder<CategoryController>(builder: (categoryController) {
//           Store? store;
//           if(storeController.store != null && storeController.store!.name != null && categoryController.categoryList != null) {
//             store = storeController.store;
//             storeController.setCategoryList();
//             log(store.toString());
//           }

//           return (storeController.store != null && storeController.store!.name != null && categoryController.categoryList != null) ? CustomScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             controller: scrollController,
//             slivers: [

//               ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
//                 child: Container(
//                   color: const Color(0xFF171A29),
//                   padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//                   alignment: Alignment.center,
//                   child: Center(child: SizedBox(width: Dimensions.webMaxWidth, child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                     child: Row(children: [
//                       Expanded(
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                           child: Stack(
//                             children: [
//                               CustomImage(
//                                 fit: BoxFit.cover, height: 240, width: 590,
//                                 image: store?.coverPhotoFullUrl ?? '',
//                               ),

//                               store?.discount != null ? Positioned(
//                                 bottom: 0, left: 0, right: 0,
//                                 child: Container(
//                                   width: double.infinity,
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                   padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                                   child: Text('${store?.discount!.discountType == 'percent' ? '${store?.discount!.discount}% ${'off'.tr}'
//                                       : '${PriceConverter.convertPrice(store?.discount!.discount,currency: store?.currency!.currencyCode)} ${'off'.tr}'} '
//                                       '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(store?.discount!.minPurchase,currency: store?.currency?.currencyCode )},'
//                                       ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(store!.discount!.startTime!)} '
//                                       '- ${DateConverter.convertTimeToTime(store.discount!.endTime!)}',
//                                     style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
//                                       color: Colors.black,
//                                     ),
//                                     textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
//                                   ),
//                                 ),
//                               ) : const SizedBox(),

//                             ],
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: Dimensions.paddingSizeLarge),

//                       Expanded(child: StoreDescriptionViewWidget(store: store)),

//                     ]),
//                   ))),
//                 ),
//               ) : SliverAppBar(
//                 expandedHeight: 300, toolbarHeight: 100,
//                 pinned: true, floating: false, elevation: 0.5,
//                 backgroundColor: Theme.of(context).cardColor,
//                 leading: IconButton(
//                   icon: Container(
//                     height: 50, width: 50,
//                     decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).primaryColor),
//                     alignment: Alignment.center,
//                     child: Icon(Icons.chevron_left, color: Theme.of(context).cardColor),
//                   ),
//                   onPressed: () => Get.back(),
//                 ),
//                 flexibleSpace: FlexibleSpaceBar(
//                   titlePadding: EdgeInsets.zero,
//                   centerTitle: true,
//                   expandedTitleScale: 1.1,
//                   title: CustomizableSpaceBarWidget(
//                     builder: (context, scrollingRate) {
//                       return Container(
//                         height: store!.discount != null ? 145 : 100,
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).cardColor,
//                           borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
//                         ),
//                         child: Column(
//                           children: [
//                             store.discount != null ? Container(
//                               width: double.infinity,
//                               decoration: BoxDecoration(
//                                 color: Theme.of(context).primaryColor.withOpacity(1 - scrollingRate),
//                                 borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
//                               ),
//                               padding: EdgeInsets.all(Dimensions.paddingSizeExtraSmall - (GetPlatform.isAndroid ? (scrollingRate * Dimensions.paddingSizeExtraSmall) : 0)),
//                               child: Text('${store.discount!.discountType == 'percent' ? '${store.discount!.discount}% ${'off'.tr}'
//                                   : '${PriceConverter.convertPrice(store.discount!.discount,currency: store?.currency?.currencyCode)} ${'off'.tr}'} '
//                                   '${'on_all_products'.tr}, ${'after_minimum_purchase'.tr} ${PriceConverter.convertPrice(store.discount!.minPurchase,currency: store?.currency?.currencyCode)},'
//                                   ' ${'daily_time'.tr}: ${DateConverter.convertTimeToTime(store.discount!.startTime!)} '
//                                   '- ${DateConverter.convertTimeToTime(store.discount!.endTime!)}',
//                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
//                                   color: Colors.black.withOpacity(1 - scrollingRate),
//                                 ),
//                                 textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
//                               ),
//                             ) : const SizedBox(),

//                             Container(
//                               color: Theme.of(context).cardColor.withOpacity(scrollingRate),
//                               padding: EdgeInsets.only(
//                                 bottom: 0,
//                                 left: Get.find<LocalizationController>().isLtr ? 40 * scrollingRate : 0,
//                                 right: Get.find<LocalizationController>().isLtr ? 0 : 40 * scrollingRate,
//                               ),
//                               child: Align(
//                                 alignment: Alignment.bottomLeft,
//                                 child: Container(
//                                   height: 100, color: Theme.of(context).cardColor.withOpacity(scrollingRate == 0.0 ? 1 : 0),
//                                   padding: EdgeInsets.only(
//                                     left: Get.find<LocalizationController>().isLtr ? 20 : 0,
//                                     right: Get.find<LocalizationController>().isLtr ? 0 : 20,
//                                   ),
//                                   child: Row(children: [
//                                     ClipRRect(
//                                       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                                       child: Stack(children: [
//                                         CustomImage(
//                                           image: '${store.logoFullUrl}',
//                                           height: 60 - (scrollingRate * 15), width: 70 - (scrollingRate * 15), fit: BoxFit.cover,
//                                         ),

//                                         storeController.isStoreOpenNow(store.active!, store.schedules) ? const SizedBox() : Positioned(
//                                           bottom: 0, left: 0, right: 0,
//                                           child: Container(
//                                             height: 30,
//                                             alignment: Alignment.center,
//                                             decoration: BoxDecoration(
//                                               borderRadius: const BorderRadius.vertical(bottom: Radius.circular(Dimensions.radiusSmall)),
//                                               color: Colors.black.withOpacity(0.6),
//                                             ),
//                                             child: Text(
//                                               'closed_now'.tr, textAlign: TextAlign.center,
//                                               style: robotoRegular.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeSmall),
//                                             ),
//                                           ),
//                                         ),
//                                       ]),
//                                     ),
//                                     const SizedBox(width: Dimensions.paddingSizeSmall),

//                                     Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start,mainAxisAlignment: MainAxisAlignment.center, children: [
//                                       Row(children: [
//                                         Expanded(child: Text(
//                                           store.name!, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge - (scrollingRate * 3), color: Theme.of(context).textTheme.bodyMedium!.color),
//                                           maxLines: 1, overflow: TextOverflow.ellipsis,
//                                         )),
//                                         const SizedBox(width: Dimensions.paddingSizeSmall),

//                                       ]),
//                                       const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                                       Text(
//                                         store.address ?? '', maxLines: 1, overflow: TextOverflow.ellipsis,
//                                         style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall - (scrollingRate * 2), color: Theme.of(context).disabledColor),
//                                       ),
//                                       SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : 0),
//                                       Row(children: [
//                                         Flexible(
//                                           child: Text('minimum_order'.tr, style: robotoRegular.copyWith(
//                                             fontSize: Dimensions.fontSizeExtraSmall - (scrollingRate * 2), color: Theme.of(context).disabledColor,
//                                           ), maxLines: 1, overflow: TextOverflow.ellipsis),
//                                         ),
//                                         const SizedBox(width: Dimensions.paddingSizeExtraSmall),
//                                         Text(
//                                           PriceConverter.convertPrice(store.minimumOrder,currency: store.currency?.currencyCode), textDirection: TextDirection.ltr,
//                                           style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraSmall - (scrollingRate * 2), color: Theme.of(context).primaryColor),
//                                         ),
//                                       ]),
//                                     ])),

//                                     GetBuilder<FavouriteController>(builder: (favouriteController) {
//                                       bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
//                                       return InkWell(
//                                         onTap: () {
//                                           if(AuthHelper.isLoggedIn()) {
//                                             isWished ? favouriteController.removeFromFavouriteList(store!.id, true)
//                                                 : favouriteController.addToFavouriteList(null, store?.id, true);
//                                           }else {
//                                             showCustomSnackBar('you_are_not_logged_in'.tr);
//                                           }
//                                         },
//                                         child: Container(
//                                           decoration: BoxDecoration(
//                                             color: Theme.of(context).primaryColor.withOpacity(0.1),
//                                             borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                           ),
//                                           padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                                           child: Icon(
//                                             isWished ? Icons.favorite : Icons.favorite_border,
//                                             color: isWished ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
//                                             size: 24  - (scrollingRate * 4),
//                                           ),
//                                         ),
//                                       );
//                                     }),
//                                     const SizedBox(width: Dimensions.paddingSizeSmall),

//                                     AppConstants.webHostedUrl.isNotEmpty ? InkWell(
//                                       onTap: () {
//                                         storeController.shareStore();
//                                       },
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                           color: Theme.of(context).primaryColor.withOpacity(0.1),
//                                           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                         ),
//                                         padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                                         child: Icon(
//                                           Icons.share, size: 24  - (scrollingRate * 4),
//                                         ),
//                                       ),
//                                     ) : const SizedBox(),
//                                     const SizedBox(width: Dimensions.paddingSizeSmall),

//                                   ]),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                   background: CustomImage(
//                     fit: BoxFit.cover,
//                     image: '${store!.coverPhotoFullUrl}',
//                   ),
//                 ),
//                 actions: const [
//                   SizedBox(),
//                 ],
//               ),

//               (ResponsiveHelper.isDesktop(context)  && storeController.recommendedItemModel != null && storeController.recommendedItemModel!.items!.isNotEmpty)
//               ? SliverToBoxAdapter(
//                 child: Container(
//                   color: Theme.of(context).primaryColor.withOpacity(0.10),
//                   child: Center(
//                     child: SizedBox(
//                       width: Dimensions.webMaxWidth,
//                       height: ResponsiveHelper.isDesktop(context) ? 325 : 125,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const SizedBox(height: Dimensions.paddingSizeSmall),
//                           Text('recommended_for_you'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, fontWeight: FontWeight.w700)),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                           Text('here_is_what_you_might_like'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor)),
//                           const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                           SizedBox(
//                             height: 250,
//                             child: ListView.builder(
//                               shrinkWrap: true,
//                               scrollDirection: Axis.horizontal,
//                               itemCount: storeController.recommendedItemModel!.items!.length,
//                               physics: const BouncingScrollPhysics(),
//                               padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   width:  225,
//                                   padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
//                                   margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
//                                   child: WebItemWidget(
//                                     isStore: false, item: storeController.recommendedItemModel!.items![index],
//                                     store: null, index: index, length: null, isCampaign: false, inStore: true,
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ): const SliverToBoxAdapter(child: SizedBox()),
//               const SliverToBoxAdapter(child: SizedBox(height: Dimensions.paddingSizeSmall)),

//               ///web view..
//               ResponsiveHelper.isDesktop(context) ? SliverToBoxAdapter(
//                 child: FooterView(
//                   child: SizedBox(
//                     width: Dimensions.webMaxWidth,
//                     child: Padding(
//                       padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
//                       child: Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           SizedBox(
//                             width: 175,
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Expanded(
//                                   child: ListView.builder(
//                                     shrinkWrap: true,
//                                     scrollDirection: Axis.vertical,
//                                     itemCount: storeController.categoryList!.length,
//                                     padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
//                                     physics: const NeverScrollableScrollPhysics(),
//                                     itemBuilder: (context, index) {
//                                       return InkWell(
//                                         onTap: () {
//                                           storeController.setCategoryIndex(index, itemSearching: storeController.isSearching);
//                                         },
//                                         child: Padding(
//                                           padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
//                                           child: Container(
//                                             padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
//                                             decoration: BoxDecoration(
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.bottomRight,
//                                                 end: Alignment.topLeft,
//                                                 colors: <Color>[
//                                                   index == storeController.categoryIndex ? Theme.of(context).primaryColor.withOpacity(0.50) : Colors.transparent,
//                                                   index == storeController.categoryIndex ? Theme.of(context).cardColor : Colors.transparent,
//                                                 ]
//                                               )
//                                             ),
//                                             child: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
//                                               Text(
//                                                 storeController.categoryList![index].name!,
//                                                 maxLines: 1, overflow: TextOverflow.ellipsis,
//                                                 style: index == storeController.categoryIndex
//                                                     ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
//                                                     : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
//                                               ),
//                                             ]),
//                                           ),
//                                         ),
//                                       );
//                                     },
//                                   ),
//                                 ),

//                                 Container(
//                                   height: storeController.categoryList!.length * 50, width: 1,
//                                   color: Theme.of(context).disabledColor.withOpacity(0.5),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(width: Dimensions.paddingSizeLarge),

//                           Expanded(child: Column (
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Container(
//                                     padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                                     height: 45,
//                                     width: 430,
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                       color: Theme.of(context).cardColor,
//                                       border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.40)),
//                                     ),
//                                     child: Row(
//                                       children: [
//                                         Expanded(
//                                           child: TextField(
//                                             controller: _searchController,
//                                             textInputAction: TextInputAction.search,
//                                             decoration: InputDecoration(
//                                               contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//                                               hintText: 'search_for_items'.tr,
//                                               hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
//                                               border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall), borderSide: BorderSide.none),
//                                               filled: true, fillColor:Theme.of(context).cardColor,
//                                               isDense: true,
//                                               prefixIcon: Icon(Icons.search, color: Theme.of(context).primaryColor.withOpacity(0.50)),
//                                             ),
//                                             onSubmitted: (String? value) {
//                                               if(value!.isNotEmpty) {
//                                                 Get.find<StoreController>().getStoreSearchItemList(
//                                                   _searchController.text.trim(), widget.store!.id.toString(), 1, storeController.type,
//                                                 );
//                                               }
//                                             } ,
//                                             onChanged: (String? value) { } ,
//                                           ),
//                                         ),
//                                         const SizedBox(width: Dimensions.paddingSizeSmall),

//                                         !storeController.isSearching ? CustomButton(
//                                           radius: Dimensions.radiusSmall,
//                                           height: 40,
//                                           width: 74,
//                                           buttonText: 'search'.tr,
//                                           isBold: false,
//                                           fontSize: Dimensions.fontSizeSmall,
//                                           onPressed: () {
//                                             storeController.getStoreSearchItemList(
//                                               _searchController.text.trim(), widget.store!.id.toString(), 1, storeController.type,
//                                             );
//                                           },
//                                         ) : InkWell(onTap: () {
//                                           _searchController.text = '';
//                                           storeController.initSearchData();
//                                           storeController.changeSearchStatus();
//                                         },
//                                           child: Container(
//                                             decoration: BoxDecoration(
//                                               color: Theme.of(context).primaryColor,
//                                               borderRadius: BorderRadius.circular(Dimensions.radiusSmall)
//                                             ),
//                                             padding: const EdgeInsets.symmetric(vertical: 3, horizontal: Dimensions.paddingSizeSmall),
//                                             child: const Icon(Icons.clear, color: Colors.white),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                   const SizedBox(width: Dimensions.paddingSizeSmall),

//                                   (Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!)
//                                   ? SizedBox(
//                                     width: 300,
//                                     height:  30,
//                                     child:  ListView.builder(
//                                       shrinkWrap: true,
//                                       scrollDirection: Axis.horizontal,
//                                       itemCount: Get.find<ItemController>().itemTypeList.length,
//                                       padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
//                                       physics: const NeverScrollableScrollPhysics(),
//                                       itemBuilder: (context, index) {
//                                         return Padding(
//                                           padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
//                                           child:  CustomCheckBoxWidget(
//                                             title: Get.find<ItemController>().itemTypeList[index].tr,
//                                             value: storeController.type == Get.find<ItemController>().itemTypeList[index],
//                                             onClick: () {
//                                               if(storeController.isSearching){
//                                                 storeController.getStoreSearchItemList(
//                                                   storeController.searchText, widget.store!.id.toString(), 1, Get.find<ItemController>().itemTypeList[index],
//                                                 );
//                                               } else {
//                                                 storeController.getStoreItemList(storeController.store!.id, 1, Get.find<ItemController>().itemTypeList[index], true);
//                                               }
//                                             },
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ) : const SizedBox(),
//                                 ],
//                               ),
//                               const SizedBox(height: Dimensions.paddingSizeSmall),

//                               PaginatedListView(
//                                 scrollController: scrollController,
//                                 onPaginate: (int? offset) {
//                                   if(storeController.isSearching){
//                                     storeController.getStoreSearchItemList(
//                                       storeController.searchText, widget.store!.id.toString(), offset!, storeController.type,
//                                     );
//                                   } else {
//                                     storeController.getStoreItemList(widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false);
//                                   }
//                                 },
//                                 totalSize: storeController.isSearching
//                                     ? storeController.storeSearchItemModel?.totalSize
//                                     : storeController.storeItemModel?.totalSize,
//                                 offset: storeController.isSearching
//                                     ? storeController.storeSearchItemModel?.offset
//                                     : storeController.storeItemModel?.offset,
//                                 itemView: WebItemsView(
//                                   isStore: false, stores: null, fromStore: true,
//                                   items: storeController.isSearching
//                                       ? storeController.storeSearchItemModel?.items
//                                       : (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null) ? storeController.storeItemModel!.items : null,
//                                   inStorePage: true,
//                                   padding: const EdgeInsets.symmetric(
//                                     horizontal: Dimensions.paddingSizeSmall,
//                                     vertical: Dimensions.paddingSizeSmall,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ))

//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ) : const SliverToBoxAdapter(child:SizedBox()),


//               ///mobile view..
//               ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
//               SliverToBoxAdapter(child: Center(child: Container(
//                 width: Dimensions.webMaxWidth,
//                 padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                 color: Theme.of(context).cardColor,
//                 child: Column(children: [

//                   ResponsiveHelper.isDesktop(context) ? const SizedBox() : StoreDescriptionViewWidget(store: store),
//                   const SizedBox(height: Dimensions.paddingSizeSmall),

//                   store?.announcementActive??false ? Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor.withOpacity(0.05),
//                       borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                       border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.2)),
//                     ),
//                     padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                     margin: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
//                     child: Row(children: [
//                       Image.asset(Images.announcement, height: 20, width: 20),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),

//                       Flexible(child: Text(store?.announcementMessage??'', style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall))),
//                     ]),
//                   ) : const SizedBox(),

//                   StoreBannerWidget(storeController: storeController),

//                   const SizedBox(height: Dimensions.paddingSizeLarge),

//                   (!ResponsiveHelper.isDesktop(context) && storeController.recommendedItemModel != null && storeController.recommendedItemModel!.items!.isNotEmpty) ? Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('recommended_for_you'.tr, style: robotoMedium),
//                       const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                       SizedBox(
//                         height: ResponsiveHelper.isDesktop(context) ? 150 : 130,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: storeController.recommendedItemModel!.items!.length,
//                           physics: const BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return Padding(
//                               padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.symmetric(vertical: 20) : const EdgeInsets.symmetric(vertical: 10) ,
//                               child: Container(
//                                 width: ResponsiveHelper.isDesktop(context) ? 500 : 300,
//                                 padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
//                                 margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
//                                 child: ItemWidget(
//                                   isStore: false, item: storeController.recommendedItemModel!.items![index],
//                                   store: null, index: index, length: null, isCampaign: false, inStore: true,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ) : const SizedBox(),
//                 ]),
//               ))),

//               ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
//               (storeController.categoryList!.isNotEmpty) ? SliverPersistentHeader(
//                 pinned: true,
//                 delegate: SliverDelegate(height: 90, child: Center(child: Container(
//                   width: Dimensions.webMaxWidth,
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
//                   ),
//                   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                   child: Column(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
//                         child: Row(children: [
//                           Text('all_products'.tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault)),
//                           const Expanded(child: SizedBox()),

//                           !ResponsiveHelper.isDesktop(context) ? InkWell(
//                             onTap: ()=> Get.toNamed(RouteHelper.getSearchStoreItemRoute(store!.id)),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                 color: Theme.of(context).primaryColor.withOpacity(0.1),
//                               ),
//                               padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                               child: Icon(Icons.search, size: 28, color: Theme.of(context).primaryColor),
//                             ),
//                           ) : const SizedBox(),

//                           storeController.type.isNotEmpty ? VegFilterWidget(
//                               type: storeController.type,
//                               onSelected: (String type) {
//                                 storeController.getStoreItemList(storeController.store!.id, 1, type, true);
//                               },
//                           ) : const SizedBox(),

//                         ]),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),

//                       SizedBox(
//                         height: 30,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: storeController.categoryList!.length,
//                           padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
//                           physics: const BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             return InkWell(
//                               onTap: () => storeController.setCategoryIndex(index),
//                               child: Container(
//                                 padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
//                                 margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                   color: index == storeController.categoryIndex ? Theme.of(context).primaryColor.withOpacity(0.1) : Colors.transparent,
//                                 ),
//                                 child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//                                   Text(
//                                     storeController.categoryList![index].name!,
//                                     style: index == storeController.categoryIndex
//                                         ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor)
//                                         : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
//                                   ),
//                                 ]),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ))),
//               ) : const SliverToBoxAdapter(child: SizedBox()),

//               ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
//               Builder(
//                 builder: (context) {
                 
//                   return SliverToBoxAdapter(child: Container(
//                     width: Dimensions.webMaxWidth,
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).colorScheme.surface,
//                     ),
//                     child: PaginatedListView(
//                       scrollController: scrollController,
//                       onPaginate: (int? offset) => storeController.getStoreItemList(widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false),
//                       totalSize: storeController.storeItemModel?.totalSize,
//                       offset: storeController.storeItemModel?.offset,
//                       itemView: ItemsView(
//                         isStore: false, stores: null,
//                         items: (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null)
//                             ? storeController.storeItemModel!.items : null,
//                         inStorePage: true,
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: Dimensions.paddingSizeSmall,
//                           vertical: Dimensions.paddingSizeSmall,
//                         ),
//                       ),
//                     ),
//                   ));
//                 }
//               ),
//             ],
//           ) : const StoreDetailsScreenShimmerWidget();
//         });
//       }),

//       floatingActionButton: GetBuilder<StoreController>(
//         builder: (storeController) {
//           return Visibility(
//             visible: storeController.showFavButton && Get.find<SplashController>().configModel!.moduleConfig!.module!.orderAttachment!
//                 && (storeController.store != null && storeController.store!.prescriptionOrder!)
//                 && Get.find<SplashController>().configModel!.prescriptionStatus! && AuthHelper.isLoggedIn(),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                 boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.5), blurRadius: 10, offset: const Offset(2, 2))],
//               ),
//               child: Row(mainAxisSize: MainAxisSize.min, children: [

//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 800),
//                   width: storeController.currentState == true ? 0 : ResponsiveHelper.isDesktop(context) ? 180 : 150,
//                   height: 30,
//                   curve: Curves.linear,
//                   child:  Center(
//                     child: Text(
//                       'prescription_order'.tr, textAlign: TextAlign.center,
//                       style: robotoMedium.copyWith(color: Theme.of(context).primaryColor), maxLines: 1, overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                 ),

//                 InkWell(
//                   onTap: () => Get.toNamed(
//                     RouteHelper.getCheckoutRoute('prescription', storeId: storeController.store!.id),
//                     arguments: CheckoutScreen(fromCart: false, cartList: null, storeId: storeController.store!.id),
//                   ),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                     ),
//                     padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                     child: Image.asset(Images.prescriptionIcon, height: 25, width: 25),
//                   ),
//                 ),

//               ]),
//             ),
//           );
//         }
//       ),

//       bottomNavigationBar: GetBuilder<CartController>(builder: (cartController) {
//         return cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context) ? const BottomCartWidget() : const SizedBox();
//       })
//     );
//   }
// }

// class SliverDelegate extends SliverPersistentHeaderDelegate {
//   Widget child;
//   double height;

//   SliverDelegate({required this.child, this.height = 100});

//   @override
//   Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   double get maxExtent => height;

//   @override
//   double get minExtent => height;

//   @override
//   bool shouldRebuild(SliverDelegate oldDelegate) {
//     return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
//   }
// }

// class CategoryProduct {
//   CategoryModel category;
//   List<Item> products;
//   CategoryProduct(this.category, this.products);
// }


class StoreScreen extends StatefulWidget {
  final Store? store;
  final bool fromModule;
  final String slug;
  const StoreScreen({super.key, required this.store, required this.fromModule, this.slug = ''});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _showTitle = false;
  bool isShop = false;
   
  @override
  void initState() {
    super.initState();
    initDataCall();
    WidgetsBinding.instance.addPostFrameCallback((_) {
        print('================================================================ACTIVATE===================================================================');
      initCall2();
    });


    scrollController.addListener(() {
      if (scrollController.offset > 50 && !_showTitle) {
        setState(() {
          _showTitle = true;
        });
      } else if (scrollController.offset <= 50 && _showTitle) {
        setState(() {
          _showTitle = false;
        });
      }
    });
  }
  
     
  // @override
  // void activate() {
  //   // TODO: implement activate
  //   super.activate();

  //   print('================================================================ACTIVATE===================================================================');
  //   initCall2();
  // }

  @override
  void dispose() {
    Get.find<StoreController>().clearstoreitems();
    print('================================================================DISPOSE===================================================================');
    scrollController.dispose();

    super.dispose();
  }

  Future<void> initDataCall() async {
    // if(Get.find<StoreController>().isSearching) {
    //   Get.find<StoreController>().changeSearchStatus(isUpdate: false);
    // }
    //  Get.find<CheckoutController>().initCheckoutData(widget.store!.id);
       isShop =  Get.find<SplashController>().module!.moduleType.toString() == AppConstants.ecommerce;
    Get.find<StoreController>().hideAnimation();
    await Get.find<StoreController>().getStoreDetails(Store(id: widget.store!.id), widget.fromModule, slug: widget.slug).then((value) {
      Get.find<StoreController>().showButtonAnimation();
    });
    if(Get.find<CategoryController>().categoryList == null) {
      Get.find<CategoryController>().getCategoryList(true);
    }
    // Get.find<StoreController>().getStoreBannerList(widget.store!.id ?? Get.find<StoreController>().store!.id);
    // Get.find<StoreController>().getRestaurantRecommendedItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, false);
    // Get.find<StoreController>().getStoreItemList(widget.store!.id ?? Get.find<StoreController>().store!.id, 1, 'all', false);

    scrollController.addListener(() {
      if(scrollController.position.userScrollDirection == ScrollDirection.reverse){
        if(Get.find<StoreController>().showFavButton){
          Get.find<StoreController>().changeFavVisibility();
          Get.find<StoreController>().hideAnimation();
        }
      }else{
        if(!Get.find<StoreController>().showFavButton){
          Get.find<StoreController>().changeFavVisibility();
          Get.find<StoreController>().showButtonAnimation();

        }
      }
    });
  }
   initCall2() async {
      bool isLoggedIn = AuthHelper.isLoggedIn();
  
        Get.find<CheckoutController>().initCheckoutData(widget.store!.id);
      // Get.find<CheckoutController>().setGuestAddress(null, isUpdate: false);
      Get.find<CheckoutController>().setPaymentMethod(0, isUpdate: false);
      Get.find<CheckoutController>().streetNumberController.text = AddressHelper.getUserAddressFromSharedPref()!.streetNumber ?? '';
      Get.find<CheckoutController>().houseController.text = AddressHelper.getUserAddressFromSharedPref()!.house ?? '';
      Get.find<CheckoutController>().floorController.text = AddressHelper.getUserAddressFromSharedPref()!.floor ?? '';
      Get.find<CheckoutController>().couponController.text = '';

      Get.find<CheckoutController>().getDmTipMostTapped();
      Get.find<CheckoutController>().setPreferenceTimeForView('', isUpdate: false);

      Get.find<CheckoutController>().getOfflineMethodList();

      if(Get.find<CheckoutController>().isCreateAccount) {
        Get.find<CheckoutController>().toggleCreateAccount(willUpdate: false);
      }

      if(Get.find<CheckoutController>().isPartialPay){
        Get.find<CheckoutController>().changePartialPayment(isUpdate: false);
      }

      if(isLoggedIn) {
        if(Get.find<ProfileController>().userInfoModel == null) {
          Get.find<ProfileController>().getUserInfo();
        }

        Get.find<CouponController>().getCouponList();

        if(Get.find<AddressController>().addressList == null) {
          Get.find<AddressController>().getAddressList();
        }
      }



      if(widget.store!.id == null){
        // _cartList = [];
        if(GetPlatform.isWeb) {
         await Get.find<CartController>().getCartDataOnline();
        }
      //   widget.fromCart ? _cartList!.addAll(Get.find<CartController>().cartList) : _cartList!.addAll(widget.cartList!);
      //   if(_cartList != null && _cartList!.isNotEmpty) {
      //     Get.find<CheckoutController>().initCheckoutData(_cartList![0]!.item!.storeId);
      //   }
      // }
      if(widget.store!.id != null){
        // Get.find<CheckoutController>().initCheckoutData(widget.store!.id);
        Get.find<CouponController>().removeCouponData(false);
      }
      Get.find<CheckoutController>().pickPrescriptionImage(isRemove: true, isCamera: false);
      // _isWalletActive = Get.find<SplashController>().configModel!.customerWalletStatus == 1;
      Get.find<CheckoutController>().updateTips(
        Get.find<CheckoutController>().getSharedPrefDmTipIndex().isNotEmpty ? int.parse(Get.find<CheckoutController>().getSharedPrefDmTipIndex()) : 0,
        notify: false,
      );
      Get.find<CheckoutController>().tipController.text = Get.find<CheckoutController>().selectedTips != -1 ? AppConstants.tips[Get.find<CheckoutController>().selectedTips] : '';
  
  }
   }
  

    BoxDecoration _buildBackgroundDecoration( bool isappbar) {
    return BoxDecoration(
      color: Theme.of(context).primaryColor,
      image: DecorationImage(
        image: AssetImage("assets/image/static_banner/WhatsApp Image 2025-01-22 at 22.11.49_212d2639.jpg"),
        fit: BoxFit.cover,
      ),
      borderRadius:  !isappbar ? BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ) : null,
    );
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));

    return Scaffold(
      appBar: null,
      endDrawer: const MenuDrawer(),
      endDrawerEnableOpenDragGesture: false,
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: GetBuilder<StoreController>(builder: (storeController) {
    
          //  initCall2();
        return GetBuilder<CategoryController>(builder: (categoryController) {
          Store? store;
          if (storeController.store != null &&
              storeController.store!.name != null
             ) {
            store = storeController.store;
            storeController.setCategoryList();
          }
    
          return (storeController.store != null &&
                   storeController.store!.name != null) 
              ?  !isShop ?     CustomScrollView(
                scrollBehavior: const MaterialScrollBehavior().copyWith(
                  
                ),
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  slivers: [
                    SliverAppBar(
                      backgroundColor:
                       Theme.of(context).cardColor,
                      scrolledUnderElevation: 0,
                      elevation: 0,
                      pinned: true,
                      //   flexibleSpace: FlexibleSpaceBar(
                      //   background: Container(
                      //     decoration: _buildBackgroundDecoration(
                      //       true
                      //     ),
                      //   ),
                      // ),
                      leading: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon:  Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor),
                      ),
                          title: Text(_showTitle ? store!.name ?? '' : '', style: 
                           robotoMedium.copyWith(fontSize: 16, color:  Colors.black,fontWeight: FontWeight.w600)
                          // robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color)
                          ),
                      // centerTitle: ",
                      actions: [
                        GetBuilder<FavouriteController>(builder: (favouriteController) {
                          bool isWished = favouriteController.wishStoreIdList.contains(store!.id);
                          return InkWell(
                            overlayColor: WidgetStateProperty.all(Colors.transparent),
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
                              color: isWished ? Colors.redAccent :  Theme.of(context).primaryColor,
                              size: 25,
                            ),
                          );
                        }),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: AppConstants.webHostedUrl.isNotEmpty
                              ? InkWell(
                                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                                  onTap: () {
                                    storeController.shareStore();
                                  },
                                  child: SvgPicture.asset('assets/image/icons/Vector.svg', height: 20),
                                )
                              : const SizedBox(),
                        ),
                      ],
                    ),
                    SliverToBoxAdapter(
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 00),
                              child: Container(
                                                    width: Dimensions.webMaxWidth,
                                                    // padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                         
                                                    decoration: 
                                                    // _buildBackgroundDecoration(
                                                    //   false
                                                    // ),
                                                    
                                                    BoxDecoration(
                                        //  color: Theme.of(context).primaryColor,
  //                                        image: DecorationImage(image: AssetImage("assets/image/static_banner/WhatsApp Image 2025-01-22 at 22.11.49_212d2639.jpg"),
  //   fit: BoxFit.cover,  // Adjust as needed (cover, contain, fill, etc.)
  // // ),
                                         borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20),
                                         )
                                                    ),
                                                    child: Column(children: [
                                                      StoreDescriptionViewWidget(store: store),
                                                      // const SizedBox(height: Dimensions.paddingSizeSmall),

                                               store!.open == 1 && store!.active!
    ? const SizedBox()
    : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 80, // Slightly taller for better visual balance
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 237, 121, 11).withOpacity(0.2),
            borderRadius: BorderRadius.circular(12), // Smoother border radius
            // border: Border.all(
            //   color: Theme.of(context).primaryColor.withOpacity(0.2),
            //   width: 1.5, // Slightly thicker border
            // ),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black.withOpacity(0.1),
            //     blurRadius: 6,
            //     offset: const Offset(0, 3), // Subtle shadow for depth
            //   ),
            // ],
          ),
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 12.0), // Better padding
          child: Row(
            children: [
            
          
              Expanded(
                child: Text(
                  "This restaurant is currently not available for delivery".tr,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w500, // Slightly bolder text
                      ),
                  maxLines: 2, // Prevent text overflow
                  overflow: TextOverflow.ellipsis,
                ),
              ),
   const SizedBox(width: 12),
              Image.asset(
                "assets/image/icons/icons8-disconnect-94.png"
              )
            ],
          ),
        ),
      ),
                                                      StoreBannerWidget(storeController: storeController),
                                                    
CouponCarousel(storeid: store!.id,),

                                             // SizedBox(height: 40,),             StoreBannerWidget(storeController: storeController)
                                                    ]),
                                                  ),
                            ))),

                    (storeController.categoryList!.isNotEmpty)
                        ? SliverPersistentHeader(
                          
                            pinned: true,
                            delegate: SliverDelegate(
                                height: 70,
                                child: Center(
                                    child: Container(
                                  width: Dimensions.webMaxWidth,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    // boxShadow: const [
                                    //   BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
                                    // ],
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 
                                  Dimensions.paddingSizeExtraSmall
                                  ),
                                  child: Column(
                                    children: [
                                   
                                       Row(
                                         children: [
                                       storeController.type.isNotEmpty ?     Expanded(
                                         child: Padding(
                                           padding: const EdgeInsets.only(left: 15,right: 0,bottom: 0),
                                           child: InkWell(
                                            onTap: ()=> Get.toNamed(RouteHelper.getSearchStoreItemRoute(store!.id)),
                                             child: Container(
                                              height: 40,
                                              // width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                color:const Color.fromARGB(255, 244, 243, 243),
                                                border: Border.all(
              width: .3,
              color: Colors.grey
            )
    
                                                
    
                                              ),
    
                                              child: Stack(
                                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Positioned(
                                                    top: 10,
                                                    left: 20,
                                                    child: SizedBox(
                                                      width: 200,
                                                      child: Text("Search in ${store!.name != null ?  store.name : "Uolo"}",
                                                      overflow: TextOverflow.ellipsis,maxLines: 1 ,),
                                                    )),
                                                  
                                                  const Positioned(
                                                    right: 10,
                                                    top: 5,
                                                    child: Icon(Icons.search,size: 30,color: Colors.red, ))
                                                ],
                                              ),
                                             ),
                                           ),
                                         ),
                                       ) : const SizedBox(),
    
                                            storeController.type.isNotEmpty ? Padding(
                                              padding: const EdgeInsets.only(bottom: 0,right: 5),
                                              child: VegFilterWidget(
                                                                            type: storeController.type,
                                                                            onSelected: (String type) {
                                                                              storeController.getStoreItemList(storeController.store!.id, 1, type, true);
                                                                            },
                                                                        ),
                                            ) : const SizedBox()
                                         ],
                                       ),
                                     
                                
                                 
                                    ],
                                  ),
                                ))),
                          )
                        : const SliverToBoxAdapter(child: SizedBox()),
    
    
    
            
    
                          (storeController.categoryList!.isNotEmpty)
                        ? SliverPersistentHeader(
                          
                            pinned: true,
                            delegate: SliverDelegate(
                                height: 50,
                                child: Center(
                                    child: Container(
                                  width: Dimensions.webMaxWidth,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    boxShadow: const [
                                      BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                                  child: Column(
                                    children: [
    
       
                                      SizedBox(
                                        height: 30,
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: storeController.categoryList!.length,
                                          padding:
                                              const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                                          physics: const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () => storeController.setCategoryIndex(index),
                                              child: Container(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: Dimensions.paddingSizeDefault,
                                                    vertical: Dimensions.paddingSizeExtraSmall),
                                                margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Theme.of(context)
                                                          .primaryColor
                                                          .withOpacity(0.2)),
                                                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                                                  color: index == storeController.categoryIndex
                                                      ? Colors.black
                                                      : Colors.transparent,
                                                ),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Text(
                                                        storeController
                                                            .categoryList![index].name!,
                                                        style: index ==
                                                                storeController
                                                                    .categoryIndex
                                                            ? robotoMedium.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Colors
                                                                    .white)
                                                            : robotoRegular.copyWith(
                                                                fontSize: Dimensions
                                                                    .fontSizeSmall,
                                                                color: Colors
                                                                    .black),
                                                      ),
                                                    ]),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                ))),
                          )
                        : const SliverToBoxAdapter(child: SizedBox()),
    
       
    
    
    
    
    
    
    
    
    
    

    
                    ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
              SliverToBoxAdapter(
                child: Container(
                width: Dimensions.webMaxWidth,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
                  child: PaginatedListView(
                    scrollController: scrollController,
                    onPaginate: (int? offset) => storeController.getStoreItemList(widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false),
                    totalSize: storeController.storeItemModel?.totalSize,
                    offset: storeController.storeItemModel?.offset,
                    itemView: ItemsView(
                      
                      // notinStore: true,
                      isStore: false, stores: null,
                      items: (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null)
                          ? storeController.storeItemModel!.items : null,
                      inStorePage: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: Dimensions.paddingSizeSmall,
                        vertical: Dimensions.paddingSizeSmall,
                      ),
                      //  isfashion: isShop,
                    ),
                  ),
                ),
              )),


       SliverToBoxAdapter(child: SizedBox(height: 50,)),
         SliverToBoxAdapter(
          child: _buildPaginationFooter(context),
        ),
  // SliverToBoxAdapter(
  //         child: EndScreenDialog(
            
  //         ),
  //       ),
            ],
          ) :
          CustomScrollView(
  slivers: [
    SliverAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.store != null) ...[
            Text(
              widget.store!.name ?? 'Store Name',
              style: const TextStyle(fontSize: 14),
            ),
            Text(
              '${widget.store!.itemCount ?? 0} Products',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ],
      ),
      floating: true,
      pinned: true,
      snap: false,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.search), // Search icon
          onPressed: () {
            // Handle the search action
          },
        ),
        IconButton(
          icon: const Icon(Icons.favorite), // Favorite icon
          onPressed: () {
            // Handle the favorite action
          },
        ),
        IconButton(
          icon: const Icon(Icons.shopping_bag),
          onPressed: () {
            
          },
        ),
      ],
    ),
    if (ResponsiveHelper.isDesktop(context))
      const SliverToBoxAdapter(child: SizedBox(height: 0))
    else if (storeController.categoryList != null && storeController.categoryList!.isNotEmpty)
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverDelegate(
          height: 60,
          child: Center(
            child: Container(
              width: Dimensions.webMaxWidth,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1),
                ],
              ),
              padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 30,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: storeController.categoryList!.length,
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => storeController.setCategoryIndex(index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: Dimensions.paddingSizeDefault,
                              vertical: Dimensions.paddingSizeExtraSmall,
                            ),
                            margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Theme.of(context).primaryColor.withOpacity(0.2),
                              ),
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                              color: index == storeController.categoryIndex
                                  ? Colors.black
                                  : Colors.transparent,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  storeController.categoryList![index].name ?? 'Category',
                                  style: index == storeController.categoryIndex
                                      ? robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Colors.white,
                                        )
                                      : robotoRegular.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                          color: Colors.black,
                                        ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
    else
      const SliverToBoxAdapter(child: SizedBox()),

  
// SliverGrid(
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2, 
//     mainAxisSpacing: 20,
//     crossAxisSpacing: 10,
//     childAspectRatio: 0.54,
//   ),
//   delegate: SliverChildBuilderDelegate(
//     (context, index) {
      
//       if (storeController.storeItemModel == null ||
//           storeController.storeItemModel!.items == null ||
//           index >= storeController.storeItemModel!.items!.length) {
//         return SizedBox.shrink(); 
//       }
//       return Ecomerceitem(
//         item: storeController.storeItemModel!.items![index],
//         isStore: true,
//         isCampaign: false,
//       );
//     },
//     childCount: 4, 
//   ),
// ),


// SliverToBoxAdapter(
//   child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
//     child: LayoutBuilder(
//       builder: (context, constraints) {
//         return  BannerView(isFeatured: false,);
//         // StoreBannerWidget(storeController: storeController);
//       },
//     ),
//   ),
// ),


// SliverGrid(
//   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//     crossAxisCount: 2,
//     mainAxisSpacing: 20,
//     crossAxisSpacing: 10,
//     childAspectRatio: 0.54,
//   ),
//   delegate: SliverChildBuilderDelegate(
//     (context, index) {
//       // Null and range check
//       if (storeController.storeItemModel == null ||
//           storeController.storeItemModel!.items == null ||
//           index + 4 >= storeController.storeItemModel!.items!.length) {
//         return 
//         Container(); // Return an empty container or a placeholder widget
//       }
//       return Ecomerceitem(
//         item: storeController.storeItemModel!.items![index + 4], // Skipping first 4
//         isStore: true,
//         isCampaign: false,
//       );
//     },
//     childCount: storeController.storeItemModel != null &&
//             storeController.storeItemModel!.items != null
//         ? storeController.storeItemModel!.items!.length - 4
//         : 0, // Ensure childCount is not negative
//   ),
// ),
 
 

        SliverGrid(
          gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio:   storeController.storeItemModel == null ||
                  storeController.storeItemModel!.items == null 
                   ? 0.74 : 0.54,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
        
              if (storeController.storeItemModel == null ||
                  storeController.storeItemModel!.items == null ||
                  index >= storeController.storeItemModel!.items!.length) {
                return Shimmer(
      colorOpacity: 1,
   
      enabled: true,
              duration: Duration(seconds: 1),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
  borderRadius: BorderRadius.circular(10)
                ),
                height: 200,
                width: 200,
              
              ),
            );
              }
              return Ecomerceitem(
                item: storeController.storeItemModel!.items![index],
                isStore: true,
                isCampaign: false,
              );
            },
            childCount: storeController.storeItemModel == null ? 4 : storeController.storeItemModel!.items!.length,
          ),
        ),

       
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
            child: LayoutBuilder(
              builder: (context, constraints) {
         
                if (storeController.storeItemModel == null) {
                  return Shimmer(
      colorOpacity: 1,

      enabled: true,
              duration: Duration(seconds: 1),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
  borderRadius: BorderRadius.circular(10)
                ),
                height: 200,
                width: 200,
              
              ),
            );
                }
                return BannerView(isFeatured: false);
              },
            ),
          ),
        ),

       
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            childAspectRatio: 0.54,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
             
              if (storeController.storeItemModel == null ||
                  storeController.storeItemModel!.items == null ||
                  index + 4 >= storeController.storeItemModel!.items!.length) {
                return Shimmer(
      colorOpacity: 1,
      
      enabled: true,
              duration: Duration(seconds: 1),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
  borderRadius: BorderRadius.circular(10)
                ),
                height: 200,
                width: 200,
              
              ),
            );
              }
              return Ecomerceitem(
                item: storeController.storeItemModel!.items![index + 4], 
                isStore: true,
                isCampaign: false,
              );
            },
            childCount: storeController.storeItemModel == null
                ? 4 
                : (storeController.storeItemModel!.items!.length - 4).clamp(0, storeController.storeItemModel!.items!.length),
          ),
        ),

        SliverToBoxAdapter(
          child: _buildPaginationFooter(context),
        ),
  ],
) : 
//            CustomScrollView(
//             slivers: [
//   SliverAppBar(
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('${widget.store!.name}',style: TextStyle(
//                   fontSize: 14
//                 ),),
//                 Text('${widget.store!.itemCount} Products',style: TextStyle(
//                   fontSize: 11
//                 ),),
//                 // Text("${widget.store!.itemCount}"),
//               ],
//             ), // Title of the AppBar
//             floating: true,
//             pinned: true,
//             snap: false,
//             actions: <Widget>[
//                IconButton(
//                 icon: Icon(Icons.search), // Search icon
//                 onPressed: () {
//                   // Handle the search action
//                 },
//               ),
//               IconButton(
//                 icon: Icon(Icons.favorite), // Favorite icon
//                 onPressed: () {
//                   // Handle the favorite action
//                 },
//               ),
             
//               IconButton(
//                 icon: Icon(Icons.shopping_bag), // Cart icon
//                 onPressed: () {
//                   // Handle the cart action
//                 },
//               ),
//             ],
//           ),
//               //  SliverToBoxAdapter(child:SizedBox(height: 100,)),
// ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox(height: 0,)) :
//                     (storeController.categoryList!.isNotEmpty)
//                         ? SliverPersistentHeader(
                          
//                             pinned: true,
//                             delegate: SliverDelegate(
//                                 height: 60,
//                                 child: Center(
//                                     child: Container(
//                                   width: Dimensions.webMaxWidth,
//                                   decoration: BoxDecoration(
//                                     color: Theme.of(context).cardColor,
//                                     boxShadow: const [
//                                       BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
//                                     ],
//                                   ),
//                                   padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//                                   child: Column(
//                                     children: [
    
//             //                
//             SizedBox(height: 10,),
//                                       SizedBox(
//                                         height: 30,
//                                         child: ListView.builder(
//                                           scrollDirection: Axis.horizontal,
//                                           itemCount: storeController.categoryList!.length,
//                                           padding:
//                                               const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
//                                           physics: const BouncingScrollPhysics(),
//                                           itemBuilder: (context, index) {
//                                             return InkWell(
//                                               onTap: () => storeController.setCategoryIndex(index),
//                                               child: Container(
//                                                 padding: const EdgeInsets.symmetric(
//                                                     horizontal: Dimensions.paddingSizeDefault,
//                                                     vertical: Dimensions.paddingSizeExtraSmall),
//                                                 margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: Theme.of(context)
//                                                           .primaryColor
//                                                           .withOpacity(0.2)),
//                                                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                                   color: index == storeController.categoryIndex
//                                                       ? Colors.black
//                                                       : Colors.transparent,
//                                                 ),
//                                                 child: Column(
//                                                     mainAxisAlignment: MainAxisAlignment.center,
//                                                     children: [
//                                                       Text(
//                                                         storeController
//                                                             .categoryList![index].name!,
//                                                         style: index ==
//                                                                 storeController
//                                                                     .categoryIndex
//                                                             ? robotoMedium.copyWith(
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeSmall,
//                                                                 color: Colors
//                                                                     .white)
//                                                             : robotoRegular.copyWith(
//                                                                 fontSize: Dimensions
//                                                                     .fontSizeSmall,
//                                                                 color: Colors
//                                                                     .black),
//                                                       ),
//                                                     ]),
//                                               ),
//                                             );
//                                           },
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ))),
//                           )
//                         : const SliverToBoxAdapter(child: SizedBox()),
    
//             ResponsiveHelper.isDesktop(context) ? const SliverToBoxAdapter(child:SizedBox()) :
//               SliverToBoxAdapter(
//                 child: Container(
//                 width: Dimensions.webMaxWidth,
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).colorScheme.surface,
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.only(top: 0),
//                   child: 
//                   Column(
//                     children: [

     
//              Padding(
//                padding: const EdgeInsets.all(10),
//                child: Container(
//                  height: MediaQuery.of(context).size.height, // Set a fixed height
//                  child: GridView.builder(
//                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                      crossAxisCount: 2, // Number of columns
//                      mainAxisSpacing: 20, // Spacing between rows
//                      crossAxisSpacing: 10, // Spacing between columns
//                      childAspectRatio: .54, // Aspect ratio of each item
//                    ),
//                    itemBuilder: (context, index) {
//                      return    Ecomerceitem(
//                      item:
//                       storeController.storeItemModel!.items ![index], isStore: true, isCampaign: false,
//                     //  imageHeight: 150, // Set a fixed height for the image
//                     //  imageWidth: 200, // Set a fixed width for the image
//                    );
//                    },
//                    itemCount: storeController.storeItemModel!.items!.length, // Number of items in the grid
//                  ),
//                ),
//              )  
               
//                   ]),
//                   // PaginatedListView(
//                   //   scrollController: scrollController,
//                   //   onPaginate: (int? offset) => storeController.getStoreItemList(widget.store!.id ?? storeController.store!.id, offset!, storeController.type, false),
//                   //   totalSize: storeController.storeItemModel?.totalSize,
//                   //   offset: storeController.storeItemModel?.offset,
//                   //   itemView: ItemsView2(
//                   //     // notinStore: true,
//                   //     isStore: false, stores: null,
//                   //     items: (storeController.categoryList!.isNotEmpty && storeController.storeItemModel != null)
//                   //         ? storeController.storeItemModel!.items : null,
//                   //     inStorePage: true,
//                   //     padding: const EdgeInsets.symmetric(
//                   //       horizontal: Dimensions.paddingSizeSmall,
//                   //       vertical: Dimensions.paddingSizeSmall,
//                   //     ), isfashion: isShop,
//                   //   ),
//                   // ),
               
//                 ),
//               )),
//             ],
//           ) :
         
         
            MyStoreShimmer(
              isloader: true,
            );
          
          //  const CustomLoaderWidget();
          
          // const StoreDetailsScreenShimmerWidget();
             
    
       
              
             
        });
    
       
    
      }),
    
    
      
    resizeToAvoidBottomInset: true,
         bottomSheet:  GetBuilder<StoreController>(
                             builder: (storeController) {
                       return (storeController.store != null &&
                   storeController.store!.name != null) ? GetBuilder<CartController>(
                             builder: (cartController){
                               return  !isShop ? cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context)
                                ?  BottomCartWidget(
                                 fromgroccery: false,
                                )
                                : const SizedBox() : const SizedBox();
                             },
                           ) : const SizedBox();
                     }
                   ),
    
         floatingActionButtonLocation: FloatingActionButtonLocation.endFloat  ,
       
        //  floatingActionButton:  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_cart_outlined,color: Theme.of(context).primaryColor,)) ,
        floatingActionButton:
   
     !isShop ?    Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      color: const Color.fromARGB(255, 32, 31, 31),
      borderRadius: BorderRadius.circular(100),
    ),
    
    child: FloatingActionButton(
      backgroundColor: const Color.fromARGB(255, 32, 31, 31),
      onPressed: (){
                showGridMenu(
                   context,
                );
      
    },
    isExtended: true, 
     child: const Icon(Icons.menu_book_sharp,color: Colors.white,size: 30,),
    
    ),
        ) : SizedBox() ,
    );
  }
}


class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;

  SliverDelegate({required this.child, this.height = 100});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != height || oldDelegate.minExtent != height || child != oldDelegate.child;
  }
}

class CategoryProduct {
  CategoryModel category;
  List<Item> products;
  CategoryProduct(this.category, this.products);
}



// void showGridMenu(BuildContext context) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         alignment: Alignment.bottomRight,
//         contentPadding: EdgeInsets.all(0),
//         content: Container(
//           width: 200,  // You can adjust the width and height as needed
//           height: 300,
//           child: SingleChildScrollView(
//             child: Column(
//               children: [
//                 ListView.builder(itemBuilder: 
//                 (context, index) {
//                   return ListTile(
//                     title: Text('Menu Item $index'),
//                     onTap: () {
//                       // Handle menu item tap
//                       Navigator.pop(context);
//                     },
//                   );
//                 }, itemCount: 10),
//               ],
//             ),
//           ),
//         ),
//       );
//     },
//   );
// }


void showGridMenu(BuildContext context) {
  
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 90,right: 1 / .9909/2),
        child:Dialog(
          
                 elevation: 0, 
          backgroundColor: const Color.fromARGB(255, 32, 31, 31),
          alignment: Alignment.bottomRight,
          //  elevation: 0,
          child: SizedBox(
            width: 200,
            height: 300,
            child: GetBuilder<StoreController>(builder: (storeController) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: storeController.categoryList!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        
                        title: Text('${storeController.categoryList![index].name}',style: const TextStyle(color: Colors.white,fontSize: 17),),
                        onTap: () {
                          // Handle menu item tap
                          Navigator.pop(context);
                          storeController.setCategoryIndex(index);
                        },
                      );
                    },
                  ),
                );
              }
            ),
          ),
        ),
      );
    },
  );
}

Widget _buildPaginationFooter(BuildContext context) {
  final storeController = Get.find<StoreController>();
  final storeModel = storeController.storeItemModel;


  if (storeModel == null || storeModel.items == null) {
    return const SizedBox(); 
  }

  final totalSize = storeModel.totalSize ?? 0;
  final currentItems = storeModel.items!.length + 1;
  final isLastPage = currentItems >= totalSize;
  print("totalSize: $totalSize  currentItems: $currentItems" " isLastPage: $isLastPage");
  return !isLastPage
      ? const SizedBox() 
      : EndScreenDialog(); 
}

class MyStoreShimmer extends StatefulWidget {
final bool  isloader;
  const MyStoreShimmer({super.key, required this.isloader});

  @override
  State<MyStoreShimmer> createState() => _MyStoreShimmerState();
}

class _MyStoreShimmerState extends State<MyStoreShimmer> with SingleTickerProviderStateMixin {


  //  late AnimationController _controller;
 @override
  // void initState() {
  //   super.initState();
  //   _controller = AnimationController(
  //     duration: const Duration(seconds: 2), 
  //     vsync: this,
  //   )..repeat(); 

 
  //   _controller.value = 2.0; 
  //   _controller.forward(); 
  //   _controller.duration = const Duration(seconds: 3);
  //   _controller.repeat(); 
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.isloader ?  Center(child: Padding(
        padding: const EdgeInsets.only(bottom: 00),
        child: Container(
          height: 200,
          width: 200,
          child: Lottie.asset('assets/animations/Animation - 1740696483528 (4).json', repeat: true,
        fit: BoxFit.cover,
        height: 100,
        width: 100
             ),
        ),
      ))  : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
              SizedBox(height: 50,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSkeleton(height: 30, width: 150),
                    SizedBox(
                      height: 5,
                    ),
                     ShimmerSkeleton(height: 20, width: 250),
                  ],
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerSkeleton(height: 30, width: 80),
                    SizedBox(
                      height: 5,
                    ),
                     ShimmerSkeleton(height: 20, width: 60),
                  ],
                ),
               
              ],
            ),
            SizedBox(height: 50,),
         Row(
          // crossAxisAlignment: ,
          mainAxisAlignment: MainAxisAlignment.spaceAround,

          children: [
            
             ShimmerSkeleton(height: 35, width: 260),
             SizedBox(width: 10,),
              ShimmerSkeleton(height: 35, width: 80),

          ],
         ),
            SizedBox(height: 20,),
          SizedBox(
            height: 45,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: 
            (context, index) {
                
              return Padding(
                  
                padding: const EdgeInsets.all(8.0),
                child: ShimmerSkeleton(
                  height: 20,
                  width: 85,
                ),
              );
            
                 
            
            },
            ),
          ),
            
                SizedBox(height: 20,),
              // ShimmerSkeleton(height: 200, width: double.infinity), 
              Container(
                height: 200,
                child: ItemShimmer()),
               SizedBox(height: 20,),
              // ShimmerSkeleton(height: 200, width:double.infinity), 
              Container(
                height: 200,
                child: ItemShimmer()),
               SizedBox(height: 20,),
              // Flexible(child: ShimmerSkeleton(height: 200, width: double.infinity)), 
            // Container(
            //     height: 200,
            //     child: ItemShimmer()),
            
          ],
        ),
      ),
    );
  }
}



class ItemShimmer extends StatelessWidget {
  const ItemShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Container(
        height: 300,
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
    );
  }
}

























class ShimmerSkeleton extends StatelessWidget {
  const ShimmerSkeleton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      colorOpacity: 1,
      //  interval: Durations.extralong4,
      enabled: true,
              duration: Duration(seconds: 1),
              color: Colors.white,
              child: Container(
                decoration: BoxDecoration(
  color: Colors.black.withOpacity(0.04),
  borderRadius: BorderRadius.circular(10)
                ),
                height: height,
                width: width,
              
              ),
            );
  }
}


class Shimmerskelton extends StatelessWidget {
  final double? height, width;
  const Shimmerskelton({super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}



