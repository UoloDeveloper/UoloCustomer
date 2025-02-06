import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';

class Fashionstorecard extends StatefulWidget {
  final Store store;
  final bool fromAllStore;
  final bool? isNewStore;
  final bool? fromTopOffers;

  const Fashionstorecard({
    Key? key,
    required this.store,
    this.fromAllStore = false,
    this.isNewStore = false,
    this.fromTopOffers = false,
  }) : super(key: key);

  @override
  _FashionstorecardState createState() => _FashionstorecardState();
}

class _FashionstorecardState extends State<Fashionstorecard> {
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
    double discount = widget.store.discount?.discount ?? 0;
    String discountType = widget.store.discount?.discountType ?? '';
    String currencySymbol = splashController.configModel!.currencySymbol!;
    bool isRightSide = splashController.configModel!.currencySymbolDirection == 'right';

    return Container(
      width: widget.fromAllStore ? double.infinity : 180,
      height: 240,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            RouteHelper.getStoreRoute(id: widget.store.id, page: 'store'),
            arguments: StoreScreen(store: widget.store, fromModule: false),
          );
        },
        child:
        //  Stack(
        //   // crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     // Store Image with Discount and Wishlist Icon
        //     _buildStoreImage(context, discount, discountType, currencySymbol, isRightSide),
        //     // Store Details
        //     // _buildStoreDetails(context),

        //     Expanded(
        //       child: Container(
        //         height: 240,
        //         decoration: BoxDecoration(
        //           color: Colors.white.withRed(
                    
        //           ),
        //           borderRadius: BorderRadius.circular(16),
        //           boxShadow: [
        //             BoxShadow(
        //               color: Colors.black.withOpacity(0.1),
        //               blurRadius: 10,
        //               spreadRadius: 2,
        //             ),
        //           ],
        //         ),
              
        //         child: Center(child: Text("${widget.store.name}",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),)),
        //       ),
        //     )
        //   ],
        // ),
     Stack(
  children: [
    // Store Image with Discount and Wishlist Icon
    _buildStoreImage(context, discount, discountType, currencySymbol, isRightSide),
    // Store Details
    // _buildStoreDetails(context),

    Container(
      height: 240,
      decoration: BoxDecoration(
        // Light reddish color
        color: const Color.fromARGB(255, 225, 140, 152)!.withOpacity(0.4), // Lightest shade of red
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 10,
        //     spreadRadius: 2,
        //   ),
        // ],
      ),
      child: Center(
        child: CustomImage(image: '${widget.store.logoFullUrl}', fit: BoxFit.cover, height: 150, width: 150,),
      ),
    ),
  ],
),
     
      ),
    );
  }

  Widget _buildStoreImage(BuildContext context, double discount, String discountType, String currencySymbol, bool isRightSide) {
    return Stack(
      children: [
        // Store Image
        ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16),bottom: Radius.circular(16)),
          child: CustomImage(
            image: '${widget.store.coverPhotoFullUrl}',
            fit: BoxFit.cover,
            height: 240,
            width: double.infinity,
          ),
        ),
        // Discount Tag
        if (discount > 0)
          Positioned(
            top: 10,
            left: 10,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.redAccent.withOpacity(0.9),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '${(isRightSide || discountType == 'percent') ? '' : currencySymbol}$discount${discountType == 'percent' ? '%' : isRightSide ? currencySymbol : ''} OFF',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        // Wishlist Icon
        // Positioned(
        //   top: 10,
        //   right: 10,
        //   child: GestureDetector(
        //     onTap: () {
        //       if (AuthHelper.isLoggedIn()) {
        //         setState(() {
        //           isWished = !isWished;
        //           isWished
        //               ? favouriteController.addToFavouriteList(null, widget.store.id, true)
        //               : favouriteController.removeFromFavouriteList(widget.store.id, true);
        //         });
        //       } else {
        //         showCustomSnackBar('you_are_not_logged_in'.tr);
        //       }
        //     },
        //     child: Container(
        //       padding: const EdgeInsets.all(6),
        //       decoration: BoxDecoration(
        //         color: Colors.white.withOpacity(0.9),
        //         shape: BoxShape.circle,
        //       ),
        //       child: Icon(
        //         isWished ? Icons.favorite : Icons.favorite_border,
        //         size: 20,
        //         color: isWished ? Colors.redAccent : Colors.grey,
        //       ),
        //     ),
        //   ),
        // ),
      
      ],
    );
  }

  Widget _buildStoreDetails(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Store Name
          Text(
            widget.store.name ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          // Rating and Delivery Time
          Row(
            children: [
              const Icon(Icons.star, size: 16, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                widget.store.avgRating?.toStringAsFixed(1) ?? '0.0',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '• ${widget.store.deliveryTime}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Store Address
          Text(
            widget.store.address ?? '',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}