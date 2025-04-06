import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/flash_sale/widgets/flash_sale_view_widget.dart';
import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';
import 'package:sixam_mart/features/home/widgets/highlight_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/Groccerycategory_view.dart';

import 'package:sixam_mart/features/home/widgets/views/best_reviewed_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/best_store_nearby_view.dart';
import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
import 'package:sixam_mart/features/home/widgets/views/promo_code_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/middle_section_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/promotional_banner_view.dart';
import 'package:sixam_mart/features/home/widgets/views/top_offers_near_me.dart';



import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/helper/auth_helper.dart';


class GroceryHomeScreen extends StatelessWidget {
  const GroceryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();
    return Theme(
      data: Theme.of(context).copyWith(
        // cardColor: Colors.white,
        // scaffoldBackgroundColor: Colors.white,
        disabledColor: Colors.white,
        // fontFamily: 'Poppins',
        // backgroundColor: Colors.white,
      ),
      //  ThemeData(
      //   primaryColor: Colors.white,
      //   // accentColor: Colors.white,
      //   scaffoldBackgroundColor: Colors.white,
      //   // cardColor: Colors.white,
      //   disabledColor: Colors.white,
      //   fontFamily: 'Poppins',
      //   // backgroundColor: Colors.white,

      // ),
      
      child: Container(
        color:  Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.only(left: 0,right: 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
            // Container(
            //   width: MediaQuery.of(context).size.width,
            //   color: Theme.of(context).disabledColor  ,
            //   child:  const Column(
            //     children: [
            //       BadWeatherWidget(),
          
            //       BannerView(isFeatured: false),
            //       SizedBox(height: 12),
            //     ],
            //   ),
            // ),
          
            // const CategoryView(),
            // CustomButton(buttonText: 'Grocery', onPressed: () {
            //   if ( Get.find<CategoryController>().GrocerycategoritemyList.isEmpty) {
            //   Get.find<CategoryController>().getGrocceryCategoryList(allCategory: false, true);
            //   }
            // },),
              const CategoryView(),
               BannerView(isFeatured: false ,Grocery: true,),
             GroceryCategoryView (),
            // isLoggedIn ? const VisitAgainView() : const SizedBox(),
            const SpecialOfferView(isFood: false, isShop: false),
            // const HighlightWidget(),
            // const FlashSaleViewWidget(),
            // const BestStoreNearbyView(),
            const MostPopularItemView(isFood: false, isShop: false),
            const MiddleSectionBannerView(),
            const BestReviewItemView(),
            const JustForYouView(),
            const TopOffersNearMe(),
            const ItemThatYouLoveView(forShop: false),
            isLoggedIn ? const PromoCodeBannerView() : const SizedBox(),
            // const NewOnMartView(isPharmacy: false, isShop: false),
            const PromotionalBannerView(),
            SizedBox(height: 200),
          ]),
        ),
      ),
    );
  }
}
