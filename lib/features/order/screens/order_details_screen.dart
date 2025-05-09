import 'dart:async';
import 'dart:collection';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/common/widgets/custom_loader.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/chat/domain/models/conversation_model.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/location/widgets/permission_dialog_widget.dart';
import 'package:sixam_mart/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart/features/order/widgets/track_details_view_widget.dart';
import 'package:sixam_mart/features/order/widgets/tracking_stepper_widget.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart/features/order/domain/models/order_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/marker_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/confirmation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/features/checkout/widgets/offline_success_dialog.dart';
import 'package:sixam_mart/features/order/widgets/cancellation_dialogue_widget.dart';
import 'package:sixam_mart/features/order/widgets/order_calcuation_widget.dart';
import 'package:sixam_mart/features/order/widgets/order_info_widget.dart';
import 'package:sixam_mart/features/review/screens/rate_review_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class OrderDetailsScreen extends StatefulWidget {
//   final OrderModel? orderModel;
//   final int? orderId;
//   final bool fromNotification;
//   final bool fromOfflinePayment;
//   final String? contactNumber;
//   const OrderDetailsScreen({super.key, required this.orderModel, required this.orderId, this.fromNotification = false, this.fromOfflinePayment = false, this.contactNumber});

//   @override
//   OrderDetailsScreenState createState() => OrderDetailsScreenState();
// }

// class OrderDetailsScreenState extends State<OrderDetailsScreen> {
//   Timer? _timer;
//   double? _maxCodOrderAmount;
//   bool? _isCashOnDeliveryActive = false;
//   final ScrollController scrollController = ScrollController();

//   void _loadData(BuildContext context, bool reload) async {
//     await Get.find<OrderController>().trackOrder(widget.orderId.toString(), reload ? null : widget.orderModel, false, contactNumber: widget.contactNumber).then((value) {
//       if(widget.fromOfflinePayment) {
//         Future.delayed(const Duration(seconds: 2), () => showAnimatedDialog(Get.context!, OfflineSuccessDialog(orderId: widget.orderId)));
//       }
//     });
//     Get.find<OrderController>().timerTrackOrder(widget.orderId.toString(), contactNumber: widget.contactNumber);
//     Get.find<OrderController>().getOrderDetails(widget.orderId.toString());
//   }

//   void _startApiCall(){
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
//       await Get.find<OrderController>().timerTrackOrder(widget.orderId.toString(), contactNumber: widget.contactNumber);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();

//     _loadData(context, false);

//     _startApiCall();
//   }

//   @override
//   void dispose() {
//     _timer?.cancel();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: Navigator.canPop(context),
//       onPopInvokedWithResult: (didPop, result) async {
//         if(widget.fromNotification || widget.fromOfflinePayment) {
//           Get.offAllNamed(RouteHelper.getInitialRoute());
//         } else {
//           return;
//         }
//       },
//       child: Scaffold(
//         appBar: CustomAppBar(title: 'order_details'.tr, onBackPressed: () {
//           if(widget.fromNotification || widget.fromOfflinePayment) {
//             Get.offAllNamed(RouteHelper.getInitialRoute());
//           } else {
//             Get.back();
//           }
//         }),
//         endDrawer: const MenuDrawer(),
//         endDrawerEnableOpenDragGesture: false,
//         backgroundColor: Theme.of(context).colorScheme.surface,
//         body: SafeArea(child: GetBuilder<OrderController>(builder: (orderController) {
//           double deliveryCharge = 0;
//           double itemsPrice = 0;
//           double discount = 0;
//           double couponDiscount = 0;
//           double tax = 0;
//           double addOns = 0;
//           double dmTips = 0;
//           double additionalCharge = 0;
//           double extraPackagingCharge = 0;
//           double referrerBonusAmount = 0;
//           OrderModel? order = orderController.trackModel;
//           bool parcel = false;
//           bool prescriptionOrder = false;
//           bool taxIncluded = false;
//           bool ongoing = false;
//           bool showChatPermission = true;
//           if(orderController.orderDetails != null  && order != null) {
//             parcel = order.orderType == 'parcel';
//             prescriptionOrder = order.prescriptionOrder!;
//             deliveryCharge = order.deliveryCharge!;
//             couponDiscount = order.couponDiscountAmount!;
//             discount = order.storeDiscountAmount! + order.flashAdminDiscountAmount! + order.flashStoreDiscountAmount!;
//             tax = order.totalTaxAmount!;
//             dmTips = order.dmTips!;
//             taxIncluded = order.taxStatus!;
//             additionalCharge = order.additionalCharge!;
//             extraPackagingCharge = order.extraPackagingAmount!;
//             referrerBonusAmount = order.referrerBonusAmount!;
//             if(prescriptionOrder) {
//               double orderAmount = order.orderAmount ?? 0;
//               itemsPrice = (orderAmount + discount) - ((taxIncluded ? 0 : tax) + deliveryCharge) - dmTips - additionalCharge;
//             } else{
//               for(OrderDetailsModel orderDetails in orderController.orderDetails!) {
//                 for(AddOn addOn in orderDetails.addOns!) {
//                   addOns = addOns + (addOn.price! * addOn.quantity!);
//                 }
//                 itemsPrice = itemsPrice + (orderDetails.price! * orderDetails.quantity!);
//               }
//             }

//             if(!parcel && order.store != null) {
//               for(ZoneData zData in AddressHelper.getUserAddressFromSharedPref()!.zoneData!) {
//                 if(zData.id == order.store!.zoneId){
//                   _isCashOnDeliveryActive = zData.cashOnDelivery;
//                 }
//                 for(Modules m in zData.modules!) {
//                   if(m.id == order.store!.moduleId) {
//                     _maxCodOrderAmount = m.pivot!.maximumCodOrderAmount;
//                     break;
//                   }
//                 }
//               }
//             }

//             if (order.store != null) {
//               if (order.store!.storeBusinessModel == 'commission') {
//                 showChatPermission = true;
//               } else if (order.store!.storeSubscription != null && order.store!.storeBusinessModel == 'subscription') {
//                 showChatPermission = order.store!.storeSubscription!.chat == 1;
//               } else {
//                 showChatPermission = false;
//               }
//             } else {
//               showChatPermission = AuthHelper.isLoggedIn();
//             }

//             ongoing = (order.orderStatus != 'delivered' && order.orderStatus != 'failed' && order.orderStatus != 'canceled' && order.orderStatus != 'refund_requested'
//             && order.orderStatus != 'refunded' && order.orderStatus != 'refund_request_canceled');

//           }
//           double subTotal = itemsPrice + addOns;
//           double total = itemsPrice + addOns - discount + (taxIncluded ? 0 : tax) + deliveryCharge - couponDiscount + dmTips + additionalCharge + extraPackagingCharge - referrerBonusAmount;

//           return orderController.orderDetails != null && order != null && orderController.trackModel != null ? Column(children: [
//             ResponsiveHelper.isDesktop(context) ? Container(
//               height: 64,
//               color: Theme.of(context).primaryColor  ,
//               child: Center(child: Text('order_details'.tr, style: robotoMedium)),
//             ) : const SizedBox(),

//             Expanded(child: SingleChildScrollView(
//               controller: scrollController,
//               physics: const BouncingScrollPhysics(),
//               child: FooterView(child: SizedBox(width: Dimensions.webMaxWidth, child: Column (
//                 children: [

//                 ResponsiveHelper.isDesktop(context) ?
//                   Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                     Expanded(
//                       flex: 6,
//                       child : OrderInfoWidget(
//                         order: order, ongoing: ongoing, parcel: parcel, prescriptionOrder: prescriptionOrder,
//                         timerCancel : () => _timer?.cancel(), startApiCall : () =>  _startApiCall(),
//                         orderController: orderController, showChatPermission: showChatPermission,
//                       ),
//                     ),
//                     const SizedBox(width: Dimensions.paddingSizeLarge),

//                     Expanded(
//                       flex: 4,
//                       child: OrderCalculationWidget(
//                         orderController: orderController, order: order, ongoing: ongoing, parcel: parcel,
//                         prescriptionOrder: prescriptionOrder, deliveryCharge: deliveryCharge, itemsPrice: itemsPrice,
//                         discount: discount, couponDiscount: couponDiscount, tax: tax, addOns: addOns, dmTips: dmTips,
//                         taxIncluded: taxIncluded, subTotal: subTotal, total: total,
//                         bottomView: _bottomView(orderController, order, parcel, total), extraPackagingAmount: extraPackagingCharge,
//                         referrerBonusAmount: referrerBonusAmount, timerCancel : () => _timer?.cancel(), startApiCall : () =>  _startApiCall(),
//                       ),
//                     ),
//                   ]) : const SizedBox(),

//                   ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderInfoWidget(
//                     order: order, ongoing: ongoing, parcel: parcel, prescriptionOrder: prescriptionOrder,
//                     timerCancel : () => _timer?.cancel(), startApiCall : () =>  _startApiCall(),
//                     orderController: orderController, showChatPermission: showChatPermission,
//                   ),

//                   ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderCalculationWidget(
//                       orderController: orderController, order: order, ongoing: ongoing, parcel: parcel,
//                       prescriptionOrder: prescriptionOrder, deliveryCharge: deliveryCharge, itemsPrice: itemsPrice,
//                       discount: discount, couponDiscount: couponDiscount, tax: tax, addOns: addOns, dmTips: dmTips, taxIncluded: taxIncluded, subTotal: subTotal, total: total,
//                       bottomView: _bottomView(orderController, order, parcel, total), extraPackagingAmount: extraPackagingCharge, referrerBonusAmount: referrerBonusAmount,
//                     timerCancel : () => _timer?.cancel(), startApiCall : () =>  _startApiCall(),
//                   ),

//                 ],
//               ))),
//             )),

//             ResponsiveHelper.isDesktop(context) ? const SizedBox() : _bottomView(orderController, order, parcel, total),

//           ]) : const Center(child: CircularProgressIndicator());
//         })),
//       ),
//     );
//   }

//   void openDialog(BuildContext context, String imageUrl) => showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
//         child: Stack(children: [

//           ClipRRect(
//             borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
//             child: PhotoView(
//               tightMode: true,
//               imageProvider: NetworkImage(imageUrl),
//               heroAttributes: PhotoViewHeroAttributes(tag: imageUrl),
//             ),
//           ),

//           Positioned(top: 0, right: 0, child: IconButton(
//             splashRadius: 5,
//             onPressed: () => Get.back(),
//             icon: const Icon(Icons.cancel, color: Colors.red),
//           )),

//         ]),
//       );
//     },
//   );

//   Widget _bottomView(OrderController orderController, OrderModel order, bool parcel, double totalPrice) {
//     return Column(children: [
//       !orderController.showCancelled ? Center(
//         child: SizedBox(
//           width: Dimensions.webMaxWidth,
//           child: Row(children: [
//             ((order.orderStatus == 'pending' && order.paymentMethod != 'digital_payment') || order.orderStatus == 'accepted' || order.orderStatus == 'confirmed'
//             || order.orderStatus == 'processing' || order.orderStatus == 'handover'|| order.orderStatus == 'picked_up') ? Expanded(
//               child: CustomButton(
//                 buttonText: parcel ? 'track_delivery'.tr : 'track_order'.tr,
//                 margin: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                 onPressed: () async{
//                   _timer?.cancel();
//                   await Get.toNamed(RouteHelper.getOrderTrackingRoute(order.id, widget.contactNumber))?.whenComplete(() {
//                     _startApiCall();
//                   });
//                 },
//               ),
//             ) : const SizedBox(),

//             (order.orderStatus == 'pending' && order.paymentStatus == 'unpaid' && order.paymentMethod == 'digital_payment' && _isCashOnDeliveryActive!) ?
//             Expanded(
//               child: CustomButton(
//                 buttonText: 'switch_to_cod'.tr,
//                 margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//                 onPressed: () {
//                   Get.dialog(ConfirmationDialog(
//                       icon: Images.warning, description: 'are_you_sure_to_switch'.tr,
//                       onYesPressed: () {

//                         if((((_maxCodOrderAmount != null && totalPrice < _maxCodOrderAmount!) || _maxCodOrderAmount == null || _maxCodOrderAmount == 0) && !parcel) || parcel){
//                           orderController.switchToCOD(order.id.toString());
//                         }else{
//                           if(Get.isDialogOpen!) {
//                             Get.back();
//                           }
//                           showCustomSnackBar('${'you_cant_order_more_then'.tr} ${PriceConverter.convertPrice(_maxCodOrderAmount)} ${'in_cash_on_delivery'.tr}');
//                         }
//                       }
//                   ));
//                 },
//               ),
//             ): const SizedBox(),

//             order.orderStatus == 'pending' ? const SizedBox(width: Dimensions.paddingSizeSmall) : const SizedBox(),

//             (order.orderStatus == 'pending' && (Get.find<AuthController>().isLoggedIn() ? true : (orderController.orderDetails != null && orderController.orderDetails!.isNotEmpty  && orderController.orderDetails?[0].isGuest == 1 ? true : false))) ? Expanded(child: Padding(
//               padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.all(Dimensions.paddingSizeSmall),
//               child: TextButton(
//                 style: TextButton.styleFrom(minimumSize: const Size(1, 50), shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(Dimensions.radiusDefault), side: BorderSide(width: 2, color: Theme.of(context).disabledColor),
//                 )),
//                 onPressed: () {
//                   orderController.setOrderCancelReason('');
//                   Get.dialog(CancellationDialogueWidget(orderId: order.id, contactNumber: widget.contactNumber));
//                 },
//                 child: Text(parcel ? 'cancel_delivery'.tr : 'cancel_order'.tr, style: robotoBold.copyWith(
//                   color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeLarge,
//                 )),
//               ),
//             )) : const SizedBox(),

//           ]),
//         ),
//       ) : Center(
//         child: Container(
//           width: Dimensions.webMaxWidth,
//           height: 50,
//           margin: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
//           alignment: Alignment.center,
//           decoration: BoxDecoration(
//             border: Border.all(width: 2, color: Theme.of(context).primaryColor),
//             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//           ),
//           child: Text('order_cancelled'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
//         ),
//       ),

//       !AuthHelper.isGuestLoggedIn() && (order.orderStatus == 'delivered' && (parcel ? order.deliveryMan != null : (orderController.orderDetails!.isNotEmpty && orderController.orderDetails![0].itemCampaignId == null))) ? Center(
//         child: Container(
//           width: Dimensions.webMaxWidth,
//           padding: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
//           child: CustomButton(
//             buttonText: 'review'.tr,
//             onPressed: () {
//               List<OrderDetailsModel> orderDetailsList = [];
//               List<int?> orderDetailsIdList = [];
//               for (var orderDetail in orderController.orderDetails!) {
//                 if(!orderDetailsIdList.contains(orderDetail.itemDetails!.id)) {
//                   orderDetailsList.add(orderDetail);
//                   orderDetailsIdList.add(orderDetail.itemDetails!.id);
//                 }
//               }
//               Get.toNamed(RouteHelper.getReviewRoute(), arguments: RateReviewScreen(
//                 orderDetailsList: orderDetailsList, deliveryMan: order.deliveryMan, orderID: order.id,
//               ));
//             },
//           ),
//         ),
//       ) : const SizedBox(),

//       (order.orderStatus == 'failed' && Get.find<SplashController>().configModel!.cashOnDelivery!) ? Center(
//         child: Container(
//           width: Dimensions.webMaxWidth,
//           padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
//           child: CustomButton(
//             buttonText: 'switch_to_cash_on_delivery'.tr,
//             onPressed: () {
//               Get.dialog(ConfirmationDialog(
//                   icon: Images.warning, description: 'are_you_sure_to_switch'.tr,
//                   onYesPressed: () {
//                     orderController.switchToCOD(order.id.toString()).then((isSuccess) {
//                       Get.back();
//                       if(isSuccess) {
//                         Get.back();
//                       }
//                     });
//                   }
//               ));
//             },
//           ),
//         ),
//       ) : const SizedBox(),
//     ]);
//   }
// }






class OrderDetailsScreen extends StatefulWidget {
  final OrderModel? orderModel;
  final int? orderId;
  final bool fromNotification;
  final bool fromOfflinePayment;
  final String? contactNumber;
  const OrderDetailsScreen({super.key, required this.orderModel, required this.orderId, this.fromNotification = false, this.fromOfflinePayment = false, this.contactNumber});

  @override
  OrderDetailsScreenState createState() => OrderDetailsScreenState();
}

class OrderDetailsScreenState extends State<OrderDetailsScreen> {
  GoogleMapController? _controller;
  bool _isLoading = true;
  Set<Marker> _markers = HashSet<Marker>();
  Timer? _timer;
  bool showChatPermission = true;
  bool isHovered = false;
  double? _maxCodOrderAmount;
  bool? _isCashOnDeliveryActive = false;
  final ScrollController scrollController = ScrollController();

  void _loadData(BuildContext context, bool reload) async {
    await Get.find<OrderController>().trackOrder(widget.orderId.toString(), reload ? null : widget.orderModel, false, contactNumber: widget.contactNumber).then((value) {
      if(widget.fromOfflinePayment) {
        Future.delayed(const Duration(seconds: 2), () => showAnimatedDialog(Get.context!, OfflineSuccessDialog(orderId: widget.orderId)));
      }
    });
    await Get.find<LocationController>().getCurrentLocation(true, notify: false, defaultLatLng: LatLng(
      double.parse(AddressHelper.getUserAddressFromSharedPref()!.latitude!),
      double.parse(AddressHelper.getUserAddressFromSharedPref()!.longitude!),
    ));
    Get.find<OrderController>().getOrderDetails(widget.orderId.toString());
  }

  void _startApiCall(){
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      await Get.find<OrderController>().timerTrackOrder(widget.orderId.toString(), contactNumber: widget.contactNumber);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadData(context, false);
    _startApiCall();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void onEntered(bool isHovered) {
    setState(() {
      this.isHovered = isHovered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: Navigator.canPop(context),
      onPopInvokedWithResult: (didPop, result) async {
        if(widget.fromNotification || widget.fromOfflinePayment) {
          Get.offAllNamed(RouteHelper.getInitialRoute());
        } else {
          return;
        }
      },
      child:
       Scaffold(

        // appBar:  AppBar(

        //   backgroundColor: Colors.transparent,
        //    leading: IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black), // Back button icon
        //   onPressed: () {
        //     Navigator.of(context).pop(); // Action for the back button
        //   },
        // )
        // ),
        // appBar: CustomAppBar(title: 'order_details'.tr, onBackPressed: () {
        //   if(widget.fromNotification || widget.fromOfflinePayment) {
        //     Get.offAllNamed(RouteHelper.getInitialRoute());
        //   } else {
        //     Get.back();
        //   }
        // }),
        // endDrawer: const MenuDrawer(),
        endDrawerEnableOpenDragGesture: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: GetBuilder<OrderController>(builder: (orderController) {
          OrderModel? order = orderController.trackModel;
          bool parcel = order?.orderType == 'parcel';
          bool prescriptionOrder = order?.prescriptionOrder ?? false;
          bool ongoing = order?.orderStatus != 'delivered' && order?.orderStatus != 'failed' && order?.orderStatus != 'canceled' && order?.orderStatus != 'refund_requested'
              && order?.orderStatus != 'refunded' && order?.orderStatus != 'refund_request_canceled';
        
          return orderController.orderDetails != null && order != null && orderController.trackModel != null ? 
          
          // Column(children: [
          //   ResponsiveHelper.isDesktop(context) ? Container(
          //     height: 64,
          //     color: Theme.of(context).primaryColor,
          //     child: Center(child: Text('order_details'.tr, style: robotoMedium)),
          //   ) : const SizedBox(),
        
          //   Expanded(child: FooterView(child: SizedBox(width: Dimensions.webMaxWidth, child: Column(children: [
          //            _buildMapSection(orderController, order),
          //            SingleChildScrollView(
          //             physics: AlwaysScrollableScrollPhysics(),
          //             child: Column(children: [
          //                    Padding(
          //                padding: const EdgeInsets.only(
          //   top: 20, left: 20, right: 20, bottom: 10
          //                ),
          //                child: TrackingStepperWidget(status: order.orderStatus, takeAway: order.orderType == 'take_away'),
          //              ),
                        
          //     ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderInfoWidget(
          //       order: order, ongoing: ongoing, parcel: parcel, prescriptionOrder: prescriptionOrder,
          //       timerCancel: () => _timer?.cancel(), startApiCall: () => _startApiCall(),
          //       orderController: orderController, showChatPermission: showChatPermission,
          //     ),
                    
          //     ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderCalculationWidget(
          //       orderController: orderController, order: order, ongoing: ongoing, parcel: parcel,
          //       prescriptionOrder: prescriptionOrder, deliveryCharge: order.deliveryCharge ?? 0,
          //       itemsPrice: _calculateItemsPrice(orderController, order), discount: _calculateDiscount(order),
          //       couponDiscount: order.couponDiscountAmount ?? 0, tax: order.totalTaxAmount ?? 0,
          //       addOns: _calculateAddOns(orderController), dmTips: order.dmTips ?? 0,
          //       taxIncluded: order.taxStatus ?? false, subTotal: _calculateSubTotal(orderController, order),
          //       total: _calculateTotal(orderController, order), bottomView: _bottomView(orderController, order, parcel, _calculateTotal(orderController, order)),
          //       extraPackagingAmount: order.extraPackagingAmount ?? 0, referrerBonusAmount: order.referrerBonusAmount ?? 0,
          //       timerCancel: () => _timer?.cancel(), startApiCall: () => _startApiCall(),
          //     ),
                    
             
          //             ]),
          //            )
                  
                    
          //   ])))),
        
          //   ResponsiveHelper.isDesktop(context) ? const SizedBox() : _bottomView(orderController, order, parcel, _calculateTotal(orderController, order)),
        
          // ]) : const Center(child: CircularProgressIndicator());
       
        Column(
          children: [
            // Fixed Map Section
            _buildMapSection(orderController, order),

            // CustomScrollView for the rest of the content
            Expanded(
              child: CustomScrollView(
                slivers: [
                

                  // Tracking Stepper
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 10),
                      child: TrackingStepperWidget(status: order.orderStatus, takeAway: order.orderType == 'take_away'),
                    ),
                  ),
       SliverToBoxAdapter(
  child: TrackDetailsViewWidget(status: order.orderStatus, track: order, showChatPermission: showChatPermission, callback: () async{
    _timer?.cancel();
    await Get.toNamed(RouteHelper.getChatRoute(
      notificationBody: NotificationBodyModel(deliverymanId: order.deliveryMan!.id, orderId: int.parse(widget.orderId.toString())),
      user: User(id: order.deliveryMan!.id, fName: order.deliveryMan!.fName, lName: order.deliveryMan!.lName, imageFullUrl: order.deliveryMan!.imageFullUrl),
    ));
    _startApiCall();
  }),
),
                  // Order Info Widget
                  SliverToBoxAdapter(
                    child: ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderInfoWidget(
                      track: order,
                      order: order,
                      ongoing: ongoing,
                      parcel: parcel,
                      prescriptionOrder: prescriptionOrder,
                      timerCancel: () => _timer?.cancel(),
                      startApiCall: () => _startApiCall(),
                      orderController: orderController,
                      showChatPermission: showChatPermission,
                    ),
                  ),

        
                  // Order Calculation Widget
                  SliverToBoxAdapter(
                    child: ResponsiveHelper.isDesktop(context) ? const SizedBox() : OrderCalculationWidget(
                      orderController: orderController,
                      order: order,
                      ongoing: ongoing,
                      parcel: parcel,
                      prescriptionOrder: prescriptionOrder,
                      deliveryCharge: order.deliveryCharge ?? 0,
                      itemsPrice: _calculateItemsPrice(orderController, order),
                      discount: _calculateDiscount(order),
                      couponDiscount: order.couponDiscountAmount ?? 0,
                      tax: order.totalTaxAmount ?? 0,
                      addOns: _calculateAddOns(orderController),
                      dmTips: order.dmTips ?? 0,
                      taxIncluded: order.taxStatus ?? false,
                      subTotal: _calculateSubTotal(orderController, order),
                      total: _calculateTotal(orderController, order),
                      bottomView: _bottomView(orderController, order, parcel, _calculateTotal(orderController, order)),
                      extraPackagingAmount: order.extraPackagingAmount ?? 0,
                      referrerBonusAmount: order.referrerBonusAmount ?? 0,
                      timerCancel: () => _timer?.cancel(),
                      startApiCall: () => _startApiCall(),
                    ),
                  ),

                  // Bottom View
                  // SliverToBoxAdapter(
                  //   child: ResponsiveHelper.isDesktop(context) ? const SizedBox() : _bottomView(orderController, order, parcel, _calculateTotal(orderController, order)),
                  // ),
                ],
              ),
            ),
             ResponsiveHelper.isDesktop(context) ? const SizedBox() : _bottomView(orderController, order, parcel, _calculateTotal(orderController, order)),
          ],
        ) : const Center(child: CustomLoaderWidget());
     
        }),

        
      ),
    
    
    );
  }

  Widget _buildMapSection(OrderController orderController, OrderModel order) {
    return order.orderType != 'take_away' ? SingleChildScrollView(
      physics: isHovered || !ResponsiveHelper.isDesktop(context) ? const NeverScrollableScrollPhysics() : const AlwaysScrollableScrollPhysics(),
      child: FooterView(
        child: SizedBox(width: Dimensions.webMaxWidth, height: ResponsiveHelper.isDesktop(context) ? 700 : MediaQuery.of(context).size.height * 0.15, child: Stack(children: [
           
          
        
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25), bottomRight: Radius.circular(25),
            ),
            child:
            //  MouseRegion(
            //   onEnter: (event) => onEntered(true),
            //   onExit: (event) => onEntered(false),
            //   child: GoogleMap(
            //     initialCameraPosition: CameraPosition(target: LatLng(
            //       double.parse(order.deliveryAddress!.latitude!), double.parse(order.deliveryAddress!.longitude!),
            //     ), zoom: 16),
            //     minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
            //     zoomControlsEnabled: false,
            //     markers: _markers,
            //     onMapCreated: (GoogleMapController controller) {
            //       _controller = controller;
            //       _isLoading = false;
            //       setMarker(
            //         order.orderType == 'parcel' ? Store(latitude: order.receiverDetails!.latitude, longitude: order.receiverDetails!.longitude,
            //             address: order.receiverDetails!.address, name: order.receiverDetails!.contactPersonName) : order.store, order.deliveryMan,
            //         order.orderType == 'take_away' ? Get.find<LocationController>().position.latitude == 0 ? order.deliveryAddress : AddressModel(
            //           latitude: Get.find<LocationController>().position.latitude.toString(),
            //           longitude: Get.find<LocationController>().position.longitude.toString(),
            //           address: Get.find<LocationController>().address,
            //         ) : order.deliveryAddress, order.orderType == 'take_away', order.orderType == 'parcel', order.moduleType == 'food',
            //       );
            //     },
            //     style: Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
            //   ),
            // ),
        
        MouseRegion(
                onEnter: (event) => onEntered(true),
                onExit: (event) => onEntered(false),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(target: LatLng(
                    double.parse(order.deliveryAddress!.latitude!), double.parse(order.deliveryAddress!.longitude!),
                  ), zoom: 16),
                  minMaxZoomPreference: const MinMaxZoomPreference(0, 16),
                  zoomControlsEnabled: false,
                  markers: _markers,
                  onMapCreated: (GoogleMapController controller) {
                    _controller = controller;
                    _isLoading = false;
                    setMarker(
                      order!.orderType == 'parcel' ? Store(latitude: order.receiverDetails!.latitude, longitude: order.receiverDetails!.longitude,
                          address: order.receiverDetails!.address, name: order.receiverDetails!.contactPersonName) : order.store, order.deliveryMan,
                      order.orderType == 'take_away' ? Get.find<LocationController>().position.latitude == 0 ? order.deliveryAddress : AddressModel(
                        latitude: Get.find<LocationController>().position.latitude.toString(),
                        longitude: Get.find<LocationController>().position.longitude.toString(),
                        address: Get.find<LocationController>().address,
                      ) : order.deliveryAddress, order.orderType == 'take_away', order.orderType == 'parcel', order.moduleType == 'food',
                    );
                  },
                  style: Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
                ),
              ),

          ),
        
          _isLoading ? const Center(child: CircularProgressIndicator()) : const SizedBox(),
        
          // Positioned(
          //   top: 100, left: 20, right: 20,
          //   child: TrackingStepperWidget(status: order.orderStatus, takeAway: order.orderType == 'take_away'),
          // ),
        
          Positioned(
            right: 15, bottom: order.orderType != 'take_away' && order.deliveryMan == null ? 50 : 50,
            child: InkWell(
              onTap: () => _checkPermission(() async {
                AddressModel address = await Get.find<LocationController>().getCurrentLocation(false, mapController: _controller);
                setMarker(
                  order.orderType == 'parcel' ? Store(latitude: order.receiverDetails!.latitude, longitude: order.receiverDetails!.longitude,
                      address: order.receiverDetails!.address, name: order.receiverDetails!.contactPersonName) : order.store, order.deliveryMan,
                  order.orderType == 'take_away' ? Get.find<LocationController>().position.latitude == 0 ? order.deliveryAddress : AddressModel(
                    latitude: Get.find<LocationController>().position.latitude.toString(),
                    longitude: Get.find<LocationController>().position.longitude.toString(),
                    address: Get.find<LocationController>().address,
                  ) : order.deliveryAddress, order.orderType == 'take_away', order.orderType == 'parcel', order.moduleType == 'food',
                  currentAddress: address, fromCurrentLocation: true,
                );
              }),
              child: Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Colors.white),
                child: Icon(Icons.my_location_outlined, color: Theme.of(context).primaryColor, size: 25),
              ),
            ),
          ),
        
          
         Padding(
           padding: const EdgeInsets.only(top: 50, left: 20),
           child: Align(
              alignment: Alignment.topLeft,
               child: InkWell(
                onTap: () {
                   if(widget.fromNotification || widget.fromOfflinePayment) {
            Get.offAllNamed(RouteHelper.getInitialRoute());
          } else {
            Get.back();
          }
                },
                 child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color.fromARGB(147, 255, 255, 255)
                  ),
                   child: Icon(  Icons.arrow_back ,color: const Color.fromARGB(211, 0, 0, 0), ),
                 ),
               ),
             ),
         ),
        ])),
      ),
    ) : const SizedBox();
  }

  Widget _bottomView(OrderController orderController, OrderModel order, bool parcel, double totalPrice) {
    return Column(children: [
      !orderController.showCancelled ? Center(
        child: SizedBox(
          width: Dimensions.webMaxWidth,
          child: Row(children: [
            ((order.orderStatus == 'pending' && order.paymentMethod != 'digital_payment') || order.orderStatus == 'accepted' || order.orderStatus == 'confirmed'
            || order.orderStatus == 'processing' || order.orderStatus == 'handover'|| order.orderStatus == 'picked_up') ? Expanded(
              child: CustomButton(
                buttonText: parcel ? 'track_delivery'.tr : 'Message'.tr,
                margin: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
                onPressed: () async {
                
                    await Get.toNamed(RouteHelper.getChatRoute(
                      notificationBody: NotificationBodyModel(orderId: order.id, restaurantId: order.store!.vendorId),
                      user: User(id: order.store!.vendorId, fName: order.store!.name, lName: '', imageFullUrl: order.store!.logoFullUrl),
                    ));
                  
                  // _timer?.cancel();
                  // await Get.toNamed(RouteHelper.getOrderTrackingRoute(order.id, widget.contactNumber))?.whenComplete(() {
                  //   _startApiCall();
                  // });
                },
              ),
            ) : const SizedBox(),

            (order.orderStatus == 'pending' && order.paymentStatus == 'unpaid' && order.paymentMethod == 'digital_payment' && _isCashOnDeliveryActive!) ?
            Expanded(
              child: CustomButton(
                buttonText: 'switch_to_cod'.tr,
                margin: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                onPressed: () {
                  Get.dialog(ConfirmationDialog(
                      icon: Images.warning, description: 'are_you_sure_to_switch'.tr,
                      onYesPressed: () {
                        if((((_maxCodOrderAmount != null && totalPrice < _maxCodOrderAmount!) || _maxCodOrderAmount == null || _maxCodOrderAmount == 0) && !parcel) || parcel){
                          orderController.switchToCOD(order.id.toString());
                        }else{
                          if(Get.isDialogOpen!) {
                            Get.back();
                          }
                          showCustomSnackBar('${'you_cant_order_more_then'.tr} ${PriceConverter.convertPrice(_maxCodOrderAmount)} ${'in_cash_on_delivery'.tr}');
                        }
                      }
                  ));
                },
              ),
            ): const SizedBox(),

            order.orderStatus == 'pending' ? const SizedBox(width: Dimensions.paddingSizeSmall) : const SizedBox(),

            (order.orderStatus == 'pending' && (Get.find<AuthController>().isLoggedIn() ? true : (orderController.orderDetails != null && orderController.orderDetails!.isNotEmpty  && orderController.orderDetails?[0].isGuest == 1 ? true : false))) ? Expanded(child: Padding(
              padding: ResponsiveHelper.isDesktop(context) ? EdgeInsets.zero : const EdgeInsets.all(Dimensions.paddingSizeSmall),
              child: TextButton(
                style: TextButton.styleFrom(minimumSize: const Size(1, 50), shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault), side: BorderSide(width: 2, color: Theme.of(context).disabledColor),
                )),
                onPressed: () {
                  orderController.setOrderCancelReason('');
                  Get.dialog(CancellationDialogueWidget(orderId: order.id, contactNumber: widget.contactNumber));
                },
                child: Text(parcel ? 'cancel_delivery'.tr : 'cancel_order'.tr, style: robotoBold.copyWith(
                  color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeLarge,
                )),
              ),
            )) : const SizedBox(),

          ]),
        ),
      ) : Center(
        child: Container(
          width: Dimensions.webMaxWidth,
          height: 50,
          margin: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          ),
          child: Text('order_cancelled'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
        ),
      ),

      !AuthHelper.isGuestLoggedIn() && (order.orderStatus == 'delivered' && (parcel ? order.deliveryMan != null : (orderController.orderDetails!.isNotEmpty && orderController.orderDetails![0].itemCampaignId == null))) ? Center(
        child: Container(
          width: Dimensions.webMaxWidth,
          padding: ResponsiveHelper.isDesktop(context) ? null : const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CustomButton(
            buttonText: 'review'.tr,
            onPressed: () {
              List<OrderDetailsModel> orderDetailsList = [];
              List<int?> orderDetailsIdList = [];
              for (var orderDetail in orderController.orderDetails!) {
                if(!orderDetailsIdList.contains(orderDetail.itemDetails!.id)) {
                  orderDetailsList.add(orderDetail);
                  orderDetailsIdList.add(orderDetail.itemDetails!.id);
                }
              }
              Get.toNamed(RouteHelper.getReviewRoute(), arguments: RateReviewScreen(
                orderDetailsList: orderDetailsList, deliveryMan: order.deliveryMan, orderID: order.id,
              ));
            },
          ),
        ),
      ) : const SizedBox(),

      (order.orderStatus == 'failed' && Get.find<SplashController>().configModel!.cashOnDelivery!) ? Center(
        child: Container(
          width: Dimensions.webMaxWidth,
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CustomButton(
            buttonText: 'switch_to_cash_on_delivery'.tr,
            onPressed: () {
              Get.dialog(ConfirmationDialog(
                  icon: Images.warning, description: 'are_you_sure_to_switch'.tr,
                  onYesPressed: () {
                    orderController.switchToCOD(order.id.toString()).then((isSuccess) {
                      Get.back();
                      if(isSuccess) {
                        Get.back();
                      }
                    });
                  }
              ));
            },
          ),
        ),
      ) : const SizedBox(),
    ]);
  }

  double _calculateItemsPrice(OrderController orderController, OrderModel order) {
    double itemsPrice = 0;
    if(order.prescriptionOrder!) {
      double orderAmount = order.orderAmount ?? 0;
      itemsPrice = (orderAmount + _calculateDiscount(order)) - ((order.taxStatus! ? 0 : order.totalTaxAmount!) + order.deliveryCharge!) - order.dmTips! - order.additionalCharge!;
    } else{
      for(OrderDetailsModel orderDetails in orderController.orderDetails!) {
        for(AddOn addOn in orderDetails.addOns!) {
          itemsPrice = itemsPrice + (addOn.price! * addOn.quantity!);
        }
        itemsPrice = itemsPrice + (orderDetails.price! * orderDetails.quantity!);
      }
    }
    return itemsPrice;
  }

  double _calculateDiscount(OrderModel order) {
    return order.storeDiscountAmount! + order.flashAdminDiscountAmount! + order.flashStoreDiscountAmount!;
  }

  double _calculateAddOns(OrderController orderController) {
    double addOns = 0;
    for(OrderDetailsModel orderDetails in orderController.orderDetails!) {
      for(AddOn addOn in orderDetails.addOns!) {
        addOns = addOns + (addOn.price! * addOn.quantity!);
      }
    }
    return addOns;
  }

  double _calculateSubTotal(OrderController orderController, OrderModel order) {
    return _calculateItemsPrice(orderController, order) + _calculateAddOns(orderController);
  }

  double _calculateTotal(OrderController orderController, OrderModel order) {
    return _calculateSubTotal(orderController, order) - _calculateDiscount(order) + (order.taxStatus! ? 0 : order.totalTaxAmount!) + order.deliveryCharge! - order.couponDiscountAmount! + order.dmTips! + order.additionalCharge! + order.extraPackagingAmount! - order.referrerBonusAmount!;
  }

  void _checkPermission(Function onTap) async {
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if(permission == LocationPermission.denied) {
      showCustomSnackBar('you_have_to_allow'.tr);
    }else if(permission == LocationPermission.deniedForever) {
      Get.dialog(const PermissionDialogWidget());
    }else {
      onTap();
    }
  }

  void setMarker(Store? store, DeliveryMan? deliveryMan, AddressModel? addressModel, bool takeAway, bool parcel, bool isRestaurant, {AddressModel? currentAddress, bool fromCurrentLocation = false}) async {
    try {
      BitmapDescriptor restaurantImageData = await MarkerHelper.convertAssetToBitmapDescriptor(
        width: (isRestaurant || parcel) ? 50 : 70,
        imagePath: parcel ? Images.userMarker : isRestaurant ? Images.restaurantMarker : Images.markerStore,
      );

      BitmapDescriptor deliveryBoyImageData = await MarkerHelper.convertAssetToBitmapDescriptor(
        width: 50, imagePath: Images.deliveryManMarker,
      );
      BitmapDescriptor destinationImageData = await MarkerHelper.convertAssetToBitmapDescriptor(
        width: 50, imagePath: takeAway ? Images.myLocationMarker : Images.userMarker,
      );

      /// Animate to coordinate
      LatLngBounds? bounds;
      double rotation = 0;
      if(_controller != null) {
        if (double.parse(addressModel!.latitude!) < double.parse(store!.latitude!)) {
          bounds = LatLngBounds(
            southwest: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
            northeast: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
          );
          rotation = 0;
        }else {
          bounds = LatLngBounds(
            southwest: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
            northeast: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
          );
          rotation = 180;
        }
      }
      LatLng centerBounds = LatLng(
        (bounds!.northeast.latitude + bounds.southwest.latitude)/2,
        (bounds.northeast.longitude + bounds.southwest.longitude)/2,
      );

      if(fromCurrentLocation && currentAddress != null) {
        LatLng currentLocation = LatLng(
          double.parse(currentAddress.latitude!),
          double.parse(currentAddress.longitude!),
        );
        _controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: currentLocation, zoom: GetPlatform.isWeb ? 7 : 15)));
      }

      if(!fromCurrentLocation) {
        _controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(target: centerBounds, zoom: GetPlatform.isWeb ? 10 : 17)));
        if(!ResponsiveHelper.isWeb()) {
          zoomToFit(_controller, bounds, centerBounds, padding: GetPlatform.isWeb ? 15 : 3);
        }
      }

      /// user for normal order , but sender for parcel order
      _markers = HashSet<Marker>();

      ///current location marker set
      if(currentAddress != null) {
        _markers.add(Marker(
          markerId: const MarkerId('current_location'),
          visible: true,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: const Offset(0.5, 0.5),
          position: LatLng(
            double.parse(currentAddress.latitude!),
            double.parse(currentAddress.longitude!),
          ),
          icon: destinationImageData,
        ));
        setState(() {});
      }

      if(currentAddress == null){
        addressModel != null ? _markers.add(Marker(
          markerId: const MarkerId('destination'),
          position: LatLng(double.parse(addressModel.latitude!), double.parse(addressModel.longitude!)),
          infoWindow: InfoWindow(
            title: parcel ? 'sender'.tr : 'Destination'.tr,
            snippet: addressModel.address,
          ),
          icon: destinationImageData,
        )) : const SizedBox();
      }

      ///store for normal order , but receiver for parcel order
      store != null ? _markers.add(Marker(
        markerId: const MarkerId('store'),
        position: LatLng(double.parse(store.latitude!), double.parse(store.longitude!)),
        infoWindow: InfoWindow(
          title: parcel ? 'receiver'.tr : Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'store'.tr : 'store'.tr,
          snippet: store.address,
        ),
        icon: restaurantImageData,
      )) : const SizedBox();

      deliveryMan != null ? _markers.add(Marker(
        markerId: const MarkerId('delivery_boy'),
        position: LatLng(double.parse(deliveryMan.lat ?? '0'), double.parse(deliveryMan.lng ?? '0')),
        infoWindow: InfoWindow(
          title: 'delivery_man'.tr,
          snippet: deliveryMan.location,
        ),
        rotation: rotation,
        icon: deliveryBoyImageData,
      )) : const SizedBox();

    }catch(_) {}
    setState(() {});
  }

  Future<void> zoomToFit(GoogleMapController? controller, LatLngBounds? bounds, LatLng centerBounds, {double padding = 0.5}) async {
    bool keepZoomingOut = true;

    while(keepZoomingOut) {
      final LatLngBounds screenBounds = await controller!.getVisibleRegion();
      if(fits(bounds!, screenBounds)){
        keepZoomingOut = false;
        final double zoomLevel = await controller.getZoomLevel() - padding;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
        break;
      }
      else {
        // Zooming out by 0.1 zoom level per iteration
        final double zoomLevel = await controller.getZoomLevel() - 0.1;
        controller.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: centerBounds,
          zoom: zoomLevel,
        )));
      }
    }
  }

  bool fits(LatLngBounds fitBounds, LatLngBounds screenBounds) {
    final bool northEastLatitudeCheck = screenBounds.northeast.latitude >= fitBounds.northeast.latitude;
    final bool northEastLongitudeCheck = screenBounds.northeast.longitude >= fitBounds.northeast.longitude;

    final bool southWestLatitudeCheck = screenBounds.southwest.latitude <= fitBounds.southwest.latitude;
    final bool southWestLongitudeCheck = screenBounds.southwest.longitude <= fitBounds.southwest.longitude;

    return northEastLatitudeCheck && northEastLongitudeCheck && southWestLatitudeCheck && southWestLongitudeCheck;
  }
}





