import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';

// class GroccerycategoryView extends StatefulWidget {
//   const GroccerycategoryView({super.key});

//   @override
//   State<GroccerycategoryView> createState() => _FoodcategoryViewState();
// }

// class _FoodcategoryViewState extends State<GroccerycategoryView> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CategoryController>(builder: (categoryController) {

      
//         return (categoryController.categoryList != null && categoryController.categoryList!.isEmpty) ? const SizedBox() :
    
//        Expanded(
//           child: ListView.builder(
//             itemCount: categoryController.categoryList!.length,
//             shrinkWrap: true,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: 8.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         Container(
//                           width: 100,
//                           height: 100,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: DecorationImage(
//                               image: NetworkImage(categoryController.categoryList![index].imageFullUrl!),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         const SizedBox(width: 10),
//                         Text(categoryController.categoryList![index].name!),
//                       ],
//                     ),
//                     const Divider(),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
// });
//       }
    
//   }
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/card_design/item_card.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';


// import 'package:flutter/material.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';
// import 'package:sixam_mart/features/category/controllers/category_controller.dart';
// import 'package:sixam_mart/features/home/widgets/views/Grocceryviews/Groccerwidgets/itemcard.dart';
// import 'package:sixam_mart/features/item/domain/models/item_model.dart';

// class GroceryCategoryView extends StatelessWidget {
//   const GroceryCategoryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: Theme.of(context).disabledColor.withOpacity(0.1),
//       child: GetBuilder<CategoryController>(builder: (categoryController) {
//         if (categoryController.GrocerycategoryList == null ||
//             categoryController.GrocerycategoryList!.isEmpty) {
//           return const Center(child: Text("No categories available"));
//         }

//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               categoryController.GrocerycategoryList!.length,
//               (index) {
//                 final String id = categoryController.GrocerycategoryList![index].id.toString();
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         categoryController.GrocerycategoryList![index].name ?? '',
//                         // style: Theme.of(context).textTheme.headline6,
//                       ),
//                       const SizedBox(height: 8),
//                       SizedBox(
//                         height: 200, // Fixed height for horizontal ListView
//                         child: FutureBuilder(
//                           future: categoryController.categoryitembyId(id, 1, categoryController.type, ),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState == ConnectionState.waiting) {
//                               return const Center(child: CircularProgressIndicator());
//                             } else if (snapshot.hasError) {
//                               return Center(child: Text("Error loading items onnn: ${snapshot.error}"));

//                             }
//                             else if (snapshot.hasData && snapshot.data!.items != null && snapshot.data!.items!.isNotEmpty) {
                              
//                               final items = snapshot.data!.items;
//                             return ListView.builder(
//                               scrollDirection: Axis.horizontal,
//                               itemCount: items!.length,
//                               itemBuilder: (context, itemIndex) {
//                                 Item data = items[itemIndex];
//                                 return ItemCard(item: data, isFood: false, isShop: false);
//                               },
//                             );

//                             } else if (!snapshot.hasData || snapshot.data!.items == null || snapshot.data!.items!.isEmpty) {
//                               return const Center(child: Text("No items available"));
//                             }
                          

//                           return const Center(child: Text("No items availableeeeeeee"));
//                             // Use the actual number of items fetched
//                             // final items = snapshot.data!.items;
//                             // return ListView.builder(
//                             //   scrollDirection: Axis.horizontal,
//                             //   itemCount: items!.length,
//                             //   itemBuilder: (context, itemIndex) {
//                             //     Item data = items[itemIndex];
//                             //     return ItemCard(item: data, isFood: false, isShop: false);
//                             //   },
//                             // );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }



import 'package:sixam_mart/features/category/screens/category_item_screen.dart';
import 'package:sixam_mart/util/dimensions.dart';

import '../../../../../common/widgets/no_data_screen.dart';

// class GroceryCategoryView extends StatelessWidget {
//   const GroceryCategoryView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       color: Theme.of(context).disabledColor.withOpacity(0.1),
//       child: GetBuilder<CategoryController>(builder: (categoryController) {
//         if (categoryController.GrocerycategoryList == null ||
//             categoryController.GrocerycategoryList!.isEmpty) {
//           return const Center(child: Text("No categories available"));
//         }

//         return SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: List.generate(
//               categoryController.GrocerycategoryList!.length,
//               (index) {
//                 final String id = categoryController.GrocerycategoryList![index].id.toString();
//                 return FutureBuilder(
//                   future: categoryController.categoryitembyId(id, 1, categoryController.type),
//                   builder: (context, snapshot) {
//                     // Check for loading state
//                     if (snapshot.connectionState == ConnectionState.waiting) {
//                       return ItemShimmerView(isPopularItem: false, title: '${categoryController.GrocerycategoryList![index].name ?? ''}', );
//                       // Center(child: CircularProgressIndicator());
//                     } else if (snapshot.hasError) {
//                       return const SizedBox.shrink();
                      
//                       // Center(child: Text("Error loading items: ${snapshot.error}"));
//                     } else if (snapshot.hasData && snapshot.data!.items != null && snapshot.data!.items!.isNotEmpty) {
//                       // If there are items, display the category name
//                       return Padding(
//                         padding: const EdgeInsets.only(bottom: 16.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             // Text(
//                             //   categoryController.GrocerycategoryList![index].name ?? '',
//                             //   // style: Theme.of(context).textTheme.headline6,
//                             // ),
//                               Padding(
//             padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
//             child: TitleWidget(
//               title: categoryController.GrocerycategoryList![index].name ?? '',

//               onTap:  (){
//             //     Get.toNamed(RouteHelper.getCategoryItemRoute(
//             // categoryController.GrocerycategoryList![index].id, categoryController.GrocerycategoryList![index].name!,
             

//             //         ));

//             Get.to(CategoryItemScreen(categoryID: id, categoryName: categoryController.GrocerycategoryList![index].name ?? '', fromgroccery: true,));

//               },
//               // image: isPopularItem ? Images.mostPopularIcon : Images.discountOfferIcon,
//             ),
//           ),
//                             const SizedBox(height: 8),
//                             SizedBox(
//                               height: 250, // Fixed height for horizontal L
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                  physics: const BouncingScrollPhysics(),
//                 padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
//                                 itemCount: snapshot.data!.items!.length,
//                                 itemBuilder: (context, itemIndex) {
//                                   Item data = snapshot.data!.items![itemIndex] ;
//                                   return Padding(
//   padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
//                                     child: ItemCard(item: data, isFood: false, isShop: false),
//                                   );
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     } else {
//                       // If there are no items, do not display the category name
//                       return const SizedBox.shrink(); // Return an empty widget
//                     }
//                   },
//                 );
//               },
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }


class GroceryCategoryView extends StatelessWidget {
  const GroceryCategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        if (categoryController.categoryList == null || categoryController.categoryList !.isEmpty) {
          return  NoDataScreen(
            text: "NO DATA",
          );
        }

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              categoryController.categoryList!.length,
              (index) {
                final String id = categoryController.categoryList![index].id.toString();
                
                return FutureBuilder(
                  future: categoryController.categoryitembyId(id, 1, categoryController.type,),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return ItemShimmerView(
                        isPopularItem: false,
                        title: categoryController.categoryList![index].name ?? '',
                      );
                    } else if (snapshot.hasError) {
                      return
                     
                       const SizedBox.shrink();
                    } else if (snapshot.hasData && snapshot.data!.items != null && snapshot.data!.items!.isNotEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                              child: TitleWidget(
                                title: categoryController.categoryList![index].name ?? '',
                                onTap: () {
                                  Get.to(CategoryItemScreen(
                                    categoryID: id,
                                    categoryName: categoryController.categoryList![index].name ?? '',
                                    // fromgroccery: true,
                                  ));
                                },
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              height: 285,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
                                itemCount: snapshot.data!.items!.length,
                                itemBuilder: (context, itemIndex) {
                                  final data = snapshot.data!.items![itemIndex];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: Dimensions.paddingSizeDefault,
                                      right: Dimensions.paddingSizeDefault,
                                      top: Dimensions.paddingSizeDefault,
                                    ),
                                    child: ItemCard(item: data, isFood: false, isShop: false),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                );
              },
            ),
          ),
        );
      }),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:shimmer_animation/shimmer_animation.dart';

// class ItemShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Shimmer(
//       duration: Duration(seconds: 2), // Optional: customize shimmer speed
//       color: Colors.grey[300]!, // Base color
//       colorOpacity: 0.3, // Optional: opacity
//       enabled: true,
//       child: Container(
//         height: 300,
//         margin: const EdgeInsets.all(0),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(10),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 2,
//               blurRadius: 5,
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(height: 26),
//                   _shimmerContainer(180, 20),
//                   _shimmerContainer(50, 20),
//                   _shimmerContainer(150, 30),
//                   _shimmerContainer(80, 20),
//                 ],
//               ),
//             ),
//             Container(width: 150),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _shimmerContainer(double width, double height) {
//     return Container(
//       width: width,
//       height: height,
//       margin: const EdgeInsets.only(bottom: 10, left: 10),
//       decoration: BoxDecoration(
//         color: Colors.grey[300],
//         borderRadius: BorderRadius.circular(3),
//       ),
//     );
//   }
// }



class ItemShimmerView extends StatelessWidget {
  final bool isPopularItem;
  final String title;
  const ItemShimmerView({super.key, required this.isPopularItem, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: Container(
        color: Colors.white,
        //  Theme.of(context).disabledColor.withOpacity(0.1)
         
        child: Column(children: [

          Padding(
            padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
            child: TitleWidget(
              title: title
              // image: isPopularItem ? Images.mostPopularIcon : Images.discountOfferIcon,
            ),
          ),

          SizedBox(
            height: 285, width: Get.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault),
              itemCount: 6,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
                  child: Shimmer(
                    duration: const Duration(seconds: 2),
                    enabled: true,
                    child: Container(
                      height: 285, width: 150,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                      ),
                      child: Column(children: [

                        Container(
                          height: 150, width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left:0, right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeSmall, bottom: Dimensions.paddingSizeSmall),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                            Container(
                              decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                       color: Colors.grey[300],
                                    ),
                              height: 20, width: 100,
                              // color: Colors.grey[300],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Container(
                              decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                       color: Colors.grey[300],
                                    ),
                              height: 15, width: 50,
                              // color: Colors.grey[300],
                            ),
                            const SizedBox(height: Dimensions.paddingSizeSmall),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                       color: Colors.grey[300],
                                    ),
                                  height: 20, width: 50,
                                  // color: Colors.grey[300],
                                ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                       color: Colors.grey[300],
                                    ),
                                  height: 30, width: 80,
                                 
                                ),
                              ],
                            ),

                          ]),
                        ),
                      ]),
                    ),
                  ),
                );
              },
            ),
          ),
        ]),
      ),
    );
  }
}
