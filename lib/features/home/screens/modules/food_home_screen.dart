import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/common/widgets/custom_divider%20copy.dart';
import 'package:sixam_mart/common/widgets/custom_divider.dart';
import 'package:sixam_mart/features/home/widgets/highlight_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/category_view.dart';
import 'package:sixam_mart/features/home/widgets/views/top_offers_near_me.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/customcard.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/features/home/widgets/bad_weather_widget.dart';
import 'package:sixam_mart/features/home/widgets/views/best_reviewed_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/best_store_nearby_view.dart';
import 'package:sixam_mart/features/home/widgets/views/item_that_you_love_view.dart';
import 'package:sixam_mart/features/home/widgets/views/just_for_you_view.dart';
import 'package:sixam_mart/features/home/widgets/views/most_popular_item_view.dart';
import 'package:sixam_mart/features/home/widgets/views/new_on_mart_view.dart';
import 'package:sixam_mart/features/home/widgets/views/special_offer_view.dart';
import 'package:sixam_mart/features/home/widgets/views/visit_again_view.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';

class FoodHomeScreen extends StatelessWidget {
  const FoodHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isLoggedIn = AuthHelper.isLoggedIn();

       double containerWidth = MediaQuery.of(context).size.width * 0.25;
        double containerHeight = containerWidth * 1.29;
        double imageHeight = containerHeight * 0.8;
        double imageTopPosition = containerHeight * 0.2;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

     
                  const SizedBox(height: Dimensions.radiusDefault),
             
              const BadWeatherWidget(),
       
                const CustomDivider2(text: "EXPLORE",thickness: .1 , ),
              const SizedBox(height: Dimensions.radiusDefault),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Customcard(
                        imageBottomPosition: 0,
                        imageLeftPosition: 0,
                        imageRightPosition: 0,
                        // ontap: () => Get.to(SpecialOfferView(isFood: true, isShop: false)),
                        // ontap: () => Get.toNamed(RouteHelper.getPopularItemRoute(false, true)),
                        width: containerWidth * 1.1,
                        height: containerHeight - 20,
                        image: "assets/image/offerzoneimage.png",
                        imageHeight: imageHeight,
                        imageTopPosition: imageTopPosition + 5,
                        title: "OFFER",
                        title2: 'ZONE',
                         color:  Color.fromARGB(132, 232, 219, 243), titlecolor: Color(0xFF9C39E8), titlecolor2: Color(0xFF9C39E8),
                      ),
                      const SizedBox(width: 15),
                      Customcard(
                        imageBottomPosition: 0,
                        imageLeftPosition: 0,
                        imageRightPosition: 0,
                        // ontap: () => splashController.switchModule(1, true),
                          // ontap: () => Get.to(const MyFavorite()),
                        width: containerWidth * 1.1,
                         height: containerHeight - 20,
                        image: "assets/image/myfavoriteimage.png",
                        imageHeight: imageHeight * 0.5,
                        imageTopPosition: imageTopPosition + 33,
                        title: "FAVORITE",
                        title2: 'ITEM',
                         color:  Color.fromARGB(132, 253, 210, 216),
                         titlecolor: Color.fromARGB(255, 223, 7, 43), titlecolor2: Color.fromARGB(255, 223, 7, 43),
                      ),
                      const SizedBox(width: 15),
                      Customcard(
                        imageBottomPosition: 0,
                        imageLeftPosition: 0,
                        imageRightPosition: 0,
                        // ontap: () => Get.to(const  Popular()),
                       width: containerWidth * 1.1,
                         height: containerHeight - 20,
                        image: "assets/image/newonuolo.png",
                        imageHeight: imageHeight * 1.2,
                        imageTopPosition: imageTopPosition ,
                        title: "POPULAR",
                        title2: 'STORE', color: Color.fromARGB(138, 226, 248, 226),
                        titlecolor: const Color.fromARGB(255, 7, 119, 41), titlecolor2: Color.fromARGB(255, 7, 119, 41),
                      ),
                    ],
                  ),

    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
           
         const CustomDivider2(text: "WHAT,S ON YOUR MIND ?",thickness: .2,),
      
             SizedBox(height: MediaQuery.of(context).size.height * 0.01),
      const CategoryView(),
       BannerView(isFeatured: false),
      //  const Padding(
      //    padding: EdgeInsets.only(left: 10),
      //      child: CustomDivider2(text: "Newly Added Stores",thickness: .2, textAlign: TextAlign.left, ),
      //    ),

 SizedBox(height: 10),
               const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false),
          //  const SizedBox(height: Dimensions.paddingSizeDefault  ,),

        //     const Padding(
        //  padding: EdgeInsets.only(left: 10),
        //    child: CustomDivider2(text: "Offer Zone",thickness: .2, textAlign: TextAlign.left, ),
        //  ),


      isLoggedIn ? const VisitAgainView(fromFood: true) : const SizedBox(),
      //  SizedBox(height: 10),
      // const SpecialOfferView(isFood: false, isShop: true),
      const HighlightWidget(),
      // const TopOffersNearMe(),
      // const BestReviewItemView(),
  
      // const ItemThatYouLoveView(forShop: false),
      // const MostPopularItemView(isFood: true, isShop: false),
      const JustForYouView(),
      // const NewOnMartView(isNewStore: true, isPharmacy: false, isShop: false),
    ]);
  }
}
