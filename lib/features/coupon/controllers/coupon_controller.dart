import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/coupon/domain/services/coupon_service_interface.dart';


class CouponController extends GetxController implements GetxService {
  final CouponServiceInterface couponServiceInterface;
  CouponController({required this.couponServiceInterface});

  List<CouponModel>? _couponList;
  List<CouponModel>? get couponList => _couponList;

  List<CouponModel>? _taxiCouponList;
  List<CouponModel>? get taxiCouponList => _taxiCouponList;

  CouponModel? _coupon;
  CouponModel? get coupon => _coupon;

  double? _discount = 0.0;
  double? get discount => _discount;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _freeDelivery = false;
  bool get freeDelivery => _freeDelivery;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if(notify) {
      update();
    }
  }

  Future<void> getCouponList() async {
    List<CouponModel>? couponList = await couponServiceInterface.getCouponList();
    _couponList = [];
    _couponList!.addAll(couponList??[]);
      update();
  }

  Future<void> getTaxiCouponList() async {
    List<CouponModel>? taxiCouponList = await couponServiceInterface.getTaxiCouponList();
    _taxiCouponList = [];
    _taxiCouponList!.addAll(taxiCouponList??[]);
      update();
  }

  Future<double?> applyCoupon(String coupon, double order, double? deliveryCharge, int? storeID) async {
       final  order1 = Get.find<CartController>().subTotal;
    _isLoading = true;
    _discount = 0;
    update();
    CouponModel? couponModel = await couponServiceInterface.applyCoupon(coupon, storeID);
    if (couponModel != null) {
      _coupon = couponModel;
      if(_coupon!.couponType == 'free_delivery') {
        _processFreeDeliveryCoupon(deliveryCharge!, order1);
      }else {
        _processCoupon(order1);
      }
    } else {
      _discount = 0.0;
    }
    _isLoading = false;
    update();
    return _discount;
  }

  _processFreeDeliveryCoupon(double deliveryCharge, double order) {
    if(deliveryCharge > 0) {
      if (_coupon!.minPurchase! <= order) {
        _discount = 0;
        _freeDelivery = true;
      } else {
        showCustomSnackBar('${'the_minimum_item_purchase_amount_for_this_coupon_is'.tr} '
            '${PriceConverter.convertPrice(_coupon!.minPurchase)} '
            '${'but_you_have'.tr} ${PriceConverter.convertPrice(order)}');
        _coupon = null;
        _discount = 0;
      }
    }else {
      showCustomSnackBar('invalid_code_or'.tr);
    }
  }

  _processCoupon(double order) {
    if (_coupon!.minPurchase != null && _coupon!.minPurchase! <= order) {
      if (_coupon!.discountType == 'percent') {
        if (_coupon!.maxDiscount != null && _coupon!.maxDiscount! > 0) {
          _discount = (_coupon!.discount! * order / 100) < _coupon!.maxDiscount! ? (_coupon!.discount! * order / 100) : _coupon!.maxDiscount;
        } else {
          _discount = _coupon!.discount! * order / 100;
        }
      } else {
        _discount = _coupon!.discount;
      }
    } else {
      _discount = 0.0;
      showCustomSnackBar('${'the_minimum_item_purchase_amount_for_this_coupon_is'.tr} '
          '${PriceConverter.convertPrice(_coupon!.minPurchase)} '
          '${'but_you_have'.tr} ${PriceConverter.convertPrice(order)}');
    }
  }

  Future<double?> applyTaxiCoupon(String coupon, double orderAmount, int? providerId) async {
    _isLoading = true;
    _discount = 0;
    update();
    CouponModel? taxiCouponModel = await couponServiceInterface.applyTaxiCoupon(coupon, providerId);
    if (taxiCouponModel != null) {
      _coupon = taxiCouponModel;
      if (_coupon!.minPurchase != null && _coupon!.minPurchase! < orderAmount) {
        if (_coupon!.discountType == 'percent') {
          if (_coupon!.maxDiscount != null && _coupon!.maxDiscount! > 0) {
            _discount = (_coupon!.discount! * orderAmount / 100) < _coupon!.maxDiscount! ? (_coupon!.discount! * orderAmount / 100) : _coupon!.maxDiscount;
          } else {
            _discount = _coupon!.discount! * orderAmount / 100;
          }
        } else {
          _discount = _coupon!.discount;
        }
      } else {
        _discount = 0.0;
      }
    }
    _isLoading = false;
    update();
    return _discount;
  }




// validateCoupen  (CouponModel? coupon, double order, double? deliveryCharge, ) {
//   // coupon = _coupon;
//     showCustomSnackBar('validating_coupon'.tr, isError: false);
//       print("order amount is ${order}");
//     if (coupon == null) {
//       showCustomSnackBar('please_enter_a_coupon_code'.tr);
//       return false;
//     } 
  
//     else if (order <= coupon.minPurchase!) {
//       showCustomSnackBar('${'the_minimum_item_purchase_amount_for_this_coupon_is'.tr} '
//           '${PriceConverter.convertPrice(coupon.minPurchase)} '
//           '${'but_you_have'.tr} ${PriceConverter.convertPrice(order)}');
//       showCustomSnackBar('your_order_amount_is_too_low'.tr);
//       removeCouponData( true);
//       Get.find<CheckoutController>().couponController.text = '';
//       return false;
//     } else if (deliveryCharge != null && deliveryCharge < 0) {
//       showCustomSnackBar('invalid_delivery_charge'.tr);
//       return false;
//     // } else if (storeID == null || storeID <= 0) {
//     //   showCustomSnackBar('invalid_store_id'.tr);
//     //   return false;
//     }
//     return true;
//   }










  void removeCouponData(bool notify) {
    _coupon = null;
    _isLoading = false;
    _discount = 0.0;
    _freeDelivery = false;
    if(notify) {
      update();
    }
  }

}