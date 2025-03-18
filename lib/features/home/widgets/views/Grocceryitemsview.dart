import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sixam_mart/common/widgets/card_design/item_card.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';

class Grocceyitemdata extends StatefulWidget {
  final ItemModel? items;
  final String? name;
  // final CategoryController categoryController;
  const Grocceyitemdata({super.key, required this.items, required this.name,});

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
        Text(widget.name ?? '' ,),
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

