import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sixam_mart/common/widgets/card_design/item_card.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/footer_view.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/widgets/bottom_cart_widget.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/cart_widget.dart';
import 'package:sixam_mart/common/widgets/item_view.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:sixam_mart/common/widgets/veg_filter_widget.dart';
import 'package:sixam_mart/common/widgets/web_menu_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItemScreen extends StatefulWidget {
  final String? categoryID;
  final String categoryName;
  const CategoryItemScreen({super.key, required this.categoryID, required this.categoryName});

  @override
  CategoryItemScreenState createState() => CategoryItemScreenState();
}

class CategoryItemScreenState extends State<CategoryItemScreen> with TickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  final ScrollController storeScrollController = ScrollController();
  TabController? _tabController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, initialIndex: 0, vsync: this);
    Get.find<CategoryController>().getSubCategoryList(widget.categoryID);

    Get.find<CategoryController>().getCategoryStoreList(
      widget.categoryID, 1, Get.find<CategoryController>().type, false,
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent
          && Get.find<CategoryController>().categoryItemList != null
          && !Get.find<CategoryController>().isLoading) {
        int pageSize = (Get.find<CategoryController>().pageSize! / 10).ceil();
        if (Get.find<CategoryController>().offset < pageSize) {
          if (kDebugMode) {
            print('end of the page');
          }
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getCategoryItemList(
            Get.find<CategoryController>().subCategoryIndex == 0 ? widget.categoryID
                : Get.find<CategoryController>().subCategoryList![Get.find<CategoryController>().subCategoryIndex].id.toString(),
            Get.find<CategoryController>().offset+1, Get.find<CategoryController>().type, false,
          );
        }
      }
    });
    storeScrollController.addListener(() {
      if (storeScrollController.position.pixels == storeScrollController.position.maxScrollExtent
          && Get.find<CategoryController>().categoryStoreList != null
          && !Get.find<CategoryController>().isLoading) {
        int pageSize = (Get.find<CategoryController>().restPageSize! / 10).ceil();
        if (Get.find<CategoryController>().offset < pageSize) {
          if (kDebugMode) {
            print('end of the page');
          }
          Get.find<CategoryController>().showBottomLoader();
          Get.find<CategoryController>().getCategoryStoreList(
            Get.find<CategoryController>().subCategoryIndex == 0 ? widget.categoryID
                : Get.find<CategoryController>().subCategoryList![Get.find<CategoryController>().subCategoryIndex].id.toString(),
            Get.find<CategoryController>().offset+1, Get.find<CategoryController>().type, false,
          );
        }
      }
    });
  }


  bool isgrocery = Get.find<SplashController>().module!.moduleType.toString() == AppConstants.grocery;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (catController) {
      List<Item>? item;
      List<Store>? stores;
      if(catController.isSearching ? catController.searchItemList != null : catController.categoryItemList != null) {
        item = [];
        if (catController.isSearching) {
          item.addAll(catController.searchItemList!);
        } else {
          item.addAll(catController.categoryItemList!);
        }
      }
      if(catController.isSearching ? catController.searchStoreList != null : catController.categoryStoreList != null) {
        stores = [];
        if (catController.isSearching) {
          stores.addAll(catController.searchStoreList!);
        } else {
          stores.addAll(catController.categoryStoreList!);
        }
      }

      return PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) async {
          if(catController.isSearching) {
            catController.toggleSearch();
          }else {
            return;
          }
        },
        child: Scaffold(
          appBar: (ResponsiveHelper.isDesktop(context) ? const WebMenuBar() : AppBar(
            backgroundColor: Theme.of(context).cardColor,
            surfaceTintColor: Theme.of(context).cardColor,
            shadowColor: Colors.white ,


            elevation: 0,
            title: catController.isSearching ? SizedBox(
              height: 45,
              child: TextField(
                autofocus: true,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  hintText: 'Search...',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    borderSide: BorderSide(color: Theme.of(context).disabledColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    borderSide: BorderSide(color: Theme.of(context).disabledColor),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () => catController.toggleSearch(),
                    icon: Icon(
                      catController.isSearching ? Icons.close_sharp : Icons.search,
                      color: Theme.of(context).disabledColor,
                    ),
                  ),
                ),
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeLarge),
                onSubmitted: (String query) {
                  catController.searchData(
                    query, catController.subCategoryIndex == 0 ? widget.categoryID
                      : catController.subCategoryList![catController.subCategoryIndex].id.toString(),
                    catController.type,
                  );
                }
              ),
            ) : Text(widget.categoryName, style: robotoRegular.copyWith(
              fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).textTheme.bodyLarge!.color,
            )),
            centerTitle: false,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              color: Theme.of(context).textTheme.bodyLarge!.color,
              onPressed: () {
                if(catController.isSearching) {
                  catController.toggleSearch();
                }else {
                  Get.back();
                }
              },
            ),
            actions: [

              !catController.isSearching ? IconButton(
                onPressed: () => catController.toggleSearch(),
                icon: Icon(
                  catController.isSearching ? Icons.close_sharp : Icons.search,
                  color: Theme.of(context).textTheme.bodyLarge!.color,
                ),
              ) : const SizedBox(),

              // IconButton(
              //   onPressed: () => Get.toNamed(RouteHelper.getCartRoute()),
              //   icon: CartWidget(color: Theme.of(context).textTheme.bodyLarge!.color, size: 25),
              // ),

              VegFilterWidget(type: catController.type, fromAppBar: true, onSelected: (String type) {
                if(catController.isSearching) {
                  catController.searchData(
                    catController.subCategoryIndex == 0 ? widget.categoryID
                        : catController.subCategoryList![catController.subCategoryIndex].id.toString(), '1', type,
                  );
                }else {
                  if(catController.isStore) {
                    catController.getCategoryStoreList(
                      catController.subCategoryIndex == 0 ? widget.categoryID
                          : catController.subCategoryList![catController.subCategoryIndex].id.toString(), 1, type, true,
                    );
                  }else {
                    catController.getCategoryItemList(
                      catController.subCategoryIndex == 0 ? widget.categoryID
                          : catController.subCategoryList![catController.subCategoryIndex].id.toString(), 1, type, true,
                    );
                  }
                }
              }),

              const SizedBox(width: Dimensions.paddingSizeSmall),
            ],
          )),
          // endDrawer: const MenuDrawer(),endDrawerEnableOpenDragGesture: false,
          body: 
          
          isgrocery ? 
       catController.isLoading ? Center(
            child : CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
          ) :
          Column(
            crossAxisAlignment: CrossAxisAlignment.center ,
            mainAxisAlignment: MainAxisAlignment.center ,
            children: [
                   (catController.subCategoryList != null && !catController.isSearching) ? Center(child: Container(
                  height: 40, width: Dimensions.webMaxWidth, color: Theme.of(context).cardColor,
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                  child: ListView.builder(
                    key: scaffoldKey,
                    scrollDirection: Axis.horizontal,
                    itemCount: catController.subCategoryList!.length,
                    padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () => catController.setSubCategoryIndex(index, widget.categoryID),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                          margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            color: index == catController.subCategoryIndex ? Theme.of(context).primaryColor   : Colors.transparent,
                          ),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Text(
                              catController.subCategoryList![index].name!,
                              style: index == catController.subCategoryIndex
                                  ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)
                                  : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                            ),
                          ]),
                        ),
                      );
                    },
                  ),
                )) : const SizedBox(),
          
          
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   child: Expanded(
                //     child: GridView.builder(gridDelegate: 
                //     SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 2,
                //       crossAxisSpacing: 10,
                //       mainAxisSpacing: 10,
                //       childAspectRatio: 0.7,
                //     ),
                //     itemCount: item!.length,
                //                      itemBuilder: (context, index) {
                //      return Container(
                //       height: 300,
                //       width: 100,
                //       child: ItemCard(item: item![index], isFood: false, isShop: false));
                //                      },
                //     ),
                //   ),
                // ),
          
              //    Flexible(
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,

              //     child: Center(
              //       child: GridView.builder(
              //         padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
              //         // physics: alwaysScrollableScrollPhysics
              //         // shrinkWrap: true,
              //         addRepaintBoundaries: true,
              //         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //                 // mainAxisExtent: .4,
              //                 crossAxisCount: 2,
              //                 crossAxisSpacing: 3,
              //                 mainAxisSpacing: .10,
              //                 childAspectRatio: 0.65,
              //         ),
              //         itemCount: item!.length,
              //         itemBuilder: (context, index) {
              //                 return ItemCard(item: item![index], isFood: false, isShop: false,width: 180,);
              //         },
              //       ),
              //     ),
                  
              //   ),
              // )
            
            Flexible(
  child: Container(
    width: MediaQuery.of(context).size.width,
    child: Center(
      child: GridView.builder(
        padding: const EdgeInsets.only(left: 20, right: 10, top: 10),
        addRepaintBoundaries: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 3,
          mainAxisSpacing: 0.10,
          childAspectRatio: 0.65,
        ),
        itemCount: item != null ? item!.length : 0, 
        itemBuilder: (context, index) {
          return ItemCard(item: item![index], isFood: false, isShop: false, width: 180);
        },
      ),
    ),
  ),
)
            ],
          ) : ResponsiveHelper.isDesktop(context) ?  SingleChildScrollView(
           
           
            child:  FooterView(
              child: Center(child: SizedBox(
                width: Dimensions.webMaxWidth,
                child: Column(children: [

                  (catController.subCategoryList != null && !catController.isSearching) ? Center(child: Container(
                    height: 40, width: Dimensions.webMaxWidth, color: Theme.of(context).cardColor,
                    padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                    child: ListView.builder(
                      key: scaffoldKey,
                      scrollDirection: Axis.horizontal,
                      itemCount: catController.subCategoryList!.length,
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () => catController.setSubCategoryIndex(index, widget.categoryID),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                            margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                              color: index == catController.subCategoryIndex ? Theme.of(context).primaryColor   : Colors.transparent,
                            ),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Text(
                                catController.subCategoryList![index].name!,
                                style: index == catController.subCategoryIndex
                                    ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)
                                    : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                              ),
                            ]),
                          ),
                        );
                      },
                    ),
                  )) : const SizedBox(),

                  Center(child: Container(
                    width: Dimensions.webMaxWidth,
                    color: Theme.of(context).cardColor,
                    child: TabBar(
                      controller: _tabController,
                      indicatorColor: Theme.of(context).primaryColor,
                      indicatorWeight: 3,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                      labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                      tabs: [
                        Tab(text: 'item'.tr),
                        Tab(text: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants'.tr : 'stores'.tr),
                      ],
                    ),
                  )),

                  SizedBox(
                    height: 600,
                    child: NotificationListener(
                      onNotification: (dynamic scrollNotification) {
                        if (scrollNotification is ScrollEndNotification) {
                          if((_tabController!.index == 1 && !catController.isStore) || _tabController!.index == 0 && catController.isStore) {
                            catController.setRestaurant(_tabController!.index == 1);
                            if(catController.isSearching) {
                              catController.searchData(
                                catController.searchText, catController.subCategoryIndex == 0 ? widget.categoryID
                                  : catController.subCategoryList![catController.subCategoryIndex].id.toString(), catController.type,
                              );
                            }else {
                              if(_tabController!.index == 1) {
                                catController.getCategoryStoreList(
                                  catController.subCategoryIndex == 0 ? widget.categoryID
                                      : catController.subCategoryList![catController.subCategoryIndex].id.toString(),
                                  1, catController.type, false,
                                );
                              }else {
                                catController.getCategoryItemList(
                                  catController.subCategoryIndex == 0 ? widget.categoryID
                                      : catController.subCategoryList![catController.subCategoryIndex].id.toString(),
                                  1, catController.type, false,
                                );
                              }
                            }
                          }
                        }
                        return false;
                      },
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          SingleChildScrollView(
                            controller: scrollController,
                            child: ItemsView(
                              isStore: false, items: item, stores: null, noDataText: 'no_category_item_found'.tr,
                            ),
                          ),
                          SingleChildScrollView(
                            controller: storeScrollController,
                            child: ItemsView(
                              isStore: true, items: null, stores: stores,
                              noDataText: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'no_category_restaurant_found'.tr : 'no_category_store_found'.tr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  catController.isLoading ? Center(child: Padding(
                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                    child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
                  )) : const SizedBox(),

                ]),
              )),
            ),
          ) : SizedBox(
            width: Dimensions.webMaxWidth,
            child: Column(children: [
              const SizedBox(height: 10),

              (catController.subCategoryList != null && !catController.isSearching) ? Center(child: Container(
                height: 40, width: Dimensions.webMaxWidth, color: Theme.of(context).cardColor,
                padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
                child: ListView.builder(
                  key: scaffoldKey,
                  scrollDirection: Axis.horizontal,
                  itemCount: catController.subCategoryList!.length,
                  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => catController.setSubCategoryIndex(index, widget.categoryID),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeExtraSmall),
                        margin: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall + 5),
                          color: index == catController.subCategoryIndex ? Theme.of(context).primaryColor   : Colors.transparent,
                        ),
                        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          Text(
                            catController.subCategoryList![index].name!,
                            style: index == catController.subCategoryIndex
                                ? robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).cardColor)
                                : robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          ),
                        ]),
                      ),
                    );
                  },
                ),
              )) : const SizedBox(),

              Center(child: Container(
                width: Dimensions.webMaxWidth,
                color: Theme.of(context).cardColor,
                child: TabBar(
                  controller: _tabController,
                  indicatorColor: Theme.of(context).primaryColor,
                  indicatorWeight: 3,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).disabledColor,
                  unselectedLabelStyle: robotoRegular.copyWith(color: Theme.of(context).disabledColor, fontSize: Dimensions.fontSizeSmall),
                  labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).primaryColor),
                  tabs: [
                    Tab(text: 'item'.tr),
                    Tab(text: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'restaurants'.tr : 'stores'.tr),
                  ],
                ),
              )),


              Expanded(child: NotificationListener(
                onNotification: (dynamic scrollNotification) {
                  if (scrollNotification is ScrollEndNotification) {
                    if((_tabController!.index == 1 && !catController.isStore) || _tabController!.index == 0 && catController.isStore) {
                      catController.setRestaurant(_tabController!.index == 1);
                      if(catController.isSearching) {
                        catController.searchData(
                          catController.searchText, catController.subCategoryIndex == 0 ? widget.categoryID
                            : catController.subCategoryList![catController.subCategoryIndex].id.toString(), catController.type,
                        );
                      }else {
                        if(_tabController!.index == 1) {
                          catController.getCategoryStoreList(
                            catController.subCategoryIndex == 0 ? widget.categoryID
                                : catController.subCategoryList![catController.subCategoryIndex].id.toString(),
                            1, catController.type, false,
                          );
                        }else {
                          catController.getCategoryItemList(
                            catController.subCategoryIndex == 0 ? widget.categoryID
                                : catController.subCategoryList![catController.subCategoryIndex].id.toString(),
                            1, catController.type, false,
                          );
                        }
                      }
                    }
                  }
                  return false;
                },
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    SingleChildScrollView(
                      controller: scrollController,
                      child: ItemsView(
                        isStore: false, items: item, stores: null, noDataText: 'no_category_item_found'.tr,
                      ),
                    ),
                    SingleChildScrollView(
                      controller: storeScrollController,
                      child: ItemsView(
                        isStore: true, items: null, stores: stores,
                        noDataText: Get.find<SplashController>().configModel!.moduleConfig!.module!.showRestaurantText! ? 'no_category_restaurant_found'.tr : 'no_category_store_found'.tr,
                      ),
                    ),
                  ],
                ),
              )),

              catController.isLoading ? Center(child: Padding(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor)),
              )) : const SizedBox(),

            ]),
          ),
           floatingActionButton: GetBuilder<CartController>(builder: (cartController) {
  return 
  
  isgrocery ? Stack(
    children: [
      
    //   Positioned(
    //     bottom: 120,
    //     right: 5,
    //     child:   Container(
    //   width: 60,
    //   height: 60,
    //   decoration: BoxDecoration(
    //     color: const Color.fromARGB(255, 32, 31, 31),
    //     borderRadius: BorderRadius.circular(100),
    //   ),
      
    //   child: FloatingActionButton(
    //     backgroundColor: const Color.fromARGB(255, 32, 31, 31),
    //     onPressed: (){
    //               // showgrocceryMenu(
    //               //    context,
    //               // );
        
    //   },
    //   isExtended: true, 
    //    child: const Icon(Icons.menu_book_sharp,color: Colors.white,size: 30,),
      
    //   ),
    // ) ,
   
    //   ),

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
           bottomNavigationBar: isgrocery ? null : GetBuilder<CartController>(
      builder: (cartController){
        return  cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context)
         ?  BottomCartWidget(
          fromgroccery: true,
         )
         : const SizedBox() ;
      },
    ),
    
        ),
      );
    });
  }
}
