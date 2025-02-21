import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/hover/text_hover.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/discount_tag.dart';
import 'package:sixam_mart/common/widgets/new_tag.dart';
import 'package:sixam_mart/common/widgets/not_available_widget.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';

class StoreCardWithDistance extends StatefulWidget {
  final Store store;
  final bool fromAllStore;
  final bool? isNewStore; 
  final bool? fromTopOffers;
   final bool? fromitemsview;

  const StoreCardWithDistance({
    Key? key,
    required this.store,
    this.fromAllStore = false,
    this.isNewStore = false,
    this.fromTopOffers = false, this.fromitemsview = false,
  }) : super(key: key);

  @override
  _StoreCardWithDistanceState createState() => _StoreCardWithDistanceState();
}

class _StoreCardWithDistanceState extends State<StoreCardWithDistance> {
  final splashController = Get.find<SplashController>();
  final storeController = Get.find<StoreController>();
  final favouriteController = Get.find<FavouriteController>();
  bool isWished = false;

  @override
  void initState() {
    super.initState();
    isWished = favouriteController.wishStoreIdList.contains(widget.store.id);
  }

  @override
  Widget build(BuildContext context) {
    double distance = (widget.store.distance! / 1000);
    double discount = widget.store.discount?.discount ?? 0;
    String discountType = widget.store.discount?.discountType ?? '';
    String currencySymbol = splashController.configModel!.currencySymbol!;
    bool isRightSide = splashController.configModel!.currencySymbolDirection == 'right';

    return Container(
      width: widget.fromAllStore ? double.infinity : 150,
      height: 300,
      // decoration: BoxDecoration(
      //   color: Theme.of(context).cardColor,
      //   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      //   boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
      // ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            RouteHelper.getStoreRoute(id: widget.store.id, page: 'store'),
            arguments: StoreScreen(store: widget.store, fromModule: false),
          );
        },
        child: Column(
          children: [
            _buildStoreImage(context, discount, discountType, currencySymbol, isRightSide),
            _buildStoreDetails(context, distance, discount, discountType, currencySymbol, isRightSide),
          ],
        ),
      ),
    );
  }

  Widget _buildStoreImage(BuildContext context, double discount, String discountType, String currencySymbol, bool isRightSide) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(Dimensions.radiusDefault+ 8),
            topRight: Radius.circular(Dimensions.radiusDefault +8),
            bottomLeft: Radius.circular(Dimensions.radiusDefault + 8),
            bottomRight: Radius.circular(Dimensions.radiusDefault + 8),
          ),
          child: CustomImage(
            image: '${widget.store.coverPhotoFullUrl}',
            fit: BoxFit.cover,
            height: 170,
            width: double.infinity,

          ),
        ),
        if (discount > 0)
        DiscountTag(discount: discount, discountType: discountType,fromTop: 85, currency:widget.store?.currency?.currencySymbol,),
          // Positioned( 
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: 2),
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusDefault)),
          //       color: Theme.of(context).colorScheme.error.withOpacity(0.8),
          //     ),
          //     child: Text(
          //       '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} off',
          //       style: robotoMedium.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall),
          //       textAlign: TextAlign.center,
          //     ),
          //   ),
          // ),
        Positioned(
          top: 15,
          right: 15,
          child: GestureDetector(
            onTap: () {
              if (AuthHelper.isLoggedIn()) {
                setState(() {
                  isWished = !isWished;
                  isWished ? favouriteController.addToFavouriteList(null, widget.store.id, true) : favouriteController.removeFromFavouriteList(widget.store.id, true);
                });
              } else {
                showCustomSnackBar('you_are_not_logged_in'.tr);
              }
            },
            child: Icon(
              isWished ? Icons.favorite : Icons.favorite_border,
              size: 20,
              color: Colors.red,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStoreDetails(BuildContext context , double distance, double discount, String discountType, String currencySymbol, bool isRightSide) {
    return Padding(
      padding: const EdgeInsets.only(left: 0,right: 0,top: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.store.name ?? '',
            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge,fontWeight: FontWeight.w600 ,color: widget.fromitemsview! ? Colors.white : Colors.black),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 1),

          
                             Row(children: [
                         Row(children: [
                      const Icon(Icons.stars_rounded, size: 20, color: Color(0xFF085B42)),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  
                      Text(
                       widget.store!.avgRating!.toStringAsFixed(1),
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600,color: widget.fromitemsview! ? Colors.white : Colors.black),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  
                    
                    ]),
                                    
                        
                        // const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                  
                        Text(
                          '${ widget.store!.deliveryTime}',
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600,color: widget.fromitemsview! ? Colors.white : Colors.black),
                        ),
                      ]),
                  
        
          Row(
            children: [
              // Icon(Icons.location_on_outlined, color: Theme.of(context).primaryColor, size: 15),
              // const SizedBox(width: Dimensions.paddingSizeExtraSmall),
              // Expanded(
              //   child: Text(
              //     widget.store.address ?? '',
              //     style: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
              //     maxLines: 1,
              //     overflow: TextOverflow.ellipsis,
              //   ),
              // ),

              // Text(
              //   '${distance > 100 ? '100+' : distance.toStringAsFixed(2)} km',
              //   style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
              // ),
       
                      
                Expanded(
                  child: RichText(
                    maxLines: 1,
                                 overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              children: [
                                TextSpan(
                  text: widget.store.address ?? '',
                  style: robotoRegular.copyWith(color: Colors.grey[600], fontSize: Dimensions.fontSizeDefault,fontWeight: FontWeight.w500 ),
                                //     maxLines: 1,
                                //     overflow: TextOverflow.ellipsis,,
                                ),
                                TextSpan(
                  text: '  ', // Space between address and distance
                                ),
                                TextSpan(
                  text: '${distance > 100 ? '100+' : distance.toStringAsFixed(2)} km',
                  style: robotoRegular.copyWith(
                    color:Colors.grey[600],
                    fontSize: Dimensions.fontSizeDefault,
                    fontWeight: FontWeight.w500
                  ),
                                ),
                              ],
                            )),
                )
            ],
          ),
          const SizedBox(height: Dimensions.paddingSizeExtraSmall),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       '${distance > 100 ? '100+' : distance.toStringAsFixed(2)} km from you',
          //       style: robotoRegular.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
          //     ),
          //     // CustomButton(
          //     //   height: 30,
          //     //   width: 65,
          //     //   radius: Dimensions.radiusSmall,
          //     //   onPressed: () {
          //     //     Get.toNamed(
          //     //       RouteHelper.getStoreRoute(id: widget.store.id, page: 'store'),
          //     //       arguments: StoreScreen(store: widget.store, fromModule: false),
          //     //     );
          //     //   },
          //     //   buttonText: 'Visit',
          //     //   color: Theme.of(context).primaryColor,
          //     //   textColor: Theme.of(context).cardColor,
          //     //   fontSize: Dimensions.fontSizeSmall,
          //     // ),
          //   ],
          // ),
       
       
        ],
      ),
    );
  }
}