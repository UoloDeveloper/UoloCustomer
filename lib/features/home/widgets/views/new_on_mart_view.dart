import 'package:sixam_mart/common/widgets/card_design/store_card_with_distance.dart';
import 'package:sixam_mart/common/widgets/custom_divider%20copy.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/FashionStoreCard.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/home/widgets/web/web_new_on_view_widget.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/card_design/store_card.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';


class NewOnMartView extends StatelessWidget {
  final bool isPharmacy;
  final bool isShop;
  final bool isNewStore;
    final bool? itemsview;
  const NewOnMartView({super.key, required this.isPharmacy, required this.isShop, this.isNewStore = false,this.itemsview = false});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      List<Store>? storeList = storeController.latestStoreList;

      return storeList != null ? storeList.isNotEmpty ? Padding(
        padding: const EdgeInsets.symmetric(vertical: 0),
        child: Padding(
         padding:  EdgeInsets.only(bottom: itemsview! ? 10 :  0),
          child: Container(
              decoration: itemsview! ? BoxDecoration(
                 color:  Color(0xFFE6E6FA)
                //  Theme.of(context).primaryColor
                  // Color.fromARGB(190, 141, 190, 234),
                //  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
               ) : null,
            child: Column(children: [
            
              Padding(
                padding:  EdgeInsets.only(left: itemsview! ? 10 : 0,top:itemsview! ? 30 :   0),
                child: CustomDivider1(text: "Newly Added".toUpperCase(),thickness: .2,textAlign: TextAlign.left,color: itemsview! ? Colors.black : Colors.black,),
                
                //  TitleWidget(
                //   title: 'Newly Added'.tr,
                //   onTap: () => Get.toNamed(RouteHelper.getAllStoreRoute('latest')),
                // ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            
              (isPharmacy || isShop) ? SizedBox(
                height: 240,
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                    itemCount: storeList.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
                        child: isShop? Fashionstorecard(store: storeList[index],isNewStore: isNewStore) : StoreCardWithDistance(store: storeList[index], isNewStore: isNewStore,fromitemsview: itemsview!,),
                      );
                    }),
              ) : SizedBox(
                height: 270,
                child: ListView.builder(
                  controller: ScrollController(),
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding:  EdgeInsets.only(left: itemsview! ? 10 :  0),
                  itemCount: storeList.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: 0, top: Dimensions.paddingSizeSmall),
                      child: StoreCardWithDistance(store: storeList[index],fromitemsview: false,),
                    );
                  },
                ),
              ),
            ]),
          ),
        ),
      ) : const SizedBox.shrink() : const SizedBox.shrink();
    });
  }
}

// class PopularStoreShimmer extends StatelessWidget {
//   final StoreController storeController;
//   const PopularStoreShimmer({super.key, required this.storeController});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: ListView.builder(
//         shrinkWrap: true,
//         physics: const BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//         padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
//         itemCount: 10,
//         itemBuilder: (context, index){
//           return Container(
//             height: 150, width: 200,
//             margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, bottom: 5),
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                 boxShadow: [BoxShadow(color: Colors.grey[300]!, blurRadius: 10, spreadRadius: 1)],
//             ),
//             child: Shimmer(
//               duration: const Duration(seconds: 2),
//               child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

//                 Container(
//                   height: 90, width: 200,
//                   decoration: BoxDecoration(
//                       borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)),
//                       color: Colors.grey[300],
//                   ),
//                 ),

//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
//                     child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [

//                       Container(height: 10, width: 100, color: Colors.grey[300]),
//                       const SizedBox(height: 5),

//                       Container(height: 10, width: 130, color: Colors.grey[300]),
//                       const SizedBox(height: 5),

//                       const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
//                     ]),
//                   ),
//                 ),
//               ]),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

