import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/card_design/store_card_with_distance.dart';
import 'package:sixam_mart/common/widgets/card_design/visit_again_card.dart';
import 'package:sixam_mart/common/widgets/custom_divider%20copy.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/FashionStoreCard.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/home/widgets/components/custom_triangle_shape.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class VisitAgainView extends StatefulWidget {
  final bool? fromFood;
  final bool isshop;
  final bool? itemsview;
  const VisitAgainView({super.key, this.fromFood = false,  this.isshop = false,  this.itemsview = false, });

  @override
  State<VisitAgainView> createState() => _VisitAgainViewState();
}

class _VisitAgainViewState extends State<VisitAgainView> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
        List<Store>? stores = storeController.visitAgainStoreList;

      return   stores != null && stores.length > 1 ? stores.isNotEmpty ? 
       Padding(
         padding:  EdgeInsets.only(bottom: widget.itemsview! ? 10 :  0),
         child: Container(
            decoration: widget.itemsview! ? BoxDecoration(
               color: Color(0xFFE6E6FA)
              //  Color.fromARGB(93, 57, 3, 88) 
              //  Color(0xFFF5FEFD),
                // Theme.of(context).primaryColor,
              //  Color.fromARGB(184, 73, 174, 246),
              //  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
             ) : null,
           child: Column(
             children: [
               Padding(
                   padding:  EdgeInsets.only(left: widget.itemsview! ? 10 : 0,bottom: 10,top:widget.itemsview! ? 30 :   0),
                child: CustomDivider1(text: "Try Again".toUpperCase(),thickness: .2,textAlign: TextAlign.left,color: !widget.itemsview! ? Colors.black : Colors.black,),
                
                
                //  TitleWidget(
                //   title: 'Try Again'.tr,
                //   onTap: () => Get.toNamed(RouteHelper.getAllStoreRoute('latest')),
                // ),
              ),
               Container(
                height: widget.isshop? 260 : 270,
                 child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.only(left: widget.itemsview! ? 10 : 0),
                          itemCount: stores.length,
                          itemBuilder: (context, index){
                            return Padding(
                              padding: const EdgeInsets.only(right: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall),
                              child: widget.isshop? Fashionstorecard(store: stores[index],isNewStore:false) : StoreCardWithDistance(store: stores[index],fromitemsview: false,),
                            );
                          }),
               ),
             ],
           ),
         ),
       ) : SizedBox(): SizedBox();
      //  Padding(
      //   padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      //   child: Stack(clipBehavior: Clip.none, children: [

      //       Container(
      //         height: 350, width: double.infinity,
      //         color: Theme.of(context).primaryColor,
      //       ),

      //       Padding(
      //         padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
      //         child: Column(children: [

      //           Text(widget.fromFood! ? "wanna_try_again".tr : "visit_again".tr, style: robotoBold.copyWith(color: Theme.of(context).cardColor)),
      //           const SizedBox(height: Dimensions.paddingSizeSmall),

      //           Text(
      //             'get_your_recent_purchase_from_the_shop_you_recently_visited'.tr,
      //             style: robotoRegular.copyWith(color: Theme.of(context).cardColor, fontSize: Dimensions.fontSizeSmall),
      //           ),
      //           const SizedBox(height: Dimensions.paddingSizeSmall),
 
      //           CarouselSlider.builder(
      //             itemCount: stores.length,
      //             options: CarouselOptions(
      //               aspectRatio: 1.0,
      //               enlargeCenterPage: true,
      //               disableCenter: true,
      //             ),
      //             itemBuilder: (BuildContext context, int index, int realIndex) {
      //             return StoreCardWithDistance(store: stores[index]);
                  
      //             //  VisitAgainCard(store: stores[index], fromFood: widget.fromFood!);
      //             },
      //           ),
      //         ]),
      //       ),

      //     const Positioned(
      //       top: 20, left: 10,
      //       child: TriangleWidget(),
      //     ),

      //     const Positioned(
      //       top: 10, right: 100,
      //       child: TriangleWidget(),
      //     ),
      //   ]),
      // ) : const SizedBox() : VisitAgainShimmerView();
      
    });
  }
}

class VisitAgainShimmerView extends StatelessWidget {
  const VisitAgainShimmerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault),
      child: Stack(clipBehavior: Clip.none, children: [

        Container(
          height: 150, width: double.infinity,
          color: Theme.of(context).cardColor,
        ),

        Padding(
          padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
          child: Column(children: [

            Shimmer(
              child: Container(
                height: 10, width: 100,
                color: Theme.of(context).shadowColor,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            Shimmer(
              child: Container(
                height: 10, width: 200,
                color: Theme.of(context).shadowColor,
              ),
            ),
            const SizedBox(height: Dimensions.paddingSizeSmall),

            CarouselSlider.builder(
              itemCount: 5,
              options: CarouselOptions(
                aspectRatio: 2.2,
                enlargeCenterPage: true,
                disableCenter: true,
              ),
              itemBuilder: (BuildContext context, int index, int realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  child: Shimmer(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        color: Theme.of(context).shadowColor,
                      ),
                    ),
                  ),
                );
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
