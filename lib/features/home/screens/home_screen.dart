import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/common/widgets/card_design/store_card.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/banner/controllers/banner_controller.dart';
import 'package:sixam_mart/features/brands/controllers/brands_controller.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/home/notdeliverablescreen.dart';
import 'package:sixam_mart/features/home/screens/videobanner.dart';
import 'package:sixam_mart/features/home/widgets/all_store_filter_widget.dart';
import 'package:sixam_mart/features/home/widgets/cashback_logo_widget.dart';
import 'package:sixam_mart/features/home/widgets/cashback_dialog_widget.dart';
import 'package:sixam_mart/features/home/widgets/refer_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/item/controllers/campaign_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/flash_sale/controllers/flash_sale_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/menu/screens/menu_screen.dart';
import 'package:sixam_mart/features/notification/controllers/notification_controller.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/review/controllers/review_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/home/screens/modules/food_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/grocery_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/pharmacy_home_screen.dart';
import 'package:sixam_mart/features/home/screens/modules/shop_home_screen.dart';
import 'package:sixam_mart/features/parcel/controllers/parcel_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/paginated_list_view.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:sixam_mart/features/home/screens/web_new_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/home/widgets/module_view.dart';
import 'package:sixam_mart/features/parcel/screens/parcel_category_screen.dart';

// import '../../dashboard/dashboardscroll_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});


  static Future<void> loadData(bool reload, {bool fromModule = false}) async {
    Get.find<LocationController>().syncZoneData();
    Get.find<FlashSaleController>().setEmptyFlashSale(fromModule: fromModule);
    //  await Get.find<BannerController>().getBannerList(true);
    // print('------------call from home');
    // await Get.find<CartController>().getCartDataOnline();
        //  if ( Get.find<CategoryController>().GrocerycategoritemyList.isEmpty) {
        // Get.find<CategoryController>().getGrocceryCategoryList(allCategory: false, true);
        // }
        //  Get.find<CategoryController>().getGrocceryCategoryList(allCategory: false, true);
    if(AuthHelper.isLoggedIn()) {
      Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);

    }
    if(Get.find<SplashController>().module != null && !Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel!) {
      Get.find<BannerController>().getBannerList(reload);
      Get.find<StoreController>().getRecommendedStoreList();
      if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.grocery) {
        Get.find<FlashSaleController>().getFlashSale(reload, false);
          if ( Get.find<CategoryController>().GrocerycategoritemyList.isEmpty) {
        Get.find<CategoryController>().getGrocceryCategoryList(allCategory: false, true);
        }
      //  if(  Get.find<CategoryController>().categoryItemList == null && Get.find<CategoryController>().categoryItemList!.isEmpty) {
      //        Get.find<CategoryController>().getCategoryList(false, allCategory: false);
      //  }
      }
      
      if(Get.find<SplashController>().module!.moduleType.toString() == AppConstants.ecommerce) {
        Get.find<ItemController>().getFeaturedCategoriesItemList(false, false);
        Get.find<FlashSaleController>().getFlashSale(reload, false);
        Get.find<BrandsController>().getBrandList();
      }
      Get.find<BannerController>().getPromotionalBannerList(reload);
      Get.find<ItemController>().getDiscountedItemList(reload, false, 'all');
      Get.find<CategoryController>().getCategoryList(reload);
      Get.find<StoreController>().getPopularStoreList(reload, 'all', false);
      Get.find<CampaignController>().getBasicCampaignList(reload);
      Get.find<CampaignController>().getItemCampaignList(reload);
      Get.find<ItemController>().getPopularItemList(reload, 'all', false);
      Get.find<StoreController>().getLatestStoreList(reload, 'all', false);
      Get.find<StoreController>().getTopOfferStoreList(reload, false);
      Get.find<ItemController>().getReviewedItemList(reload, 'all', false);
      Get.find<ItemController>().getRecommendedItemList(reload, 'all', false);
      Get.find<StoreController>().getStoreList(1, reload);
      Get.find<AdvertisementController>().getAdvertisementList();
    }
    if(AuthHelper.isLoggedIn()) {
      // Get.find<StoreController>().getVisitAgainStoreList(fromModule: fromModule);
      await Get.find<ProfileController>().getUserInfo();
      Get.find<NotificationController>().getNotificationList(reload);
      Get.find<CouponController>().getCouponList();
    
    }
    Get.find<SplashController>().getModules();
    if(Get.find<SplashController>().module == null && Get.find<SplashController>().configModel!.module == null) {
      Get.find<BannerController>().getFeaturedBanner();
      Get.find<StoreController>().getFeaturedStoreList();
      if(AuthHelper.isLoggedIn()) {
        Get.find<AddressController>().getAddressList();
      }
    }
    if(Get.find<SplashController>().module != null && Get.find<SplashController>().configModel!.moduleConfig!.module!.isParcel!) {
      Get.find<ParcelController>().getParcelCategoryList();
    }
    if(Get.find<SplashController>().module != null && Get.find<SplashController>().module!.moduleType.toString() == AppConstants.pharmacy) {
      Get.find<ItemController>().getBasicMedicine(reload, false);
      Get.find<StoreController>().getFeaturedStoreList();
      await Get.find<ItemController>().getCommonConditions(false);
      if(Get.find<ItemController>().commonConditions!.isNotEmpty) {
        Get.find<ItemController>().getConditionsWiseItem(Get.find<ItemController>().commonConditions![0].id!, false);
      }
    }
     
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  bool searchBgShow = false;
  bool isPinned = false;
  final GlobalKey _headerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    
  // final reviewlist =
  //  Get.find<OrderController>().getHistoryOrders(1).then((value) {

  //     // Get.find<OrderController>().historyOrderModel!.orders!.where(
  //     //     // (element) => element.rating == null,
  //     // );
      
  //  });
          
          //  final reviewlist = Get.find<ReviewController>().storeReviewList!.where(
          //      (element) => element.rating == null,
          //  );

          //  if(reviewlist.isNotEmpty) {
          //      _showModalBottomSheet(context);
          //  }
   
      // Get.find<CategoryController>().getFoodCategoryList(false, allCategory: true);
      // _updateStatusBarColor();

      //    Get.find<ReviewController>().storeReviewList!.where(
      //       (element) => element.rating == null,
      // );
    });

    _scrollController.addListener(_onScroll);

    HomeScreen.loadData(false).then((value) {
      Get.find<SplashController>().getReferBottomSheetStatus();

      if((Get.find<ProfileController>().userInfoModel?.isValidForDiscount??false) && Get.find<SplashController>().showReferBottomSheet) {
        _showReferBottomSheet();
      }
    });

    if(!ResponsiveHelper.isWeb()) {
      Get.find<LocationController>().getZone(
          AddressHelper.getUserAddressFromSharedPref()!.latitude,
          AddressHelper.getUserAddressFromSharedPref()!.longitude, false, updateInAddress: true
      );
    }



 
  }

 
   void _onScroll() {
    _updateStatusBarColor();

    final scrollDirection = _scrollController.position.userScrollDirection;
    final bottomsheetcontroller = Get.find<SplashController>();

    if (scrollDirection == ScrollDirection.forward) {
      if (!bottomsheetcontroller.showBottomSheet.value) {
        bottomsheetcontroller.showBottomSheet.value = true;
      }
    } else if (scrollDirection == ScrollDirection.reverse) {
      if (bottomsheetcontroller.showBottomSheet.value) {
        bottomsheetcontroller.showBottomSheet.value = false;
      }
    }

    if (_scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      if (Get.find<HomeController>().showFavButton) {
        Get.find<HomeController>().changeFavVisibility();
        Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
      }
    } else {
      if (Get.find<HomeController>().showFavButton) {
        Get.find<HomeController>().changeFavVisibility();
        Future.delayed(const Duration(milliseconds: 800), () => Get.find<HomeController>().changeFavVisibility());
      }
    }
  }

  void _updateStatusBarColor() {
    print("Scroll Offset: ${_scrollController.offset}");
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: SystemUiOverlay.values);

    if (_scrollController.offset > 50) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,

      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ));
    }
  }


  @override
  void dispose() {
    super.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
  }

  void _showReferBottomSheet() {
    ResponsiveHelper.isDesktop(context) ? Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(22),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const ReferBottomSheetWidget(),
      ),
      useSafeArea: false,
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false))
        : showModalBottomSheet(
      isScrollControlled: true, useRootNavigator: true, context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const ReferBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashController>(builder: (splashController) {
      if(splashController.moduleList != null && splashController.moduleList!.length == 1) {
        splashController.switchModule(0, true);
      }
      bool showMobileModule = !ResponsiveHelper.isDesktop(context) && splashController.module == null && splashController.configModel!.module == null;
      bool isParcel = splashController.module != null && splashController.configModel!.moduleConfig!.module!.isParcel!;
      bool isPharmacy = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.pharmacy;
      bool isFood = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.food;
      bool isShop = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.ecommerce;
      bool isGrocery = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.grocery;




  // if(splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.grocery){ 

  //   Get.to(Notdeliverablescreen());
  // }

  if (isGrocery ) {
        return const NotDeliverableScreen();
      }
//  if ( Get.find<StoreController>().storeModel!.stores!.isEmpty) {
//   return const NotDeliverableScreen();
//  }

      return GetBuilder<HomeController>(builder: (homeController) {


        return Scaffold(
          extendBodyBehindAppBar: false,

          // appBar: ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : null,
          // endDrawer: const MenuDrawer(),
          endDrawerEnableOpenDragGesture: false,
          backgroundColor: Colors.white,
          body: isParcel ? const ParcelCategoryScreen() : RefreshIndicator(
            
            onRefresh: () async {
              splashController.setRefreshing(true);
              if (Get.find<SplashController>().module != null) {
                await Get.find<LocationController>().syncZoneData();
                await Get.find<BannerController>().getBannerList(true);
                if (isGrocery) {
                  await Get.find<FlashSaleController>().getFlashSale(true, true);
                }
                await Get.find<BannerController>().getPromotionalBannerList(true);
                await Get.find<ItemController>().getDiscountedItemList(true, false, 'all');
                await Get.find<CategoryController>().getCategoryList(true);
                await Get.find<StoreController>().getRecommendedStoreList();
                await Get.find<StoreController>().getPopularStoreList(true, 'all', false);
                await Get.find<CampaignController>().getItemCampaignList(true);
                Get.find<CampaignController>().getBasicCampaignList(true);
                await Get.find<ItemController>().getPopularItemList(true, 'all', false);
                await Get.find<StoreController>().getLatestStoreList(true, 'all', false);
                await Get.find<StoreController>().getTopOfferStoreList(true, false);
                await Get.find<ItemController>().getReviewedItemList(true, 'all', false);
                await Get.find<StoreController>().getStoreList(1, true);
                Get.find<AdvertisementController>().getAdvertisementList();
                if (AuthHelper.isLoggedIn()) {
                  await Get.find<ProfileController>().getUserInfo();
                  await Get.find<NotificationController>().getNotificationList(true);
                  Get.find<CouponController>().getCouponList();
                }
                if (isPharmacy) {
                  Get.find<ItemController>().getBasicMedicine(true, true);
                  Get.find<ItemController>().getCommonConditions(true);
                }
                if (isShop) {
                  await Get.find<FlashSaleController>().getFlashSale(true, true);
                  Get.find<ItemController>().getFeaturedCategoriesItemList(true, true);
                  Get.find<BrandsController>().getBrandList();
                }
              } else {
                await Get.find<BannerController>().getFeaturedBanner();
                await Get.find<SplashController>().getModules();
                if (AuthHelper.isLoggedIn()) {
                  await Get.find<AddressController>().getAddressList();
                }
                await Get.find<StoreController>().getFeaturedStoreList();
              }
              splashController.setRefreshing(false);
            },
            child: ResponsiveHelper.isDesktop(context) ? WebNewHomeScreen(
              scrollController: _scrollController,
            ) : CustomScrollView(

              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
          
               
          


            SliverToBoxAdapter(
                      

                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Stack(
                        children: [
                          VideoContainer( link: "assets/image/static_banner/videobanner.mp4",),

                            //  if (!showMobileModule)
                                Padding(
                                  padding: const EdgeInsets.only(top: 110,right: 10,left: 10),
                                  child: Center(
                                    child: Container(
                                      height: 50,
                                      width: Dimensions.webMaxWidth,
                                      color: searchBgShow
                                          ? Get.find<ThemeController>().darkTheme
                                              ? Theme.of(context).colorScheme.surface
                                              : Theme.of(context).cardColor
                                          : null,
                                      padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                      child: InkWell(
                                        onTap: () => Get.toNamed(RouteHelper.getSearchRoute()),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                                          margin: const EdgeInsets.symmetric(vertical: 3),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).cardColor,
                                            borderRadius: BorderRadius.circular(20),
                                            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(
                                                CupertinoIcons.search,
                                                size: 25,
                                                color: Theme.of(context).primaryColor,
                                              ),
                                              const SizedBox(width: Dimensions.paddingSizeExtraSmall),
                                              Expanded(
                                                child: Text(
                                                  Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                                                      ? 'search_food_or_restaurant'.tr
                                                      : 'search_item_or_store'.tr,
                                                  style: robotoRegular.copyWith(
                                                    fontSize: Dimensions.fontSizeSmall,
                                                    color: Theme.of(context).hintColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ), 
                             
                        ],
                      ),
                    ),
                  ),
             

          
                SliverToBoxAdapter(
                  child: Center(child: SizedBox(
                    width: Dimensions.webMaxWidth,
                    child: !showMobileModule ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          
                          isGrocery ? const
                          // SizedBox()
                           GroceryHomeScreen()
                          // Notdeliverablescreen()
                          : isPharmacy ? const PharmacyHomeScreen()
                          : isFood ? const FoodHomeScreen()
                          : isShop ? const ShopHomeScreen()
                          : const SizedBox(),
          
                    ]) : ModuleView(splashController: splashController),
                  )),
                ),

           
          isGrocery ||  isShop  ?  SliverToBoxAdapter(
                child: SizedBox(),
               ) :  showMobileModule ? SliverToBoxAdapter(
            child: SizedBox(),
          ) : SliverToBoxAdapter(
                child:  Padding(
                padding: const EdgeInsets.only(left:10),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                  // Text(
                  // Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants'.tr : 'stores'.tr,
                  //   style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  // ),
                  Flexible(
                    child:  Text(
                    ' ${Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants_near_you'.tr : 'stores_near_you'.tr}',
                    maxLines: 1, overflow: TextOverflow.ellipsis,
                    style: robotoRegular.copyWith(color: Colors.black, fontSize: Dimensions.fontSizeExtraLarge,fontWeight: FontWeight.w600),
                  ),
                  ),
                ]),
              ),
               ),
         isGrocery ||  isShop ? SliverToBoxAdapter(
                child: SizedBox(),
               )   :   !showMobileModule ?
                // SliverSafeArea(
                
                // top: true,
                //  sliver:
                  
                  SliverPersistentHeader(
                    key: _headerKey,
                    pinned: true,
                    delegate: SliverDelegate(
                      height:  isPinned ? 70 : 40,
                      callback: (val) {
                        searchBgShow = val;
                        isPinned = val;
                        print('isPinned: $val');
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            // isPinned ? const SizedBox(height: 30) : SizedBox(),
                            Padding(
                              padding:  EdgeInsets.only(top: !isPinned ? 0 : 30),
                              child: const AllStoreFilterWidget(

                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
              //  )
               
                : const SliverToBoxAdapter(),
          
      // Get.find<StoreController>().storeModel!.stores!.isEmpty ? const SliverToBoxAdapter(child: SizedBox()) :  
      
            isGrocery ||  isShop ? SliverToBoxAdapter(
                child: SizedBox(),
               )  :   SliverToBoxAdapter(child: !showMobileModule ? Center(child: GetBuilder<StoreController>(builder: (storeController) {
                  return 
                  Padding(
                    padding: EdgeInsets.only(bottom: ResponsiveHelper.isDesktop(context) ? 0 : 100,),
                    child: 
                    
                    
                     PaginatedListView(
                      
                      scrollController: _scrollController,
                      totalSize: storeController.storeModel?.totalSize,
                      offset: storeController.storeModel?.offset,
                      onPaginate: (int? offset) async => await storeController.getStoreList(offset!, false),
                      itemView: ItemsView(
                        isHome: true,
                        isStore: true,
                        items: null,
                        isFoodOrGrocery: (isFood || isGrocery),
                        stores: storeController.storeModel?.stores,
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall ,
                          // vertical: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault,
                        ),
                      ),
                    ),
                  );
                }),) : const SizedBox()),
          
              ],
            ),
          ),

          // floatingActionButton: AuthHelper.isLoggedIn() && homeController.cashBackOfferList != null && homeController.cashBackOfferList!.isNotEmpty ?
          // homeController.showFavButton ? Padding(
          //   padding: EdgeInsets.only(bottom: 50.0, right: ResponsiveHelper.isDesktop(context) ? 50 : 0),
          //   child: InkWell(
          //     onTap: () => Get.dialog(const CashBackDialogWidget()),
          //     child: const CashBackLogoWidget(),
          //   ),
   floatingActionButton: GetBuilder<CartController>(builder: (cartController) {
  return 
  
  isGrocery ? Stack(
    children: [
      
      Positioned(
        bottom: 120,
        right: 5,
        child:   Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 32, 31, 31),
        borderRadius: BorderRadius.circular(100),
      ),
      
      child: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 32, 31, 31),
        onPressed: (){
                  // showgrocceryMenu(
                  //    context,
                  // );
        
      },
      isExtended: true, 
       child: const Icon(Icons.menu_book_sharp,color: Colors.white,size: 30,),
      
      ),
    ) ,
   
      ),

      // Cart Container (Visible only if cart items > 0)
      if (cartController.cartList.isNotEmpty) 
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 40, bottom: 50),
            child: InkWell(
              onTap: () => Get.toNamed(RouteHelper.getCheckoutRoute('cart')),
              child: Container(
                width: 221,
                height: 50,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(50), 
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                       
                      //  Builder(
                      //    builder: (context) {
                           
                      //      return Image.network(
                      //       cartController.cartList[0].item!.imageFullUrl!,);
                      //    }
                      //  ),
              
                      Padding(
                        padding: const EdgeInsets.all(6),
                        child: Container(
                          height: 38,
                          width: 80,
                                        decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(50), 
                                      ),
                          child: Stack(
                            children: [
                            
                                  for (int index = 0;
                                  //  index < cartController.cartList.length  ; 
                                  index < min(cartController.cartList.length , 3);
                                  //  index < min(cartController.cartList.length, 3);
                                      index++) ...[
                                    Positioned(
                                      left: index * 20,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                        
                                        child:  CustomImage(
                                          image: cartController.cartList[index].item!.imageFullUrl ?? "",
                                          fit: BoxFit.fill,
                                          height: 38,
                                          width: 38,
                                        )
                                        //  Image.network(
                                        //   cartController!.cartList[index].item!.imageFullUrl ?? "",
                                        //   height: 38,
                                        //   width: 38,
                                        //   fit: BoxFit.fill,
                                        // ),
                                      ),
                                    ),
                                  ]
                                 
                              //  Positioned(child: Image.network(cartController.cartList[].item!.imageFullUrl!,height: 50,width: 50,fit: BoxFit.fill,),) 
                            ],
                          ),
                        ),
                      ),
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("View Cart", style: robotoRegular.copyWith(color: Colors.white, fontSize: 15)),
                        Text(
                          "${cartController.cartList.length ?? 0} Items",
                          style: const TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ],
                    ),
              
              
                    Padding(
                      padding: const EdgeInsets.all(6),
                      child: Container(
                        height: 38,
                        width: 38,
                        decoration: BoxDecoration(
                          borderRadius:  BorderRadius.circular(100),
                          color:  const Color(0xFF27093C)
                      ),
                       child:  const Center(child: Icon(CupertinoIcons.right_chevron, color: Colors.white,),),
                      ),
                    )
              
                  ],
                ),
              ),
            ),
          ),
        ),
    ],
  ) : const SizedBox();



}),

          
        );
      });
    });
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  double height;
  Function(bool isPinned)? callback;
  bool isPinned = false;

  SliverDelegate({required this.child, this.height = 50, this.callback});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    isPinned = shrinkOffset == maxExtent /* || shrinkOffset < maxExtent*/;
    callback!(isPinned);
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












void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          height: 300,
          child: Column(
            children: [
              Text(
                'Modal Bottom Sheet',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              // Text('This is a simple bottom sheet example.'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Close the bottom sheet
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
