import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';

class GroccerycategoryView extends StatefulWidget {
  const GroccerycategoryView({super.key});

  @override
  State<GroccerycategoryView> createState() => _FoodcategoryViewState();
}

class _FoodcategoryViewState extends State<GroccerycategoryView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CategoryController>(builder: (categoryController) {

      
        return (categoryController.categoryList != null && categoryController.categoryList!.isEmpty) ? const SizedBox() :
    
       Expanded(
          child: ListView.builder(
            itemCount: categoryController.categoryList!.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(categoryController.categoryList![index].imageFullUrl!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(categoryController.categoryList![index].name!),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        );
});
      }
    
  }
