import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/common/widgets/card_design/item_card.dart';
import 'package:sixam_mart/common/widgets/custom_divider%20copy.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';

class Grocceyitemdata extends StatefulWidget {
  final ItemModel? items;
  final String? name;
  // final CategoryController categoryController;
   final int? id;
  const Grocceyitemdata({super.key, required this.items, required this.name, this.id,});

  @override
  State<Grocceyitemdata> createState() => _GrocceyitemdataState();
}
  // final   List<Item>? itemdata = [];

    // fetchdata () async {
    //                final ItemModel? itemdatas = await  categoryController.categoryitembyId(
    //     // id, // Use the id passed to the widget
    //     // 1,
    //     // categoryController.type,
    //   );
    //          if (itemdatas != Null) {
    //             itemdata!.addAll(itemdatas!.items!);
    //               // return const SizedBox.shrink();


    //          }

    //             }
class _GrocceyitemdataState extends State<Grocceyitemdata> {
  @override
  Widget build(BuildContext context) {
    return  widget.items!.items!.isEmpty ? const SizedBox.shrink() :  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(widget.name ?? '' ,),
          Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, left: Dimensions.paddingSizeDefault, right: Dimensions.paddingSizeDefault),
              child: TitleWidget(
                title: widget.name ?? '' ,
                // image: Images.discountOfferIcon,
                onTap: () {
                  //  if(index == 9 && categoryController.categoryList!.length > 10) {
                  //               Get.toNamed(RouteHelper.getCategoryRoute());
                  //             } else {
                  //               Get.toNamed(RouteHelper.getCategoryItemRoute(
                  //                 categoryController.categoryList![index].id, categoryController.categoryList![index].name!,
                  //               ));
                  //             }

                     Get.toNamed(RouteHelper.getCategoryItemRoute(
                                  widget.id  , widget.name!,
                                ));
                }
                
                //  Get.toNamed(RouteHelper.getPopularItemRoute(false, true)),
              ),
            )
        //  Padding(
        //         padding:  EdgeInsets.only(left: 10,),
        //         child: CustomDivider1(text: widget.name ?? ''.toUpperCase(),thickness: .2,textAlign: TextAlign.left,color:  Colors.black,fontsize: 16,),
                
        //         //  TitleWidget(
        //         //   title: 'Newly Added'.tr,
        //         //   onTap: () => Get.toNamed(RouteHelper.getAllStoreRoute('latest')),
        //         // ),
        //       ),,
        ,
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: widget.items!.items!.length,
            shrinkWrap: true,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (widget.items!.items!.isEmpty) {
                return const SizedBox.shrink();
              }
              return   Padding(
                padding: const EdgeInsets.all(8.0),
                child: ItemCard(item: widget.items!.items![index], isFood: false, isShop: false),
              );
            }
          ),
        ),
      ],
    );
  }
}

