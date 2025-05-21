import 'package:flutter/material.dart';
import 'package:sixam_mart/common/models/response_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/favourite/domain/services/favourite_service_interface.dart';

class FavouriteController extends GetxController implements GetxService {
  final FavouriteServiceInterface favouriteServiceInterface;
  FavouriteController({required this.favouriteServiceInterface});

  List<Item?>? _wishItemList;
  List<Item?>? get wishItemList => _wishItemList;

  List<Store?>? _wishStoreList;
  List<Store?>? get wishStoreList => _wishStoreList;

  List<int?> _wishItemIdList = [];
  List<int?> get wishItemIdList => _wishItemIdList;

  List<int?> _wishStoreIdList = [];
  List<int?> get wishStoreIdList => _wishStoreIdList;

  bool _isRemoving = false;
  bool get isRemoving => _isRemoving;

  void addToFavouriteList(Item? product, int? storeID, bool isStore, {bool getXSnackBar = false}) async {
    _isRemoving = true;
    update();
    if(isStore) {
      _wishStoreList ??= [];
      _wishStoreIdList.add(storeID);
      _wishStoreList!.add(Store());
    }else{
      _wishItemList ??= [];
      _wishItemList!.add(product);
      _wishItemIdList.add(product!.id);
    }
    ResponseModel responseModel = await favouriteServiceInterface.addFavouriteList(isStore ? storeID : product!.id, isStore);
    if (responseModel.isSuccess) {
      showCustomSnackBar(responseModel.message, isError: false, getXSnackBar: getXSnackBar);
    } else {
      if(isStore) {
        for (var storeId in _wishStoreIdList) {
          if (storeId == storeID) {
            _wishStoreIdList.removeAt(_wishStoreIdList.indexOf(storeId));
          }
        }
      }else{
        for (var productId in _wishItemIdList) {
          if(productId == product!.id){
            _wishItemIdList.removeAt(_wishItemIdList.indexOf(productId));
          }
        }
      }
      showCustomSnackBar(responseModel.message, isError: true, getXSnackBar: getXSnackBar);
    }
    _isRemoving = false;
    update();
  }

  void removeFromFavouriteList(int? id, bool isStore, {bool getXSnackBar = false}) async {
    _isRemoving = true;
    update();

    int idIndex = -1;
    int? storeId, itemId;
    Store? store;
    Item? item;
    if(isStore) {
      idIndex = _wishStoreIdList.indexOf(id);
      if(idIndex != -1) {
        storeId = id;
        _wishStoreIdList.removeAt(idIndex);
        store = _wishStoreList![idIndex];
        _wishStoreList!.removeAt(idIndex);
      }
    }else {
      idIndex = _wishItemIdList.indexOf(id);
      if(idIndex != -1) {
        itemId = id;
        _wishItemIdList.removeAt(idIndex);
        item = _wishItemList![idIndex];
        _wishItemList!.removeAt(idIndex);
      }
    }
    ResponseModel responseModel = await favouriteServiceInterface.removeFavouriteList(id, isStore);
    if (responseModel.isSuccess) {
      showCustomSnackBar(responseModel.message, isError: false, getXSnackBar: getXSnackBar);
    }
    else {
      showCustomSnackBar(responseModel.message, isError: true, getXSnackBar: getXSnackBar);
      if(isStore) {
        _wishStoreIdList.add(storeId);
        _wishStoreList!.add(store);
      }else {
        _wishItemIdList.add(itemId);
        _wishItemList!.add(item);
      }
    }
    _isRemoving = false;
    update();
  }

  Future<void> getFavouriteList() async {
    _wishItemList = null;
    _wishStoreList = null;
    Response response = await favouriteServiceInterface.getFavouriteList();
    if (response.statusCode == 200) {
      update();
      _wishItemList = [];
      _wishStoreList = [];
      _wishStoreIdList = [];
      _wishItemIdList = [];

      if(response.body['item'] != null) {
        response.body['item'].forEach((item) async {
          if(item['module_type'] == null || !Get.find<SplashController>().getModuleConfig(item['module_type']).newVariation!
            || item['variations'] == null || item['variations'].isEmpty || (item['food_variations'] != null && item['food_variations'].isNotEmpty)){


            Item i = Item.fromJson(item);
            if(Get.find<SplashController>().module == null){
                if (i.store!.noservicerestriction == 0 && i.store!.distancelimit == 0) {
          print('item name: ${i.storeName}  wishItemList: ${i.store!.noservicerestriction} ${i.store!.distancelimit}');
        } else {
          _wishItemList!.add(i);
        }
              _wishItemList!.addAll(favouriteServiceInterface.wishItemList(i));
              _wishItemIdList.addAll(favouriteServiceInterface.wishItemIdList(i));
            }else{
              // _wishItemList!.add(i);
              // _wishItemIdList.add(i.id);

                  // if(Get.find<SplashController>().module == null){
                if (i.store!.noservicerestriction == 0 && i.store!.distancelimit == 0) {
          print('item name: ${i.storeName}  wishItemList: ${i.store!.noservicerestriction} ${i.store!.distancelimit}');
        } else {
          _wishItemList!.add(i);
        }
        // }
            }
          }
        });
      }

      response.body['store'].forEach((store) async {
        if(Get.find<SplashController>().module == null){
          _wishStoreList!.addAll(favouriteServiceInterface.wishStoreList(store));
          _wishStoreIdList.addAll(favouriteServiceInterface.wishStoreIdList(store));
        }else{
          Store? s;
          try{
            s = Store.fromJson(store);
          }catch(e){
            debugPrint('exception create in store list create : $e');
          }
          if(s != null && Get.find<SplashController>().module!.id == s.moduleId) {
            _wishStoreList!.add(s);
            _wishStoreIdList.add(s.id);
          }
        }
      });
    }
    update();
  }



// Future<void> getFavouriteList() async {
//   _wishItemList = null;
//   _wishStoreList = null;
//   Response response = await favouriteServiceInterface.getFavouriteList();
//   if (response.statusCode != 200) {
//     print('Failed to fetch favorites: ${response.statusCode}');
//     update();
//     return;
//   }

//   _wishItemList = [];
//   _wishStoreList = [];
//   _wishStoreIdList = [];
//   _wishItemIdList = [];

//   // Process items
//   if (response.body['item'] != null && response.body['item'] is List) {
//     for (var item in response.body['item']) {
//       if (item['module_type'] == null ||
//           !Get.find<SplashController>().getModuleConfig(item['module_type']).newVariation! ||
//           item['variations'] == null ||
//           item['variations'].isEmpty ||
//           (item['food_variations'] != null && item['food_variations'].isNotEmpty)) {
//         try {
//           Item i = Item.fromJson(item);
//           if (Get.find<SplashController>().module == null) {
//             if (i.store?.noservicerestriction == 0 && i.store?.distancelimit == 0) {
//               print('Item name: ${i.storeName}  wishItemList: ${i.store?.noservicerestriction} ${i.store?.distancelimit}');
//             } else {
//               _wishItemList!.add(i);
//             }
//             _wishItemList!.addAll(favouriteServiceInterface.wishItemList(i));
//             _wishItemIdList.addAll(favouriteServiceInterface.wishItemIdList(i));
//           } else {
//             if (i.store?.noservicerestriction == 0 && i.store?.distancelimit == 0) {
//               print('Item name: ${i.storeName}  wishItemList: ${i.store?.noservicerestriction} ${i.store?.distancelimit}');
//             } else {
//               _wishItemList!.add(i);
//             }
//           }
//         } catch (e) {
//           print('Error parsing item: $e');
//         }
//       }
//     }
//   }

//   // Process stores
//   if (response.body['store'] != null && response.body['store'] is List) {
//     final splashController = Get.find<SplashController>();
//     final isModuleNull = splashController.module == null;
//     print('==========================================================STORE DATA: ${response.body['store']}========================================================================');
//     for (var store in response.body['store']) {
//       if (isModuleNull) {
//         try {
//           final storeList = favouriteServiceInterface.wishStoreList(store);
//           final storeIdList = favouriteServiceInterface.wishStoreIdList(store);
//           _wishStoreList!.addAll(storeList);
//           _wishStoreIdList.addAll(storeIdList);
//           print('Added ${storeList.length} stores from wishStoreList');
//         } catch (e) {
//           print('Error in wishStoreList: $e');
//         }
//       } else {
//         try {
//           Store? s = Store.fromJson(store);
//           if (s != null && splashController.module!.id == s.moduleId) {
//             _wishStoreList!.add(s);
//             _wishStoreIdList.add(s.id!);
//             print('Added store: ${s.name} with ID: ${s.id}');
//           } else {
//             print('Store not added: ${s?.name}, moduleId mismatch or null');
//           }
//         } catch (e) {
//           print('Error parsing store: $e');
//         }
//       }
//     }
//   } else {
//     print('No stores in response or invalid store data');
//   }

//   print('Final wishStoreList length: ${_wishStoreList!.length}');
//   update();
// }
 
 
  void removeFavourite() {
    _wishItemIdList = [];
    _wishStoreIdList = [];
  }

}
