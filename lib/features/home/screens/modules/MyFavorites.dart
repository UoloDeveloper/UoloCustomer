import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/common/widgets/custom_app_bar.dart';
import 'package:sixam_mart/common/widgets/item_widget.dart';
import 'package:sixam_mart/common/widgets/no_data_screen.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';


import 'package:sixam_mart/features/home/widgets/web/widgets/store_card_widget.dart';
import 'package:sixam_mart/features/item/controllers/item_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';


// class MyFavorite extends StatefulWidget {
//   const MyFavorite({super.key});

//   @override
//   State<MyFavorite> createState() => _OfferZoneState();
// }

// class _OfferZoneState extends State<MyFavorite> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),

//       body: GetBuilder<StoreController>(builder: (storeController) {
//         List<Store>? stores = storeController.visitAgainStoreList;

//       return ListView.builder(
            
//             itemBuilder: StoreCardWidget2(store:stores![index]));
//         }
//       ),
//     );
//   }
// }

// class MyFavorite extends StatefulWidget {
//   const MyFavorite({super.key});

//   @override
//   State<MyFavorite> createState() => _MyFavoriteState();
// }
//  @override
  
//    bool storeselected = false;




// class _MyFavoriteState extends State<MyFavorite> {
//   @override
//   Widget build(BuildContext context) {

   
//     return Scaffold(
//       appBar: AppBar(),
//       body: Column(
//         children: [
//           // Your row, if needed
//           Row(
//             children: [
//               Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.only(left: 50,right: 30,bottom: 0),
//                   child:InkWell(
//                     onTap: (){
//                       storeselected = true; 
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                        border: Border(
//                           bottom: BorderSide(
//                             color: Colors.black,  
//                             width: 3.0,  
//                           ),
//                         ),
//                       ),
//                       // width: 100,
//                       height: 50,
//                       child:  Center(child: Text("Dishes",
//                        style: TextStyle(
//                         fontSize: 15,
//                         fontWeight: FontWeight.w600,
//                         color: storeselected ? Colors.black :   Color(0xFF505A6E)
//                       ) )),
//                     ),
//                   ),
//                 ),
//               ),
//              Expanded(
//                child:  Padding(
//                   padding: const EdgeInsets.only(left: 30,right: 50),
//                   child:InkWell(
//                     onTap: () {
//                         storeselected = false;
//                     },
//                     child: Container(
//                       decoration: BoxDecoration(
//                        border: Border(
//                           bottom: BorderSide(
//                             color: Color(0xFFFF5200)
//                     ,
//                             width: 5.0,  
//                           ),
//                         ),
//                       ),
//                     // width: 100,
//                     height: 50,
//                       child:  Center(child: Text("Restaurants",
//                       style: TextStyle( 
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                         color: storeselected ?  Color(0xFF505A6E): Colors.black
//                       ) 
//                       ,)),  
//                     ),
//                   ),
//                ),
//              ),
//             ],
//           ),
//           Divider(thickness: 1,height: 0,),
//           // Expanded ListView to avoid unbounded height issues
//           Expanded(
//             child: GetBuilder<ItemController>(builder: (itemController) {
//                 return GetBuilder<StoreController>(builder: (storeController) {
//                   List<Store>? stores = storeController.visitAgainStoreList;
//                   List<Item>? items = itemController.reviewedItemList;
                  
//                   // Ensure stores list is not null or empty
//                   if (stores == null || stores.isEmpty) {
//                     return const Center(child: Text('No stores available.'));
//                   }
                
//                   // Use ListView.builder with proper constraints
//                   return ListView.builder(
//                     itemCount: stores.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return  ItemWidget(item: items![index], isStore: false, store: stores[index], index: index, length: items.length);
//                       //  StoreCardWidget2(store: stores[index]); // Build each store card
//                     },
//                   );
//                 });
//               }
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class MyFavorite extends StatefulWidget {
//   const MyFavorite({super.key});

//   @override
//   State<MyFavorite> createState() => _MyFavoriteState();
// }

// class _MyFavoriteState extends State<MyFavorite> {
//   bool storeselected = false; 

//   @override
//   void initState() {
//     super.initState();
//     storeselected = false; // Initialize it to false in initState
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: CustomAppBar(title: 'My Favorites',showCart: true,),
//       body: Column(
//         children: [
//           // Your row, if needed
//           Row(
//             children: [
//               Expanded(
//                 child: InkWell(
//                             splashColor: Colors.transparent,
//                   overlayColor: MaterialStateProperty.all(Colors.transparent),
//                   onTap: () {
//                     setState(() {
//                       storeselected = true; // Update state and rebuild
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
                    
//                       border: Border(
//                         bottom: BorderSide(
//                           color: storeselected ? Color(0xFFFF5200) :Colors.transparent  ,
//                           width: 5.0,
//                         ),
//                       ),
                      
//                     ),
//                     height: 30,
//                     child: Center(
//                       child: Text(
//                         "Dishes",
//                         style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                           color: storeselected ? Colors.black : Color(0xFF505A6E),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: InkWell(
//                             splashColor: Colors.transparent,
//                   overlayColor: MaterialStateProperty.all(Colors.transparent),
//                   onTap: () {
                
//                     setState(() {
//                       storeselected = false; // Update state and rebuild
//                     });
//                   },
//                   child: Container(
//                     decoration: BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: storeselected ? Colors.transparent : Color(0xFFFF5200)  ,
//                           width: 5.0,
//                         ),
//                       ),
//                     ),
//                     height: 30,
//                     child: Center(
//                       child: Text(
//                         "Restaurants",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                           color: storeselected ? Color(0xFF505A6E) : Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Divider(thickness: 1, height: 0),
//           // Expanded ListView to avoid unbounded height issues
//           Expanded(
//             child: GetBuilder<ItemController>(builder: (itemController) {
//               return GetBuilder<StoreController>(builder: (storeController) {
//                 List<Store>? stores = storeController.visitAgainStoreList;
//                 List<Item>? items = itemController.reviewedItemList;

//                 // Ensure stores list is not null or empty
//                 if (stores == null || stores.isEmpty) {
//                   return const Center(child:  NoDataScreen(text: 'No Data.'));
//                 }

//                 // Use ListView.builder with proper constraints
//                 return ListView.builder(
//                   itemCount: stores.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return  storeselected ? ItemWidget(
//                       item:  items![index],
//                       isStore: false,
//                       store: stores[index],
//                       index: index,
//                       length: items.length,
//                     ) : StoreCardWidget2(store: stores[index]);
//                   },
//                 );
//               });
//             }),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:get/get.dart';
import 'package:sixam_mart/features/store/widgets/bottom_cart_widget.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class MyFavorite extends StatefulWidget {
  const MyFavorite({super.key});

  @override
  State<MyFavorite> createState() => _MyFavoriteState();
}

class _MyFavoriteState extends State<MyFavorite> with SingleTickerProviderStateMixin {
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
      appBar: const CustomAppBar(title: 'My Favorites', showCart: false),
      body: Column(
        children: [
          // TabBar with Dishes and Restaurants
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
              Tab(text: "  Dishes  "),
              Tab(text: "  Restaurants  "),
            ],
          ),
          // Divider(thickness: 0, height: 0),
          // Expanded TabBarView to display content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Dishes Tab
                GetBuilder<FavouriteController>(builder: (favouriteController) {
                  List<Item?>? items = favouriteController.wishItemList;

                  if (items == null || items.isEmpty) {
                    return const Center(child: NoDataScreen(text: 'No Data.'));
                  }

                  return ListView.separated(
                    itemCount: items.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 200,
                        child: ItemWidget(
                          item: items[index],
                          isStore: false,
                          store: null,
                          index: index,
                          length: items.length,
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) { 
                      return Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: const Divider(),
                      );
                     },
                  );
                }),
                // Restaurants Tab
              GetBuilder<FavouriteController>(builder: (favouriteController) {
                  List<Store?>? stores = favouriteController.wishStoreList;

                  if (stores == null || stores.isEmpty) {
                    return const Center(child: NoDataScreen(text: 'No Data.'));
                  }

                  return ListView.separated(
                    itemCount: stores.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        height: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: StoreCardWidget2(store: stores[index]),
                        ),
                      );
                    }, separatorBuilder: (BuildContext context, int index) { 
                      return Padding(
                         padding: const EdgeInsets.only(left: 10,right: 10),
                        
                        child: const Divider(),
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
           ?  BottomCartWidget(
            // fromgroccery: true,
           )
           : const SizedBox();
  },
)
    );
  }
}
