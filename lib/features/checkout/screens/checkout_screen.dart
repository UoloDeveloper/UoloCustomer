

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/common/models/config_model.dart';
import 'package:sixam_mart/common/widgets/address_widget.dart';
import 'package:sixam_mart/common/widgets/custom_dropdown.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/custom_text_field.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/cart/screens/cart_screen.dart';
import 'package:sixam_mart/features/cart/widgets/cart_item_widget.dart';
import 'package:sixam_mart/features/cart/widgets/delivery_option_button_widget.dart';
import 'package:sixam_mart/features/cart/widgets/extra_packaging_widget.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/checkout/domain/models/place_order_body_model.dart';
import 'package:sixam_mart/features/checkout/widgets/bottom_section.dart';
import 'package:sixam_mart/features/checkout/widgets/deliveroption.dart';

import 'package:sixam_mart/features/checkout/widgets/delivery_section.dart';
import 'package:sixam_mart/features/checkout/widgets/note_prescription_section.dart';
import 'package:sixam_mart/features/checkout/widgets/partial_pay_view.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_method_bottom_sheet.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_section.dart';
import 'package:sixam_mart/features/checkout/widgets/placeorderbottomsheet.dart';
import 'package:sixam_mart/features/checkout/widgets/top_section.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/home/controllers/home_controller.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/features/loyalty/screens/loyalty_screen.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/module_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/common/widgets/web_constrained_box.dart';
import 'package:sixam_mart/common/widgets/web_page_title_widget.dart';
import 'package:sixam_mart/features/cart/widgets/web_cart_items_widget.dart';
import 'package:sixam_mart/features/cart/widgets/web_suggested_item_view_widget.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
    final List<CartModel?>? cartList;
  final bool fromCart;
  final int? storeId;
    final String? storename;
  const CheckoutScreen({super.key, this.cartList, required this.fromCart, this.storeId, this.storename});

  @override
  State<CheckoutScreen> createState() => _CheckoutState();
}

class _CheckoutState extends State<CheckoutScreen> {
  final ScrollController scrollController = ScrollController();
  GlobalKey<ExpandableBottomSheetState> key = GlobalKey();
  final GlobalKey _widgetKey = GlobalKey();
  double _height = 0;







  
  final ScrollController _scrollController = ScrollController();
  final JustTheController tooltipController1 = JustTheController();
  final JustTheController tooltipController2 = JustTheController();
  final JustTheController tooltipController3 = JustTheController();

  double? _taxPercent = 0;
  bool? _isCashOnDeliveryActive = false;
  bool? _isDigitalPaymentActive = false;
  bool _isOfflinePaymentActive = false;
  List<CartModel?>? _cartList;
  bool _isWalletActive = false;
  String _deliveryChargeForView = '';

  List<AddressModel> address = [];
  bool canCheckSmall = false;
  double? _payableAmount = 0;
  double badWeatherChargeForToolTip = 0;
  double extraChargeForToolTip = 0;
  bool isPassedVariationPrice = false;

  final TextEditingController guestContactPersonNameController = TextEditingController();
  final TextEditingController guestContactPersonNumberController = TextEditingController();
  final TextEditingController guestEmailController = TextEditingController();
  final TextEditingController guestPasswordController = TextEditingController();
  final TextEditingController guestConfirmPasswordController = TextEditingController();
  final FocusNode guestNumberNode = FocusNode();
  final FocusNode guestEmailNode = FocusNode();
  final FocusNode guestPasswordNode = FocusNode();
  final FocusNode guestConfirmPasswordNode = FocusNode();

  bool _firstTimeCheckPayment = false;
     

  @override
  void initState() {
    super.initState();
    initCall();
  }

  Future<void> initCall() async {
    
    if (Get.find<CartController>().cartList.isEmpty) {
      await Get.find<CartController>().getCartDataOnline();
    }
    if (Get.find<CartController>().cartList.isNotEmpty) {
      Get.find<CartController>().calculationCart();
    }


    bool isLoggedIn = AuthHelper.isLoggedIn();
      // Get.find<CheckoutController>().setGuestAddress(null, isUpdate: false);
      Get.find<CheckoutController>().streetNumberController.text = AddressHelper.getUserAddressFromSharedPref()!.streetNumber ?? '';
      Get.find<CheckoutController>().houseController.text = AddressHelper.getUserAddressFromSharedPref()!.house ?? '';
      Get.find<CheckoutController>().floorController.text = AddressHelper.getUserAddressFromSharedPref()!.floor ?? '';
      Get.find<CheckoutController>().couponController.text = '';

      Get.find<CheckoutController>().getDmTipMostTapped();
      Get.find<CheckoutController>().setPreferenceTimeForView('', isUpdate: false);

      Get.find<CheckoutController>().getOfflineMethodList();

      if(Get.find<CheckoutController>().isCreateAccount) {
        Get.find<CheckoutController>().toggleCreateAccount(willUpdate: false);
      }

      if(Get.find<CheckoutController>().isPartialPay){
        Get.find<CheckoutController>().changePartialPayment(isUpdate: false);
      }

      if(isLoggedIn) {
        if(Get.find<ProfileController>().userInfoModel == null) {
          Get.find<ProfileController>().getUserInfo();
        }

        Get.find<CouponController>().getCouponList();

        if(Get.find<AddressController>().addressList == null) {
          Get.find<AddressController>().getAddressList();
        }
      }

      if(widget.storeId == null){
        _cartList = [];
        if(GetPlatform.isWeb) {
         await Get.find<CartController>().getCartDataOnline();
        }
        widget.fromCart ? _cartList!.addAll(Get.find<CartController>().cartList) : _cartList!.addAll(widget.cartList!);
        if(_cartList != null && _cartList!.isNotEmpty) {
          Get.find<CheckoutController>().initCheckoutData(_cartList![0]!.item!.storeId);
        }
      }
      if(widget.storeId != null){
        Get.find<CheckoutController>().initCheckoutData(widget.storeId);
        Get.find<CouponController>().removeCouponData(false);
      }
      Get.find<CheckoutController>().pickPrescriptionImage(isRemove: true, isCamera: false);
      _isWalletActive = Get.find<SplashController>().configModel!.customerWalletStatus == 1;
      Get.find<CheckoutController>().updateTips(
        Get.find<CheckoutController>().getSharedPrefDmTipIndex().isNotEmpty ? int.parse(Get.find<CheckoutController>().getSharedPrefDmTipIndex()) : 0,
        notify: false,
      );
      Get.find<CheckoutController>().tipController.text = Get.find<CheckoutController>().selectedTips != -1 ? AppConstants.tips[Get.find<CheckoutController>().selectedTips] : '';

  }

  void _getExpandedBottomSheetHeight() {
    final RenderBox renderBox = _widgetKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;

    setState(() {
      _height = size.height;
    });
  }


  void _setSinglePaymentActive() {
    if((!_firstTimeCheckPayment && !_isCashOnDeliveryActive! && _isDigitalPaymentActive! && Get.find<SplashController>().configModel!.activePaymentMethodList!.length == 1) && ((!_isWalletActive && AuthHelper.isLoggedIn()) || !AuthHelper.isLoggedIn()) ) {
      Future.delayed(const Duration(milliseconds: 600), (){
        Get.find<CheckoutController>().setPaymentMethod(2, isUpdate: false);
        Get.find<CheckoutController>().changeDigitalPaymentName(Get.find<SplashController>().configModel!.activePaymentMethodList![0].getWay!, willUpdate: false);
        _firstTimeCheckPayment = true;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();

    guestContactPersonNameController.dispose();
    guestContactPersonNumberController.dispose();
  }



  @override
  Widget build(BuildContext context) {
    bool isDesktop = ResponsiveHelper.isDesktop(context);
 String currency = Get.find<CartController>().getCurrncyForUi();
    Module? module = Get.find<SplashController>().configModel!.moduleConfig!.module;
    bool guestCheckoutPermission = AuthHelper.isGuestLoggedIn() && Get.find<SplashController>().configModel!.guestCheckoutStatus!;
    bool isLoggedIn = AuthHelper.isLoggedIn();



    
    return GetBuilder<CheckoutController>(builder: (checkoutController) {
        List<DropdownItem<int>> addressList = _getDropdownAddressList(context: context, addressList: Get.find<AddressController>().addressList, store: checkoutController.store);
        return
         Scaffold(
          backgroundColor:Color(0xFFF0F0F5) ,
          // appBar: 
          
          
//       AppBar(
// elevation: 0,
//   // title: null, // Set title to null if not needed
//   flexibleSpace: SafeArea(
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 0), // Optional padding
//       child: DeliverySection2(
//         checkoutController: checkoutController,
//         address: address,
//         addressList: addressList,
//         guestNameTextEditingController: guestContactPersonNameController,
//         guestNumberTextEditingController: guestContactPersonNumberController,
//         guestNumberNode: guestNumberNode,
//         guestEmailController: guestEmailController,
//         guestEmailNode: guestEmailNode,
//       ),
//     ),
//   ),
// ),

          // endDrawer: const MenuDrawer(),
          body: GetBuilder<CartController>(builder: (cartController) {
            return cartController.cartList.isNotEmpty
                ? GetBuilder<CheckoutController>(builder: (checkoutController) {
                  
            
            address =  _getAddressList(addressList: Get.find<AddressController>().addressList, store: checkoutController.store) ;
        
            bool todayClosed = false;
            bool tomorrowClosed = false;
            Pivot? moduleData = _getModuleData(store: checkoutController.store);
            _isCashOnDeliveryActive = _checkCODActive(store: checkoutController.store);
            _isDigitalPaymentActive = _checkDigitalPaymentActive(store: checkoutController.store);
            _isOfflinePaymentActive = Get.find<SplashController>().configModel!.offlinePaymentStatus! && _checkZoneOfflinePaymentOnOff(addressModel: AddressHelper.getUserAddressFromSharedPref(), checkoutController: checkoutController);
            if(checkoutController.store != null) {
              todayClosed = checkoutController.isStoreClosed(true, checkoutController.store!.active!, checkoutController.store!.schedules);
              tomorrowClosed = checkoutController.isStoreClosed(false, checkoutController.store!.active!, checkoutController.store!.schedules);
              _taxPercent = checkoutController.store!.tax;
            }
                    return GetBuilder<CouponController>(builder: (couponController) {
                    
                       double? maxCodOrderAmount;
                    
                              if(moduleData != null) {
                    maxCodOrderAmount = moduleData.maximumCodOrderAmount;
                              }
                              double price = _calculatePrice(store: checkoutController.store, cartList: _cartList);
                              double addOns = _calculateAddonsPrice(store: checkoutController.store, cartList: _cartList);
                              double variations = _calculateVariationPrice(store: checkoutController.store, cartList: _cartList, calculateWithoutDiscount: true);
                              double? discount = _calculateDiscount(
                    store: checkoutController.store, cartList: _cartList, price: price, addOns: addOns,
                              );
                              double couponDiscount = PriceConverter.toFixed(couponController.discount!);
                              bool taxIncluded = Get.find<SplashController>().configModel!.taxIncluded == 1;
                    
                              double subTotal = 
                               Get.find<CartController>().subTotal;
                              
                              // _calculateSubTotal(price: price, addOns: addOns, variations: variations, cartList: _cartList);
                    
                              double referralDiscount = _calculateReferralDiscount(subTotal, discount, couponDiscount);
                    
                              double orderAmount = _calculateOrderAmount(
                    price: price, variations: variations, discount: discount, addOns: addOns,
                    couponDiscount: couponDiscount, cartList: _cartList, referralDiscount: referralDiscount,
                              );
                    
                              double tax = _calculateTax(
                    taxIncluded: taxIncluded, orderAmount: orderAmount, taxPercent: _taxPercent,
                              );
                    
                              double additionalCharge =  Get.find<SplashController>().configModel!.additionalChargeStatus!
                      ? Get.find<SplashController>().configModel!.additionCharge! : 0;
                              double originalCharge = _calculateOriginalDeliveryCharge(
                    store: checkoutController.store, address: AddressHelper.getUserAddressFromSharedPref()!,
                    distance: checkoutController.distance, extraCharge: checkoutController.extraCharge,
                              );
                              double deliveryCharge = _calculateDeliveryCharge(
                    store: checkoutController.store, address: AddressHelper.getUserAddressFromSharedPref()!, distance: checkoutController.distance,
                    extraCharge: checkoutController.extraCharge, orderType: checkoutController.orderType!, orderAmount: orderAmount,
                              );
                    
                              if(checkoutController.orderType != 'take_away' && checkoutController.store != null) {
                    _deliveryChargeForView = (checkoutController.orderType == 'delivery' ? checkoutController.store!.freeDelivery! : true) ? 'free'.tr
                        : deliveryCharge != -1 ? PriceConverter.convertPrice(deliveryCharge,currency:currency) : 'calculating'.tr;
                              }
                    
                              double extraPackagingCharge = _calculateExtraPackagingCharge(checkoutController);
                    
                              double total = _calculateTotal(
                    subTotal: subTotal, deliveryCharge: deliveryCharge, discount: discount,
                    couponDiscount: couponDiscount, taxIncluded: taxIncluded, tax: tax, orderType: checkoutController.orderType!,
                    tips: checkoutController.tips, additionalCharge: additionalCharge, extraPackagingCharge: extraPackagingCharge,
                              );
                    
                              bool isPrescriptionRequired = _checkPrescriptionRequired();

                  
                    
                              total = total - referralDiscount;
                    
                              if(widget.storeId != null){
                    checkoutController.setPaymentMethod(0, isUpdate: false);
                              }
                              checkoutController.setTotalAmount(total - (checkoutController.isPartialPay ? Get.find<ProfileController>().userInfoModel!.walletBalance! : 0));
                    
                              if(_payableAmount != checkoutController.viewTotalPrice && checkoutController.distance != null && isLoggedIn) {
                    _payableAmount = checkoutController.viewTotalPrice;
                    showCashBackSnackBar();
                              }
                    
                              _setSinglePaymentActive();


                                 AddressModel? selectedAddress = checkoutController.addressIndex != null 
        ? address[checkoutController.addressIndex!] 
        : null;
                        return    Stack(
                          children: [
                            CustomScrollView(
                                slivers: [

                                  SliverAppBar(
                                    pinned: true,
                                       leading: Padding(
                                         padding: const EdgeInsets.all(8.0),
                                         child: IconButton(
                                                                   onPressed: () => Get.back(),
                                                                   icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                                                                 ),
                                       ),
                                    title:Padding(
                                      padding: const EdgeInsets.only(top : 15,left: 10),
                                      child: InkWell(
                                          onTap: (){
                                           
                                            _showAddressDropdown(
                                              context,
                                             addressList,
                                             checkoutController,
                                              address
                            
                            
                                            ); // Show the bottom sheet
                                            },
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                             Padding(
                                               padding: const EdgeInsets.only(left: 10 ),
                                               child: Text("${checkoutController.store!.name}",style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w400,
                                                    color: const Color.fromARGB(109, 27, 26, 26)
                                                  ),),
                                             ),
                                            Row(children: [
                                            SizedBox(width: 5,),
                                              Icon(
                                                Icons.near_me,
                                                size: 18,
                                                color: const Color.fromARGB(239, 55, 55, 55),
                                              ),
                                                Text("${selectedAddress!.addressType}",style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),),
                                                                  Container(
                                                    height: 13, // Thickness of the divider
                                                    width: 1, // Width of the divider
                                                    color: const Color.fromARGB(239, 55, 55, 55), // Color of the divider
                                                    margin: EdgeInsets.symmetric(horizontal: 8), // Space around the divider
                                                  ),
                                                                        Flexible(
                                                                          child: Text("${selectedAddress!.address}",style: TextStyle(
                                                                            fontSize: 14,
                                                                            fontWeight:FontWeight.w500 ,
                                                                            color: const Color.fromARGB(109, 27, 26, 26)
                                                                          ),
                                                                          overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        )
                                                                       ],),
                                          ],
                                        ),
                                      ),
                                    ),
                                   leadingWidth: 10,
                              //  leading: 
                               ),
                                              //                 SliverAppBar(
                                  
                                  
                                              //                 forceMaterialTransparency: false,
                                              //                   // systemOverlayStyle:     ,
                                              //   // scrolledUnderElevation:  ,                
                                              //   elevation: 0,
                                              //   pinned: true,
                                                 
                                              //   flexibleSpace: SafeArea(
                                              //     child: DeliverySection2(
                                              //       checkoutController: checkoutController,
                                              //       address: address,
                                              //       addressList: addressList,
                                              //       guestNameTextEditingController: guestContactPersonNameController,
                                              //       guestNumberTextEditingController: guestContactPersonNumberController,
                                              //       guestNumberNode: guestNumberNode,
                                              //       guestEmailController: guestEmailController,
                                              //       guestEmailNode: guestEmailNode,
                                              //     ),
                                              //   ),
                                              // ),
                             
                             
                                   SliverToBoxAdapter(
                                    child: Column(
                                        children: [
                                              discount > 0 ?    Padding(
                                                      padding: const EdgeInsets.all(8),
                                                      child: Container(
                                                        decoration:  BoxDecoration(
                                                          color: Theme.of(context).primaryColor.withOpacity(0.1)
                                                          
                                                          //  Color(0xFFD7E5FF)
                                            ,
                                                          borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                                                        ),
                                                        width: double.infinity,height: 43,
                                            
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Row(
                                                            children: [
                                                          
                                    Text("🥳",  style: TextStyle(
                                      fontSize: Dimensions.fontSizeLarge
                                    ),),
                                    const SizedBox(width: 5,),
                                    Text(
                                      'You saved ${PriceConverter.convertPrice( discount,currency:currency)} on delivery',
                                      style: robotoBold.copyWith(color: Theme.of(context).primaryColor.withOpacity(0.8)
                                      
                                      //  const Color(0xFF366BC9)
                                        ,fontSize: Dimensions.fontSizeSmall), // Change 'Colors.green' to your desired color
                                    ),
                                                            ],
                                                          ),
                                                        ),
                                            
                                                      ),
                                                    ): const SizedBox(),
                                           
                                                DeliveryOptionsWidget(originalCharge:  originalCharge, deliveryCharge:deliveryCharge , extraChargeForToolTip:extraChargeForToolTip , badWeatherChargeForToolTip: badWeatherChargeForToolTip, total:  total, deliveryChargeForView: _deliveryChargeForView, checkoutController: checkoutController,)   , 
                                                      Padding(
                                                        padding: const EdgeInsets.only(bottom: 8,left: 8,right: 8),
                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                    WebConstrainedBox(
                                                                      dataLength: cartController.cartList.length, minLength: 5, minHeight: 0.6,
                                                                      child: Container(
                                                                           decoration: BoxDecoration(
                                                                              color: Theme.of(context).cardColor,
                                                                                    borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                                                                              boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 10)],
                                                                        
                                                                            ),
                                                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                                                          Container(
                                                                         
                                                                            child: ListView.builder(
                                                                              physics: const NeverScrollableScrollPhysics(),
                                                                              shrinkWrap: true,
                                                                              itemCount: cartController.cartList.length,
                                                                              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                                                                              itemBuilder: (context, index) {
                                                                                return CartItemWidget(cart: cartController.cartList[index], cartIndex: index, addOns: cartController.addOnsList[index], isAvailable: cartController.availableList[index]);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          // const Divider(thickness: 0.5, height: 5),

                                                                          Padding(
                                                                            padding: const EdgeInsets.only(left: 20),
                                                                            child: Row(
                                                                              children: [
                                                                                CustomInkWell(
                                                                                  onTap: () {
                                                                                 setState(() {

                                                                                  if(checkoutController.showadditionalnote == true){
                                                                                    checkoutController.showadditionalnote = false;
                                                                                  }else
                                                                                     checkoutController.showadditionalnote = true;
                                                                                 });  
                                      
                                                                                  },
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                                                                                      border: Border.all(
                                                                                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                        width: 0.5,
                                                                                      ),
                                                                                      
                                                                                      //  Border(
                                                                                      //   b
                                                                                      //   top: BorderSide(
                                                                                      //     color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                      //     width: 0.5,
                                                                                      //   ),
                                                                                      // ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text("Cooking request",style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w400
                                                                                      ),),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                            
                                                                            
                                                                            SizedBox(width: 10,),
                                                                              CustomInkWell(

                                                                                radius: Dimensions.radiusLarge,
                                                                                onTap: () {
                                                                                    cartController.forcefullySetModule(cartController.cartList[0].item!.moduleId!);
                                                                                    Get.toNamed(
                                                                                      RouteHelper.getStoreRoute(id: cartController.cartList[0].item!.storeId, page: 'item'),
                                                                                      arguments: StoreScreen(store: Store(id: cartController.cartList[0].item!.storeId), fromModule: false),
                                                                                    );
                                                                                  },
                                                                                child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusLarge)),
                                                                                      border: Border.all(
                                                                                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                        width: 0.5,
                                                                                      ),
                                                                                      
                                                                                      //  Border(
                                                                                      //   b
                                                                                      //   top: BorderSide(
                                                                                      //     color: Theme.of(context).primaryColor.withOpacity(0.1),
                                                                                      //     width: 0.5,
                                                                                      //   ),
                                                                                      // ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.all(8.0),
                                                                                      child: Text("add More Items",style: TextStyle(
                                                                                        fontSize: 14,
                                                                                        fontWeight: FontWeight.w400
                                                                                      ),),
                                                                                    ),
                                                                                  ),
                                                                              ),
                                                                            
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        
                                                                        
                                                                        
                                                                   
     

      checkoutController.showadditionalnote ? Padding(
        padding: const EdgeInsets.only(left: 20,right: 20,top: 20),
        child: CustomTextField(
      showBorder: false,
              controller: checkoutController.noteController,
              titleText: 'Type cooking requests'.tr,

              showLabelText: false,
              maxLines: 4,
              inputType: TextInputType.multiline,
              inputAction: TextInputAction.done,
              capitalization: TextCapitalization.sentences,
            ),
      ) : SizedBox(),
          const SizedBox(height: Dimensions.paddingSizeLarge),
                                                                          ExtraPackagingWidget(cartController: cartController),
                                                                        ]),
                                                                      ),
                                                                    ),
                                                                    // const SizedBox(height: Dimensions.paddingSizeSmall),
                                                                    // !ResponsiveHelper.isDesktop(context) ? pricingView(cartController, cartController.cartList[0].item!) : const SizedBox(),
                                                                  ]),
                                                      ),
     
     
     
     
      //                                        Padding(
      //    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
      //    child: Container(
      //     decoration: BoxDecoration(
      //       color: Theme.of(context).cardColor,
      //       borderRadius: BorderRadius.circular(Dimensions.radiusLarge)
      //     ),
      //      child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //        children: [

      //         Padding(
      //           padding: const EdgeInsets.only(left: 10,top: 10),
      //           child: Text("Deliverd to",style: robotoMedium),
      //         ),
      //          InkWell(
      //           onTap: () {
      //              _showAddressDropdown(
      //                                             context,
      //                                            addressList,
      //                                            checkoutController,
      //                                             address
                                
                                
      //                                           );
      //           },
      //            child: AddressWidget(
      //                       address: address[checkoutController.addressIndex!],
      //                       fromAddress: false, fromCheckout: true,
      //               ),
      //          ),
      //        ],
      //      ),
      //    ),
      //  ),
                                         
                                         
                                                           TopSection(
                                                            Currency: currency,
                                      checkoutController: checkoutController, charge: originalCharge, deliveryCharge: deliveryCharge,
                                      addressList: addressList,
                                      tomorrowClosed: tomorrowClosed, todayClosed: todayClosed, module : module, price: price,
                                      discount: discount, addOns: addOns, address: address, cartList: _cartList, isCashOnDeliveryActive: _isCashOnDeliveryActive!,
                                      isDigitalPaymentActive: _isDigitalPaymentActive!, isWalletActive: _isWalletActive, storeId: widget.storeId,
                                      total: total, isOfflinePaymentActive: _isOfflinePaymentActive, guestNameTextEditingController: guestContactPersonNameController,
                                      guestNumberTextEditingController: guestContactPersonNumberController, guestNumberNode: guestNumberNode,
                                      guestEmailController: guestEmailController, guestEmailNode: guestEmailNode,
                                      tooltipController1: tooltipController1, tooltipController2: tooltipController2, dmTipsTooltipController: tooltipController3,
                                      guestPasswordController: guestPasswordController, guestConfirmPasswordController: guestConfirmPasswordController,
                                      guestPasswordNode: guestPasswordNode, guestConfirmPasswordNode: guestConfirmPasswordNode, variationPrice: isPassedVariationPrice ? variations : 0,
                                      deliveryChargeForView: _deliveryChargeForView, badWeatherCharge: badWeatherChargeForToolTip, extraChargeForToolTip: extraChargeForToolTip,
                                    ),
                                    
                                            
      //                                           Padding(
      //    padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
      //    child: Container(
      //     decoration: BoxDecoration(
      //       color: Theme.of(context).cardColor,
      //       borderRadius: BorderRadius.circular(Dimensions.radiusLarge)
      //     ),
      //      child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //        children: [

      //         Padding(
      //           padding: const EdgeInsets.only(left: 10,top: 10),
      //           child: Text("Deliverd to",style: robotoMedium),
      //         ),
      //          InkWell(
      //           onTap: () {
      //              _showAddressDropdown(
      //                                             context,
      //                                            addressList,
      //                                            checkoutController,
      //                                             address
                                
                                
      //                                           );
      //           },
      //            child: AddressWidget(
      //                       address: address[checkoutController.addressIndex!],
      //                       fromAddress: false, fromCheckout: true,
      //               ),
      //          ),
      //        ],
      //      ),
      //    ),
      //  ),
                                       
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                                      child: BottomSection(
                                        checkoutController: checkoutController, total: total ?? 0, 
                                        
                                        module: module! , subTotal: subTotal,
                                        discount: discount, couponController: couponController, taxIncluded: taxIncluded, tax: tax,
                                        deliveryCharge: deliveryCharge,
                                        todayClosed: todayClosed,tomorrowClosed: tomorrowClosed, orderAmount: orderAmount,
                                        maxCodOrderAmount: maxCodOrderAmount, storeId: widget.storeId, taxPercent: _taxPercent, price: price, addOns : addOns,
                                        isPrescriptionRequired: isPrescriptionRequired, checkoutButton: _orderPlaceButton(
                                          checkoutController, todayClosed, tomorrowClosed, orderAmount, deliveryCharge,
                                          tax, discount, total, maxCodOrderAmount, isPrescriptionRequired,currency
                                        ), referralDiscount: referralDiscount, variationPrice: isPassedVariationPrice ? variations : 0, distance: checkoutController.distance ?? 0, dicount: discount, SelectedAddress: selectedAddress,
                                      ),
                                    ),
                                                                    
                                    
                                                        !ResponsiveHelper.isDesktop(context) ? suggestedItemView(cartController.cartList) : const SizedBox(), 
                                         // ResponsiveHelper.isDesktop(context) ? const 
                                          // SizedBox.shrink() : CheckoutButton(cartController: cartController, availableList: cartController.availableList),
                                    
                                    //        ResponsiveHelper.isDesktop(context) ? const SizedBox() : Container(
                                    //                 decoration: BoxDecoration(
                                    //                   color: Colors.white,
                                    //                   // boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 10)],
                                    //                 ),
                                    //                 child: Column(
                                    //                   children: [
                                    // // Padding(
                                    // //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
                                    // //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                    // //     Text(
                                    // //       checkoutController.isPartialPay ? 'due_payment'.tr : 'total_amount'.tr,
                                    // //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                                    // //     ),
                                    // //     PriceConverter.convertAnimationPrice(
                                    // //       currency: currency,
                                    // //       checkoutController.viewTotalPrice,
                                    // //       textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
                                    // //     ),
                                    // //   ]),
                                    // // ),
                                    
                                    // // _orderPlaceButton(
                                    // //     checkoutController, todayClosed, tomorrowClosed, orderAmount, deliveryCharge, tax, discount, total, maxCodOrderAmount, isPrescriptionRequired,  currency
                                    // // ),

                            
                                    //                   ],
                                    //                 ),
                                    //               ),

   
                                    SizedBox(height: 30,),
                                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:  [
                          Text("PAYMENT PREFERENCES",style: TextStyle(
                             color:  const Color(0xFF868686),
                             fontSize: Dimensions.fontSizeExtraLarge,
                              fontWeight: FontWeight.w400
                          ),),
                        ],
                      ),
SizedBox(height: 20,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width /2,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Cash on Delivery Preferred",style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600
                                  ),),
                                      Text("We prefer cash on delivery, even though the delivery personnel have all online UPI payment options",style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF868686)
                                      ),),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                SvgPicture.asset("assets/image/freepik--background-complete--inject-31.svg", width: 106, height: 121),
                                Positioned(
                                  left: 40,
                                  top: 50,
                                  child: Image.asset("assets/image/Indian-shopkeeper-is-holding-money-in-hand-10-small 1.png", height: 84, width: 84)),
                              ],
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          color: Colors.white,
                           
                        ),
              
                        child:const Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment:   MainAxisAlignment.center ,
                            children: [
                          
                              Paymenticoncard(image: "assets/image/paytmlogo.png"),
                              SizedBox(width: 10,),
                              Paymenticoncard(image: "assets/image/gpayicon.png"),
                              SizedBox(width: 10,),
                              Paymenticoncard(image: "assets/image/png-transparent-phonepe-india-unified-payments-interface-india-purple-violet-text 1.png"),
                              SizedBox(width: 10,),
                              Paymenticoncard(image: "assets/image/bharat-interface-for-money-bhim-logo-vector 1.png"),
                              SizedBox(width: 10,),
                              Paymenticoncard(image: "assets/image/5968269 1.png")
                            
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: 10,),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cancelation Policy".toUpperCase(),style: TextStyle(
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500, 
                                color: Color.fromARGB(255, 177, 175, 175),  
                                fontFamily: 'Poppins'
                                ),
                                textAlign: TextAlign.left,
                                ),
                                 Text("Help us reduce food waste by avoiding cancellation. The amount paid in non-refundabale after placing  the order".toLowerCase(),style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w500, 
                                color: Color.fromARGB(255, 177, 175, 175),
                                fontFamily: 'Poppins'
                                ),
                                textAlign: TextAlign.left,
                                ),
                            ],
                          ),
                        ),
                      ),
                       SizedBox(height: 200,),
                                        ],
                                      ),
                                  ),
                              
                              
                                ],
                              
                            ),

//                                ResponsiveHelper.isDesktop(context) ? const SizedBox() : Container(
//                         decoration: BoxDecoration(
//                           color: Theme.of(context).cardColor,
//                           boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 10)],
//                         ),
//                         child: Column(
//                           children: [

//       //                       GetBuilder<CheckoutController>(
//       // builder: (checkoutController) {
//       //   return Get.find<SplashController>().configModel!.partialPaymentStatus! 
//       //   && Get.find<SplashController>().configModel!.customerWalletStatus == 1
//       //   && Get.find<ProfileController>().userInfoModel!.walletBalance! > 0 ?  Container(
//       //                             height: 40,
//       //                             width: double.infinity,
//       //                             color: Colors.amber[50],
//       //                             padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//       //                             child: Row(
//       //                               mainAxisAlignment: MainAxisAlignment.start,
//       //                               children: [
//       //                                   Checkbox(
//       //                                         value:  checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
//       //                                         onChanged: (bool? value) {
//       //                                           // setState(() {
//       //                                           //   // isChecked = value!;
//       //                                           // });
//       //                                         }, 
//       //                                       ),
//       //                                 Text("Wallet Balance",)
//       //                             //     Text(
//       //                             //       'order_summary'.tr,
//       //                             //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//       //                             //     ),
//       //                             //     InkWell(
                                    
//       //                             // )
//       //                             ])
//       //                           ) : const SizedBox();
//       //                         }
//       //                       )
//                             // Padding(
//                             //   padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
//                             //   child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                             //     Text(
//                             //       checkoutController.isPartialPay ? 'due_payment'.tr : 'total_amount'.tr,
//                             //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//                             //     ),
//                             //     PriceConverter.convertAnimationPrice(
//                             //       checkoutController.viewTotalPrice,
//                             //       textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//                             //     ),
//                             //   ]),
//                             // ),
// //             InkWell( 
// // onTap: () {
// //   Get.to(LoyaltyScreen());
// // },
// //               child: PartialPayView2(totalPrice: total, isPrescription: false,)),
//                         // Positioned(
//                         //       child: Row(
//                         //         children: [
//                         //          PaymentSection(
//                         //                           storeId: widget.storeId, isCashOnDeliveryActive: _isCashOnDeliveryActive!, isDigitalPaymentActive: _isDigitalPaymentActive!,
//                         //                           isWalletActive:_isWalletActive, total: total, checkoutController: checkoutController, isOfflinePaymentActive: _isOfflinePaymentActive,
//                         //                         ),
//                         //           Expanded(
//                         //                                 // 
//                         //           // child: Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired, guestContactPersonNameController: guestContactPersonNameController, guestContactPersonNumberController: guestContactPersonNumberController, guestEmailController: guestEmailController, guestPasswordController: guestPasswordController, guestConfirmPasswordController: guestConfirmPasswordController, fromCart: widget.fromCart)
//                         //             // // Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired)
                                    
//                         //                child : _orderPlaceButton(checkoutController, todayClosed, tomorrowClosed, orderAmount, deliveryCharge, tax, discount, total, maxCodOrderAmount, isPrescriptionRequired) 
                                     
//                         //           ),
//                         //         ],
//                         //       ),
//                         //     ),
        
        
        
        
        
                     
                  
//                           ],
//                         ),
//                       ),


//                           Positioned(
//                             bottom: 0,
//                             left: 0,
//                             right: 0,
//                               child: Container(
//                                 decoration: BoxDecoration(color: const Color(0xFFF0F0F5), boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 10)]),
//                                 child: Column(
//                                   children: [
//                                     // Row(
//                                     //   children: [
//                                     //    PaymentSection(
//                                     //                     storeId: widget.storeId, isCashOnDeliveryActive: _isCashOnDeliveryActive!, isDigitalPaymentActive: _isDigitalPaymentActive!,
//                                     //                     isWalletActive:_isWalletActive, total: total, checkoutController: checkoutController, isOfflinePaymentActive: _isOfflinePaymentActive,
//                                     //                   ),
//                                     //     Expanded(
//                                     //                           // 
//                                     //     // child: Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired, guestContactPersonNameController: guestContactPersonNameController, guestContactPersonNumberController: guestContactPersonNumberController, guestEmailController: guestEmailController, guestPasswordController: guestPasswordController, guestConfirmPasswordController: guestConfirmPasswordController, fromCart: widget.fromCart)
//                                     //       // // Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired)
                                          
//                                     //          child : _orderPlaceButton(checkoutController, todayClosed, tomorrowClosed, orderAmount, deliveryCharge, tax, discount, total, maxCodOrderAmount, isPrescriptionRequired) 
                                           
//                                     //     ),
                                    
                                       
//                                     //   ],
//                                     // ),

//                                     //  SizedBox(height: 5,)
                                 
                                 
                                 
//                             GetBuilder<CheckoutController>(
//       builder: (checkoutController) {
//         return Get.find<SplashController>().configModel!.partialPaymentStatus! 
//         && Get.find<SplashController>().configModel!.customerWalletStatus == 1
//         && Get.find<ProfileController>().userInfoModel!.walletBalance! > 0 ?  Container(
//                                   height: 40,
//                                   width: double.infinity,
//                                   color: Colors.amber[50],
//                                   padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                                   child: Row(
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                         Checkbox(
//                                               value:  checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
//                                               onChanged: (bool? value) {
//                                                 // setState(() {
//                                                 //   // isChecked = value!;
//                                                 // });
//                                               }, 
//                                             ),
//                                       Text("Wallet Balance",)
//                                   //     Text(
//                                   //       'order_summary'.tr,
//                                   //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//                                   //     ),
//                                   //     InkWell(
                                    
//                                   // )
//                                   ])
//                                 ) : const SizedBox();
//                               }
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeExtraSmall),
//                               child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                                 Text(
//                                   checkoutController.isPartialPay ? 'due_payment'.tr : 'total_amount'.tr,
//                                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//                                 ),
//                                 PriceConverter.convertAnimationPrice(
//                                   checkoutController.viewTotalPrice,
//                                   textStyle: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
//                                 ),
//                               ]),
//                             ),
//             InkWell( 
// onTap: () {
//   Get.to(LoyaltyScreen(fromNotification: false,));
// },
//               child: PartialPayView2(totalPrice: total, isPrescription: false,)),
//                         Positioned(
//                               child: Row(
//                                 children: [
//                                  PaymentSection(
//                                                   storeId: widget.storeId, isCashOnDeliveryActive: _isCashOnDeliveryActive!, isDigitalPaymentActive: _isDigitalPaymentActive!,
//                                                   isWalletActive:_isWalletActive, total: total, checkoutController: checkoutController, isOfflinePaymentActive: _isOfflinePaymentActive,
//                                                 ),
//                                   Expanded(
//                                                         // 
//                                   // child: Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired, guestContactPersonNameController: guestContactPersonNameController, guestContactPersonNumberController: guestContactPersonNumberController, guestEmailController: guestEmailController, guestPasswordController: guestPasswordController, guestConfirmPasswordController: guestConfirmPasswordController, fromCart: widget.fromCart)
//                                     // // Orderplace_button(checkoutController: checkoutController, todayClosed: todayClosed, tomorrowClosed: tomorrowClosed, orderAmount: orderAmount, tax: tax, total: total, isPrescriptionRequired: isPrescriptionRequired)
                                    
//                                        child : _orderPlaceButton(checkoutController, todayClosed, tomorrowClosed, orderAmount, deliveryCharge, tax, discount, total, maxCodOrderAmount, isPrescriptionRequired) 
                                     
//                                   ),
//                                 ],
//                               ),
//                             ),
        
        
        
        
//                                   ],
//                                 ),
//                               ),
//                             ),
        
                        
                        
                        Positioned(
  bottom: 0,
  left: 0,
  right: 0,
  child: Container(
    decoration: BoxDecoration(
      color: Theme.of(context).cardColor,
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).primaryColor.withOpacity(0.1),
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      children: [
        // Wallet Balance Section
       
      //   GetBuilder<CheckoutController>(
      // builder: (checkoutController) {
      //   return Get.find<SplashController>().configModel!.partialPaymentStatus! 
      //   && Get.find<SplashController>().configModel!.customerWalletStatus == 1
      //   && Get.find<ProfileController>().userInfoModel!.walletBalance! > 0 ?  Container(
      //                             height: 40,
      //                             width: double.infinity,
      //                             color: Colors.amber[50],
      //                             padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      //                             child: Row(
      //                               mainAxisAlignment: MainAxisAlignment.start,
      //                               children: [
      //                                   Checkbox(
      //                                         value:  checkoutController.isPartialPay || checkoutController.paymentMethodIndex == 1,
      //                                         onChanged: (bool? value) {
      //                                           // setState(() {
      //                                           //   // isChecked = value!;
      //                                           // });
      //                                         }, 
      //                                       ),
      //                                 Text("Wallet Balance",)
      //                             //     Text(
      //                             //       'order_summary'.tr,
      //                             //       style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
      //                             //     ),
      //                             //     InkWell(
                                    
      //                             // )
      //                             ])
      //                           ) : const SizedBox();
      //                         }
      //                       ),
      //   // Loyalty Screen Navigation
        InkWell(
          onTap: () {
            Get.to(LoyaltyScreen(fromNotification: false));
          },
          child: PartialPayView2(totalPrice: total, isPrescription: false, currency: currency,),
        ),

        // Payment Section and Order Button
        Row(
          children: [
            PaymentSection(
              storeId: widget.storeId,
              isCashOnDeliveryActive: _isCashOnDeliveryActive!,
              isDigitalPaymentActive: _isDigitalPaymentActive!,
              isWalletActive: _isWalletActive,
              total: total,
              checkoutController: checkoutController,
              isOfflinePaymentActive: _isOfflinePaymentActive,
            ),
            Expanded(
              child: _orderPlaceButton(
                checkoutController,
                todayClosed,
                tomorrowClosed,
                orderAmount,
                deliveryCharge,
                tax,
                discount,
                total,
                maxCodOrderAmount,
                isPrescriptionRequired,
                 currency
              ),
            ),

                
          ],
        ),

            SizedBox(height: 10,)
      ],
    ),
  ),
),
                       
                          ],
                        );
                      }
                    );
                  }
                )
                : const NoDataScreen(isCart: true, text: '', showFooter: true);
          }),
        );
     
     
      }
    );
  }




    Widget suggestedItemView(List<CartModel> cartList){
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).cardColor),
      width: double.infinity,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        GetBuilder<StoreController>(builder: (storeController) {
          List<Item>? suggestedItems;
          if(storeController.cartSuggestItemModel != null){
            suggestedItems = [];
            List<int> cartIds = [];
            for (CartModel cartItem in cartList) {
              cartIds.add(cartItem.item!.id!);
            }
            for (Item item in storeController.cartSuggestItemModel!.items!) {
              if(!cartIds.contains(item.id)){
                suggestedItems.add(item);
              }
            }
          }
          return storeController.cartSuggestItemModel != null && suggestedItems!.isNotEmpty ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeExtraSmall),
                child: Text('you_may_also_like'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault)),
              ),

              SizedBox(
                height: ResponsiveHelper.isDesktop(context) ? 160 : 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: suggestedItems.length,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(left: ResponsiveHelper.isDesktop(context) ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeDefault),
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: ResponsiveHelper.isDesktop(context) ? const EdgeInsets.symmetric(vertical: 20) : const EdgeInsets.symmetric(vertical: 10) ,
                      child: Container(
                        width: ResponsiveHelper.isDesktop(context) ? 500 : 300,
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall, left: Dimensions.paddingSizeExtraSmall),
                        margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: ItemWidget(
                          isStore: false, item: suggestedItems![index], fromCartSuggestion: true,
                          store: null, index: index, length: null, isCampaign: false, inStore: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ) : const SizedBox();
        }),
      ]),
    );
  }



Widget _orderPlaceButton(
  CheckoutController checkoutController,
  bool todayClosed,
  bool tomorrowClosed,
  double orderAmount,
  double? deliveryCharge,
  double tax,
  double? discount,
  double total,
  double? maxCodOrderAmount,
  bool isPrescriptionRequired,  final String? currency,
) {
  return InkWell(


    onTap: checkoutController.acceptTerms ? () {
      // checkoutController. = true;
          bool isAvailable = true;
          DateTime scheduleStartDate = DateTime.now();
          DateTime scheduleEndDate = DateTime.now();
          bool isGuestLogIn = AuthHelper.isGuestLoggedIn();
          if(checkoutController.timeSlots == null || checkoutController.timeSlots!.isEmpty) {
            isAvailable = false;
          }else {
            DateTime date = checkoutController.selectedDateSlot == 0 ? DateTime.now() : DateTime.now().add(const Duration(days: 1));
            DateTime startTime = checkoutController.timeSlots![checkoutController.selectedTimeSlot].startTime!;
            DateTime endTime = checkoutController.timeSlots![checkoutController.selectedTimeSlot].endTime!;
            scheduleStartDate = DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute+1);
            scheduleEndDate = DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute+1);
            if(_cartList != null){
              for (CartModel? cart in _cartList!) {
                if (!DateConverter.isAvailable(
                  cart!.item!.availableTimeStarts, cart.item!.availableTimeEnds,
                  time: checkoutController.store!.scheduleOrder! ? scheduleStartDate : null,
                ) && !DateConverter.isAvailable(
                  cart.item!.availableTimeStarts, cart.item!.availableTimeEnds,
                  time: checkoutController.store!.scheduleOrder! ? scheduleEndDate : null,
                )) {
                  isAvailable = false;
                  break;
                }
              }
            }
          }
        
          if(isGuestLogIn && checkoutController.guestAddress == null && checkoutController.orderType != 'take_away') {
            showCustomSnackBar('please_setup_your_delivery_address_first'.tr);
          } else if(isGuestLogIn && checkoutController.orderType == 'take_away' && guestContactPersonNameController.text.isEmpty) {
            showCustomSnackBar('please_enter_contact_person_name'.tr);
          } else if(isGuestLogIn && checkoutController.orderType == 'take_away' && guestContactPersonNumberController.text.isEmpty) {
            showCustomSnackBar('please_enter_contact_person_number'.tr);
          }else if(isGuestLogIn && checkoutController.orderType == 'take_away' && guestEmailController.text.isEmpty) {
            showCustomSnackBar('please_enter_contact_person_email'.tr);
          }else if(isGuestLogIn && checkoutController.isCreateAccount && guestPasswordController.text.isEmpty) {
            showCustomSnackBar('enter_password'.tr);
          }else if(isGuestLogIn && checkoutController.isCreateAccount && guestConfirmPasswordController.text.isEmpty) {
            showCustomSnackBar('enter_confirm_password'.tr);
          }else if(isGuestLogIn && checkoutController.isCreateAccount && (guestPasswordController.text != guestConfirmPasswordController.text)) {
            showCustomSnackBar('confirm_password_does_not_matched'.tr);
          }else if(isPrescriptionRequired && checkoutController.pickedPrescriptions.isEmpty) {
            showCustomSnackBar('you_must_upload_prescription_for_this_order'.tr);
          } else if(!_isCashOnDeliveryActive! && !_isDigitalPaymentActive! && !_isWalletActive) {
            showCustomSnackBar('no_payment_method_is_enabled'.tr);
            
          } else if(checkoutController.store!.open == 1 && !checkoutController.store!.active!  ) {

            
          showCustomSnackBar("The store isn't serving right now");


          } else if( checkoutController.store!.scheduleOrder == true && checkoutController.preferableTime.isEmpty   ) {
             showCustomSnackBar("Preferable time is required");
            
          }
          else if(checkoutController.paymentMethodIndex == -1) {
            if(ResponsiveHelper.isDesktop(context)){
              Get.dialog(Dialog(backgroundColor: Colors.transparent, child: PaymentMethodBottomSheet(
                isCashOnDeliveryActive: _isCashOnDeliveryActive!, isDigitalPaymentActive: _isDigitalPaymentActive!,
                isWalletActive: _isWalletActive, storeId: widget.storeId, totalPrice: total, isOfflinePaymentActive: _isOfflinePaymentActive,
              )));
            }else{
              showModalBottomSheet(
                context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                builder: (con) => PaymentMethodBottomSheet(
                  isCashOnDeliveryActive: _isCashOnDeliveryActive!, isDigitalPaymentActive: _isDigitalPaymentActive!,
                  isWalletActive: _isWalletActive, storeId: widget.storeId, totalPrice: total, isOfflinePaymentActive: _isOfflinePaymentActive,
                ),
              );
            }
          } else if(orderAmount < checkoutController.store!.minimumOrder! && widget.storeId == null) {
            showCustomSnackBar('${'minimum_order_amount_is'.tr} ${checkoutController.store!.minimumOrder}');
          }else if(checkoutController.tipController.text.isNotEmpty && checkoutController.tipController.text != 'not_now' && double.parse(checkoutController.tipController.text.trim()) < 0) {
            showCustomSnackBar('tips_can_not_be_negative'.tr);
          }else if((checkoutController.selectedDateSlot == 0 && todayClosed) || (checkoutController.selectedDateSlot == 1 && tomorrowClosed)) {
            showCustomSnackBar(Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                ? 'restaurant_is_closed'.tr : 'store_is_closed'.tr);
          }else if(checkoutController.paymentMethodIndex == 0 && _isCashOnDeliveryActive! && maxCodOrderAmount != null && maxCodOrderAmount != 0 && (total > maxCodOrderAmount) && widget.storeId == null){
            showCustomSnackBar('${'you_cant_order_more_then'.tr} ${PriceConverter.convertPrice(maxCodOrderAmount)} ${'in_cash_on_delivery'.tr}');
          }else if(checkoutController.paymentMethodIndex != 0 && widget.storeId != null){
            showCustomSnackBar('payment_method_is_not_available'.tr);
          }else if (checkoutController.timeSlots == null || checkoutController.timeSlots!.isEmpty) {
            if(checkoutController.store!.scheduleOrder!) {
              showCustomSnackBar('select_a_time'.tr);
            }else {
              showCustomSnackBar(Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText!
                  ? 'restaurant_is_closed'.tr : 'store_is_closed'.tr);
            }
          }else if (!isAvailable) {
            showCustomSnackBar('one_or_more_products_are_not_available_for_this_selected_time'.tr);
          }else if (checkoutController.orderType != 'take_away' && checkoutController.distance == -1 && deliveryCharge == -1) {
            showCustomSnackBar('delivery_fee_not_set_yet'.tr);
          }else if (widget.storeId != null && checkoutController.pickedPrescriptions.isEmpty) {
            showCustomSnackBar('please_upload_your_prescription_images'.tr);
          }else if (!checkoutController.acceptTerms) {
            showCustomSnackBar('please_accept_privacy_policy_trams_conditions_refund_policy_first'.tr);
          }
          else {
        
            AddressModel? finalAddress = isGuestLogIn ? checkoutController.guestAddress : address[checkoutController.addressIndex!];
        
            if(isGuestLogIn && checkoutController.orderType == 'take_away') {
              String number = checkoutController.countryDialCode! + guestContactPersonNumberController.text;
              finalAddress = AddressModel(contactPersonName: guestContactPersonNameController.text, contactPersonNumber: number,
                address: AddressHelper.getUserAddressFromSharedPref()!.address!, latitude: AddressHelper.getUserAddressFromSharedPref()!.latitude,
                longitude: AddressHelper.getUserAddressFromSharedPref()!.longitude, zoneId: AddressHelper.getUserAddressFromSharedPref()!.zoneId,
                email: guestEmailController.text,
              );
            }
        
            if(!isGuestLogIn && finalAddress!.contactPersonNumber == 'null'){
              finalAddress.contactPersonNumber = Get.find<ProfileController>().userInfoModel!.phone;
            }
        
            if(widget.storeId == null){
        
              List<OnlineCart> carts = [];
              for (int index = 0; index < _cartList!.length; index++) {
                CartModel cart = _cartList![index]!;
                List<int?> addOnIdList = [];
                List<int?> addOnQtyList = [];
                for (var addOn in cart.addOnIds!) {
                  addOnIdList.add(addOn.id);
                  addOnQtyList.add(addOn.quantity);
                }
        
                List<OrderVariation> variations = [];
                if(Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation!) {
                  for(int i=0; i<cart.item!.foodVariations!.length; i++) {
                    if(cart.foodVariations![i].contains(true)) {
                      variations.add(OrderVariation(name: cart.item!.foodVariations![i].name, values: OrderVariationValue(label: [])));
                      for(int j=0; j<cart.item!.foodVariations![i].variationValues!.length; j++) {
                        if(cart.foodVariations![i][j]!) {
                          variations[variations.length-1].values!.label!.add(cart.item!.foodVariations![i].variationValues![j].level);
                        }
                      }
                    }
                  }
                }
                carts.add(OnlineCart(
                  cart.id, cart.item!.id, cart.isCampaign! ? cart.item!.id : null,
                  cart.discountedPrice.toString(), '',
                  Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation! ? null : cart.variation,
                  Get.find<SplashController>().getModuleConfig(cart.item!.moduleType).newVariation! ? variations : null,
                  cart.quantity, addOnIdList, cart.addOns, addOnQtyList, 'Item', itemType: !widget.fromCart ? "AppModelsItemCampaign" : null,
                ));
              }
        
              PlaceOrderBodyModel placeOrderBody = PlaceOrderBodyModel(
                cart: carts, couponDiscountAmount: Get.find<CouponController>().discount, distance: checkoutController.distance,
                scheduleAt: !checkoutController.store!.scheduleOrder! ? null : (checkoutController.selectedDateSlot == 0
                    && checkoutController.selectedTimeSlot == 0) ? null : DateConverter.dateToDateAndTime(scheduleEndDate),
                orderAmount: total, orderNote: checkoutController.noteController.text, orderType: checkoutController.orderType,
                paymentMethod: checkoutController.paymentMethodIndex == 0 ? 'cash_on_delivery'
                    : checkoutController.paymentMethodIndex == 1 ? 'wallet'
                    : checkoutController.paymentMethodIndex == 2 ? 'digital_payment' : 'offline_payment',
                couponCode: (Get.find<CouponController>().discount! > 0 || (Get.find<CouponController>().coupon != null
                    && Get.find<CouponController>().freeDelivery)) ? Get.find<CouponController>().coupon!.code : null,
                storeId: _cartList![0]!.item!.storeId,
                address: finalAddress!.address, latitude: finalAddress.latitude, longitude: finalAddress.longitude,
                senderZoneId: null, addressType: finalAddress.addressType,
                contactPersonName: finalAddress.contactPersonName ?? '${Get.find<ProfileController>().userInfoModel!.fName} '
                    '${Get.find<ProfileController>().userInfoModel!.lName}',
                contactPersonNumber: finalAddress.contactPersonNumber ?? Get.find<ProfileController>().userInfoModel!.phone,
                streetNumber: isGuestLogIn ? finalAddress.streetNumber??'' : checkoutController.streetNumberController.text.trim(),
                house: isGuestLogIn ? finalAddress.house??'' : checkoutController.houseController.text.trim(),
                floor: isGuestLogIn ? finalAddress.floor??'' : checkoutController.floorController.text.trim(),
                discountAmount: discount, taxAmount: tax, receiverDetails: null, parcelCategoryId: null,
                chargePayer: null, dmTips: (checkoutController.orderType == 'take_away' || checkoutController.tipController.text == 'not_now') ? '' : checkoutController.tipController.text.trim(),
                cutlery: Get.find<CartController>().addCutlery ? 1 : 0,
                unavailableItemNote: Get.find<CartController>().notAvailableIndex != -1 ? Get.find<CartController>().notAvailableList[Get.find<CartController>().notAvailableIndex] : '',
                deliveryInstruction: checkoutController.selectedInstruction != -1 ? AppConstants.deliveryInstructionList[checkoutController.selectedInstruction] : '',
                partialPayment: checkoutController.isPartialPay ? 1 : 0, guestId: isGuestLogIn ? int.parse(AuthHelper.getGuestId()) : 0,
                isBuyNow: widget.fromCart ? 0 : 1, guestEmail: isGuestLogIn ? finalAddress.email : null,
                extraPackagingAmount: Get.find<CartController>().needExtraPackage ? checkoutController.store!.extraPackagingAmount : 0,
                createNewUser: checkoutController.isCreateAccount ? 1 : 0, password: guestPasswordController.text,
              );
        
              if(checkoutController.paymentMethodIndex == 3){
                Get.toNamed(RouteHelper.getOfflinePaymentScreen(
                  placeOrderBody: placeOrderBody, zoneId: checkoutController.store!.zoneId!, total: checkoutController.viewTotalPrice!,
                  maxCodOrderAmount: maxCodOrderAmount, fromCart: widget.fromCart, isCodActive: _isCashOnDeliveryActive, forParcel: false,
                ));
              } else {
          showModalBottomSheet(
                context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
                builder: (con) => Placeorderbottomsheet(checkoutController: checkoutController, placeOrderBody: placeOrderBody, isCashOnDeliveryActive: _isCashOnDeliveryActive!, fromCart: widget.fromCart, total: total, address: finalAddress!,));
  
                // print("Calling Checkout");
                // checkoutController.placeOrder(placeOrderBody, checkoutController.store!.zoneId, total, maxCodOrderAmount, widget.fromCart, _isCashOnDeliveryActive!, checkoutController.pickedPrescriptions);
              }
            }else{
        
              checkoutController.placePrescriptionOrder(widget.storeId, checkoutController.store!.zoneId, checkoutController.distance,
                  finalAddress!.address!, finalAddress.longitude!, finalAddress.latitude!, checkoutController.noteController.text,
                  checkoutController.pickedPrescriptions, (checkoutController.orderType == 'take_away' || checkoutController.tipController.text == 'not_now')
                      ? '' : checkoutController.tipController.text.trim(), checkoutController.selectedInstruction != -1
                      ? AppConstants.deliveryInstructionList[checkoutController.selectedInstruction] : '', 0, 0, widget.fromCart, _isCashOnDeliveryActive!
              );
            }
        
          }
        } : null,
   
   
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 65,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
      ) ,
        padding: const EdgeInsets.symmetric(
          vertical: Dimensions.paddingSizeSmall,
          horizontal: Dimensions.paddingSizeLarge,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  PriceConverter.convertPrice(checkoutController.viewTotalPrice,currency: currency),
                  
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500,color: Colors.white),
                ),
                const Text(
                  "Total",
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500,color: Colors.white),
                ),
              ],
            ),
            const Column(
              children: [
                SizedBox(height: 9,),
                Row(
                  children: [
                    Text(
                      "Place Order",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 10,color: Colors.white),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


  List<DropdownItem<int>> _getDropdownAddressList({required BuildContext context, required List<AddressModel>? addressList, required Store? store}) {
    List<DropdownItem<int>> dropDownAddressList = [];

    dropDownAddressList.add(DropdownItem<int>(value: 0, child: SizedBox(
      width: context.width > Dimensions.webMaxWidth ? Dimensions.webMaxWidth - 50 : context.width - 50,
      child: AddressWidget(
        address: AddressHelper.getUserAddressFromSharedPref(),
        fromAddress: false, fromCheckout: true,
      ),
    )));

    if(addressList != null && store != null) {
      for(int index=0; index<addressList.length; index++) {
        if(addressList[index].zoneIds!.contains(store.zoneId)) {

          dropDownAddressList.add(DropdownItem<int>(value: index + 1, child: SizedBox(
            width: context.width > Dimensions.webMaxWidth ? Dimensions.webMaxWidth-50 : context.width-50,
            child: AddressWidget(
              address: addressList[index],
              fromAddress: false, fromCheckout: true,
            ),
          )));
        }
      }
    }
    return dropDownAddressList;
  }

  List<AddressModel> _getAddressList({required List<AddressModel>? addressList, required Store? store}) {
    List<AddressModel> address = [];

    address.add(AddressHelper.getUserAddressFromSharedPref()!);

    if(addressList != null && store != null) {
      for(int index=0; index<addressList.length; index++) {
        if(addressList[index].zoneIds!.contains(store.zoneId)) {
          address.add(addressList[index]);
        }
      }
    }
    return address;
  }

  Pivot? _getModuleData({required Store? store}) {
    Pivot? moduleData;
    if(store != null) {
      for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
        for(Modules m in zData.modules!) {
          if(m.id == Get.find<SplashController>().module!.id && m.pivot!.zoneId == store.zoneId) {
            moduleData = m.pivot;
            break;
          }
        }
      }
    }
    return moduleData;
  }

  bool _checkCODActive({required Store? store}) {
    bool isCashOnDeliveryActive = false;
    if(store != null){
      for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
        if(zData.id ==  store.zoneId) {
          isCashOnDeliveryActive = zData.cashOnDelivery! && Get.find<SplashController>().configModel!.cashOnDelivery!;
        }
      }
    }
    return isCashOnDeliveryActive;
  }

  bool _checkDigitalPaymentActive({required Store? store}) {
    bool isDigitalPaymentActive = false;
    if(store != null){
      for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
        if(zData.id ==  store.zoneId) {
          isDigitalPaymentActive = zData.digitalPayment! && Get.find<SplashController>().configModel!.digitalPayment!;
        }
      }
    }
    return isDigitalPaymentActive;
  }

  double _calculatePrice({required Store? store, required List<CartModel?>? cartList}) {
    double price = 0;
    if(cartList != null) {
      for (var cartModel in cartList) {
        if(Get.find<SplashController>().getModuleConfig(cartModel!.item!.moduleType).newVariation!){
          price = price + (cartModel.item!.price! * cartModel.quantity!);
        } else {
          price = _calculateVariationPrice(store: store, cartList: cartList);
        }
      }
    }
    return PriceConverter.toFixed(price);
  }

  double _calculateAddonsPrice({required Store? store, required List<CartModel?>? cartList}) {
    double addOns = 0;
    if(store != null && cartList != null) {
      for (var cartModel in cartList) {
        List<AddOns> addOnList = [];
        for (var addOnId in cartModel!.addOnIds!) {
          for (AddOns addOns in cartModel.item!.addOns!) {
            if (addOns.id == addOnId.id) {
              addOnList.add(addOns);
              break;
            }
          }
        }
        for (int index = 0; index < addOnList.length; index++) {
          addOns = addOns + (addOnList[index].price! * cartModel.addOnIds![index].quantity!);
        }
      }
    }
    return PriceConverter.toFixed(addOns);
  }

  double _calculateVariationPrice({required Store? store, required List<CartModel?>? cartList, bool calculateDiscount = false, bool calculateWithoutDiscount = false}) {
    double variationPrice = 0;
    double variationDiscount = 0;
    if(store != null && cartList != null) {
      for (var cartModel in cartList) {
        double? discount = cartModel!.item!.storeDiscount == 0 ? cartModel.item!.discount : cartModel.item!.storeDiscount;
        String? discountType = cartModel.item!.storeDiscount == 0 ? cartModel.item!.discountType : 'percent';

        if(Get.find<SplashController>().getModuleConfig(cartModel.item!.moduleType).newVariation!) {
          isPassedVariationPrice = true;
          for(int index = 0; index< cartModel.item!.foodVariations!.length; index++) {
            for(int i=0; i<cartModel.item!.foodVariations![index].variationValues!.length; i++) {
              if(cartModel.foodVariations![index][i]!) {
                variationPrice += (PriceConverter.convertWithDiscount(cartModel.item!.foodVariations![index].variationValues![i].optionPrice!, discount, discountType, isFoodVariation: true)! * cartModel.quantity!);
                variationDiscount += (cartModel.item!.foodVariations![index].variationValues![i].optionPrice! * cartModel.quantity!);
              }
            }
          }
        } else {

          String variationType = '';
          for(int i=0; i<cartModel.variation!.length; i++) {
            variationType = cartModel.variation![i].type!;
          }

          if(cartModel.item!.variations!.isNotEmpty) {
            for (Variation variation in cartModel.item!.variations!) {
              if (variation.type == variationType) {
                variationPrice += (variation.price! * cartModel.quantity!);
                break;
              }
            }
          } else {
            variationDiscount += (PriceConverter.convertWithDiscount(cartModel.item!.price!, discount, discountType)! * cartModel.quantity!);
            variationPrice += (cartModel.item!.price! * cartModel.quantity!);
          }

        }
      }
    }
    if(calculateDiscount) {
      return (variationDiscount - variationPrice);
    } else if(calculateWithoutDiscount) {
      return variationDiscount;
    } else {
      return variationPrice;
    }
  }

  double _calculateDiscount({required Store? store, required List<CartModel?>? cartList, required double price, required double addOns}) {
    double discount = 0;
    if (store != null && cartList != null) {
      for (var cartModel in cartList) {
        double? dis = (store.discount != null
            && DateConverter.isAvailable(store.discount!.startTime, store.discount!.endTime))
            && cartModel!.item!.flashSale != 1
            ? store.discount!.discount : cartModel!.item!.discount;
        String? disType = (store.discount != null
            && DateConverter.isAvailable(store.discount!.startTime, store.discount!.endTime))
            && cartModel.item!.flashSale != 1
            ? 'percent' : cartModel.item!.discountType;
        if(Get.find<SplashController>().getModuleConfig(cartModel.item!.moduleType).newVariation!) {
          double d = ((cartModel.item!.price! - PriceConverter.convertWithDiscount(cartModel.item!.price!, dis, disType)!) * cartModel.quantity!);
          discount = discount + d;
          if(disType == 'percent' && discount != 0) {
            discount = discount + _calculateFoodVariationDiscount(cartModel: cartModel);
          }
        } else {
          String variationType = '';
          double variationPrice = 0;
          double variationWithoutDiscountPrice = 0;
          for(int i=0; i<cartModel.variation!.length; i++) {
            variationType = cartModel.variation![i].type!;
          }
          if(cartModel.item!.variations!.isNotEmpty){
            for (Variation variation in cartModel.item!.variations!) {
              if (variation.type == variationType) {
                variationPrice += (PriceConverter.convertWithDiscount(variation.price!, dis, disType)! * cartModel.quantity!);
                variationWithoutDiscountPrice += (variation.price! * cartModel.quantity!);
                break;
              }
            }
            discount = discount + (variationWithoutDiscountPrice - variationPrice);

          } else {
            double d = ((cartModel.item!.price! - PriceConverter.convertWithDiscount(cartModel.item!.price!, dis, disType)!) * cartModel.quantity!);
            discount = discount + d;
          }

        }
      }
    }

    if (store != null && store.discount != null) {
      if (store.discount!.maxDiscount != 0 && store.discount!.maxDiscount! < discount) {
        discount = store.discount!.maxDiscount!;
      }
      if (store.discount!.minPurchase != 0 && store.discount!.minPurchase! > (price + addOns)) {
        discount = 0;
      }
    }
    return PriceConverter.toFixed(discount);
  }

  double _calculateFoodVariationDiscount({required CartModel? cartModel}) {
    double variationPrice = 0;
    double variationDiscount = 0;
    if(cartModel != null) {
      double? discount = cartModel.item!.storeDiscount == 0 ? cartModel.item!.discount : cartModel.item!.storeDiscount;
      String? discountType = cartModel.item!.storeDiscount == 0 ? cartModel.item!.discountType : 'percent';
      for (int index = 0; index < cartModel.item!.foodVariations!.length; index++) {
        for (int i = 0; i < cartModel.item!.foodVariations![index].variationValues!.length; i++) {
          if (cartModel.foodVariations![index][i]!) {
            variationPrice += (PriceConverter.convertWithDiscount(
                cartModel.item!.foodVariations![index].variationValues![i].optionPrice!, discount, discountType,
                isFoodVariation: true)! * cartModel.quantity!);
            variationDiscount +=
            (cartModel.item!.foodVariations![index].variationValues![i].optionPrice! * cartModel.quantity!);
          }
        }
      }
    }
    return (variationDiscount - variationPrice);
  }

  double _calculateOrderAmount({required double price, required double variations, required double discount, required double addOns, required double couponDiscount, required List<CartModel?>? cartList, required double referralDiscount}) {
    double orderAmount = 0;
    double variationPrice = 0;
    if(cartList != null && cartList.isNotEmpty && Get.find<SplashController>().getModuleConfig(cartList[0]?.item?.moduleType).newVariation!){
      variationPrice = variations;
    }
    orderAmount = (price + variationPrice - discount) + addOns - couponDiscount - referralDiscount;
    return PriceConverter.toFixed(orderAmount);
  }

  double _calculateTax({required bool taxIncluded, required double orderAmount, required double? taxPercent}) {
    double tax = 0;
    if(taxIncluded){
      tax = orderAmount * taxPercent! /(100 + taxPercent);
    }else{
      tax = PriceConverter.calculation(orderAmount, taxPercent, 'percent', 1);
    }
    return PriceConverter.toFixed(tax);
  }

  double _calculateSubTotal({required double price, required double addOns, required double variations, required List<CartModel?>? cartList}) {
    double subTotal = 0;
    bool isFoodVariation = false;

    if(cartList != null && cartList.isNotEmpty) {
      isFoodVariation = Get.find<SplashController>().getModuleConfig(cartList[0]!.item!.moduleType).newVariation!;
    }
    if(isFoodVariation){
      subTotal = price + addOns + variations;
    } else {
      subTotal = price;
    }

    return subTotal;
  }
 double _calculateOriginalDeliveryCharge({required Store? store, required AddressModel address, required double? distance, required double? extraCharge}) {
    double deliveryCharge = -1;

    Pivot? moduleData;
    ZoneData? zoneData;
    if(store != null) {
      for(ZoneData zData in address.zoneData!) {

        for(Modules m in zData.modules!) {
          if(m.id == Get.find<SplashController>().module!.id && m.pivot!.zoneId == store.zoneId) {
            moduleData = m.pivot;
            break;
          }
        }

        if(zData.id == store.zoneId) {
          zoneData = zData;
        }
      }
    }
    double perKmCharge = 0;
    double minimumCharge = 0;
    double maximumCharge = 0;
    if(store != null && distance != null && distance != -1 && store.selfDeliverySystem == 1) {
      perKmCharge = store.perKmShippingCharge ?? 0 ;
      minimumCharge = store.minimumShippingCharge ?? 0;
      maximumCharge = store.maximumShippingCharge ?? 0;
    }else if(store != null && distance != null && distance != -1 && moduleData != null) {
      perKmCharge = moduleData.perKmShippingCharge ?? 0;
      minimumCharge = moduleData.minimumShippingCharge ?? 0;
      maximumCharge = moduleData.maximumShippingCharge ??0;
    }
    if(store != null && distance != null) {
      deliveryCharge = distance * perKmCharge;

      if(deliveryCharge < minimumCharge) {
        deliveryCharge = minimumCharge;
      }else if(deliveryCharge > maximumCharge!) {
        deliveryCharge = maximumCharge;
      }
    }

    if(store != null && store.selfDeliverySystem == 0 && extraCharge != null) {
      extraChargeForToolTip = extraCharge;
      deliveryCharge = deliveryCharge + extraCharge;
    }

    if(store != null && store.selfDeliverySystem == 0 && zoneData!.increaseDeliveryFeeStatus == 1) {
      badWeatherChargeForToolTip = (deliveryCharge * (zoneData.increaseDeliveryFee!/100));
      deliveryCharge = deliveryCharge + (deliveryCharge * (zoneData.increaseDeliveryFee!/100));
    }

    return deliveryCharge;
  }

  double _calculateDeliveryCharge({required Store? store, required AddressModel address, required double? distance, required double? extraCharge, required double orderAmount, required String orderType}) {
    double deliveryCharge = _calculateOriginalDeliveryCharge(store: store, address: address, distance: distance, extraCharge: extraCharge);

    if (orderType == 'take_away' || (store != null && store.freeDelivery!)
        || (Get.find<SplashController>().configModel!.freeDeliveryOver != null && orderAmount
            >= Get.find<SplashController>().configModel!.freeDeliveryOver!)
        || Get.find<CouponController>().freeDelivery || (AuthHelper.isGuestLoggedIn() && (Get.find<CheckoutController>().guestAddress == null && Get.find<CheckoutController>().orderType != 'take_away'))) {
      deliveryCharge = 0;
    }

    return PriceConverter.toFixed(deliveryCharge);
  }

  double _calculateTotal({
    required double subTotal, required double deliveryCharge, required double discount,
    required double couponDiscount, required bool taxIncluded, required double tax,
    required String orderType, required double tips, required double additionalCharge, required double extraPackagingCharge,
  }) {

    return PriceConverter.toFixed(
        subTotal + deliveryCharge - discount- couponDiscount + (taxIncluded ? 0 : tax)
            + ((orderType != 'take_away' && Get.find<SplashController>().configModel!.dmTipsStatus == 1) ? tips : 0)
            + additionalCharge + extraPackagingCharge
    );
  }

  bool _checkZoneOfflinePaymentOnOff({required AddressModel? addressModel, required CheckoutController checkoutController}) {
    bool? status = false;
    ZoneData? zoneData;
    for (var data in addressModel!.zoneData!) {
      if(data.id == checkoutController.store?.zoneId) {
        zoneData = data;
        break;
      }
    }
    status = zoneData?.offlinePayment ?? false;
    return status;
  }

  bool _checkPrescriptionRequired() {
    if(widget.storeId == null && Get.find<SplashController>().configModel!.moduleConfig!.module!.orderAttachment!) {
      for (var cart in _cartList!) {
        if(cart!.item!.isPrescriptionRequired!) {
          return true;
        }
      }
    }
    return false;
  }

  double _calculateExtraPackagingCharge(CheckoutController checkoutController) {
    if((checkoutController.store?.extraPackagingStatus ?? true) && (Get.find<CartController>().needExtraPackage)) {
      return checkoutController.store?.extraPackagingAmount ?? 0;
    }
    return 0;
  }

  double _calculateReferralDiscount(double subTotal, double discount, double couponDiscount) {
    double referralDiscount = 0;
    if(Get.find<ProfileController>().userInfoModel != null &&  Get.find<ProfileController>().userInfoModel!.isValidForDiscount!) {
      if (Get.find<ProfileController>().userInfoModel!.discountAmountType! == "percentage") {
        referralDiscount = (Get.find<ProfileController>().userInfoModel!.discountAmount! / 100) * (subTotal - discount - couponDiscount);
      } else {
        referralDiscount = Get.find<ProfileController>().userInfoModel!.discountAmount!;
      }
    }
    return PriceConverter.toFixed(referralDiscount);
  }

  Future<void> showCashBackSnackBar() async {
    await Get.find<HomeController>().getCashBackData(_payableAmount!);
    double? cashBackAmount = Get.find<HomeController>().cashBackData?.cashbackAmount ?? 0;
    String? cashBackType = Get.find<HomeController>().cashBackData?.cashbackType ?? '';
    String text = '${'you_will_get'.tr} ${cashBackType == 'amount' ? PriceConverter.convertPrice(cashBackAmount) : '${cashBackAmount.toStringAsFixed(0)}%'} ${'cash_back_after_completing_order'.tr}';
    if(cashBackAmount > 0) {
      showCustomSnackBar(text, isError: false);
    }
  }

}




//   void _showAddressDropdown(BuildContext context,addressList,checkoutController,address) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return Container(
//           padding: const EdgeInsets.all(16.0),
//           child:  Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Text('Choose a delivery address', style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.w600)),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: ListView.builder(
//                     itemCount:addressList.length,
//                     itemBuilder: (context, index) {
//                       return  InkWell(
//                         onTap: (){
//                                checkoutController.getDistanceInKM(
//                   LatLng(
//                     double.parse(address[index].latitude!),
//                     double.parse(address[index].longitude!),
//                   ),
//                   LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
//                 );
//                 checkoutController.setAddressIndex(index);

               
// Get.back();
//                         },
//                         child: AddressWidget(
//                                             address: address[index],
//                                             fromAddress: false, fromCheckout: true,
//                                           ),
//                       );
//                     },
//                   ),
//                 ),





//               ],
//             ),
        
//         );
//       },
//     );
//   }


// void _showAddressDropdown(BuildContext context, List addressList, checkoutController, List address) {
//   // Define the height of each item (you can adjust this based on your AddressWidget)
//   const double itemHeight = 70.0; // Example height of each item
//   final double bottomSheetHeight = (addressList.length * itemHeight) + 100; // 100 for padding and title

//   showModalBottomSheet(
//     context: context,
//     isScrollControlled: true, // Allow the bottom sheet to take full height
//     builder: (BuildContext context) {
//       return Container(
//         padding: const EdgeInsets.all(16.0),
//         height: bottomSheetHeight, // Set the height based on the number of items
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Choose a delivery address',
//               style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 10),
//             Expanded(
//               child: ListView.builder(
//                 itemCount: addressList.length,
//                 itemBuilder: (context, index) {
//                   return InkWell(
//                     onTap: () {
//                       checkoutController.getDistanceInKM(
//                         LatLng(
//                           double.parse(address[index].latitude!),
//                           double.parse(address[index].longitude!),
//                         ),
//                         LatLng(
//                           double.parse(checkoutController.store!.latitude!),
//                           double.parse(checkoutController.store!.longitude!),
//                         ),
//                       );
//                       checkoutController.setAddressIndex(index);
//                       Get.back();
//                     },
//                     child: AddressWidget(
//                       address: address[index],
//                       fromAddress: false,
//                       fromCheckout: true,
//                     ),
//                   );
//                 },
//               ),
//             ),

//                 Padding(
//                   padding: const EdgeInsets.all(12),
//                   child: CustomInkWell(
//                     onTap:   () async {
//                       Get.back();
//                       var address = await Get.toNamed(RouteHelper.getAddAddressRoute(true, false, checkoutController.store!.zoneId));
//                       if(address != null) {
//                         checkoutController.getDistanceInKM(
//                           LatLng(double.parse(address.latitude), double.parse(address.longitude)),
//                           LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
//                         );
//                         checkoutController.streetNumberController.text = address.streetNumber ?? '';
//                         checkoutController.houseController.text = address.house ?? '';
//                         checkoutController.floorController.text = address.floor ?? '';
//                       }
//                                     },
//                     child: Row(
//                       children: [
                    
//                         Container(
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.all(Radius.circular(5)),
//                             border: Border.all(
//                               color: Theme.of(context).primaryColor
//                             )
//                           ),
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 11,right: 11,top: 7,bottom: 7),
//                             child: Icon(Icons.add,size: 18,color: Theme.of(context).primaryColor),
//                           )),
//                      SizedBox(width: 20,),
//                       Text('Add New Address'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge,color: Theme.of(context).primaryColor)),
//                         Spacer(),
//                      Icon(Icons.arrow_right)
//                       ],
//                     ),
//                   ),
//                 )


// ,
//                 CustomTextField(
//             labelText: 'street_number'.tr,
//             titleText: 'write_street_number'.tr,
//             inputType: TextInputType.streetAddress,
//             focusNode: checkoutController.streetNode,
//             nextFocus: checkoutController.houseNode,
//             controller: checkoutController.streetNumberController,
//           ) ,
//           SizedBox(height: Dimensions.paddingSizeLarge ),

//           Row(
//               children: [
//                Expanded(
//                   child: CustomTextField(
//                     titleText: 'write_street_number'.tr,
//                     labelText: 'street_number'.tr,
//                     inputType: TextInputType.streetAddress,
//                     focusNode: checkoutController.streetNode,
//                     nextFocus: checkoutController.houseNode,
//                     controller: checkoutController.streetNumberController,
//                   ),
//                 ) ,
//                 SizedBox(width:  Dimensions.paddingSizeSmall ),

//                 Expanded(
//                   child: CustomTextField(
//                     titleText: 'write_house_number'.tr,
//                     labelText: 'house'.tr,
//                     inputType: TextInputType.text,
//                     focusNode: checkoutController.houseNode,
//                     nextFocus: checkoutController.floorNode,
//                     controller: checkoutController.houseController,
//                   ),
//                 ),
//                 const SizedBox(width: Dimensions.paddingSizeSmall),

//                 Expanded(
//                   child: CustomTextField(
//                     titleText: 'write_floor_number'.tr,
//                     labelText: 'floor'.tr,
//                     inputType: TextInputType.text,
//                     focusNode: checkoutController.floorNode,
//                     inputAction: TextInputAction.done,
//                     controller: checkoutController.floorController,
//                   ),
//                 ),
//                 //const SizedBox(height: Dimensions.paddingSizeLarge),
//               ]
//           ),
//           const SizedBox(height: Dimensions.paddingSizeLarge),
//           ],
//         ),
//       );
//     },
//   );
// }






void _showAddressDropdown(BuildContext context, List addressList, checkoutController, List address) {
  // Define the height of each item (you can adjust this based on your AddressWidget)
  const double itemHeight = 70.0; // Example height of each item
  const double titleHeight = 60.0; // Height for title and padding
  const double addAddressHeight = 50.0; // Height for the add address button
  const double textFieldHeight = 60.0; // Height for text fields
  const double padding = 16.0; // Padding around the container

  // Calculate the total height based on the number of items and other components
  final double bottomSheetHeight = (addressList.length * itemHeight) + titleHeight + addAddressHeight + (textFieldHeight * 3) + (padding * 2);

  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true, // Allow the bottom sheet to take full height
    builder: (BuildContext context) {
      return Container(
        // padding: const EdgeInsets.all(padding),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
          // minHeight:MediaQuery.of(context).size.height * 0.8  // Limit the height to 80% of the screen height
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max, // Use min to allow for scrolling
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    // topLeft: Radius.circular(Dimensions.radiusLarge),
                    // topRight: Radius.circular(Dimensions.radiusLarge)
                  )
                ),

                child: Center(
                  child: Container(
               height: 40,
               width: 40,
                    decoration: BoxDecoration(
                           color: const Color.fromARGB(146, 0, 0, 0),
                      borderRadius: BorderRadius.circular(
                        100
                      )
                    ),
                    child: Center(
                      child: IconButton(onPressed: (){
                        Get.back();
                      }, icon: Icon(
                        Icons.close,
                        color: const Color.fromARGB(209, 255, 255, 255),
                        size: 25,
                      )),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5,),
           Expanded(
             child: Container(
               decoration: BoxDecoration(
                 color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusExtraLarge + 5),
                    topRight: Radius.circular(Dimensions.radiusExtraLarge + 5)
                  )
                ),
             
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  
                             children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: Text(
                    'Choose a delivery address',
                    style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w600),
                                    ),
                  ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    itemCount: addressList.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          checkoutController.getDistanceInKM(
                            LatLng(
                              double.parse(address[index].latitude!),
                              double.parse(address[index].longitude!),
                            ),
                            LatLng(
                              double.parse(checkoutController.store!.latitude!),
                              double.parse(checkoutController.store!.longitude!),
                            ),
                          );
                          checkoutController.setAddressIndex(index);
                          Get.back();
                        },
                        child: AddressWidget(
                          address: address[index],
                          fromAddress: false,
                          fromCheckout: true,
                        ),
                      );
                    },
                  ),
                ),
                         const SizedBox(height: Dimensions.paddingSizeSmall),
                // Text fields for address details
                Padding(
                  padding:  const EdgeInsets.only(left: 8,right: 8),
                  child: CustomTextField(
                         radius: Dimensions.radiusLarge,
                    labelText: 'street_number'.tr,
                    titleText: 'write_street_number'.tr,
                    inputType: TextInputType.streetAddress,
                    focusNode: checkoutController.streetNode,
                    nextFocus: checkoutController.houseNode,
                    controller: checkoutController.streetNumberController,
                  ),
                ),
                SizedBox(height: Dimensions.paddingSizeLarge),
                Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(
                    children: [
                    
                      Expanded(
                        child: CustomTextField(
                               radius: Dimensions.radiusLarge,
                          titleText: 'write_house_number'.tr,
                          labelText: 'house'.tr,
                          inputType: TextInputType.text,
                          focusNode: checkoutController.houseNode,
                          nextFocus: checkoutController.floorNode,
                          controller: checkoutController.houseController,
                        ),
                      ),
                      const SizedBox(width: Dimensions.paddingSizeSmall),
                      Expanded(
                        child: CustomTextField(
                          radius: Dimensions.radiusLarge,
                          titleText: 'write_floor_number'.tr,
                          labelText: 'floor'.tr,
                          inputType: TextInputType.text,
                          focusNode: checkoutController.floorNode,
                          inputAction: TextInputAction.done,
                          controller: checkoutController.floorController,
                        ),
                      ),
                    ],
                  ),
                ),
                         const SizedBox(height: Dimensions.paddingSizeSmall),
                             
                  Padding(
                  padding: const EdgeInsets.all(12),
                  child: CustomInkWell(
                    onTap: () async {
                      Get.back();
                      var newAddress = await Get.toNamed(RouteHelper.getAddAddressRoute(true, false, checkoutController.store!.zoneId));
                      if (newAddress != null) {
                        checkoutController.getDistanceInKM(
                          LatLng(double.parse(newAddress.latitude), double.parse(newAddress.longitude)),
                          LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
                        );
                        checkoutController.streetNumberController.text = newAddress.streetNumber ?? '';
                        checkoutController.houseController.text = newAddress.house ?? '';
                        checkoutController.floorController.text = newAddress.floor ?? '';
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Theme.of(context).primaryColor),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                            child: Icon(Icons.add, size: 18, color: Theme.of(context).primaryColor),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text('Add New Address'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor)),
                        Spacer(),
                        Icon(Icons.arrow_right),
                      ],
                    ),
                  ),
                ),
                             
                             ],
                             
                ),
              ),
             ),
           ),
            
           
           
          ],
        ),
      );
    },
  );
}









class Paymenticoncard extends StatelessWidget {
  final String image;

  const Paymenticoncard({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 30,
      decoration: BoxDecoration(
        borderRadius:  BorderRadius.circular(5),
        border: Border.all(   
          color: const Color(0xFFE4E4E4)
        )
      ),
      child: Center(child: Padding(
        padding: const EdgeInsets.all(5),
        child: Image.asset(image),
      )),
    );
  }
}