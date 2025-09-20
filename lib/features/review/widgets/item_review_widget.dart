import 'package:sixam_mart/features/review/controllers/review_controller.dart';
import 'package:sixam_mart/features/review/domain/models/review_body_model.dart';
import 'package:sixam_mart/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';




// class ItemReviewWidget extends StatefulWidget {
//   final List<OrderDetailsModel> orderDetailsList;
//   const ItemReviewWidget({super.key, required this.orderDetailsList});

//   @override
//   State<ItemReviewWidget> createState() => _ItemReviewWidgetState();
// }

// class _ItemReviewWidgetState extends State<ItemReviewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReviewController>(builder: (reviewController) {
//       return SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: FooterView(child: SizedBox(width: Dimensions.webMaxWidth, child: ListView.builder(
//           itemCount: widget.orderDetailsList.length,
//           physics: const NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//           itemBuilder: (context, index) {
//             return Container(
//               padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//               margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
//               decoration: BoxDecoration(
//                 boxShadow: const [BoxShadow(color: Colors.grey  , spreadRadius: 1, blurRadius: 2, offset: Offset(0, 1))],
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
//               ),
//               child: Column(children: [

//                 // Product details
//                 Row(
//                   children: [
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                       child: CustomImage(
//                         height: 70, width: 85, fit: BoxFit.cover,
//                         image: '${widget.orderDetailsList[index].imageFullUrl}',
//                       ),
//                     ),
//                     const SizedBox(width: Dimensions.paddingSizeSmall),
//                     Expanded(child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(widget.orderDetailsList[index].itemDetails!.name!, style: robotoMedium, maxLines: 2, overflow: TextOverflow.ellipsis),
//                         const SizedBox(height: 10),
//                         Text(PriceConverter.convertPrice(widget.orderDetailsList[index].itemDetails!.price), style: robotoBold, textDirection: TextDirection.ltr),
//                       ],
//                     )),
//                     Row(children: [
//                       Text(
//                         '${'quantity'.tr}: ',
//                         style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                       ),
//                       Text(
//                         widget.orderDetailsList[index].quantity.toString(),
//                         style: robotoMedium.copyWith(color: Theme.of(context).primaryColor, fontSize: Dimensions.fontSizeSmall),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ]),
//                   ],
//                 ),
//                 const Divider(height: 20),

//                 // Rate
//                 Text(
//                   'rate_the_item'.tr,
//                   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeSmall),

                
//                 SizedBox(
//                   height: 30,
//                   child: ListView.builder(
//                     itemCount: 5,
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, i) {
//                       return InkWell(
//                         child: Icon(
//                           reviewController.ratingList[index] < (i + 1) ? Icons.star_border : Icons.star,
//                           size: 25,
//                           color: reviewController.ratingList[index] < (i + 1) ? Theme.of(context).disabledColor
//                               : Theme.of(context).primaryColor,
//                         ),
//                         onTap: () {
//                           if(!reviewController.submitList[index]) {
//                             reviewController.setRating(index, i + 1);
//                           }
//                         },
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeLarge),
//                 Text(
//                   'share_your_opinion'.tr,
//                   style: robotoMedium.copyWith(color: Theme.of(context).disabledColor), overflow: TextOverflow.ellipsis,
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeLarge),
//                 MyTextField(
//                   maxLines: 3,
//                   capitalization: TextCapitalization.sentences,
//                   isEnabled: !reviewController.submitList[index],
//                   hintText: 'write_your_review_here'.tr,
//                   fillColor: Theme.of(context).disabledColor  ,
//                   onChanged: (text) => reviewController.setReview(index, text),
//                 ),
//                 const SizedBox(height: 20),

//                 // Submit button
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
//                   child: !reviewController.loadingList[index] ? CustomButton(
//                     buttonText: reviewController.submitList[index] ? 'submitted'.tr : 'submit'.tr,
//                     onPressed: reviewController.submitList[index] ? null : () {
//                       if(!reviewController.submitList[index]) {
//                         if (reviewController.ratingList[index] == 0) {
//                           showCustomSnackBar('give_a_rating'.tr);
//                         } /*else if (reviewController.reviewList[index].isEmpty) {
//                           showCustomSnackBar('write_a_review'.tr);
//                         } */else {
//                           FocusScopeNode currentFocus = FocusScope.of(context);
//                           if (!currentFocus.hasPrimaryFocus) {
//                             currentFocus.unfocus();
//                           }
//                           ReviewBodyModel reviewBody = ReviewBodyModel(
//                             productId: widget.orderDetailsList[index].itemDetails!.id.toString(),
//                             rating: reviewController.ratingList[index].toString(),
//                             comment: reviewController.reviewList[index],
//                             orderId: widget.orderDetailsList[index].orderId.toString(),
//                           );
//                           reviewController.submitReview(index, reviewBody).then((value) {
//                             if (value.isSuccess) {
//                               showCustomSnackBar(value.message, isError: false);
//                               reviewController.setReview(index, '');
//                             } else {
//                               showCustomSnackBar(value.message);
//                             }
//                           });
//                         }
//                       }
//                     },
//                   ) : const Center(child: CircularProgressIndicator()),
//                 ),

//               ]),
//             );
//           },
//         ))),
//       );
//     });
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/review_controller.dart';

// class ItemReviewWidget extends StatefulWidget {
//   final List<OrderDetailsModel> orderDetailsList;
//   const ItemReviewWidget({super.key, required this.orderDetailsList});

//   @override
//   State<ItemReviewWidget> createState() => _ItemReviewWidgetState();
// }

// class _ItemReviewWidgetState extends State<ItemReviewWidget> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<ReviewController>(builder: (reviewController) {
//       return SingleChildScrollView(
//         physics: const BouncingScrollPhysics(),
//         child: Container(
//           width: Dimensions.webMaxWidth,
//           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
//           child: ListView.builder(
//             itemCount: widget.orderDetailsList.length,
//             physics: const NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Container(
//                 margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).cardColor,
//                   borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Theme.of(context).shadowColor.withOpacity(0.1),
//                       spreadRadius: 1,
//                       blurRadius: 8,
//                       offset: const Offset(0, 2),
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       // Product Details
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           ClipRRect(
//                             borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                             child: CustomImage(
//                               height: 80,
//                               width: 80,
//                               fit: BoxFit.cover,
//                               image: '${widget.orderDetailsList[index].imageFullUrl}',
//                             ),
//                           ),
//                           const SizedBox(width: Dimensions.paddingSizeDefault),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   widget.orderDetailsList[index].itemDetails!.name!,
//                                   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                                         fontWeight: FontWeight.w600,
//                                         fontSize: Dimensions.fontSizeLarge,
//                                       ),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                                 Text(
//                                   PriceConverter.convertPrice(widget.orderDetailsList[index].itemDetails!.price),
//                                   style: Theme.of(context).textTheme.titleSmall?.copyWith(
//                                         fontWeight: FontWeight.w700,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                   textDirection: TextDirection.ltr,
//                                 ),
//                                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                                 Text(
//                                   '${'quantity'.tr}: ${widget.orderDetailsList[index].quantity}',
//                                   style: Theme.of(context).textTheme.bodySmall?.copyWith(
//                                         color: Theme.of(context).hintColor,
//                                       ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeLarge),
//                       Divider(
//                         color: Theme.of(context).dividerColor.withOpacity(0.2),
//                         thickness: 1,
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeDefault),

//                       // Rating Section
//                       Text(
//                         'rate_the_item'.tr,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).hintColor,
//                             ),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),
//                       SizedBox(
//                         height: 40,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: 5,
//                           itemBuilder: (context, i) {
//                             return InkWell(
//                               onTap: reviewController.submitList[index]
//                                   ? null
//                                   : () => reviewController.setRating(index, i + 1),
//                               child: Padding(
//                                 padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                 child: AnimatedContainer(
//                                   duration: const Duration(milliseconds: 300),
//                                   child: Icon(
//                                     reviewController.ratingList[index] < (i + 1)
//                                         ? Icons.star_border_rounded
//                                         : Icons.star_rounded,
//                                     size: 32,
//                                     color: reviewController.ratingList[index] < (i + 1)
//                                         ? Theme.of(context).hintColor.withOpacity(0.5)
//                                         : Theme.of(context).primaryColor,
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeLarge),

//                       // Review Section
//                       Text(
//                         'share_your_opinion'.tr,
//                         style: Theme.of(context).textTheme.titleMedium?.copyWith(
//                               fontWeight: FontWeight.w600,
//                               color: Theme.of(context).hintColor,
//                             ),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),
//                       MyTextField(
                        
//                         maxLines: 4,
//                         capitalization: TextCapitalization.sentences,
//                         isEnabled: !reviewController.submitList[index],
//                         hintText: 'write_your_review_here'.tr,
//                         fillColor: Theme.of(context).cardColor.withOpacity(0.05),
//                         // borderRadius: Dimensions.radiusDefault,
//                         onChanged: (text) => reviewController.setReview(index, text),
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeLarge),

//                       // Submit Button
//                       Center(
//                         child: !reviewController.loadingList[index]
//                             ? Container(
//                                 decoration: BoxDecoration(
//                                   gradient: LinearGradient(
//                                     colors: [
//                                       Theme.of(context).primaryColor,
//                                       Theme.of(context).primaryColor.withOpacity(0.8),
//                                     ],
//                                     begin: Alignment.topCenter,
//                                     end: Alignment.bottomCenter,
//                                   ),
//                                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//                                   boxShadow: [
//                                     BoxShadow(
//                                       color: Theme.of(context).primaryColor.withOpacity(0.2),
//                                       blurRadius: 8,
//                                       offset: const Offset(0, 2),
//                                     ),
//                                   ],
//                                 ),
//                                 child: CustomButton(
//                                   buttonText: reviewController.submitList[index] ? 'submitted'.tr : 'submit'.tr,
// color: Colors.white,

//                                   // style: Theme.of(context).textTheme.labelLarge?.copyWith(
//                                   //       color: Colors.white,
//                                   //       fontWeight: FontWeight.w600,
//                                   //     ),
//                                   height: 48,
//                                   width: double.infinity,
//                                   transparent: true,
//                                   onPressed: reviewController.submitList[index]
//                                       ? null
//                                       : () {
//                                           if (!reviewController.submitList[index]) {
//                                             if (reviewController.ratingList[index] == 0) {
//                                               showCustomSnackBar('give_a_rating'.tr);
//                                             } else {
//                                               FocusScope.of(context).unfocus();
//                                               ReviewBodyModel reviewBody = ReviewBodyModel(
//                                                 productId: widget.orderDetailsList[index].itemDetails!.id.toString(),
//                                                 rating: reviewController.ratingList[index].toString(),
//                                                 comment: reviewController.reviewList[index],
//                                                 orderId: widget.orderDetailsList[index].orderId.toString(),
//                                               );
//                                               reviewController.submitReview(index, reviewBody).then((value) {
//                                                 if (value.isSuccess) {
//                                                   showCustomSnackBar(value.message, isError: false);
//                                                   reviewController.setReview(index, '');
//                                                 } else {
//                                                   showCustomSnackBar(value.message);
//                                                 }
//                                               });
//                                             }
//                                           }
//                                         },
//                                 ),
//                               )
//                             : const CircularProgressIndicator(),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       );
//     });
//   }
// }


class ItemReviewWidget extends StatefulWidget {
  final List<OrderDetailsModel> orderDetailsList;
  const ItemReviewWidget({super.key, required this.orderDetailsList});

  @override
  State<ItemReviewWidget> createState() => _ItemReviewWidgetState();
}

class _ItemReviewWidgetState extends State<ItemReviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(builder: (reviewController) {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
        child: Column(
          children: widget.orderDetailsList.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            return Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.black12,
                //     blurRadius: 10,
                //     offset: const Offset(0, 5),
                //   )
                // ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: CustomImage(
                            image: item.imageFullUrl ?? '',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.itemDetails!.name!,
                                style: robotoMedium.copyWith(fontSize: 18),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                PriceConverter.convertPrice(item.itemDetails!.price),
                                style: robotoBold.copyWith(
                                  fontSize: 15,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${'quantity'.tr}: ${item.quantity}',
                                style: robotoMedium.copyWith(color: Colors.grey.shade600,fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Divider(color: Colors.grey.shade300),

                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'rate_the_item'.tr,
                        style: robotoMedium.copyWith(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                    Row(
                      children: List.generate(5, (i) => GestureDetector(
                        onTap: () => reviewController.submitList[index] ? null : reviewController.setRating(index, i + 1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: Icon(
                            reviewController.ratingList[index] <= i ? Icons.star_outline_rounded : Icons.star_rounded,
                            size: 28,
                            color: reviewController.ratingList[index] <= i ? Colors.grey : Theme.of(context).primaryColor,
                          ),
                        ),
                      )),
                    ),

                    const SizedBox(height: 20),
                    Text(
                      'share_your_opinion'.tr,
                      style: robotoMedium.copyWith(fontSize: 16, color: Colors.black87),
                    ),
                    const SizedBox(height: 10),
                    MyTextField(
                      maxLines: 4,
                      capitalization: TextCapitalization.sentences,
                      isEnabled: !reviewController.submitList[index],
                      hintText: 'write_your_review_here'.tr,
                      fillColor: Colors.grey.shade50,
                      onChanged: (text) => reviewController.setReview(index, text),
                    ),

                    const SizedBox(height: 20),
                    Center(
                      child: reviewController.loadingList[index]
                          ? const CircularProgressIndicator()
                          : ElevatedButton.icon(
                              icon: Icon(
                                reviewController.submitList[index] ? Icons.check_circle_outline : Icons.send,
                                color: Colors.white,
                              ),
                              label: Text(
                                reviewController.submitList[index] ? 'submitted'.tr : 'submit'.tr,
                                style: robotoBold.copyWith(color: Colors.white),
                              ),
                              onPressed: reviewController.submitList[index]
                                  ? null
                                  : () {
                                      if (reviewController.ratingList[index] == 0) {
                                        showCustomSnackBar('give_a_rating'.tr);
                                      } else {
                                        FocusScope.of(context).unfocus();
                                        final reviewBody = ReviewBodyModel(
                                          productId: item.itemDetails!.id.toString(),
                                          rating: reviewController.ratingList[index].toString(),
                                          comment: reviewController.reviewList[index],
                                          orderId: item.orderId.toString(),
                                        );
                                        reviewController.submitReview(index, reviewBody).then((value) {
                                          showCustomSnackBar(value.message, isError: !value.isSuccess);
                                          if (value.isSuccess) {
                                            reviewController.setReview(index, '');
                                          }
                                        });
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    });
  }
}
