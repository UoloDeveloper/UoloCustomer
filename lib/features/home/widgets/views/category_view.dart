import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/language/controllers/language_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/home/widgets/category_pop_up.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:get/get.dart';


class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return GetBuilder<SplashController>(builder: (splashController) {
      bool isPharmacy = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.pharmacy;
      bool isFood = splashController.module != null && splashController.module!.moduleType.toString() == AppConstants.food;

      return GetBuilder<CategoryController>(builder: (categoryController) {
        return (categoryController.categoryList != null && categoryController.categoryList!.isEmpty)
        ? const SizedBox() : isPharmacy ? PharmacyCategoryView(categoryController: categoryController)
          : isFood ? FoodCategoryView(categoryController: categoryController) : Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 158,
                    child: categoryController.categoryList != null ? ListView.builder(
                      controller: scrollController,
                      itemCount: categoryController.categoryList!.length > 10 ? 10 : categoryController.categoryList!.length,
                      padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
                          child: InkWell(
                            onTap: () {
                              if(index == 9 && categoryController.categoryList!.length > 10) {
                                Get.toNamed(RouteHelper.getCategoryRoute());
                              } else {
                                Get.toNamed(RouteHelper.getCategoryItemRoute(
                                  categoryController.categoryList![index].id, categoryController.categoryList![index].name!,
                                ));
                              }
                            },
                            child: SizedBox(
                              width: 80,
                              child: Column(children: [
                                SizedBox(
                                  height: 75, width: 75,
                                  child: Stack(children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                      child: CustomImage(
                                        image: '${categoryController.categoryList![index].imageFullUrl}',
                                        height: 75, width: 75, fit: BoxFit.cover,
                                      ),
                                    ),

                                    (index == 9 && categoryController.categoryList!.length > 10) ? Positioned(
                                      right: 0, left: 0, top: 0, bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                          gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Theme.of(context).primaryColor.withOpacity(0.4),
                                              Theme.of(context).primaryColor.withOpacity(0.6),
                                              Theme.of(context).primaryColor.withOpacity(0.4),
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            '+${categoryController.categoryList!.length - 15}',
                                            style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
                                            maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                          ),
                                        )
                                      ),
                                    ) : const SizedBox(),

                                  ]),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeExtraSmall),

                                Padding(
                                  padding: EdgeInsets.only(right: index == 0 ? Dimensions.paddingSizeExtraSmall : 0),
                                  child: Text(
                                    (index == 9 && categoryController.categoryList!.length > 10) ? 'see_all'.tr : categoryController.categoryList![index].name!,
                                    style: robotoMedium.copyWith(fontSize: 11, color: (index == 9 && categoryController.categoryList!.length > 10) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color),
                                    maxLines: Get.find<LocalizationController>().isLtr ? 2 : 1, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                                  ),
                                ),

                              ]),
                            ),
                          ),
                        );
                      },
                    ) : CategoryShimmer(categoryController: categoryController),
                  ),
                ),

                ResponsiveHelper.isMobile(context) ? const SizedBox() : categoryController.categoryList != null ? Column(
                  children: [
                    InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (con) => Dialog(child: SizedBox(height: 550, width: 600, child: CategoryPopUp(
                          categoryController: categoryController,
                        ))));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Text('view_all'.tr, style: TextStyle(fontSize: Dimensions.paddingSizeDefault, color: Theme.of(context).cardColor)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,)
                  ],
                ): CategoryShimmer(categoryController: categoryController),
              ],
            ),

          ],
        );
      });
    }
    );
  }
}
    

    
class PharmacyCategoryView extends StatelessWidget {
  final CategoryController categoryController;
  const PharmacyCategoryView({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
        height: 160,
        child: categoryController.categoryList != null ? ListView.builder(
          controller: scrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
          itemCount: categoryController.categoryList!.length > 10 ? 10 : categoryController.categoryList!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
              child: InkWell(
                onTap: () {
                  if(index == 9 && categoryController.categoryList!.length > 10) {
                    Get.toNamed(RouteHelper.getCategoryRoute());
                  } else {
                    Get.toNamed(RouteHelper.getCategoryItemRoute(
                      categoryController.categoryList![index].id, categoryController.categoryList![index].name!,
                    ));
                  }
                },
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                child: Container(
                  width: 70,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).primaryColor.withOpacity(0.3),
                        Theme.of(context).cardColor.withOpacity(0.3),
                      ],
                    ),
                  ),
                  child: Column(children: [

                    Stack(
                      children: [

                        ClipRRect(
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                          child: CustomImage(
                            image: '${categoryController.categoryList![index].imageFullUrl}',
                            height: 40, width: double.infinity, fit: BoxFit.cover,
                          ),
                        ),

                        (index == 9 && categoryController.categoryList!.length > 10) ? Positioned(
                          right: 0, left: 0, top: 0, bottom: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Theme.of(context).primaryColor.withOpacity(0.4),
                                  Theme.of(context).primaryColor.withOpacity(0.6),
                                  Theme.of(context).primaryColor.withOpacity(0.4),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Text(
                                '+${categoryController.categoryList!.length - 10}',
                                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
                                maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                              ),
                            )
                          ),
                        ) : const SizedBox(),
                      ],
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),

                    Expanded(child: Text(
                      (index == 9 && categoryController.categoryList!.length > 10) ? 'see_all'.tr :  categoryController.categoryList![index].name!,
                      style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,
                      color: (index == 9 && categoryController.categoryList!.length > 10) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color),
                      maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                    )),
                  ]),
                ),
              ),
            );
          },
        ) : PharmacyCategoryShimmer(categoryController: categoryController),
      ),
    ]);
  }
}

// class FoodCategoryView extends StatelessWidget {
//   final CategoryController categoryController;
//   const FoodCategoryView({super.key, required this.categoryController});

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController scrollController = ScrollController();
//     return Stack(children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         SizedBox(
//           height: 160,
//           child: categoryController.categoryList != null ? ListView.builder(
//             controller: scrollController,
//             physics: const BouncingScrollPhysics(),
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
//             itemCount: categoryController.categoryList!.length > 10 ? 10 : categoryController.categoryList!.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
//                 child: InkWell(
//                   onTap: () {
//                     if(index == 9 && categoryController.categoryList!.length > 10) {
//                       Get.toNamed(RouteHelper.getCategoryRoute());
//                     } else {
//                       Get.toNamed(RouteHelper.getCategoryItemRoute(
//                         categoryController.categoryList![index].id, categoryController.categoryList![index].name!,
//                       ));
//                     }
//                   },
//                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                   child: SizedBox(
//                     width: 40,
//                     child: Column(children: [

//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.all(Radius.circular(100)),
//                             child: CustomImage(
//                               image: '${categoryController.categoryList![index].imageFullUrl}',
//                               height: 40, width: double.infinity, fit: BoxFit.cover,
//                             ),
//                           ),

//                           (index == 9 && categoryController.categoryList!.length > 10) ? Positioned(
//                             right: 0, left: 0, top: 0, bottom: 0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(Radius.circular(100)),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Theme.of(context).primaryColor.withOpacity(0.4),
//                                     Theme.of(context).primaryColor.withOpacity(0.6),
//                                     Theme.of(context).primaryColor.withOpacity(0.4),
//                                   ],
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '+${categoryController.categoryList!.length - 10}',
//                                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
//                                   maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
//                                 ),
//                               )
//                             ),
//                           ) : const SizedBox(),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),

//                       Expanded(child: Text(
//                         (index == 9 && categoryController.categoryList!.length > 10) ?  'see_all'.tr : categoryController.categoryList![index].name ?? '',
//                         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: (index == 9 && categoryController.categoryList!.length > 10) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color),
//                         maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
//                       )),
//                     ]),
//                   ),
//                 ),
//               );
//             },
//           ) : FoodCategoryShimmer(categoryController: categoryController),
//         ),
//       ]),

//     ]);
//   }
// }



// class FoodCategoryView extends StatelessWidget {
//   final CategoryController categoryController;
//   const FoodCategoryView({super.key, required this.categoryController});

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController scrollController = ScrollController();
//     return Stack(children: [
//       Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         SizedBox(
//           height: 160,
//           child: categoryController.categoryList != null ? ListView.builder(
//             controller: scrollController,
//             physics: const BouncingScrollPhysics(),
//             shrinkWrap: true,
//             scrollDirection: Axis.horizontal,
//             padding: const EdgeInsets.only(left: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
//             itemCount: categoryController.categoryList!.length > 10 ? 10 : categoryController.categoryList!.length,
//             itemBuilder: (context, index) {
//               return Padding(
//                 padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
//                 child: InkWell(
//                   onTap: () {
//                     if(index == 9 && categoryController.categoryList!.length > 10) {
//                       Get.toNamed(RouteHelper.getCategoryRoute());
//                     } else {
//                       Get.toNamed(RouteHelper.getCategoryItemRoute(
//                         categoryController.categoryList![index].id, categoryController.categoryList![index].name!,
//                       ));
//                     }
//                   },
//                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                   child: SizedBox(
//                     width: 40,
//                     child: Column(children: [

//                       Stack(
//                         children: [
//                           ClipRRect(
//                             borderRadius: const BorderRadius.all(Radius.circular(100)),
//                             child: CustomImage(
//                               image: '${categoryController.categoryList![index].imageFullUrl}',
//                               height: 40, width: double.infinity, fit: BoxFit.cover,
//                             ),
//                           ),

//                           (index == 9 && categoryController.categoryList!.length > 10) ? Positioned(
//                             right: 0, left: 0, top: 0, bottom: 0,
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: const BorderRadius.all(Radius.circular(100)),
//                                 gradient: LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [
//                                     Theme.of(context).primaryColor.withOpacity(0.4),
//                                     Theme.of(context).primaryColor.withOpacity(0.6),
//                                     Theme.of(context).primaryColor.withOpacity(0.4),
//                                   ],
//                                 ),
//                               ),
//                               child: Center(
//                                 child: Text(
//                                   '+${categoryController.categoryList!.length - 10}',
//                                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Theme.of(context).cardColor),
//                                   maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
//                                 ),
//                               )
//                             ),
//                           ) : const SizedBox(),
//                         ],
//                       ),
//                       const SizedBox(height: Dimensions.paddingSizeSmall),

//                       Expanded(child: Text(
//                         (index == 9 && categoryController.categoryList!.length > 10) ?  'see_all'.tr : categoryController.categoryList![index].name ?? '',
//                         style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall, color: (index == 9 && categoryController.categoryList!.length > 10) ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color),
//                         maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
//                       )),
//                     ]),
//                   ),
//                 ),
//               );
//             },
//           ) : FoodCategoryShimmer(categoryController: categoryController),
//         ),
//       ]),

//     ]);
//   }
// }

// class FoodCategoryView extends StatelessWidget {
//   final CategoryController categoryController;
//   const FoodCategoryView({super.key, required this.categoryController});

//   @override
//   Widget build(BuildContext context) {
//     final ScrollController scrollController = ScrollController();
//     return Padding(
//       padding: const EdgeInsets.only(left: 10),
//       child: Stack(
//         children: [
//           SizedBox(
//             height: 280, // Adjust height for two rows
//             child: categoryController.categoryList != null
//                 ? GridView.builder(
//                     controller: scrollController,
//                     physics: const BouncingScrollPhysics(),
//                     shrinkWrap: true,
//                     scrollDirection: Axis.horizontal,
//                     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2, // 2 rows
//                       crossAxisSpacing: Dimensions.paddingSizeDefault-15,
//                       mainAxisSpacing: Dimensions.paddingSizeDefault-15,
//                       childAspectRatio: 1.2, // Adjust aspect ratio to control item shape
//                     ),
//                     padding:  EdgeInsets.only(
//                         left: Dimensions.paddingSizeDefault -15,
//                         top:    MediaQuery.of(context).size.height * 0.01, ),
//                     itemCount: categoryController.categoryList!.length > 10
//                         ? 40
//                         : categoryController.categoryList!.length,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                         padding: const EdgeInsets.only(
//                             right: Dimensions.paddingSizeDefault),
//                         child: InkWell(
//                           overlayColor: WidgetStateColor.transparent ,
//                           onTap: () {
//                             if (index == 39 &&
//                                 categoryController.categoryList!.length > 40) {
//                               Get.toNamed(RouteHelper.getCategoryRoute());
//                             } else {
//                               Get.toNamed(RouteHelper.getCategoryItemRoute(
//                                 categoryController.categoryList![index].id,
//                                 categoryController.categoryList![index].name!,
//                               ));
//                             }
//                           },
//                           borderRadius:
//                               BorderRadius.circular(Dimensions.radiusSmall),
//                           child: Column(children: [
//                             Stack(
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: const BorderRadius.all(
//                                       Radius.circular(100)),
//                                   child: CustomImage(
//                                     image:
//                                         '${categoryController.categoryList![index].imageFullUrl}',
//                                     height: 110,
//                                     width: 110,
//                                     fit: BoxFit.cover,
//                                   ),
//                                 ),
//                                 (index == 39 &&
//                                         categoryController.categoryList!.length >
//                                             40)
//                                     ? Positioned(
//                                         right: 0,
//                                         left: 0,
//                                         top: 0,
//                                         bottom: 0,
//                                         child: Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                                   const BorderRadius.all(
//                                                       Radius.circular(100)),
//                                               gradient: LinearGradient(
//                                                 begin: Alignment.topCenter,
//                                                 end: Alignment.bottomCenter,
//                                                 colors: [
//                                                   Theme.of(context)
//                                                       .primaryColor
//                                                       .withOpacity(0.4),
//                                                   Theme.of(context)
//                                                       .primaryColor
//                                                       .withOpacity(0.6),
//                                                   Theme.of(context)
//                                                       .primaryColor
//                                                       .withOpacity(0.4),
//                                                 ],
//                                               ),
//                                             ),
//                                             child: Center(
//                                               child: Text(
//                                                 '+${categoryController.categoryList!.length - 40}',
//                                                 style: robotoMedium.copyWith(
//                                                     fontSize: Dimensions
//                                                         .fontSizeExtraLarge,
//                                                     color: Theme.of(context)
//                                                         .cardColor),
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 textAlign: TextAlign.center,
//                                               ),
//                                             )),
//                                       )
//                                     : const SizedBox(),
//                               ],
//                             ),
//                             const SizedBox(height: Dimensions.paddingSizeSmall),
//                             Expanded(
//                               child: Text(
//                                 (index == 39 &&
//                                         categoryController.categoryList!.length >
//                                             40)
//                                     ? 'see_all'.tr
//                                     : categoryController.categoryList![index]
//                                             .name ??
//                                         '',
//                                 style: robotoMedium.copyWith(
//                                   fontSize: Dimensions.fontSizeSmall,
//                                   color: (index == 39 &&
//                                           categoryController
//                                                   .categoryList!.length >
//                                               40)
//                                       ? Theme.of(context).primaryColor
//                                       : Theme.of(context)
//                                           .textTheme
//                                           .bodyMedium!
//                                           .color,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ]),
//                         ),
//                       );
//                     },
//                   )
//                 : FoodCategoryShimmer(categoryController: categoryController),
//           ),
//         ],
//       ),
//     );
//   }
// } 

// class CategoryShimmer extends StatelessWidget {
//   final CategoryController categoryController;
//   const CategoryShimmer({super.key, required this.categoryController});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: 8,
//       padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeDefault),
//       physics: const NeverScrollableScrollPhysics(),
//       scrollDirection: Axis.horizontal,
//       itemBuilder: (context, index) {
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 1, vertical: Dimensions.paddingSizeDefault),
//           child: Shimmer(
//             duration: const Duration(seconds: 2),
//             enabled: true,
//             child: SizedBox(
//               width: 80,
//               child: Column(children: [
//                 Container(
//                   height: 75, width: 75,
//                   margin: EdgeInsets.only(
//                     left: index == 0 ? 0 : Dimensions.paddingSizeExtraSmall,
//                     right: Dimensions.paddingSizeExtraSmall,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                     color: Colors.grey[300],
//                   )
//                 ),
//                 const SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                 Padding(
//                   padding: EdgeInsets.only(right: index == 0 ? Dimensions.paddingSizeExtraSmall : 0),
//                   child: Container(
//                     height: 10, width: 50,
//                     color: Colors.grey[300],
//                   ),
//                 ),

//               ]),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class FoodCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const FoodCategoryShimmer({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: SizedBox(
              width: 80,
              child: Column(children: [

                Container(
                  height: 80, width: double.infinity,
                  margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    color: Colors.grey[300],
                  )
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Container(
                  decoration: BoxDecoration(
                     color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                  height: 80, width: 80,
                 
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}


class FoodCategoryView extends StatelessWidget {
  final CategoryController categoryController;
  const FoodCategoryView({Key? key, required this.categoryController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Stack(
        children: [
          SizedBox(
            height: 260, // Adjusted height for two rows
            child: categoryController.categoryList != null
                ? GridView.builder(
                    controller: scrollController,
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Two rows
                      crossAxisSpacing: 1,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.4, // Adjusted for better alignment
                    ),
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    itemCount: categoryController.categoryList!.length > 10
                        ? 40
                        : categoryController.categoryList!.length,
                    itemBuilder: (context, index) {
                      final isSeeAll = index == 39 && categoryController.categoryList!.length > 40;
                      final category = categoryController.categoryList![index];

                      return InkWell(
                        overlayColor: MaterialStateProperty.all(Colors.transparent),
                        onTap: () {
                          if (isSeeAll) {
                            Get.toNamed(RouteHelper.getCategoryRoute());
                          } else {
                            Get.toNamed(
                              RouteHelper.getCategoryItemRoute(category.id, category.name!),
                            );
                          }
                        },
                        borderRadius: BorderRadius.circular(50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                ClipOval(
                                  child: CustomImage(
                                    image: '${category.imageFullUrl}',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (isSeeAll)
                                  Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Theme.of(context).primaryColor.withOpacity(0.4),
                                          Theme.of(context).primaryColor.withOpacity(0.6),
                                        ],
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '+${categoryController.categoryList!.length - 40}',
                                        style: robotoMedium.copyWith(
                                          fontSize: Dimensions.fontSizeExtraLarge,
                                          color: Theme.of(context).cardColor,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isSeeAll ? 'see_all'.tr : category.name ?? '',
                              style: robotoMedium.copyWith(
                                fontSize: Dimensions.fontSizeSmall +2,
                                color: isSeeAll
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).textTheme.bodyMedium?.color,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : FoodCategoryShimmer(categoryController: categoryController),
          ),
        ],
      ),
    );
  }
}

class PharmacyCategoryShimmer extends StatelessWidget {
  final CategoryController categoryController;
  const PharmacyCategoryShimmer({super.key, required this.categoryController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, top: Dimensions.paddingSizeDefault),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            enabled: true,
            child: Container(
              width: 70,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
              ),
              child: Column(children: [

                Container(
                  height: 40, width: double.infinity,
                  margin: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100), topRight: Radius.circular(100)),
                    color: Colors.grey[300],
                  )
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),

                Expanded(
                  child: Container(
                    height: 10, width: 50,
                    color: Colors.grey[300],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    );
  }
}