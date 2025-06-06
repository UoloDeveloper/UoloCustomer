





import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/home/widgets/web/widgets/store_card_widget.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/widgets/bottom_cart_widget.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';



import 'package:get/get.dart';

class Popular extends StatefulWidget {
  const Popular({super.key});

  @override
  State<Popular> createState() => _PopularState();
}

class _PopularState extends State<Popular> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Popular',
        showCart: false,
      ),
      body: Column(
        children: [
          // TabBar for Dishes and Restaurants
          TabBar(
             overlayColor: WidgetStateProperty.all(Colors.transparent),
            controller: _tabController,
                          indicatorColor: Theme.of(context).primaryColor,
                          indicatorWeight: 3,
                          labelColor: Theme.of(context).primaryColor,
                          unselectedLabelColor: Theme.of(context).disabledColor,
                          unselectedLabelStyle: robotoRegular.copyWith(color: const Color(0xFF505A6E), fontSize: Dimensions.fontSizeLarge),
                          labelStyle: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge, color: Theme.of(context).primaryColor),
            tabs: const [
              Tab(text: '  Dishes  '),
              Tab(text: '  Restaurants  '),
            ],
          ),
          // Divider(thickness: 1, height: 0),
          
          // TabBarView to display respective content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Dishes Tab
                GetBuilder<ItemController>(builder: (itemController) {
                  List<Item>? items = itemController.popularItemList;

                  if (items == null || items.isEmpty) {
                    return const Center(child: NoDataScreen(text: 'No Data.'));
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: const Divider(
                        
                      ),
                    ),
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: ItemWidget(
                          item: items[index],
                          isStore: false,
                          store: null,
                          index: index,
                          length: items.length,
                        ),
                      );
                    },
                  );
                }),

                
                GetBuilder<StoreController>(builder: (storeController) {
                  List<Store>? stores = storeController.popularStoreList;

                  if (stores == null || stores.isEmpty) {
                    return const Center(child: NoDataScreen(text: 'No Data.'));
                  }

                  return ListView.separated(
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Divider(),
                    ),
                    itemCount: stores.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          height: 180,
                          child: StoreCardWidget2(store: stores[index])),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ],
      ),
         bottomNavigationBar: GetBuilder<CartController>(
  builder: (cartController){
    return cartController.cartList.isNotEmpty && !ResponsiveHelper.isDesktop(context)
           ? BottomCartWidget(
            // fromgroccery: true,
           )
           : const SizedBox();
  },
)
    );
  }
}
