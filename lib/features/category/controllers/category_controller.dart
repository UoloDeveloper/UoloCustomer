import 'package:sixam_mart/common/enums/data_source_enum.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/category/domain/models/category_model.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/category/domain/services/category_service_interface.dart';
import 'package:sixam_mart/util/app_constants.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryServiceInterface categoryServiceInterface;
  CategoryController({required this.categoryServiceInterface});

  List<CategoryModel>? _categoryList;
  List<CategoryModel>? get categoryList => _categoryList;


   List<CategoryModel>? _GroccerycategoryList;
  List<CategoryModel>? get GrocerycategoryList => _GroccerycategoryList;

   List<ItemModel?> _GroccerycategoryitemList = [];
  List<ItemModel?> get GrocerycategoritemyList => _GroccerycategoryitemList;


  List<CategoryModel>? _subCategoryList;
  List<CategoryModel>? get subCategoryList => _subCategoryList;

  List<Item>? _categoryItemList;
  List<Item>? get categoryItemList => _categoryItemList;

  List<Store>? _categoryStoreList;
  List<Store>? get categoryStoreList => _categoryStoreList;

  List<Item>? _searchItemList = [];
  List<Item>? get searchItemList => _searchItemList;

  List<Store>? _searchStoreList = [];
  List<Store>? get searchStoreList => _searchStoreList;

  List<bool>? _interestSelectedList;
  List<bool>? get interestSelectedList => _interestSelectedList;


  List<bool>? _interestfoodSelectedList;
  List<bool>? get interestfoodSelectedList => _interestfoodSelectedList;
   
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int? _pageSize;
  int? get pageSize => _pageSize;

  int? _restPageSize;
  int? get restPageSize => _restPageSize;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  int _subCategoryIndex = 0;
  int get subCategoryIndex => _subCategoryIndex;

  String _type = 'all';
  String get type => _type;

  bool _isStore = false;
  bool get isStore => _isStore;

  String? _searchText = '';
  String? get searchText => _searchText;

  int _offset = 1;
  int get offset => _offset;

  void clearCategoryList() {
    _categoryList = null;
  }

  Future<void> getCategoryList(bool reload, {bool allCategory = false, DataSourceEnum dataSource = DataSourceEnum.local, bool fromRecall = false}) async {
    if(_categoryList == null || reload || fromRecall) {
      if(reload) {
        _categoryList = null;
      }
      List<CategoryModel>? categoryList;
      if(dataSource == DataSourceEnum.local) {
        categoryList = await categoryServiceInterface.getCategoryList(allCategory,  Get.find<SplashController>().module!, source: DataSourceEnum.local);
        _prepareCategoryList(categoryList);
        getCategoryList(false, fromRecall: true, allCategory: allCategory, dataSource: DataSourceEnum.client);
      } else {
        categoryList = await categoryServiceInterface.getCategoryList(allCategory,Get.find<SplashController>().module!, source: DataSourceEnum.client);
        _prepareCategoryList(categoryList);
      }

    }
  }


   Future<void> getGrocceryCategoryList(bool reload, {bool allCategory = false, DataSourceEnum dataSource = DataSourceEnum.local, bool fromRecall = false}) async {
    _isLoading = true;
    update();
    if(_GroccerycategoryList == null || reload || fromRecall) {
      if(reload) {
        _categoryList = null;
      }
      ModuleModel? module = Get.find<SplashController>().moduleList!.where((element) => element.moduleType ==   AppConstants.grocery).first;

      List<CategoryModel>? GrocerycategoryList;
      if(dataSource == DataSourceEnum.local) {
        GrocerycategoryList = await categoryServiceInterface.getCategoryList(allCategory,module,   source: DataSourceEnum.local);
        _prepareGrocceryCategoryList(GrocerycategoryList);
         for(int i = 0; i < GrocerycategoryList!.length; i++) {
        // _interestfoodSelectedList!.add(false);
        //  getCategoryItemList(_GroccerycategoryList![i].id.toString(), 1, 'all', false);
        print(' fettching data on category id ${GrocerycategoryList![i].id.toString()}   ${GrocerycategoryList![i].name}');
       ItemModel? itemdata =   await categoryServiceInterface.getCategoryItemList(GrocerycategoryList![i].id.toString(), offset, type);
        if (itemdata != Null) {
              _GroccerycategoryitemList.add(itemdata);

              update();

        }
// _GroccerycategoryitemList.removeWhere((element) => element!.);


      }
        // getGrocceryCategoryList(false, fromRecall: true, allCategory: allCategory, dataSource: DataSourceEnum.client);

      } else {
        GrocerycategoryList = await categoryServiceInterface.getCategoryList(allCategory, module, source: DataSourceEnum.client);
        // _prepareGrocceryCategoryList(GrocerycategoryList);
         for(int i = 0; i < GrocerycategoryList!.length; i++) {
        // _interestfoodSelectedList!.add(false);
        //  getCategoryItemList(_GroccerycategoryList![i].id.toString(), 1, 'all', false);
        print(' fettching data on category id ${GrocerycategoryList![i].id.toString()}   ${GrocerycategoryList![i].name}');
       ItemModel? itemdata =   await categoryServiceInterface.getCategoryItemList(GrocerycategoryList![i].id.toString(), offset, type);
        if (itemdata != Null) {
              _GroccerycategoryitemList.add(itemdata);

              update();

        }
// _GroccerycategoryitemList.removeWhere((element) => element!.);


      }
      }

    
    }

    _isLoading = false;
    update();
  }
  _prepareCategoryList(List<CategoryModel>? categoryList) {
    if (categoryList != null) {
      _categoryList = [];
      _interestSelectedList = [];
      _categoryList!.addAll(categoryList);
      for(int i = 0; i < _categoryList!.length; i++) {
        _interestSelectedList!.add(false);
      }
    }
    update();
  }

  _prepareGrocceryCategoryList(List<CategoryModel>? GrocerycategoryList) {
    if (GrocerycategoryList != null) {
      _GroccerycategoryList = [];
      _interestfoodSelectedList = [];
      _GroccerycategoryList!.addAll(GrocerycategoryList);
      for(int i = 0; i < _GroccerycategoryList!.length; i++) {
        _interestfoodSelectedList!.add(false);
      }
    }
    update();
  }
  void getSubCategoryList(String? categoryID) async {
     _isLoading = true;
    _subCategoryIndex = 0;
    _subCategoryList = null;
    _categoryItemList = null;
    List<CategoryModel>? subCategoryList = await categoryServiceInterface.getSubCategoryList(categoryID);
    if (subCategoryList != null) {
      _subCategoryList= [];
      _subCategoryList!.add(CategoryModel(id: int.parse(categoryID!), name: 'all'.tr));
      _subCategoryList!.addAll(subCategoryList);
      getCategoryItemList(categoryID, 1, 'all', false);
    }

     _isLoading = false;
    update();
  }

  void setSubCategoryIndex(int index, String? categoryID) {
    _subCategoryIndex = index;
    if(_isStore) {
      getCategoryStoreList(_subCategoryIndex == 0 ? categoryID : _subCategoryList![index].id.toString(), 1, _type, true);
    }else {
      getCategoryItemList(_subCategoryIndex == 0 ? categoryID : _subCategoryList![index].id.toString(), 1, _type, true);
    }
  }

  void getCategoryItemList(String? categoryID, int offset, String type, bool notify) async {
   
    _offset = offset;
    if(offset == 1) {
      if(_type == type) {
        _isSearching = false;
      }
      _type = type;
      if(notify) {
        update();
      }
      _categoryItemList = null;
    }
    ItemModel? categoryItem = await categoryServiceInterface.getCategoryItemList(categoryID, offset, type);
    if (categoryItem != null) {
      if (offset == 1) {
        _categoryItemList = [];
      }
      categoryItem.items!.removeWhere((element) =>  element.store!.noservicerestriction == 0 &&  element.store!.distancelimit == 0  );
      _categoryItemList!.addAll(categoryItem.items!);
      _pageSize = categoryItem.totalSize;
      _isLoading = false;
    }
   
    update();
  }

  void getCategoryStoreList(String? categoryID, int offset, String type, bool notify) async {
    _offset = offset;
    if(offset == 1) {
      if(_type == type) {
        _isSearching = false;
      }
      _type = type;
      if(notify) {
        update();
      }
      _categoryStoreList = null;
    }
    StoreModel? categoryStore = await categoryServiceInterface.getCategoryStoreList(categoryID, offset, type);
    if (categoryStore != null) {
      if (offset == 1) {
        _categoryStoreList = [];
      }
      _categoryStoreList!.addAll(categoryStore.stores!);
      _restPageSize = categoryStore.totalSize;
      _isLoading = false;
    }
    update();
  }

  void searchData(String? query, String? categoryID, String type) async {
    if((_isStore && query!.isNotEmpty) || (!_isStore && query!.isNotEmpty /*&& query != _itemResultText*/)) {
      _searchText = query;
      _type = type;
      _isStore ? _searchStoreList = null : _searchItemList = null;
      _isSearching = true;
      update();

      Response response = await categoryServiceInterface.getSearchData(query, categoryID, _isStore, type);
      if (response.statusCode == 200) {
        if (query.isEmpty) {
          _isStore ? _searchStoreList = [] : _searchItemList = [];
        } else {
          if (_isStore) {
            _searchStoreList = [];
            _searchStoreList!.addAll(StoreModel.fromJson(response.body).stores!);
            update();
          } else {
            _searchItemList = [];
            _searchItemList!.addAll(ItemModel.fromJson(response.body).items!);
          }
        }
      }
      update();
    }
  }

  void toggleSearch() {
    _isSearching = !_isSearching;
    _searchItemList = [];
    if(_categoryItemList != null) {
      _searchItemList!.addAll(_categoryItemList!);
    }
    update();
  }

  void showBottomLoader() {
    _isLoading = true;
    update();
  }

  Future<bool> saveInterest(List<int?> interests) async {
    _isLoading = true;
    update();
    bool isSuccess = await categoryServiceInterface.saveUserInterests(interests);
    _isLoading = false;
    update();
    return isSuccess;
  }

  void addInterestSelection(int index) {
    _interestSelectedList![index] = !_interestSelectedList![index];
    update();
  }

  void setRestaurant(bool isRestaurant) {
    _isStore = isRestaurant;
    update();
  }


// Future<ItemModel?> categoryitembyId( String categoryID, int offset, String type) async {
//   // Fetch data from the service
//   final data = await categoryServiceInterface.getCategoryItemList(categoryID, offset, type);
  
//   // Check if data is null
//   if (data == null) {
//   // Get.snackbar(
//   //     "Error",
//   //     "Failed to load data for ID $categoryID: Data is null",
//   //     snackPosition: SnackPosition.TOP,
//   //   );
//     throw Exception('Failed to load data for ID $categoryID: Data is null');
//   }

//   // Check if categories are not empty
//   if (data.items != null && data.items!.isNotEmpty) {
//   //  Get.snackbar(
//   //     "Success",
//   //     "successfully to load data for ID $categoryID: ${data.items!.length} categories found",
//   //     snackPosition: SnackPosition.TOP,
//   //   );
//     return data;
//   } else {
//   //  Get.snackbar(
//   //     "Error",
//   //     "Failed to load data for ID $categoryID:  No categories found",
//   //     snackPosition: SnackPosition.TOP,
//   //   );
//     throw Exception('Failed to load data for ID $categoryID: No categories found' " $data and ${data.items!.first.name}");
//   }
// }

Future<ItemModel?> categoryitembyId( String categoryID, int offset, String type) async {
  // Fetch data from the service
  final data = await categoryServiceInterface.getCategoryItemList(categoryID, offset, type);
  
  // Check if data is null
  if (data == null) {
  // Get.snackbar(
  //     "Error",
  //     "Failed to load data for ID $categoryID: Data is null",
  //     snackPosition: SnackPosition.TOP,
  //   );
    throw Exception('Failed to load data for ID $categoryID: Data is null');
  }

  // Check if categories are not empty
  if (data.items != null && data.items!.isNotEmpty) {
  //  Get.snackbar(
  //     "Success",
  //     "successfully to load data for ID $categoryID: ${data.items!.length} categories found",
  //     snackPosition: SnackPosition.TOP,
  //   );
    return data;
  } else {
  //  Get.snackbar(
  //     "Error",
  //     "Failed to load data for ID $categoryID:  No categories found",
  //     snackPosition: SnackPosition.TOP,
  //   );
    throw Exception('Failed to load data for ID $categoryID: No categories found' " $data and ${data.items!.first.name}");
  }
}

}
