import 'package:intl/intl.dart';
import 'package:sixam_mart/common/widgets/cart_count_view.dart';
import 'package:sixam_mart/common/widgets/corner_banner/banner.dart';
import 'package:sixam_mart/common/widgets/corner_banner/corner_discount_tag.dart';
import 'package:sixam_mart/common/widgets/custom_asset_image_widget.dart';
import 'package:sixam_mart/common/widgets/custom_favourite_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/common/widgets/organic_tag.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class ItemWidget extends StatelessWidget {
//   final Item? item;
//   final Store? store;
//   final bool isStore;
//   final int index;
//   final int? length;
//   final bool inStore;
//   final bool isCampaign;
//   final bool isFeatured;
//   final bool fromCartSuggestion;
//   final double? imageHeight;
//   final double? imageWidth;
//   final bool? isCornerTag;
//   const ItemWidget({super.key, required this.item, required this.isStore, required this.store, required this.index,
//     required this.length, this.inStore = false, this.isCampaign = false, this.isFeatured = false,
//     this.fromCartSuggestion = false, this.imageHeight, this.imageWidth, this.isCornerTag = false});

//   @override
//   Widget build(BuildContext context) {
//     final bool ltr = Get.find<LocalizationController>().isLtr;
//     bool desktop = ResponsiveHelper.isDesktop(context);
//     double? discount;
//     String? discountType;
//     bool isAvailable;
//     String genericName = '';

//     if(!isStore && item!.genericName != null && item!.genericName!.isNotEmpty) {
//       for (String name in item!.genericName!) {
//         genericName += name;
//       }
//     }
//     if(isStore) {
//       discount = store!.discount != null ? store!.discount!.discount : 0;
//       discountType = store!.discount != null ? store!.discount!.discountType : 'percent';
//       isAvailable = store!.open == 1 && store!.active!;
//     }else {
//       discount = (item!.storeDiscount == 0 || isCampaign) ? item!.discount : item!.storeDiscount;
//       discountType = (item!.storeDiscount == 0 || isCampaign) ? item!.discountType : 'percent';
//       isAvailable = DateConverter.isAvailable(item!.availableTimeStarts, item!.availableTimeEnds);
//     }

//     return Stack(
//       children: [
//         Container(
//           margin: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//             color: Theme.of(context).cardColor,
//             boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
//           ),
//           child: CustomInkWell(
//             onTap: () {
//               if(isStore) {
//                 if(store != null) {
//                   if(isFeatured && Get.find<SplashController>().moduleList != null) {
//                     for(ModuleModel module in Get.find<SplashController>().moduleList!) {
//                       if(module.id == store!.moduleId) {
//                         Get.find<SplashController>().setModule(module);
//                         break;
//                       }
//                     }
//                   }
//                   Get.toNamed(
//                     RouteHelper.getStoreRoute(id: store!.id, page: isFeatured ? 'module' : 'item'),
//                     arguments: StoreScreen(store: store, fromModule: isFeatured),
//                   );
//                 }
//               }else {
//                 if(isFeatured && Get.find<SplashController>().moduleList != null) {
//                   for(ModuleModel module in Get.find<SplashController>().moduleList!) {
//                     if(module.id == item!.moduleId) {
//                       Get.find<SplashController>().setModule(module);
//                       break;
//                     }
//                   }
//                 }
//                 Get.find<ItemController>().navigateToItemPage(item, context, inStore: inStore, isCampaign: isCampaign);
//               }
//             },
//             radius: Dimensions.radiusDefault,
//             padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.all(fromCartSuggestion ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall) : const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
//             child: TextHover(
//               builder: (hovered) {
//                 return Column(mainAxisAlignment: MainAxisAlignment.center, children: [

//                   Expanded(child: Padding(
//                     padding: EdgeInsets.symmetric(vertical: desktop ? 0 : Dimensions.paddingSizeExtraSmall),
//                     child: Row(children: [

//                       Stack(children: [
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                           child: CustomImage(
//                             isHovered: hovered,
//                             image: '${isStore ? store != null ? store!.logoFullUrl : '' : item!.imageFullUrl}',
//                             height: imageHeight ?? (desktop ? 120 : length == null ? 100 : 90), width: imageWidth ?? (desktop ? 120 : 90), fit: BoxFit.cover,
//                           ),
//                         ),

//                         (isStore || isCornerTag!) ? DiscountTag(
//                           discount: discount, discountType: discountType,
//                           freeDelivery: isStore ? store!.freeDelivery : false,
//                         ) : const SizedBox(),

//                         !isStore ? OrganicTag(item: item!, placeInImage: true) : const SizedBox(),

//                         isAvailable ? const SizedBox() : NotAvailableWidget(isStore: isStore),

//                         Positioned(
//                           top: 5, left: 5,
//                           child: GetBuilder<FavouriteController>(builder: (favouriteController) {
//                             bool isWished = isStore ? favouriteController.wishStoreIdList.contains(store!.id) : favouriteController.wishItemIdList.contains(item!.id);
//                             return CustomFavouriteWidget(
//                               isWished: isWished,
//                               isStore: isStore,
//                               store: store,
//                               item: item,
//                             );
//                           }),
//                         ),
//                       ]),
//                       const SizedBox(width: Dimensions.paddingSizeSmall),

//                       Expanded(
//                         child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.start, children: [

//                           Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//                             Flexible(
//                               child: Text(
//                                 isStore ? store!.name! : item!.name!,
//                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
//                                 maxLines: 1, overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             (!isStore && Get.find<SplashController>().configModel!.moduleConfig!.module!.vegNonVeg! && Get.find<SplashController>().configModel!.toggleVegNonVeg!)
//                                 ? Image.asset(item != null && item!.veg == 0 ? Images.nonVegImage : Images.vegImage,
//                                 height: 10, width: 10, fit: BoxFit.contain) : const SizedBox(),

//                             (Get.find<SplashController>().configModel!.moduleConfig!.module!.unit! && item != null && item!.unitType != null) ? Text(
//                               '(${ item!.unitType ?? ''})',
//                               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: Theme.of(context).hintColor),
//                             ) : const SizedBox(),

//                             SizedBox(width: item!.isStoreHalalActive! && item!.isHalalItem! ? Dimensions.paddingSizeExtraSmall : 0),

//                             !isStore && item!.isStoreHalalActive! && item!.isHalalItem! ? const CustomAssetImageWidget(
//                                 Images.halalTag, height: 13, width: 13) : const SizedBox(),

//                             SizedBox(width: ResponsiveHelper.isDesktop(context) ? 20 : 0),
//                           ]),
//                           const SizedBox(height: 3),

//                           (isStore ? store!.address != null : item!.storeName != null) ? Text(
//                             isStore ? store!.address ?? '' : item!.storeName ?? '',
//                             style: robotoRegular.copyWith(
//                               fontSize: Dimensions.fontSizeExtraSmall,
//                               color: Theme.of(context).disabledColor,
//                             ),
//                             maxLines: 1, overflow: TextOverflow.ellipsis,
//                           ) : const SizedBox(),

//                           (genericName.isNotEmpty) ? Flexible(
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 5.0),
//                               child: Text(
//                                 genericName,
//                                 style: robotoMedium.copyWith(
//                                   fontSize: Dimensions.fontSizeSmall,
//                                   color: Theme.of(context).disabledColor,
//                                 ),
//                                 maxLines: 1, overflow: TextOverflow.ellipsis,
//                               ),
//                             ),
//                           ) : const SizedBox(),
//                           SizedBox(height: ((desktop || isStore) && (isStore ? store!.address != null : item!.storeName != null)) ? 3 : 3),

//                           !isStore && (item!.ratingCount! > 0) ? Row(children: [

//                             Icon(Icons.star, size: 16, color: Theme.of(context).primaryColor),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               item!.avgRating!.toStringAsFixed(1),
//                               style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               '(${item!.ratingCount})',
//                               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
//                             ),

//                           ]) : const SizedBox(),

//                           SizedBox(height: (!isStore && desktop) || (!isStore && (item!.ratingCount! > 0)) ? 3 : 0),

//                           isStore && (store != null && store!.ratingCount! > 0) ? Row(children: [

//                             Icon(Icons.star, size: 16, color: Theme.of(context).primaryColor),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               store!.avgRating!.toStringAsFixed(1),
//                               style: robotoMedium,
//                             ),
//                             const SizedBox(width: Dimensions.paddingSizeExtraSmall),

//                             Text(
//                               '(${store!.ratingCount})',
//                               style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).hintColor),
//                             ),

//                           ]) : Row(children: [
//                             Text(
//                               PriceConverter.convertPrice(item!.price, discount: discount, discountType: discountType),
//                               style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall), textDirection: TextDirection.ltr,
//                             ),
//                             SizedBox(width: discount! > 0 ? Dimensions.paddingSizeExtraSmall : 0),

//                             discount > 0 ? Text(
//                               PriceConverter.convertPrice(item!.price),
//                               style: robotoMedium.copyWith(
//                                 fontSize: Dimensions.fontSizeExtraSmall,
//                                 color: Theme.of(context).disabledColor,
//                                 decoration: TextDecoration.lineThrough,
//                               ), textDirection: TextDirection.ltr,
//                             ) : const SizedBox(),
//                           ]),

//                         ]),
//                       ),

//                       Column(mainAxisAlignment: isStore ? MainAxisAlignment.center : MainAxisAlignment.spaceBetween, children: [

//                         const SizedBox(),

//                         CartCountView(
//                           item: item!,
//                           index: index,
//                         ),

//                       ]),

//                     ]),
//                   )),

//                 ]);
//               }
//             ),
//           ),
//         ),

//         (!isStore && isCornerTag! == false) ? Positioned(
//           right: ltr ? 0 : null, left: ltr ? null : 0,
//           child: CornerDiscountTag(
//             bannerPosition: ltr ? CornerBannerPosition.topRight : CornerBannerPosition.topLeft,
//             elevation: 0,
//             discount: discount, discountType: discountType,
//             freeDelivery: isStore ? store!.freeDelivery : false,
//         )) : const SizedBox(),

//       ],
//     );
//   }
// }


class ItemWidget extends StatefulWidget {
  final Item? item;
  final Item? singleitem;
  final Store? store;
  final bool isStore;
  final bool Recomended;
  final int index;
  final int? length;
  final bool inStore;
    final bool notinStore;
  final bool isCampaign;
  final bool isFeatured;
  final bool fromCartSuggestion;
  final double? imageHeight;
  final double? imageWidth;
  final bool? isCornerTag;

  const ItemWidget({
    super.key,
    required this.item,
    required this.isStore,
    required this.store,
    required this.index,
    required this.length,
    this.inStore = false,
    this.isCampaign = false,
    this.isFeatured = false,
    this.fromCartSuggestion = false,
    this.imageHeight,
    this.imageWidth,
    this.notinStore = false,
    this.isCornerTag = false,
    this.singleitem,
      this.Recomended = false,
  });

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<ItemWidget> {
  final itemController = Get.find<ItemController>();
  bool _isAdded = false; 
  bool _isAdding = false; 
  bool _showFullDescription = false;

  @override
  Widget build(BuildContext context) {
    final bool ltr = Get.find<LocalizationController>().isLtr;
    bool desktop = ResponsiveHelper.isDesktop(context);
    double? discount;
    String? discountType;
    bool isAvailable;
    bool customizable;
    bool itemAvailable;
    if (widget.isStore && widget.store != null) {
      discount = widget.store!.discount?.discount ?? 0;
      discountType = widget.store!.discount?.discountType ?? 'percent';
      isAvailable = widget.store!.open == 1 && widget.store!.active == true;
        customizable = false;
    } else if (widget.item != null) {
      discount = (widget.item!.storeDiscount == 0 || widget.isCampaign)
          ? widget.item!.discount
          : widget.item!.storeDiscount;
      discountType = (widget.item!.storeDiscount == 0 || widget.isCampaign)
          ? widget.item!.discountType
          : 'percent';
      isAvailable = DateConverter.isAvailable(
          widget.item!.availableTimeStarts, widget.item!.availableTimeEnds);

           customizable = widget.item!.foodVariations!.isEmpty;
    } else {
      discount = 0;
      discountType = 'percent';
      isAvailable = false;
      customizable = false;
    }

  String startTime = DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(widget.item!.availableTimeStarts.toString()));
  String EndTime = DateFormat('hh:mm a').format(DateFormat('HH:mm').parse(widget.item!.availableTimeEnds.toString()));

   itemAvailable = DateConverter.isAvailable(widget.item!.availableTimeStarts, widget.item!.availableTimeEnds);

  print("Item Available: $itemAvailable  ${widget.item!.availableTimeStarts} - ${widget.item!.availableTimeEnds}");
return Container(
  height: 190,
  decoration:  BoxDecoration(
    color: Colors.white,
  
  borderRadius:  BorderRadius.all( 
    Radius.circular(
      Dimensions.radiusDefault
    )
   ) 
  ),
  child: Padding(
    padding:  EdgeInsets.only(top:widget.Recomended ? 5 : 0),
    
    child: Stack(
      children: [
     
        SizedBox(
          height:  _showFullDescription ? 220 : 200,
          child: CustomInkWell(
    
            onTap: () {
               Get.find<ItemController>().navigateToItemPage(widget.item, context);
            },
            
            radius: Dimensions.radiusDefault,
            padding: desktop
                ? const EdgeInsets.all(Dimensions.paddingSizeSmall)
                : const EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeSmall,
                    vertical: Dimensions.paddingSizeExtraSmall,
                  ),
            child: Stack(
              children: [
              //  isAvailable ? const SizedBox() : Positioned(
              //   right: 0,
              //   top: 0,
              //    child: Container(
              //     height: 200,
              //     width: 200,
              //     child: NotAvailableWidget(isStore: widget.isStore)),
              //  ),
                Align(
                 alignment: Alignment.topRight,
                  child: Padding(
                 padding: widget.Recomended ? EdgeInsets.only(top: 10) : EdgeInsets.all(0),
                    child: ClipRRect(
                      
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      child: Stack(
                        children: [
                        
                          Stack(
                            children: [
                              CustomImage(
                                // fromstore: true,
                                image: widget.isStore
                                    ? widget.store?.logoFullUrl ??
                                        'assets/images/placeholder.png'
                                    : widget.item?.imageFullUrl ??
                                        'assets/images/placeholder.png',
                                height: widget.imageHeight ?? (desktop ?  120 : 145),
                                width: widget.imageWidth ?? (desktop ? 200 :  145),
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                          
                        
                            !customizable ||  isAvailable   ?  const SizedBox() :     Padding(
                              padding: widget.Recomended ? EdgeInsets.only(top: 0) : EdgeInsets.all(0),
                              child: Container(
                                height: widget.imageHeight ?? (desktop ? 120 : 145),
                              width: widget.imageWidth ?? (desktop ? 200 : 145),
                              color: Colors.black.withOpacity(.5),
                              child: Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                  !itemAvailable ? 'Not Available' :    !isAvailable ? 'Not Available' : 'Customizable',
                                      style: robotoRegular.copyWith(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                              
                                       !isAvailable ?     Text(
                                      'available@ $startTime - $EndTime',
                                      style: robotoRegular.copyWith(
                                        fontSize: 8,
                                        color: Colors.white,
                                        
                                      ),
                                      textAlign: TextAlign.center,
                                    ) : SizedBox(),
                                  ],
                                ),
                              ),
                                                      ),
                            )  ,
                        
                          // isAvailable ? const SizedBox() :  Container(
                          //     height: widget.imageHeight ?? (desktop ? 120 :  widget.Recomended ? 120 : 145),
                          //   width: widget.imageWidth ?? (desktop ? 200 :  widget.Recomended ? 120 : 145),
                          //   color: Colors.black.withOpacity(.6),
                          //   child: Center(
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                        
                          //         Text(
                          //           'Not Available',
                          //           style: robotoRegular.copyWith(
                          //             fontSize: 12,
                          //             color: Colors.white,
                                      
                          //           ),
                          //           textAlign: TextAlign.center,
                          //         ),
                          //         Text(
                          //           'available@ $startTime - $EndTime',
                          //           style: robotoRegular.copyWith(
                          //             fontSize: 8,
                          //             color: Colors.white,
                                      
                          //           ),
                          //           textAlign: TextAlign.center,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                       
                       
                        ],
                      ),
                    ),
                  ),
                ),
                      //  const SizedBox( height: 5,),
                          Positioned(
                            right: 26,
                            bottom: 5,
                            child: !customizable ?   Text("Customizable", style: TextStyle(
                              color: Theme.of(context).disabledColor,
                              fontSize: widget.Recomended ? 10 : 12,
                              fontWeight: FontWeight.w600
                            )) : const SizedBox(),
                          ),
            
                Align(
                 alignment: Alignment.topLeft,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width:   MediaQuery.of(context).size.width/2.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Veg/Non-Veg Icon
                          if (!widget.isStore &&
                              Get.find<SplashController>()
                                      .configModel
                                      ?.moduleConfig
                                      ?.module
                                      ?.vegNonVeg == true &&
                              Get.find<SplashController>()
                                      .configModel
                                      ?.toggleVegNonVeg == true &&
                              widget.item != null)
                            Align(
                              alignment: Alignment.topLeft,
                              child: Image.asset(
                                widget.item!.veg == 0
                                    ? Images.nonVegImage
                                    : Images.vegImage,
                                height:  15,
                                width: 15,
                                fit: BoxFit.contain,
                              ),
                            ),
                          const SizedBox(height: 5),
                      
                          // Item Name
                           Text(
                             widget.isStore
                                 ? widget.store?.name ?? ''.toString()
                                 : "${widget.item?.name}${itemAvailable ? '' : ' (Not Available)'}"  ?? ''.toString(),
                             style: robotoMedium.copyWith(
                               fontSize:  Dimensions.fontSizeLarge,
                               fontWeight: FontWeight.w600
    
                             ), 
                           
                                                
                             maxLines: 3,
                             overflow: TextOverflow.ellipsis,
                             
                           ),
                        widget.notinStore ? const SizedBox() :   Text(
                            //  widget.isStore
                                  // widget.store?.name ?? ''.toString(),
                                  widget.item?.storeName ?? ''.toString(),
                             style: robotoMedium.copyWith(
                               fontSize: Dimensions.fontSizeDefault,
                               fontWeight: FontWeight.w500,
                               color: Theme.of(context).disabledColor,
                             ), 
                           
                                                
                             maxLines: 3,
                             overflow: TextOverflow.ellipsis,
                             
                           ),
                          const SizedBox(height: 5),
                      
                          // Item Price
                          Row(
                            children: [
                              Text(
                                PriceConverter.convertPrice(
                                  _getPrice(widget.item),
                                  discount: discount,
                                  discountType: discountType,
                                  currency: widget.item?.currency?.currencyCode 
                                ),
                                style: robotoMedium.copyWith(
                                  fontSize: Dimensions.fontSizeDefault,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                               const SizedBox(width: 8,),
                                if (discount! > 0  && customizable )
                            Text(
                              PriceConverter.convertPrice(widget.item?.price,currency: widget.item?.currency?.currencyCode ),
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: Theme.of(context).disabledColor,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            ],
                          ),
                        
                          const SizedBox(height: 5),
                      
                          // // Rating Section
                          // if (!widget.isStore &&
                          //     widget.item?.ratingCount != null &&
                          //     widget.item!.ratingCount! > 0)
                          //   Align(
                          //     alignment: Alignment.topLeft,
                          //     child: Row(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         SvgPicture.asset(
                          //           Images.foodratingstar,
                          //           height: 16,
                          //           width: 16,
                          //           fit: BoxFit.contain,
                          //         ),
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeExtraSmall),
                          //         Text(
                          //           widget.item!.avgRating!.toStringAsFixed(1),
                          //           style: robotoMedium.copyWith(
                          //               fontSize: Dimensions.fontSizeSmall),
                          //         ),
                          //         const SizedBox(
                          //             width: Dimensions.paddingSizeExtraSmall),
                          //         Text(
                          //           '(${widget.item!.ratingCount})',
                          //           style: robotoRegular.copyWith(
                          //             fontSize: Dimensions.fontSizeSmall,
                          //             color: Theme.of(context).hintColor,
                          //           ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                      
                             GetBuilder<FavouriteController>(
                                builder: (favouriteController) {
                                  bool isWished =
                                      favouriteController.wishStoreIdList.contains(
                                         widget.item!.id);
                                return InkWell(
                                  splashColor: Colors.transparent,
    
                                  onTap: () {
                                      if (AuthHelper.isLoggedIn()) {
                                        isWished
                                            ? favouriteController
                                                .removeFromFavouriteList(widget.item!.id, true)
                                            : favouriteController.addToFavouriteList(
                                                null, widget.item!.id, true);
                                      } else {
                                        showCustomSnackBar(
                                            'you_are_not_logged_in'.tr);
                                      }
                                  },
                                  child: Container(
                                    width:   
                                    isWished ? widget.Recomended ? 110 :  105 : widget.Recomended ? 130 : 130,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      // color:  Color(0xFFE5BFFF),
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(
                                        width: .2,
                                        color: Colors.grey
                                      )
                                    ),
                                    child:  Padding(
                                      padding:   EdgeInsets.all ( widget.Recomended ? 4: 8 ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center ,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(isWished ?  Icons.bookmark_outlined :Icons.bookmark_border_outlined , color: isWished ? Colors.red : Colors.red, size:widget.Recomended ? 16 :  15),
                                           SizedBox(width: widget.Recomended ?  2 : 3,),
                                          Text(isWished ? "In 'Collection'" : "Add to Collection", style:  TextStyle(color: Colors.black, fontSize:  widget.Recomended ? 11 : 10),)
                                        ],
                                        
                                      ),
                                    ) ,
                                  ),
                                );
                              }
                            ),
                       
                           const SizedBox(height: 10,),
                             Flexible(
                               child: Text( widget.item!.description ?? "" ,style: const TextStyle(
                                color: Colors.grey,
                                
                               ),
                                 maxLines: 
                                  widget.Recomended ? 1 :  2,
                                  
                               overflow: TextOverflow.ellipsis,),
                             )
                                   
                            // AutoScrollDescription (description: widget.item!.description ?? "", recommended: widget.Recomended,)
                            //  Flexible(
                            //   child: Column(
                            //     crossAxisAlignment: CrossAxisAlignment.start,
                            //     children: [
                            //       Text(
                            //         widget.item!.description ?? "",
                            //         style: const TextStyle(color: Colors.grey),
                            //         maxLines: _showFullDescription ? 5 : 2,
                            //         overflow: _showFullDescription ? null : TextOverflow.ellipsis,
                            //       ),
                            //       // if (widget.item!.description != null && widget.item!.description!.isNotEmpty && !_showFullDescription)
                            //             if ( widget.item!.description!.length > 200)
                            //         TextButton(
                            //           onPressed: () {
                            //             setState(() {
                            //               _showFullDescription = true;
                            //             });
                            //           },
                            //           child:  Text( _showFullDescription ? "Show less" : "Read More", style: TextStyle(color: Colors.blue)),
                            //         ),
                            //     ],
                            //   ),
                            // )
                        ],
                      ),
                    ),
                  ),
                ),
      

              isAvailable ?   Positioned(
                               bottom:   !customizable ? widget.Recomended ? 0 : 25 :  widget.Recomended ? 5 :   20,
                      right: widget.Recomended  ? 15 : widget.Recomended ? 15 : 17,
                  child: CartCountView(item: widget.item!, index: widget.index)) : const SizedBox(),
                // Positioned: Add to Cart Button (Bottom Right)
                //  GetBuilder<CartController>(
                //             builder: (cartController) {
                //                 int cartIndex = cartController.cartList.indexWhere(
                //                   (cartItem) => cartItem.item?.id == widget.item?.id);
                //               bool isAdded = cartIndex != -1;
                              
                //     return !isAvailable ? const SizedBox()  :  Positioned(
                //       bottom:   !customizable ? widget.Recomended ? 0 : 10 :  widget.Recomended ? 15 :   25,
                //       right: widget.Recomended && isAdded  ? 10 : widget.Recomended ? 15 : 17,
                //       child: Column(
                //         children: [
                //           GetBuilder<CartController>(
                //             builder: (cartController) {
                            
                          
                //               return isAdded
                //                   ? Container(
                //                       width: widget.Recomended ? 102 :  110,
                //                       height: widget.Recomended ? 30 : 40,
                //                       decoration: BoxDecoration(
                //                         color: Colors.white,
                //                         borderRadius: BorderRadius.circular(10),
                //                         boxShadow: [
                //                           BoxShadow(
                //                             color: Colors.grey.withOpacity(0.2),
                //                             spreadRadius: 2,
                //                             blurRadius: 5,
                //                           ),
                //                         ],
                //                       ),
                //                       child: Row(
                //                         crossAxisAlignment: CrossAxisAlignment.center,
                //                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                         children: [
                //                      IconButton(
                //                             onPressed: () {
                //                               if (cartController
                //                                       .cartList[cartIndex].quantity ==
                //                                   1) {
                //                                 cartController!.removeFromCart(
                //                                     cartIndex, item: widget.item);
                //                               } else {
                //                                 cartController.setQuantity(
                //                                     false, cartIndex, widget.item!.stock, 50);
                //                               }
                //                             },
                //                             icon:  Icon(Icons.remove,color: Colors.green ,size: widget.Recomended ? 18 : 25,),
                //                           ),
                                    
                          
                //                             Text(
                //                             "${cartController.cartList[cartIndex].quantity ?? 1}",
                //                             style:  TextStyle(
                //                               color: Colors.green,
                //                               fontSize: widget.Recomended ? 15 : 18,
                //                                fontWeight: FontWeight.w600
                //                             ),
                //                           ),
                //                        IconButton(
                //                             onPressed: () {
                //                               widget.item!.variations!.isEmpty
                //                                   ? cartController.setQuantity(
                //                                       true, cartIndex, widget.item!.stock, 50)
                //                                   : Get.find<ItemController>()
                //                                       .navigateToItemPage(widget.item, context,
                //                                           inStore: widget.inStore,
                //                                           isCampaign: widget.isCampaign);
                //                             },
                //                             icon:  Icon(Icons.add, color: Colors.green,size: widget.Recomended ? 18 : 25,),
                //                           ),
                                       
                //                         ],
                //                       ),
                //                     )
                //                   : widget.item!.foodVariations!.isEmpty
                //                       ? InkWell(
                //                           onTap: () async {
                //                             setState(() {
                //                               _isAdding = true;
                //                             });
                          
                //                             // Add item to cart
                //                             OnlineCart onlineCart = OnlineCart(
                //                                   widget.item?.id,
                //                                   widget.isCampaign
                //                                       ? null
                //                                       : widget.item!.id,
                //                                   widget.isCampaign
                //                                       ? widget.item!.id
                //                                       : null,
                //                                   widget.item!.price.toString(),
                //                                   '',
                //                                   null,
                //                                   ModuleHelper.getModuleConfig(
                //                                               widget.item!.moduleType)
                //                                           .newVariation!
                //                                       ? []
                //                                       : null,
                //                                   1,
                //                                   [],
                //                                   [],
                //                                   [],
                //                                   'Item',
                //                                 );
                          
                //                             if (cartController!.existAnotherStoreItem(
                //                                 widget.item!.storeId,
                //                                 Get.find<SplashController>().module?.id)) {
                //                               // Show reset confirmation
                //                               Get.dialog(
                //                                   ConfirmationDialog(
                //                                     // icon: Images.warning,
                //                                     title: 'Replace Cart Item?',
                //                                     description:
                //                                         'Your Cart contains items from  another store.Do you want to discard selection?',
                //                                     onYesPressed: () async {
                //                                       Get.back();
                //                                       await cartController!
                //                                           .clearCartOnline()
                //                                           .then((success) async {
                //                                         if (success) {
                //                                           await cartController
                //                                               .addToCartOnline(onlineCart);
                //                                           setState(() {
                //                                             _isAdded = true;
                //                                             _isAdding = false;
                //                                           });
                //                                         }
                //                                       });
                //                                     },
                          
                //                                     onNoPressed: () async {
                //                                       _isAdded = false;
                //                                             _isAdding = true;
                //                                                Get.back();
                //                                     },
                //                                   ),
                //                                   barrierDismissible: false);
                //                             } else {
                //                               await cartController
                //                                   .addnewsingleitem(onlineCart)
                //                                   .then((success) {
                //                                 if (success) {
                //                                   setState(() {
                //                                     _isAdded = true;
                //                                     _isAdding = false;
                //                                   });
                //                                 } else {
                //                                   setState(() {
                //                                     _isAdding = false;
                //                                   });
                //                                 }
                //                               });
                //                             }
                //                           },
                //                           child:  Container(
                //                             width: widget.Recomended ? 90 : 110,
                //                             height: widget.Recomended ? 30 : 40,
                //                             margin: const EdgeInsets.all(0),
                //                             decoration: BoxDecoration(
                //                               color: Colors.white,
                //                               borderRadius: BorderRadius.circular(10),
                //                               boxShadow: [
                //                                 BoxShadow(
                //                                   color: Colors.grey.withOpacity(0.2),
                //                                   spreadRadius: 2,
                //                                   blurRadius: 5,
                //                                 ),
                //                               ],
                //                             ),
                //                             child: Center(
                //                               child: _isAdding
                //                                   ?
                                                  
                //                               //      Row(
                //                               //       crossAxisAlignment: CrossAxisAlignment.center ,
                //                               //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                               //       children: [
                //                               //         IconButton(
                //                               //           onPressed: () {},
                //                               //           icon:  Icon(Icons.remove, color: Colors.green, size: widget.Recomended ? 18 : 25,)),
                //                               //          Text("1", style: TextStyle(
                //                               //           color: Colors.green,
                //                               // fontSize: widget.Recomended ? 15 : 18,
                //                               //  fontWeight: FontWeight.w600
                //                               //         )),
                //                               //         IconButton( onPressed: () {},
                //                               //           icon: Icon(Icons.add, color: Colors.green, size: widget.Recomended ? 18 : 25,)),
                //                               //       ],
                //                               //     )

                //                                 SizedBox(
                //                                   height: 20,
                //                                   width: 20,
                //                                   child: CircularProgressIndicator(color: Colors.green))
                //                                   :  Text("ADD", style: TextStyle(
                //                                     color: Colors.green,
                //                                     fontSize: widget.Recomended ? 15 : 18,
                //                                      fontWeight: FontWeight.w600
                //                                     ),),
                //                             ),
                //                           ),
                //                         )
                //                       : InkWell(
                //                           onTap: () {
                //                             Get.find<ItemController>().navigateToItemPage(
                //                                 widget.item, context,
                //                                 inStore: widget.inStore,
                //                                 isCampaign: widget.isCampaign);
                //                           },
                //                           child: Container(
                //                             width: widget.Recomended ? 90 : 110,
                //                             height: widget.Recomended ? 30 : 40,
                //                             margin: const EdgeInsets.all(0),
                //                             decoration: BoxDecoration(
                //                               color: Colors.white,
                //                               borderRadius: BorderRadius.circular(10),
                //                               boxShadow: [
                //                                 BoxShadow(
                //                                   color: Colors.grey.withOpacity(0.2),
                //                                   spreadRadius: 2,
                //                                   blurRadius: 5,
                //                                 ),
                //                               ],
                //                             ),
                //                             child:  Center(
                //                               child: Text("ADD" , style: TextStyle(
                //                                 color: Colors.green,
                //                                     fontSize: widget.Recomended ? 16 : 18,
                //                                      fontWeight: FontWeight.w600
                //                               )),
                //                             ),
                //                           ),
                //                         );
                //             },
                //           ),
                    
                //           const SizedBox( height: 5,),
                //           !customizable ?   Text("Customizable", style: TextStyle(
                //             color: Theme.of(context).disabledColor,
                //             fontSize: widget.Recomended ? 10 : 12,
                //             fontWeight: FontWeight.w600
                //           )) : const SizedBox(),
                //         ],
                //       ),
                //     );
                //   }
                // ),
           
           
             ],
            ),
          ),
        ),
      ],
    ),
  ),
);

  }

  double _getPrice(Item? item) {
  if (item?.foodVariations != null && item!.foodVariations!.isNotEmpty) {
    // Filter out variants with null prices and find the lowest valid price
    var validPrices = item.foodVariations!
        .expand((foodVariation) => foodVariation.variationValues ?? [])
        .map((variationValue) => variationValue.optionPrice ?? double.infinity) // Use infinity for invalid prices
        .where((price) => price != double.infinity) // Keep only valid prices
        .toList();

    if (validPrices.isNotEmpty) {
      return validPrices.reduce((a, b) => a < b ? a : b);
    }
  }
  // If no variations or all are invalid, return the base price
  return item?.price ?? 0;
}




}












class AutoScrollDescription extends StatefulWidget {
  final String description;
  final bool recommended;

  const AutoScrollDescription({
    Key? key,
    required this.description,
    required this.recommended,
  }) : super(key: key);

  @override
  _AutoScrollDescriptionState createState() => _AutoScrollDescriptionState();
}

class _AutoScrollDescriptionState extends State<AutoScrollDescription> {
  late final ScrollController _scrollController;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() async {
    // Auto-scroll delay for smooth scrolling
    const scrollDelay = Duration(seconds: 1);
    const scrollSpeed = Duration(milliseconds: 100);

    while (mounted && !_isScrolling) {
      setState(() {
        _isScrolling = true;
      });

      await Future.delayed(scrollDelay);

      if (_scrollController.hasClients) {
        double maxScrollExtent = _scrollController.position.maxScrollExtent;
        while (_scrollController.offset < maxScrollExtent && mounted) {
          await Future.delayed(scrollSpeed);
          _scrollController.jumpTo(
            _scrollController.offset + 2, // Adjust speed as needed
          );
        }

        // Scroll back to top after reaching the end
        await Future.delayed(scrollDelay);
        if (mounted) _scrollController.jumpTo(0);
      }

      setState(() {
        _isScrolling = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SingleChildScrollView(
        controller: _scrollController,
        scrollDirection: Axis.vertical,
        child: Text(
          widget.description,
          style: const TextStyle(
            color: Colors.grey,
          ),
          maxLines: widget.recommended ? 1 : 2, // Optional for `recommended`
          overflow: widget.recommended ? TextOverflow.ellipsis : null,
        ),
      ),
    );
  }
}
