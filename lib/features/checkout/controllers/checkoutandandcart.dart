

import 'dart:convert';
import 'dart:html' as html;
import 'dart:typed_data';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixam_mart/api/api_client.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/cart/domain/models/online_cart_model.dart';
import 'package:sixam_mart/features/cart/domain/services/cart_service_interface.dart';
import 'package:sixam_mart/features/checkout/domain/models/distance_model.dart';
import 'package:sixam_mart/features/checkout/domain/models/place_order_body_model.dart';
import 'package:sixam_mart/features/checkout/domain/models/timeslote_model.dart';
import 'package:sixam_mart/features/checkout/domain/services/checkout_service_interface.dart';
import 'package:sixam_mart/features/checkout/widgets/order_successfull_dialog.dart';
import 'package:sixam_mart/features/checkout/widgets/partial_pay_dialog_widget.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/features/payment/domain/models/offline_method_model.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/module_helper.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';

import '../../language/controllers/language_controller.dart';

class CartCheckoutController extends GetxController implements GetxService {
  // ----- Service Interfaces -----
  final CheckoutServiceInterface checkoutServiceInterface;
  final CartServiceInterface cartServiceInterface;

  CartCheckoutController({
    required this.checkoutServiceInterface,
    required this.cartServiceInterface,
  });

  // ----- TEXT CONTROLLERS -----
  final TextEditingController couponController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController houseController = TextEditingController();
  final TextEditingController floorController = TextEditingController();
  final TextEditingController tipController = TextEditingController();
  
  final FocusNode streetNode = FocusNode();
  final FocusNode houseNode = FocusNode();
  final FocusNode floorNode = FocusNode();

  // ----- CART FIELDS -----
  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;

  double _subTotal = 0;
  double get subTotal => _subTotal;
  double _itemPrice = 0;
  double get itemPrice => _itemPrice;
  double _itemDiscountPrice = 0;
  double get itemDiscountPrice => _itemDiscountPrice;
  double _addOns = 0;
  double get addOns => _addOns;
  double _tax = 0;
  double get tax => _tax;
  double _variationPrice = 0;
  double get variationPrice => _variationPrice;

  List<List<AddOns>> _addOnsList = [];
  List<List<AddOns>> get addOnsList => _addOnsList;
  List<bool> _availableList = [];
  List<bool> get availableList => _availableList;
  
  List<String> notAvailableList = [
    'Remove it from my cart', 
    'I\'ll wait until it\'s restocked', 
    'Please cancel the order', 
    'Call me ASAP', 
    'Notify me when it\'s back'
  ];
  
  bool _addCutlery = false;
  bool get addCutlery => _addCutlery;
  int _notAvailableIndex = -1;
  int get notAvailableIndex => _notAvailableIndex;
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  bool _needExtraPackage = true;
  bool get needExtraPackage => _needExtraPackage;
  bool _isExpanded = true;
  bool get isExpanded => _isExpanded;
  int? _directAddCartItemIndex = -1;
  int? get directAddCartItemIndex => _directAddCartItemIndex;

  // ----- CHECKOUT FIELDS -----
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  bool showadditionalnote = false;
  bool tryingtoplace = true;
  
  AddressModel? _guestAddress;
  AddressModel? get guestAddress => _guestAddress;
  
  String? countryDialCode = Get.find<AuthController>().getUserCountryCode().isNotEmpty 
    ? Get.find<AuthController>().getUserCountryCode()
    : CountryCode.fromCountryCode(Get.find<SplashController>().configModel!.country!).dialCode 
    ?? Get.find<LocalizationController>().locale.countryCode;

  int? _mostDmTipAmount;
  int? get mostDmTipAmount => _mostDmTipAmount;
  
  String _preferableTime = '';
  String get preferableTime => _preferableTime;
  
  List<OfflineMethodModel>? _offlineMethodList;
  List<OfflineMethodModel>? get offlineMethodList => _offlineMethodList;
  
  bool _isPartialPay = false;
  bool get isPartialPay => _isPartialPay;
  
  double _tips = 0;
  double get tips => _tips;
  
  int _selectedTips = 0;
  int get selectedTips => _selectedTips;
  
  Store? _store;
  Store? get store => _store;
  
  int? _addressIndex = 0;
  int? get addressIndex => _addressIndex;
  
  XFile? _orderAttachment;
  XFile? get orderAttachment => _orderAttachment;
  
  Uint8List? _rawAttachment;
  Uint8List? get rawAttachment => _rawAttachment;
  
  bool _acceptTerms = true;
  bool get acceptTerms => _acceptTerms;
  
  int _paymentMethodIndex = -1;
  int get paymentMethodIndex => _paymentMethodIndex;
  
  int _selectedDateSlot = 0;
  int get selectedDateSlot => _selectedDateSlot;
  
  int _selectedTimeSlot = 0;
  int get selectedTimeSlot => _selectedTimeSlot;
  
  double? _distance;
  double? get distance => _distance;
  
  List<TimeSlotModel>? _timeSlots;
  List<TimeSlotModel>? get timeSlots => _timeSlots;
  
  List<TimeSlotModel>? _allTimeSlots;
  List<TimeSlotModel>? get allTimeSlots => _allTimeSlots;
  
  List<XFile> _pickedPrescriptions = [];
  List<XFile> get pickedPrescriptions => _pickedPrescriptions;
  
  double? _extraCharge;
  double? get extraCharge => _extraCharge;
  
  String? _orderType = 'delivery';
  String? get orderType => _orderType;
  
  double? _viewTotalPrice = 0;
  double? get viewTotalPrice => _viewTotalPrice;
  
  int _selectedOfflineBankIndex = 0;
  int get selectedOfflineBankIndex => _selectedOfflineBankIndex;
  
  int _selectedInstruction = -1;
  int get selectedInstruction => _selectedInstruction;
  
  bool _isDmTipSave = false;
  bool get isDmTipSave => _isDmTipSave;
  
  String? _digitalPaymentName;
  String? get digitalPaymentName => _digitalPaymentName;
  
  bool _canShowTipsField = false;
  bool get canShowTipsField => _canShowTipsField;
  
  bool _isExpanded2 = false;
  bool get isExpanded2 => _isExpanded2;
  
  bool _isExpand = false;
  bool get isExpand => _isExpand;
  
  bool _isCreateAccount = false;
  bool get isCreateAccount => _isCreateAccount;

  // ----- INITIALIZATION -----
  @override
  void onInit() {
    super.onInit();
    // Any initialization logic can go here
  }

  @override
  void dispose() {
    couponController.dispose();
    noteController.dispose();
    streetNumberController.dispose();
    houseController.dispose();
    floorController.dispose();
    tipController.dispose();
    streetNode.dispose();
    houseNode.dispose();
    floorNode.dispose();
    super.dispose();
  }

  // ----- CART MANAGEMENT METHODS -----
  
  String getCurrncyForUi() {
    if (cartList.isEmpty) {
      return Get.find<SplashController>().configModel!.currencySymbol!;
    }
    for (var cartModel in cartList) {
      if (cartModel.item != null && cartModel.item!.currency != null && cartModel.item!.currency!.currencyCode != null) {
        return cartModel.item!.currency!.currencyCode!;
      }
    }
    return Get.find<SplashController>().configModel!.currencySymbol!;
  }

  double calculationCart() { 
    _addOnsList = [];
    _availableList = [];
    _itemPrice = 0;
    _itemDiscountPrice = 0;
    _addOns = 0;
    _variationPrice = 0;
    bool isFoodVariation = false;
    double variationWithoutDiscountPrice = 0;
    bool haveVariation = false;
    
    for (var cartModel in cartList) {
      if (ModuleHelper.getModuleConfig(cartModel.item!.moduleType).newVariation != null) {
        isFoodVariation = ModuleHelper.getModuleConfig(cartModel.item!.moduleType).newVariation!;
      }
      
      double? discount = cartModel.item!.storeDiscount == 0 ? cartModel.item!.discount : cartModel.item!.storeDiscount;
      String? discountType = cartModel.item!.storeDiscount == 0 ? cartModel.item!.discountType : 'percent';

      List<AddOns> addOnList = cartServiceInterface.prepareAddonList(cartModel);
      _addOnsList.add(addOnList);
      _availableList.add(DateConverter.isAvailable(cartModel.item!.availableTimeStarts, cartModel.item!.availableTimeEnds));
      _addOns = cartServiceInterface.calculateAddonPrice(_addOns, addOnList, cartModel);
      _variationPrice = cartServiceInterface.calculateVariationPrice(isFoodVariation, cartModel, discount, discountType, _variationPrice);
      variationWithoutDiscountPrice = cartServiceInterface.calculateVariationWithoutDiscountPrice(isFoodVariation, cartModel, variationWithoutDiscountPrice);
      haveVariation = cartServiceInterface.checkVariation(isFoodVariation, cartModel);

      double price = haveVariation ? variationWithoutDiscountPrice : (cartModel.item!.price! * cartModel.quantity!);
      double discountPrice = haveVariation ? (variationWithoutDiscountPrice - _variationPrice)
          : (price - (PriceConverter.convertWithDiscount(cartModel.item!.price!, discount, discountType)! * cartModel.quantity!));

      _itemPrice = _itemPrice + price;
      _itemDiscountPrice = _itemDiscountPrice + discountPrice;
      haveVariation = false;
    }
    
    if (isFoodVariation) {
      _itemDiscountPrice = _itemDiscountPrice + (variationWithoutDiscountPrice - _variationPrice);
      _variationPrice = variationWithoutDiscountPrice;
      _subTotal = (_itemPrice - _itemDiscountPrice) + _addOns + _variationPrice;
    } else {
      _subTotal = (_itemPrice - _itemDiscountPrice);
    }

    return _subTotal;
  }

  double calculateTax({required bool taxIncluded, required double orderAmount, required double? taxPercent}) {
    double tax = 0;
    if (taxIncluded) {
      tax = orderAmount * taxPercent! / (100 + taxPercent);
    } else {
      tax = PriceConverter.calculation(orderAmount, taxPercent, 'percent', 1);
    }
    _tax = tax;
    update();
    return PriceConverter.toFixed(tax);
  }

  Future<void> addToCart(CartModel cartModel, int? index) async {
    if (index != null && index != -1) {
      _cartList.replaceRange(index, index + 1, [cartModel]);
    } else {
      _cartList.add(cartModel);
    }
    Get.find<ItemController>().setExistInCart(cartModel.item, null, notify: true);
    await cartServiceInterface.addSharedPrefCartList(_cartList);
    calculationCart();
    update();
  }

  int? getCartId(int cartIndex) {
    return cartServiceInterface.getCartId(cartIndex, _cartList);
  }

  Future<void> setQuantity(bool isIncrement, int cartIndex, int? stock, int? quantityLimit) async {
    _isLoading = true;
    update();

    _cartList[cartIndex].quantity = await cartServiceInterface.decideItemQuantity(
        isIncrement, _cartList, cartIndex, stock, quantityLimit, Get.find<SplashController>().configModel!.moduleConfig!.module!.stock!);

    double discountedPrice = await cartServiceInterface.calculateDiscountedPrice(
        _cartList[cartIndex], _cartList[cartIndex].quantity!, ModuleHelper.getModuleConfig(_cartList[cartIndex].item!.moduleType).newVariation!);
        
    if (ModuleHelper.getModuleConfig(_cartList[cartIndex].item!.moduleType).newVariation!) {
      await Get.find<ItemController>().setExistInCart(_cartList[cartIndex].item, null, notify: true);
    }

    await updateCartQuantityOnline(_cartList[cartIndex].id!, discountedPrice, _cartList[cartIndex].quantity!);
  }

  Future<void> removeFromCart(int index, {Item? item}) async {
    int cartId = _cartList[index].id!;
    _cartList.removeAt(index);
    update();
    Get.find<ItemController>().cartIndexSet();
    await removeCartItemOnline(cartId, item: item);
    if (Get.find<ItemController>().item != null) {
      Get.find<ItemController>().cartIndexSet();
    }
  }

  Future<void> clearCartList({bool canRemoveOnline = true}) async {
    _cartList = [];
    if ((AuthHelper.isLoggedIn() || AuthHelper.isGuestLoggedIn()) && 
        (ModuleHelper.getModule() != null || ModuleHelper.getCacheModule() != null) && canRemoveOnline) {
      clearCartOnline();
    }
  }

  int isExistInCart(int? itemID, String variationType, bool isUpdate, int? cartIndex) {
    return cartServiceInterface.isExistInCart(_cartList, itemID, variationType, isUpdate, cartIndex);
  }

  bool existAnotherStoreItem(int? storeID, int? moduleId) {
    return cartServiceInterface.existAnotherStoreItem(storeID, moduleId, _cartList);
  }

  void setCurrentIndex(int index, bool notify) {
    _currentIndex = index;
    if (notify) {
      update();
    }
  }

  // ----- ONLINE CART METHODS -----
  
  Future<bool> addToCartOnline(OnlineCart cart) async {
    _isLoading = true;
    bool success = false;
    update();
    List<OnlineCartModel>? onlineCartList = await cartServiceInterface.addToCartOnline(cart);
    _cartList = [];
    _cartList.addAll(cartServiceInterface.formatOnlineCartToLocalCart(onlineCartModel: onlineCartList ?? []));
    calculationCart();
    success = true;
    _isLoading = false;
    update();
    return success;
  }

  Future<bool> updateCartOnline(OnlineCart cart) async {
    _isLoading = true;
    bool success = false;
    update();
    List<OnlineCartModel>? onlineCartList = await cartServiceInterface.updateCartOnline(cart);
    _cartList = [];
    _cartList.addAll(cartServiceInterface.formatOnlineCartToLocalCart(onlineCartModel: onlineCartList ?? []));
    calculationCart();
    success = true;
    _isLoading = false;
    update();
    return success;
  }

  Future<void> updateCartQuantityOnline(int cartId, double price, int quantity) async {
    _isLoading = true;
    update();
    bool success = await cartServiceInterface.updateCartQuantityOnline(cartId, price, quantity);
    if (success) {
      await getCartDataOnline();
      calculationCart();
      await Future.delayed(const Duration(milliseconds: 200));
    }
    _isLoading = false;
    update();
  }

  Future<void> getCartDataOnline() async {
    if (ModuleHelper.getModule() != null || ModuleHelper.getCacheModule() != null) {
      _isLoading = true;
      List<OnlineCartModel>? onlineCartList = await cartServiceInterface.getCartDataOnline();
      _cartList = [];
      _cartList.addAll(cartServiceInterface.formatOnlineCartToLocalCart(onlineCartModel: onlineCartList ?? []));
      calculationCart();
      _isLoading = false;
      update();
    }
  }

  Future<bool> removeCartItemOnline(int cartId, {Item? item}) async {
    _isLoading = true;
    update();
    bool success = await cartServiceInterface.removeCartItemOnline(cartId);
    if (success) {
      await getCartDataOnline();
      if (item != null) {
        Get.find<ItemController>().setExistInCart(item, null, notify: true);
      }
    }
    _isLoading = false;
    update();
    return success;
  }

  Future<bool> clearCartOnline() async {
    _isLoading = true;
    update();
    bool success = await cartServiceInterface.clearCartOnline();
    if (success) {
      getCartDataOnline();
    }
    _isLoading = false;
    update();
    return success;
  }

  int cartQuantity(int itemId) {
    return cartServiceInterface.cartQuantity(itemId, _cartList);
  }

  String cartVariant(int itemId) {
    return cartServiceInterface.cartVariant(itemId, _cartList);
  }

  void setExpanded(bool setExpand) {
    _isExpanded = setExpand;
    update();
  }

  // ----- CART UTILITY METHODS -----
  
  void setDirectlyAddToCartIndex(int? index) {
    _directAddCartItemIndex = index;
  }

  void toggleExtraPackage({bool willUpdate = true}) {
    _needExtraPackage = !_needExtraPackage;
    if (willUpdate) {
      update();
    }
  }

  void setAvailableIndex(int index, {bool willUpdate = true}) {
    _notAvailableIndex = cartServiceInterface.availableSelectedIndex(_notAvailableIndex, index);
    if (willUpdate) {
      update();
    }
  }

  void updateCutlery({bool willUpdate = true}) {
    _addCutlery = !_addCutlery;
    if (willUpdate) {
      update();
    }
  }

  Future<void> forcefullySetModule(int moduleId) async {
    ModuleModel? module = cartServiceInterface.forcefullySetModule(
        Get.find<SplashController>().module, Get.find<SplashController>().moduleList, moduleId);
    if (module != null) {
      await Get.find<SplashController>().setModule(module);
      HomeScreen.loadData(true);
    }
  }

  // ----- CHECKOUT MANAGEMENT METHODS -----
  
  Future<void> initCheckoutData(int? storeId) async {
    _isLoading = true;
    Get.find<CouponController>().removeCouponData(false);
    clearPrevData();
    _store = await Get.find<StoreController>().getStoreDetails(Store(id: storeId), false);
    if (_store == null) {
      return;
    }
    initializeTimeSlot(_store!);
    _isLoading = false;
  }

  void showTipsField() {
    _canShowTipsField = !_canShowTipsField;
    update();
  }

  Future<void> addTips(double tips) async {
    _tips = tips;
    update();
  }

  void expandedUpdate(bool status) {
    _isExpanded2 = status;
    update();
  }

  void setPaymentMethod(int index, {bool isUpdate = true}) {
    _paymentMethodIndex = index;
    if (isUpdate) {
      update();
    }
  }

  void changeDigitalPaymentName(String name, {bool willUpdate = true}) {
    _digitalPaymentName = name;
    if (willUpdate) {
      update();
    }
  }

  void setOrderType(String? type, {bool notify = true}) {
    _orderType = type;
    if (notify) {
      update();
    }
  }

  void changePartialPayment({bool isUpdate = true}) {
    _isPartialPay = !_isPartialPay;
    if (isUpdate) {
      update();
    }
  }

  void setAddressIndex(int? index) {
    _addressIndex = index;
    update();
  }

// r changing the address. Defaults to true.

  void setGuestAddress(AddressModel? address, {bool isUpdate = true}) {
    _guestAddress = address;
    if (isUpdate) {
      update();
    }
  }

  Future<void> getDmTipMostTapped() async {
    _mostDmTipAmount = await checkoutServiceInterface.getDmTipMostTapped();
    update();
  }

  void setPreferenceTimeForView(String time, {bool isUpdate = true}) {
    _preferableTime = time;
    if (isUpdate) {
      update();
    }
  }

  Future<void> getOfflineMethodList() async {
    _offlineMethodList = null;
    _offlineMethodList = await checkoutServiceInterface.getOfflineMethodList();
    update();
  }

  void updateTips(int index, {bool notify = true}) {
    _selectedTips = index;
    if (_selectedTips == 0 || _selectedTips == 5) {
      _tips = 0;
    } else {
      _tips = double.parse(AppConstants.tips[index]);
    }
    if (notify) {
      update();
    }
  }

  void saveSharedPrefDmTipIndex(String i) {
    checkoutServiceInterface.saveSharedPrefDmTipIndex(i);
  }

  String getSharedPrefDmTipIndex() {
    return checkoutServiceInterface.getSharedPrefDmTipIndex();
  }

  void setTotalAmount(double amount) {
    _viewTotalPrice = amount;
  }

  void clearPrevData() {
    _addressIndex = 0;
    _acceptTerms = true;
    _paymentMethodIndex = -1;
    _selectedDateSlot = 0;
    _selectedTimeSlot = 0;
    _distance = null;
    _orderAttachment = null;
    _rawAttachment = null;
  }

  // ----- TIME SLOT METHODS -----
  
  Future<void> initializeTimeSlot(Store store) async {
    _timeSlots = await checkoutServiceInterface.initializeTimeSlot(
        store, Get.find<SplashController>().configModel!.scheduleOrderSlotDuration!);
    _allTimeSlots = await checkoutServiceInterface.initializeTimeSlot(
        store, Get.find<SplashController>().configModel!.scheduleOrderSlotDuration!);

    _validateSlot(_allTimeSlots!, 0, store.orderPlaceToScheduleInterval, notify: false);
  }

  void _validateSlot(List<TimeSlotModel> slots, int dateIndex, int? interval, {bool notify = true}) {
    _timeSlots = checkoutServiceInterface.validateTimeSlot(
        slots, dateIndex, interval, Get.find<SplashController>().configModel!.moduleConfig!.module!.orderPlaceToScheduleInterval!);

    if (notify) {
      update();
    }
  }

  void updateTimeSlot(int index) {
    _selectedTimeSlot = index;
    update();
  }

  void updateDateSlot(int index, int? interval) {
    _selectedDateSlot = index;
    if (_allTimeSlots != null) {
      validateSlot(_allTimeSlots!, index, interval);
    }
    update();
  }

  void validateSlot(List<TimeSlotModel> slots, int dateIndex, int? interval, {bool notify = true}) {
    _timeSlots = [];
    DateTime now = DateTime.now();
    if (Get.find<SplashController>().configModel!.moduleConfig!.module!.orderPlaceToScheduleInterval!) {
      now = now.add(Duration(minutes: interval!));
    }
    int day = 0;
    if (dateIndex == 0) {
      day = DateTime.now().weekday;
    } else {
      day = DateTime.now().add(const Duration(days: 1)).weekday;
    }
    if (day == 7) {
      day = 0;
    }
    for (var slot in slots) {
      if (day == slot.day && (dateIndex == 0 ? slot.endTime!.isAfter(now) : true)) {
        _timeSlots!.add(slot);
      }
    }
    if (notify) {
      update();
    }
  }

  // ----- PRESCRIPTION METHODS -----
  
  void pickPrescriptionImage({required bool isRemove, required bool isCamera}) async {
    if (isRemove) {
      _pickedPrescriptions = [];
    } else {
      XFile? xFile = await ImagePicker().pickImage(
          source: isCamera ? ImageSource.camera : ImageSource.gallery, imageQuality: 50);
      if (xFile != null) {
        _pickedPrescriptions.add(xFile);
      }
      update();
    }
  }

  void removePrescriptionImage(int index) {
    _pickedPrescriptions.removeAt(index);
    update();
  }

  // ----- STORE STATUS METHODS -----
  
  bool isStoreClosed(bool today, bool active, List<Schedules>? schedules) {
    return Get.find<StoreController>().isStoreClosed(today, active, schedules);
  }

  bool isStoreOpenNow(bool active, List<Schedules>? schedules) {
    return Get.find<StoreController>().isStoreOpenNow(active, schedules);
  }

  // ----- DISTANCE AND DELIVERY METHODS -----
  
  Future<double?> getDistanceInKM(LatLng originLatLng, LatLng destinationLatLng, {bool isDuration = false, bool fromDashboard = false}) async {
    _distance = -1;
    Response response = await checkoutServiceInterface.getDistanceInMeter(originLatLng, destinationLatLng);
    try {
      if (response.statusCode == 200 && response.body['status'] == 'OK') {
        if (isDuration) {
          _distance = DistanceModel.fromJson(response.body).rows![0].elements![0].duration!.value! / 3600;
        } else {
          _distance = DistanceModel.fromJson(response.body).rows![0].elements![0].distance!.value! / 1000;
        }
      } else {
        if (!isDuration) {
          _distance = Geolocator.distanceBetween(
            originLatLng.latitude, originLatLng.longitude, destinationLatLng.latitude, destinationLatLng.longitude,
          ) / 1000;
        }
      }
    } catch (e) {
      if (!isDuration) {
        _distance = Geolocator.distanceBetween(originLatLng.latitude, originLatLng.longitude,
            destinationLatLng.latitude, destinationLatLng.longitude) / 1000;
      }
    }
    if (!fromDashboard) {
      await _getExtraCharge(_distance);
    }
    update();
    return _distance;
  }

  Future<double?> _getExtraCharge(double? distance) async {
    _extraCharge = null;
    _extraCharge = await checkoutServiceInterface.getExtraCharge(distance);
    return _extraCharge;
  }

  // ----- PAYMENT METHODS -----
  
  Future<bool> checkBalanceStatus(double totalPrice, double discount) async {
    totalPrice = (totalPrice - discount);
    if (isPartialPay) {
      changePartialPayment();
    }
    setPaymentMethod(-1);
    if ((Get.find<ProfileController>().userInfoModel!.walletBalance! < totalPrice) && 
        (Get.find<ProfileController>().userInfoModel!.walletBalance! != 0.0)) {
      Get.dialog(PartialPayDialogWidget(isPartialPay: true, totalPrice: totalPrice), useSafeArea: false,);
    } else {
      Get.dialog(PartialPayDialogWidget(isPartialPay: false, totalPrice: totalPrice), useSafeArea: false,);
    }
    update();
    return true;
  }

  void selectOfflineBank(int index, {bool canUpdate = true}) {
    _selectedOfflineBankIndex = index;
    if (canUpdate) {
      update();
    }
  }

  void setInstruction(int index) {
    if (_selectedInstruction == index) {
      _selectedInstruction = -1;
    } else {
      _selectedInstruction = index;
    }
    update();
  }

  void toggleDmTipSave() {
    _isDmTipSave = !_isDmTipSave;
    update();
  }

  void stopLoader({bool canUpdate = true}) {
    _isLoading = false;
    if (canUpdate) {
      update();
    }
  }

  void toggleExpand() {
    _isExpand = !_isExpand;
    update();
  }

  void toggleCreateAccount({bool willUpdate = true}) {
    _isCreateAccount = !_isCreateAccount;
    if (willUpdate) {
      update();
    }
  }

  // ----- ORDER PLACEMENT METHODS -----
  
  Future<String> placeOrder(
    PlaceOrderBodyModel placeOrderBody,
    int? zoneID,
    double amount,
    double? maximumCodOrderAmount,
    bool fromCart,
    bool isCashOnDeliveryActive,
    List<XFile>? orderAttachment, {
    bool isOfflinePay = false,
  }) async {
    _isLoading = true;
    update();

    try {
      final multiParts = orderAttachment?.map((file) => MultipartBody('order_attachment[]', file)).toList();

      if (kDebugMode) {
        print("placeOrderBody: ${placeOrderBody.toJson()}");
      }

      final response = await checkoutServiceInterface.placeOrder(placeOrderBody, multiParts ?? []);

      if (response.statusCode == 200) {
        final orderID = response.body['order_id'].toString();
        final userID = response.body['user_id']?.toString() ?? '';
        final message = response.body['message'] as String?;

        if (!isOfflinePay) {
          callback(
            true,
            message,
            orderID,
            zoneID,
            amount,
            maximumCodOrderAmount,
            fromCart,
            isCashOnDeliveryActive,
            placeOrderBody.contactPersonNumber!,
            userID,
          );
        } else {
          getCartDataOnline();
        }

        _orderAttachment = null;
        _rawAttachment = null;

        if (kDebugMode) {
          print('Order placed: $orderID');
        }
        return orderID;
      }

      final errorMessage = response.statusText ?? 'Unknown error';
      final userID = response.body['user_id']?.toString() ?? '';
      
      if (response.statusCode == 406) {
        showCustomSnackBar(errorMessage);
        Get.back(closeOverlays: true);
      } else if (!isOfflinePay) {
        callback(
          false,
          errorMessage,
          '-1',
          zoneID,
          amount,
          maximumCodOrderAmount,
          fromCart,
          isCashOnDeliveryActive,
          placeOrderBody.contactPersonNumber,
          userID,
        );
      } else {
        showCustomSnackBar(errorMessage);
      }
      return '';
    } catch (e) {
      if (kDebugMode) {
        print('Error placing order: $e');
      }
      if (!isOfflinePay) {
        callback(
          false,
          'Failed to place order: $e',
          '-1',
          zoneID,
          amount,
          maximumCodOrderAmount,
          fromCart,
          isCashOnDeliveryActive,
          placeOrderBody.contactPersonNumber,
          '',
        );
      } else {
        showCustomSnackBar('Failed to place order: $e');
      }
      return '';
    } finally {
      _isLoading = false;
      update();
    }
  }

  Future<void> placePrescriptionOrder(int? storeId, int? zoneID, double? distance, String address, 
      String longitude, String latitude, String note, List<XFile> orderAttachment,
      String dmTips, String deliveryInstruction, double orderAmount, double maxCodAmount, 
      bool fromCart, bool isCashOnDeliveryActive) async {
    List<MultipartBody> multiParts = [];
    for (XFile file in orderAttachment) {
      multiParts.add(MultipartBody('order_attachment[]', file));
    }
    _isLoading = true;
    update();
    Response response = await checkoutServiceInterface.placePrescriptionOrder(
        storeId, distance, address, longitude, latitude, note, multiParts, dmTips, deliveryInstruction);
    _isLoading = false;
    if (response.statusCode == 200) {
      String? message = response.body['message'];
      String orderID = response.body['order_id'].toString();
      callback(true, message, orderID, zoneID, orderAmount, maxCodAmount, fromCart, isCashOnDeliveryActive, null, '');
      _orderAttachment = null;
      _rawAttachment = null;
      if (kDebugMode) {
        print('-------- Order placed successfully $orderID ----------');
      }
    } else {
      callback(false, response.statusText, '-1', zoneID, orderAmount, maxCodAmount, fromCart, isCashOnDeliveryActive, null, '');
    }
    update();
  }

  void callback(
      bool isSuccess, String? message, String orderID, int? zoneID, double amount,
      double? maximumCodOrderAmount, bool fromCart, bool isCashOnDeliveryActive, String? contactNumber,
      String userID) async {

    if (isSuccess) {
      if (fromCart) {
        clearCartList();
      }
      setGuestAddress(null);
      if (!Get.find<OrderController>().showBottomSheet) {
        Get.find<OrderController>().showRunningOrders(canUpdate: false);
      }
      if (isDmTipSave) {
        saveSharedPrefDmTipIndex(selectedTips.toString());
      }
      stopLoader(canUpdate: false);
      HomeScreen.loadData(true);
      if (paymentMethodIndex == 2) {
        if (GetPlatform.isWeb) {
          await Get.find<AuthController>().saveGuestNumber(contactNumber ?? '');
          String? hostname = html.window.location.hostname;
          String protocol = html.window.location.protocol;
          String selectedUrl;
          selectedUrl = '${AppConstants.baseUrl}/payment-mobile? zone_id=$zoneID&& order_id=$orderID&&customer_id=${Get.find<ProfileController>().userInfoModel?.id ?? (userID.isNotEmpty ? userID : AuthHelper.getGuestId())}'
              '&payment_method=$digitalPaymentName&payment_platform=web&&callback=$protocol//$hostname${RouteHelper.orderSuccess}?id=$orderID&status=';

          html.window.open(selectedUrl, "_self");
        } else {
          Get.offNamed(RouteHelper.getPaymentRoute(
            orderID, Get.find<ProfileController>().userInfoModel?.id ?? (userID.isNotEmpty ? int.parse(userID) : 0), 
            orderType, amount, isCashOnDeliveryActive, digitalPaymentName, guestId: userID.isNotEmpty ? userID : AuthHelper.getGuestId(),
            contactNumber: contactNumber,
          ));
        }
      } else {
        double total = ((amount / 100) * Get.find<SplashController>().configModel!.loyaltyPointItemPurchasePoint!);
        if (AuthHelper.isLoggedIn()) {
          Get.find<AuthController>().saveEarningPoint(total.toStringAsFixed(0));
        }
        if (ResponsiveHelper.isDesktop(Get.context) && AuthHelper.isLoggedIn()) {
          Get.offNamed(RouteHelper.getInitialRoute());
          Future.delayed(const Duration(seconds: 2), () => Get.dialog(Center(child: SizedBox(height: 350, width: 500, child: OrderSuccessfulDialog(orderID: orderID)))));
        } else {
          Get.offNamed(RouteHelper.getOrderSuccessRoute(orderID, contactNumber, createAccount: _isCreateAccount));
        }
      }
      clearPrevData();
      Get.find<CouponController>().removeCouponData(false);
      updateTips(
        getSharedPrefDmTipIndex().isNotEmpty ? int.parse(getSharedPrefDmTipIndex()) : 0,
        notify: false,
      );
    } else {
      showCustomSnackBar(message);
    }
  }
}
