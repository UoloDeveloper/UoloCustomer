import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';
import 'package:sixam_mart/common/widgets/address_widget.dart';
import 'package:sixam_mart/common/widgets/cancellation_dialog.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/checkout/domain/models/place_order_body_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/payment/widgets/offline_payment_button.dart';
import 'package:sixam_mart/features/checkout/widgets/payment_button_new.dart';

// class Placeorderbottomsheet extends StatefulWidget {

// final  CheckoutController checkoutController;
// final PlaceOrderBodyModel placeOrderBody;
// final  bool? isCashOnDeliveryActive ;
//   final bool fromCart;
//   final double total;
//   final   double? maxCodOrderAmount;
 
//    Placeorderbottomsheet({super.key, e, required this.checkoutController,required this.placeOrderBody,required this.isCashOnDeliveryActive, required this.fromCart, required this.total, this.maxCodOrderAmount});

//   @override
//   State<Placeorderbottomsheet> createState() => _PlaceorderbottomsheetState();
// }

// class _PlaceorderbottomsheetState extends State<Placeorderbottomsheet> {


//   @override
//   void initState() {
//     super.initState();
// _startProgress();
//     print('=====digital payments : ${Get.find<SplashController>().configModel!.activePaymentMethodList!}');

//   }

//  bool _isOrderPlaced = false;
//   bool _isOrderCanceled = false;
//     int _progressDuration = 10; // 30 seconds
//   double _progressValue = 0.0;

//   void _startProgress() {
//     setState(() {
//       _isOrderPlaced = true;
//       _isOrderCanceled = false;
//       _progressValue = 0.0;
//     });

//     // Simulate order placement after 30 seconds
//     Future.delayed(Duration(seconds: _progressDuration), () {


//       if (!_isOrderCanceled) {
//        widget.checkoutController.placeOrder(widget.placeOrderBody,widget.checkoutController.store!.zoneId, widget. total,widget.  maxCodOrderAmount, widget.fromCart,widget.isCashOnDeliveryActive!,widget.checkoutController.pickedPrescriptions);
//         // _placeOrder();
//       }
//     });

//     // Update progress bar every 100 milliseconds
//     const interval = Duration(milliseconds: 100);
//     int totalSteps = _progressDuration * 10; // 30 seconds * 10 steps per second

//     int currentStep = 0;
//     Timer.periodic(interval, (Timer timer) {      

//       setState(() {
//         _progressValue = (currentStep / totalSteps);
//         currentStep++;
//       });

//       // Stop the timer if progress is complete or order is canceled
//       if (currentStep > totalSteps || _isOrderCanceled) {
//         timer.cancel();
//       }
//     });
//   }

//   void _placeOrder() {
//     // Place order logic here
//     print("Order Placed!");
//     setState(() {
//       _isOrderPlaced = false;
//     });
//   }

//   void _cancelOrder() {
//     setState(() {
//       _isOrderCanceled = true;
//       _isOrderPlaced = false;
//     });
//     print("Order Canceled!");
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLoggedIn = AuthHelper.isLoggedIn();
//     bool isDesktop = ResponsiveHelper.isDesktop(context);


//     return SizedBox(
//       width: 550,
//       child: Container(
//         constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
//         decoration: BoxDecoration(
//           color: Colors.transparent,
         
//         ),
      
//         child: Column(mainAxisSize: MainAxisSize.min, children: [

         

//           // ResponsiveHelper.isDesktop(context) ? Align(
//           //   alignment: Alignment.topRight,
//           //   child: InkWell(
//           //     onTap: () => Get.back(),
//           //     child: Container(
//           //       height: 30, width: 30,
//           //       margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//           //       decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(50)),
//           //       child: const Icon(Icons.clear),
//           //     ),
//           //   ),
//           // ) : Align(
//           //   alignment: Alignment.center,
//           //   child: Container(
//           //     height: 4, width: 35,
//           //     margin: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
//           //     decoration: BoxDecoration(color: Theme.of(context).disabledColor, borderRadius: BorderRadius.circular(10)),
//           //   ),
//           // ),
//           CustomInkWell(
//             onTap: (){
//               Get.back();
//             },
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 color: Colors.white,
            
//               ),
//               height: 40,
//               width: 40,
              
//               child: Icon(Icons.close,size: 30,),
//             ),
//           ),
//           const SizedBox(height: Dimensions.paddingSizeSmall),

//           Container(
//             decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                borderRadius: BorderRadius.vertical(
//             top: const Radius.circular(Dimensions.radiusLarge),
//             bottom: Radius.circular(ResponsiveHelper.isDesktop(context) ? Dimensions.radiusLarge : 0),
//           )
//             ),
      
//               padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeLarge),
//             child: Flexible(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeDefault : 0),
//                   child: GetBuilder<CheckoutController>(
//                     builder: (checkoutController) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [

//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                   Container(
//                                     width: 70,
//                                     height: 50,
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(6.0),
//                                       child: Image.asset(Images.codIcon,),
//                                     ),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: Colors.black12
//                                       ),
//                                       borderRadius: BorderRadius.circular(10)
//                                     ),
//                                   ),

//                                      Text("Paid by wallet")
//                               ],
//                             )
//           //               Container(
//           //   width: MediaQuery.of(context).size.width,
//           //   height: 400,
//           // ),,

//            ,  Row(
//              children: [
//                LinearProgressIndicator(
//                 borderRadius: BorderRadius.circular(25),
//                             value: _progressValue,
//                             backgroundColor: Colors.grey[300],
//                             valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                             minHeight: 20, // Adjust height of the progress bar
//                           ),

//                           InkWell(
//                             onTap: () {
//                               _cancelOrder();
//                             },
//                             child: Container(
//                               width: 80,
//                               height: 40,
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.black
//                                 )
//                               ),
//                               child: Text("Cancel"),
//                             ),
//                           )
//              ],
//            ),
//                         ],
//                       );
//                     }
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // SafeArea(
//           //   child: CustomButton(
//           //     buttonText: 'select'.tr,
//           //     onPressed: () => Get.back(),
//           //   ),
//           // ),

//         ]),
//       ),
//     );
//   }
// }


// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Placeorderbottomsheet extends StatefulWidget {
//   final CheckoutController checkoutController;
//   final PlaceOrderBodyModel placeOrderBody;
//   final bool? isCashOnDeliveryActive;
//   final bool fromCart;
//   final double total;
//   final double? maxCodOrderAmount;

//   Placeorderbottomsheet({
//     super.key,
//     required this.checkoutController,
//     required this.placeOrderBody,
//     required this.isCashOnDeliveryActive,
//     required this.fromCart,
//     required this.total,
//     this.maxCodOrderAmount,
//   });

//   @override
//   State<Placeorderbottomsheet> createState() => _PlaceorderbottomsheetState();
// }

// class _PlaceorderbottomsheetState extends State<Placeorderbottomsheet> {
//   bool _isOrderPlaced = false;
//   bool _isOrderCanceled = false;
//   int _progressDuration = 10; // 10 seconds
//   double _progressValue = 0.0;
//   Timer? _timer; // Timer reference
//   int _currentStep = 0; // Track the current step

//   @override
//   void initState() {
//     super.initState();
//     _startProgress();
//     print('=====digital payments : ${Get.find<SplashController>().configModel!.activePaymentMethodList!}');
//   }

//   void _startProgress() {
//     setState(() {
//       _isOrderPlaced = true;
//       _isOrderCanceled = false;
//       _progressValue = 0.0;
//       _currentStep = 0; // Reset current step
//     });

//     // Simulate order placement after the specified duration
//     Future.delayed(Duration(seconds: _progressDuration), () {
//       if (!_isOrderCanceled) {
//         widget.checkoutController.placeOrder(
//           widget.placeOrderBody,
//           widget.checkoutController.store!.zoneId,
//           widget.total,
//           widget.maxCodOrderAmount,
//           widget.fromCart,
//           widget.isCashOnDeliveryActive!,
//           widget.checkoutController.pickedPrescriptions,
//         );
//       }
//     });

//     // Update progress bar every 100 milliseconds
//     const interval = Duration(milliseconds: 100);
//     int totalSteps = _progressDuration * 10; // 10 seconds * 10 steps per second

//     _timer = Timer.periodic(interval, (Timer timer) {
//       if (_currentStep >= totalSteps || _isOrderCanceled) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _progressValue = (_currentStep / totalSteps);
//           _currentStep++;
//         });
//       }
//     });
//   }

//   void _cancelOrder() {
//     setState(() {
//       _isOrderCanceled = true;
//       _isOrderPlaced = false;
//     });
//     print("Order Canceled!");
//   }

//   void _pauseTimer() {
//     if (_timer != null) {
//       _timer!.cancel();
//     }
//   }

//   void _resumeTimer() {
//     const interval = Duration(milliseconds: 100);
//     int totalSteps = _progressDuration * 10; // 10 seconds * 10 steps per second

//     _timer = Timer.periodic(interval, (Timer timer) {
//       if (_currentStep >= totalSteps || _isOrderCanceled) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _progressValue = (_currentStep / totalSteps);
//           _currentStep++;
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isLoggedIn = AuthHelper.isLoggedIn();
//     bool isDesktop = ResponsiveHelper.isDesktop(context);

//     return SizedBox(
//       width: 550,
//       child: Container(
//         constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             CustomInkWell(
//               onTap: () {
//                 Get.back();
//               },
//               child: Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   color: Colors.white,
//                 ),
//                 height: 40,
//                 width: 40,
//                 child: Icon(Icons.close, size: 30),
//               ),
//             ),
//             const SizedBox(height: Dimensions.paddingSizeSmall),
//             Container(
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.vertical(
//                   top: const Radius.circular(Dimensions.radiusLarge),
//                   bottom: Radius.circular(ResponsiveHelper.isDesktop(context) ? Dimensions.radiusLarge : 0),
//                 ),
//               ),
//               padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeSmall : Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeLarge),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: isDesktop ? Dimensions.paddingSizeDefault : 0),
//                   child: GetBuilder<CheckoutController>(
//                     builder: (checkoutController) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Container(
//                                 width: 70,
//                                 height: 50,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(6.0),
//                                   child: Image.asset(Images.codIcon),
//                                 ),
//                                 decoration: BoxDecoration(
//                                   border: Border.all(color: Colors.black12),
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                               ),
//                               const SizedBox(width: 8), // Add some spacing
//                               Text("Paid by wallet"),
//                             ],
//                           ),
//                           const SizedBox(height: Dimensions.paddingSizeSmall),
//                           Row(
//                             children: [
//                               Expanded(
//                                 child: LinearProgressIndicator(
//                                   borderRadius: BorderRadius.circular(25),
//                                   value: _progressValue,
//                                   backgroundColor: Colors.grey[300],
//                                   valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
//                                   minHeight: 20,
//                                 ),
//                               ),
//                               const SizedBox(width: 8), // Add some spacing
//                               InkWell(
//                                 onTap: () {
//                                   // Pause timer and show dialog
//                                   _pauseTimer();
                                      
//                                   showDialog(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       return CancellationDialog1(
//                                         icon: Images.warning,
//                                         onYesPressed: () {
//                                           // Cancel the order
//                                       _cancelOrder();
//                                           Get.back(); // Close the dialog
//                                         },
//                                         onNoPressed: () {
//                                           // Resume the timer
//                                           _resumeTimer();
//                                           Get.back(); // Close the dialog
//                                         },
//                                         title: "Are you sure you want to cancel order?",
//                                       );
//                                     },
//                                   );
//                                 },
//                                 child: Container(
//                                   width: 80,
//                                   height: 30,
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   child: Center(child: Text("Cancel")),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       );
//                     },
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Placeorderbottomsheet extends StatefulWidget {
  final CheckoutController checkoutController;
  final PlaceOrderBodyModel placeOrderBody;
  final bool? isCashOnDeliveryActive;
  final bool fromCart;
  final double total;
  final double? maxCodOrderAmount;
  final AddressModel address;

  Placeorderbottomsheet({
    super.key,
    required this.checkoutController,
    required this.placeOrderBody,
    required this.isCashOnDeliveryActive,
    required this.fromCart,
    required this.total,
    this.maxCodOrderAmount, required this.address,
  });

  @override
  State<Placeorderbottomsheet> createState() => _PlaceorderbottomsheetState();
}

class _PlaceorderbottomsheetState extends State<Placeorderbottomsheet> {
  bool _isOrderPlaced = false;
  bool _isOrderCanceled = false;
  bool _isTimerPaused = false;
  int _progressDuration = 4; // 10 seconds
  double _progressValue = 0.0;
  Timer? _timer;
  int _currentStep = 0;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    setState(() {
      _isOrderPlaced = true;
      _isOrderCanceled = false;
      _isTimerPaused = false;
      _progressValue = 0.0;
      _currentStep = 0;
    });

    Future.delayed(Duration(seconds: _progressDuration), () {
      if (!_isOrderCanceled && !_isTimerPaused) {

        setState(() {
          _isOrderPlaced = false;
        });
        widget.checkoutController.placeOrder(
          widget.placeOrderBody,
          widget.checkoutController.store!.zoneId,
          widget.total,
          widget.maxCodOrderAmount,
          widget.fromCart,
          widget.isCashOnDeliveryActive!,
          widget.checkoutController.pickedPrescriptions,
        );
      }
    });

    _startTimer();
  }

  void _startTimer() {
    const interval = Duration(milliseconds: 100);
    int totalSteps = _progressDuration * 10;

    _timer = Timer.periodic(interval, (Timer timer) {
      if (_currentStep >= totalSteps || _isOrderCanceled || _isTimerPaused) {
        timer.cancel();
      } else {
        setState(() {
          _progressValue = (_currentStep / totalSteps);
          _currentStep++;
        });
      }
    });
  }

  void _cancelOrder() {
    setState(() {
      _isOrderCanceled = true;
      _isOrderPlaced = false;
    });
    _timer?.cancel();
    print("Order Canceled!");
  }

  void _pauseTimer() {
    setState(() {
      _isTimerPaused = true;
    });
    _timer?.cancel();
  }

  void _resumeTimer() {
    setState(() {
      _isTimerPaused = false;
    });
    _startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 550,
      child: Container(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        decoration: BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // InkWell(
            //   onTap: () => Get.back(),
            //   child: Container(
            //           padding:  const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
            //           decoration: BoxDecoration(
            //             color: Colors.black.withOpacity(0.1),
            //             shape: BoxShape.circle,
            //             boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 5)],
            //           ),
            //           child: const Icon(Icons.close, size: 30,color: Colors.white,),
            //       ),
            // ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text("Placing Your Order", style: robotoBold.copyWith(fontSize: 20)),
                  const SizedBox(height: 10),
           widget.isCashOnDeliveryActive == true ?      Row(
                    children: [
                      Container(
                        width: 60,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(Images.codIcon),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text("Pay ${widget.total.round()} Cash on Delivery"),
                    ],
                  ) : SizedBox(),
                //       const SizedBox(height: 10),
                // widget.placeOrderBody.paymentMethod == AppConstants ?   Row(
                //     children: [
                //       Container(
                //         width: 60,
                //         height: 50,
                //         child: Padding(
                //           padding: const EdgeInsets.all(10),
                //           child: SvgPicture.asset('assets/image/icons/Vector (1).svg')
                //           // Image.asset("assets/image/icons/Vector (1).svg"),
                //         ),
                //         decoration: BoxDecoration(
                //           border: Border.all(color: Colors.black12),
                //           borderRadius: BorderRadius.circular(10),
                //         ),
                //       ),
                //       const SizedBox(width: 8),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text("${ widget.placeOrderBody.paymentMethod ?? 123} promo applied"),
                //           Text("${widget.placeOrderBody.couponDiscountAmount ?? 123} saved"),
                //         ],
                //       ),
                //     ],
                //   ) : SizedBox(),
              
              
                  // SizedBox(height: 6,),
                  //  const SizedBox(height: 10),
                  const SizedBox(height: 10),
                widget.placeOrderBody.couponCode != null ?   Row(
                    children: [
                      Container(
                        width: 60,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset('assets/image/icons/Vector (1).svg')
                          // Image.asset("assets/image/icons/Vector (1).svg"),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${widget.placeOrderBody.couponCode!.toUpperCase()} promo applied"),
                          Text("${widget.placeOrderBody.couponDiscountAmount!.round()} saved"),
                        ],
                      ),
                    ],
                  ) : SizedBox(),
              
              
                  // SizedBox(height: 6,),
                   const SizedBox(height: 10),
                   Row(
                     children: [
                       Container(
                        width: 60,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Image.asset(
                           widget. address!.addressType == 'home' ? Images.homeIcon : widget.address!.addressType == 'office' ? Images.workIcon : Images.otherIcon,
                            color: Theme.of(context).primaryColor, height: ResponsiveHelper.isDesktop(context) ? 20 : 15, width: ResponsiveHelper.isDesktop(context) ? 25 : 20,
                          ),
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),

                      SizedBox(width: 6,),
                       Column(
                        crossAxisAlignment:   CrossAxisAlignment.start,
                        children: [
                            Text("Delivering to ${  widget. address!.addressType !=  'home' && widget. address!.addressType != 'office'  ? "" :  widget.address.addressType}"),
                             Text("${widget.address.address}")
                        ],
                       ),
                     ],
                   ),
                  // AddressWidget(address: widget.address, fromAddress: false),
                       const SizedBox(height: 20),
                 _isOrderPlaced ?  Row(
                    children: [
                     Expanded(
                        child: CustomLinearProgressIndicator(value: _progressValue, ),
                        //  LinearProgressIndicator(
                        //   borderRadius: BorderRadius.circular(15),

                        //   value: _progressValue,
                        //   backgroundColor: Colors.grey[300],
                        //   valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                        //   minHeight: 20,
                        // ),
                      ) ,
                      const SizedBox(width: 8),
                      InkWell(
                        onTap: () {
                          _pauseTimer();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return CancellationDialog(
                                        icon: Images.warning,
                                        onYesPressed: () {
                                          // Cancel the order
                                          //  Get.back();
                                      _cancelOrder();
                                          Get.back(); // Close the dialog
                                            Get.back();
                                        },
                                        onNoPressed: () {
                                          // Resume the timer
                                          _resumeTimer();
                                          _startProgress();
                                             Get.back();
                                          // Get.back(); // Close the dialog
                                        },
                                        title: "Are you sure you want to cancel order?",
                                      );
                                    },
                                  );
                              
                              // AlertDialog(
                              //   title: Text("Cancel Order"),
                              //   content: Text("Are you sure you want to cancel the order?"),
                              //   actions: [
                              //     TextButton(
                              //       onPressed: () {
                              //         _resumeTimer();
                              //         Get.back();
                              //       },
                              //       child: Text("No"),
                              //     ),
                              //     TextButton(
                              //       onPressed: () {
                              //         _cancelOrder();
                              //         Get.back();
                              //       },
                              //       child: Text("Yes"),
                              //     ),
                              //   ],
                              // );
                          
                          
                            },
                          // )
                        // },
                        child: Container(
                          // width: 80,
                          height: 30,
                          // decoration: BoxDecoration(
                          //   border: Border.all(color: Theme.of(context).primaryColor),
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          child: Center(child: Text("Cancel",style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),)),
                        ),
                      ),
                    ],
                  ) : Container(
                    width: MediaQuery.sizeOf(context).width ,

                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(child: Text("Order Placed")),
                              SizedBox(width: 10,),
                              Container(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Theme.of(context).primaryColor,
                                  
                                ),
                              )
                            ],
                          ),
                    ),
                  ), 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomLinearProgressIndicator extends StatelessWidget {
  final double value;

  const CustomLinearProgressIndicator({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 23,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: Stack(
        children: [
          FractionallySizedBox(
            widthFactor: value,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [ Colors.deepPurple.shade800 ,
            Colors.purple.shade400  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight
                ),
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}