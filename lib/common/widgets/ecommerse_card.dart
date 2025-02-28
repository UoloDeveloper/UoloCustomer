import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class Ecomerceitem extends StatefulWidget {
  final Item? item;
  final bool isFeatured;
  final double? imageHeight;
  final double? imageWidth;
   final double? Width;
    final Store? store;
  final bool isStore;
   final bool isCampaign;

  const Ecomerceitem({
    super.key,
    required this.item,
    this.isFeatured = false,
    this.imageHeight,
    this.imageWidth, this.store, required this.isStore, required this.isCampaign, this.Width,
  });

  @override
  _ItemWidgetState createState() => _ItemWidgetState();
}

class _ItemWidgetState extends State<Ecomerceitem> {
  bool _isFavourite = false;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveHelper.isDesktop(context);
    final double imageHeight = widget.imageHeight ?? (isDesktop ? 200 : 230);
    final double imageWidth = widget.imageWidth ?? (isDesktop ? 200 : 200);


     double? discount;
    String? discountType;
    bool isAvailable;
    bool customizable;

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

    return CustomInkWell(
      onTap: () => Get.find<ItemController>().navigateToItemPage(widget.item, context),
      child: Container(
        height: 300,
        width: widget.Width ?? null,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withOpacity(0.1),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16),bottom:Radius.circular(16) ),
                  child: CustomImage(
                    image: widget.item?.imageFullUrl ?? 'assets/images/placeholder.png',
                    height: imageHeight ,
                    width: imageWidth,
                    fit: BoxFit.cover,
                  ),
                ),
      
                // Favourite Icon
                Positioned(
                  top: 10,
                  right: 10,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _isFavourite = !_isFavourite;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isFavourite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavourite ? Colors.red : Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ),
      
                // Featured Tag
                if (widget.isFeatured)
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Featured',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
      
            // Details Section
            Padding(
              padding: const EdgeInsets.only(top: 12, left: 2, right: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    widget.item?.storeName ?? 'Store Name',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  // Dress Name
                  Text(
                    widget.item?.name ?? 'Dress Name',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
      
                  const SizedBox(height: 4),
      // Star Rating Section
      Row(
        children: List.generate(4, (index) {
      return Icon(
        index < (widget.item?.ratingCount ?? 0) ? Icons.star : Icons.star_border,
        color: index < (widget.item?.ratingCount ?? 0) ? Colors.grey[800] : Colors.grey,
        size: 20,
      );
        }),
      ),
      
      
      
      SizedBox(height: 5,),
        Row(
                              children: [
                                Text(
                                  PriceConverter.convertPrice(
                                    _getPrice(widget.item),
                                    discount: discount,
                                    discountType: discountType,
                                    // currency: widget.item?.currency?.currencyCode 
                                  ),
                                  style: robotoMedium.copyWith(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                 const SizedBox(width: 8,),
                                  if (discount! > 0)
                              Text(
                                PriceConverter.convertPrice(widget.item?.price,),
                                style: robotoMedium.copyWith(
                                  fontSize: 13,
                                  color: Theme.of(context).disabledColor,
                                  decoration: TextDecoration.lineThrough,
                                  decorationColor: Theme.of(context).disabledColor,
                                    fontWeight: FontWeight.w600,
                                ),
                              ),
      
                  SizedBox(width: 5,),
                              if (discount! > 0) Text("${discountType == 'percent' ? '${discount.round()}% off' : '${PriceConverter.convertPrice(discount,)} off'}",style: robotoMedium.copyWith(fontSize: 14,fontWeight: FontWeight.w600,color: Colors.green),),
                              ],
                            ),
                  // Price
                 
      
                
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
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
