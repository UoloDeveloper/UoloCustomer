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


import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/home/widgets/views/Grocceryitemsview.dart';

import 'package:sixam_mart/features/item/domain/models/item_model.dart';

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
//           child:  Column(
//             children: [
//               ListView.builder(
//                               itemCount:categoryController.GrocerycategoritemyList!.length ,
//                               itemBuilder: (context, itemIndex) {
                              
//                               // final Item data = categoryController.GrocerycategoryList![index].items![itemIndex];
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                    Text(
//                             categoryController.GrocerycategoryList![itemIndex].name ?? '',
//                             // style: Theme.of(context).textTheme.headline6,
//                           ),
//                                   SizedBox(
//                                     height: 200,
//                                     child: Grocceyitemdata(items: categoryController.GrocerycategoritemyList[itemIndex],)),
//                                 ],
//                               );
                              
                            
//                             }),
//             ],
//           )
          
       
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
      color: Theme.of(context).disabledColor.withOpacity(0.1),
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        // Check if the grocery category list is null or empty
        if (categoryController.GrocerycategoryList == null ||
            categoryController.GrocerycategoryList!.isEmpty) {
          return const Center(child: Text("No categories available"));
        }

    //  categoryController.GrocerycategoritemyList!.removeWhere((element) => element.);
      
        return categoryController.isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Use a ListView.builder with a fixed height
              SizedBox(
                // height: 300, // Set a fixed height for the ListView
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  
                  itemCount: categoryController.GrocerycategoritemyList!.length,
                  itemBuilder: (context, itemIndex) {
                     ItemModel? category = categoryController.GrocerycategoritemyList![itemIndex];
                    
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text(
                        //   category!.items![0].name ?? '',
                        //   // style: Theme.of(context).textTheme.headline,
                        // ),
                        SizedBox(
                          // height: 300,
                          child: Grocceyitemdata(items: category, name: categoryController.GrocerycategoryList![itemIndex].name , ), // Ensure items is not null
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}