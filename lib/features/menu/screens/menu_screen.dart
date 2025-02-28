import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/auth/widgets/auth_dialog_widget.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/language/widgets/language_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/menu/widgets/portion_widget.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
bool _isGeneralVisible = false;
bool _ispromotionactVisible = false;
bool _isEarningsVisible = false;
bool _isSupportVisible = false;

class _MenuScreenState extends State<MenuScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: GetBuilder<ProfileController>(builder: (profileController) {
        final bool isLoggedIn = AuthHelper.isLoggedIn();

        return !isLoggedIn ? SizedBox()  :  Column(children: [

          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            child: Padding(
              padding: const EdgeInsets.only(
                left: Dimensions.paddingSizeExtremeLarge, right: Dimensions.paddingSizeExtremeLarge,
                top: 50, bottom: Dimensions.paddingSizeExtremeLarge,
              ),
              child: Row(children: [

            profileController.userInfoModel!.imageFullUrl == null ?  ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: Image.asset(
                              "assets/image/vecteezy_3d-cartoon-man-with-glasses-and-beard-illustration_51767450.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ) :
                    Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(1),
                  child: ClipOval(child: CustomImage(
                    placeholder: Images.guestIconLight,
                    image: '${(profileController.userInfoModel != null && isLoggedIn) ? profileController.userInfoModel!.imageFullUrl : ''}',
                    height: 70, width: 70, fit: BoxFit.cover,
                  )),
                ),

                
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Expanded(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    isLoggedIn && profileController.userInfoModel == null ? Shimmer(
                      child: Container(
                        height: 15, width: 150,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ) : Text(
                      isLoggedIn ? '${profileController.userInfoModel?.fName ?? ''} ${profileController.userInfoModel?.lName ?? ''}' : 'guest_user'.tr,
                      style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
                    ),
                    SizedBox(height: isLoggedIn && profileController.userInfoModel == null ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeExtraSmall),

                    isLoggedIn && profileController.userInfoModel == null ? Shimmer(
                      child: Container(
                        height: 15, width: 100,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ) : isLoggedIn ? Text(
                      profileController.userInfoModel != null ? DateConverter.containTAndZToUTCFormat(profileController.userInfoModel!.createdAt!) : '',
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                    ) : InkWell(
                      onTap: () async {
                        if(!ResponsiveHelper.isDesktop(context)) {
                          await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                          if(AuthHelper.isLoggedIn()) {
                            profileController.getUserInfo();
                          }
                        }else{
                          Get.dialog(const Center(child: AuthDialogWidget(exitFromApp: true, backFromThis: true)));
                        }
                      },
                      child: Text(
                        'login_to_view_all_feature'.tr,
                        style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor),
                      ),
                    ) ,

                  ]),
                ),

              ]),
            ),
          ),

          Expanded(child: SingleChildScrollView(
            child: Ink(
              color: Theme.of(context).primaryColor  ,
              // padding: const EdgeInsets.only(top: Dimensions.paddingSizeLarge),
              child: Column(children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [
                

                  Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(children: [
                      InkWell(
                        onTap:  (){
                          setState(() {
                             _isGeneralVisible = !_isGeneralVisible;
                          });
                        },
                          child: Container(
                            width:MediaQuery.of(context).size.width,
                          
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'general'.tr,
                                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor  ),
                                  textAlign: TextAlign.start,
                                ),
                        
                                Icon(
                                  _isGeneralVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                )
                              ],
                            ),
                          ),
                        ),
                   if(_isGeneralVisible) PortionWidget(icon: Images.profileIcon, title: 'profile'.tr, route: RouteHelper.getProfileRoute()),
                   if(_isGeneralVisible) PortionWidget(icon: Images.addressIcon, title: 'my_address'.tr, route: RouteHelper.getAddressRoute()),
                 if(_isGeneralVisible)  PortionWidget(icon: Images.languageIcon, title: 'language'.tr, hideDivider: true, onTap: ()=> _manageLanguageFunctionality(), route: ''),
                    ]),
                  )

                ]),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(children: [
                       InkWell(
                        onTap: () {
                          setState(() {
                            _ispromotionactVisible = !_ispromotionactVisible;
                          });
                        },
                         child: Container(
                           width:MediaQuery.of(context).size.width,
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 'promotional_activity'.tr,
                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor  ),
                               ),

                                                 Icon(
                             _ispromotionactVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            )
                             ],
                           ),
                         ),
                       ),
                 if(_ispromotionactVisible)     PortionWidget(
                        icon: Images.couponIcon, title: 'coupon'.tr, route: RouteHelper.getCouponRoute(),
                        hideDivider: Get.find<SplashController>().configModel!.loyaltyPointStatus == 1 || Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? false : true,
                      ),
   if(_ispromotionactVisible) 
                      (Get.find<SplashController>().configModel!.loyaltyPointStatus == 1) ? PortionWidget(
                          icon: Images.pointIcon, title: 'loyalty_points'.tr, route: RouteHelper.getLoyaltyRoute(),
                        hideDivider: Get.find<SplashController>().configModel!.customerWalletStatus == 1 ? false : true,
                        suffix: !isLoggedIn ? null : '${profileController.userInfoModel?.loyaltyPoint != null ? profileController.userInfoModel!.loyaltyPoint.toString() : '0'} ${'points'.tr}' ,
                      ) : const SizedBox(),

                 if(_ispromotionactVisible)         (Get.find<SplashController>().configModel!.customerWalletStatus == 1) ? PortionWidget(
                          icon: Images.walletIcon, title: 'my_wallet'.tr, hideDivider: true, route: RouteHelper.getWalletRoute(),
                        suffix: !isLoggedIn ? null : PriceConverter.convertPrice(profileController.userInfoModel != null ? profileController.userInfoModel!.walletBalance : 0),
                      ) : const SizedBox(),
                    ]),
                  )
                ]),

                (Get.find<SplashController>().configModel!.refEarningStatus == 1 ) || (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) ||
                    (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ?
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                 

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Column(children: [
    InkWell(
                        onTap: () {
                          setState(() {
                            _isEarningsVisible = !_isEarningsVisible;
                          });
                        },
                         child: Container(
                           width:MediaQuery.of(context).size.width,
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 'Earnings'.tr,
                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor  ),
                               ),
                                                 Icon(
                              _isEarningsVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            )
                             ],
                           ),
                         ),
                       ),
              if (_isEarningsVisible)        (Get.find<SplashController>().configModel!.refEarningStatus == 1 ) ? PortionWidget(
                          icon: Images.referIcon, title: 'refer_and_earn'.tr, route: RouteHelper.getReferAndEarnRoute(),
                        hideDivider: (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) ||
                            (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ? false : true,
                      ) : const SizedBox(),

                if (_isEarningsVisible)          (Get.find<SplashController>().configModel!.toggleDmRegistration! && !ResponsiveHelper.isDesktop(context)) ? PortionWidget(
                          icon: Images.dmIcon, title: 'join_as_a_delivery_man'.tr, route: RouteHelper.getDeliverymanRegistrationRoute(),
                        hideDivider: (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ? false : true,
                      ) : const SizedBox(),

                  if (_isEarningsVisible)        (Get.find<SplashController>().configModel!.toggleStoreRegistration! && !ResponsiveHelper.isDesktop(context)) ? PortionWidget(
                          icon: Images.storeIcon, title: 'open_store'.tr, hideDivider: true, route: RouteHelper.getRestaurantRegistrationRoute(),
                      ) : const SizedBox(),
                    ]),
                  )
                ]) : const SizedBox(),

                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
               

                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                      boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeDefault),
                    margin: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child:
                     Column(children: [

                      InkWell(
                        onTap: () {
                          setState(() {
                            _isSupportVisible = !_isSupportVisible;
                          });
                        },
                         child: Container(
                           width:MediaQuery.of(context).size.width,
                           child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text(
                                 'help_and_support'.tr,
                                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, color: Theme.of(context).primaryColor  ),
                               ),
                                                 Icon(
                               _isSupportVisible ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                            )
                             ],
                           ),
                         ),
                       ),
                  if(_isSupportVisible)    PortionWidget(icon: Images.chatIcon, title: 'live_chat'.tr, route: RouteHelper.getConversationRoute()),
                     if(_isSupportVisible)   PortionWidget(icon: Images.helpIcon, title: 'help_and_support'.tr, route: RouteHelper.getSupportRoute()),
                     if(_isSupportVisible)   PortionWidget(icon: Images.aboutIcon, title: 'about_us'.tr, route: RouteHelper.getHtmlRoute('about-us')),
                     if(_isSupportVisible)   PortionWidget(icon: Images.termsIcon, title: 'terms_conditions'.tr, route: RouteHelper.getHtmlRoute('terms-and-condition')),
                     if(_isSupportVisible)   PortionWidget(icon: Images.privacyIcon, title: 'privacy_policy'.tr, route: RouteHelper.getHtmlRoute('privacy-policy')),

                     if(_isSupportVisible)   (Get.find<SplashController>().configModel!.refundPolicyStatus == 1 ) ? PortionWidget(
                          icon: Images.refundIcon, title: 'refund_policy'.tr, route: RouteHelper.getHtmlRoute('refund-policy'),
                        hideDivider: (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1 ) ||
                            (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1 ) ? false : true,
                      ) : const SizedBox(),

                     if(_isSupportVisible)   (Get.find<SplashController>().configModel!.cancellationPolicyStatus == 1 ) ? PortionWidget(
                          icon: Images.cancelationIcon, title: 'cancellation_policy'.tr, route: RouteHelper.getHtmlRoute('cancellation-policy'),
                        hideDivider: (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1 ) ? false : true,
                      ) : const SizedBox(),

                     if(_isSupportVisible)   (Get.find<SplashController>().configModel!.shippingPolicyStatus == 1 ) ? PortionWidget(
                          icon: Images.shippingIcon, title: 'shipping_policy'.tr, hideDivider: true, route: RouteHelper.getHtmlRoute('shipping-policy'),
                      ) : const SizedBox(),
                    ]),
                
                  )
                ]),
            
                InkWell(
                  onTap: () async {
                    if(AuthHelper.isLoggedIn()) {
                      Get.dialog(ConfirmationDialog(icon: Images.support, description: 'are_you_sure_to_logout'.tr, isLogOut: true, onYesPressed: () async {
                        Get.find<ProfileController>().clearUserInfo();
                        Get.find<AuthController>().socialLogout();
                        Get.find<CartController>().clearCartList(canRemoveOnline: false);
                        Get.find<FavouriteController>().removeFavourite();
                        await Get.find<AuthController>().clearSharedData();
                        Get.find<HomeController>().forcefullyNullCashBackOffers();
                        Get.offAllNamed(RouteHelper.getSignInRoute(RouteHelper.splash));
                      }), useSafeArea: false);
                    }else {
                      Get.find<FavouriteController>().removeFavourite();
                      await Get.toNamed(RouteHelper.getSignInRoute(Get.currentRoute));
                      if(AuthHelper.isLoggedIn()) {
                        await Get.find<FavouriteController>().getFavouriteList();
                        profileController.getUserInfo();
                        Get.find<ProfileController>().clearUserInfo();
                        Get.find<AuthController>().socialLogout();
                        Get.find<CartController>().clearCartList(canRemoveOnline: false);
                        Get.find<FavouriteController>().removeFavourite();
                        await Get.find<AuthController>().clearSharedData();
                        Get.find<HomeController>().forcefullyNullCashBackOffers();
                        // Get.offAllNamed(RouteHelper.getInitialRoute());

                      }
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Container(
                        padding: const EdgeInsets.all(2),
                        // decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.r),
                        child:  
                        Icon(Icons.exit_to_app, size: 20, color: Theme.of(context).cardColor),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeExtraSmall),

                      Text(AuthHelper.isLoggedIn() ? 'logout'.tr : 'sign_in'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Colors.white))
                    ]),
                  ),
                ),

                SizedBox(height: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtremeLarge : 100),

              ]),
            ),
          )),
        ]);
      }),
    );
  }

  _manageLanguageFunctionality() {
    Get.find<LocalizationController>().saveCacheLanguage(null);
    Get.find<LocalizationController>().searchSelectedLanguage();

    showModalBottomSheet(
      isScrollControlled: true, useRootNavigator: true, context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const LanguageBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<LocalizationController>().setLanguage(Get.find<LocalizationController>().getCacheLocaleFromSharedPref()));
  }

}
