import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sixam_mart/features/category/controllers/category_controller.dart';
import 'package:sixam_mart/features/item/domain/models/item_model.dart';

// class Grocceyitemdata extends StatefulWidget {
//   final List<Item>? items;
//   final CategoryController categoryController;
//   const Grocceyitemdata({super.key, required this.items, required this.categoryController});

//   @override
//   State<Grocceyitemdata> createState() => _GrocceyitemdataState();
// }
//   final   List<Item>? itemdata = [];

//     fetchdata () async {
//                    final ItemModel? itemdatas = await  categoryController.categoryitembyId(
//         id, // Use the id passed to the widget
//         1,
//         categoryController.type,
//       );
//              if (itemdatas != Null) {
//                 itemdata!.addAll(itemdatas!.items!);
//                   // return const SizedBox.shrink();


//              }

//                 }
// class _GrocceyitemdataState extends State<Grocceyitemdata> {
//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: widget.items!.length,
//         shrinkWrap: true,
//         physics: AlwaysScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return   Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                    color: Colors.red,
//                 // color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//             ),
//           );
//         }
//       ),
//     );
//   }
// }



// class Grocceyitemdata extends StatefulWidget {
//   final String id; 
//   final  CategoryController categoryController;
//   const Grocceyitemdata({super.key, required this.id, required this.categoryController});

//   @override
//   State<Grocceyitemdata> createState() => _GrocceyitemdataState();
// }

// class _GrocceyitemdataState extends State<Grocceyitemdata> {
//   List<Item>? items; // Store the fetched items here
//   bool isLoading = true; // Track loading state
//   String? errorMessage; // Store error messages

//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch data when the widget is initialized
//   }

//   // Future<void> fetchData() async {
//   //   try {
//   //     // Call the asynchronous function to get the category items

//   //     if (items == null) {

//   //      // Do not fetch again if items are already fetched
        
      
//   //     final ItemModel? itemdatas = await widget. categoryController.categoryitembyId(
//   //       widget.id, // Use the id passed to the widget
//   //       1,
//   //      widget.categoryController.type,
//   //     );

//   //     // Check if itemdatas is not null and contains items
//   //     if (itemdatas != null && itemdatas.items != null && itemdatas.items!.isNotEmpty) {
//   //       setState(() {
//   //         items = itemdatas.items; // Update the items list
//   //         isLoading = false; // Set loading to false
//   //       });
//   //     } else {
//   //       setState(() {
//   //         errorMessage = 'No items found for category ID ${widget.id}';
//   //         isLoading = false;
//   //       });
//   //     }
//   //   } else {
//   //     setState(() {
//   //       isLoading = false;
//   //     }); 
//   //   }

//   //   } catch (e) {
//   //     // Handle any exceptions that occur during the fetch
//   //     setState(() {
//   //       errorMessage = 'Failed to fetch data: $e';
//   //       isLoading = false;
//   //     });
//   //   }
//   // }
// Future<void> fetchData() async {
//   // Only fetch data if items is null
//   if (items == null) {
//     try {
//       final ItemModel? itemdatas = await widget.categoryController.categoryitembyId(
//         widget.id, // Use the id passed to the widget
//         1,
//         widget.categoryController.type,
//       );

//       // Check if itemdatas is not null and contains items
//       if (itemdatas != null && itemdatas.items != null && itemdatas.items!.isNotEmpty) {
//         setState(() {
//           items = itemdatas.items; // Update the items list
//           isLoading = false; // Set loading to false
//         });
//       } else {
//         setState(() {
//           errorMessage = 'No items found for category ID ${widget.id}';
//           isLoading = false;
//         });
//       }
//     } catch (e) {
//       // Handle any exceptions that occur during the fetch
//       setState(() {
//         errorMessage = 'Failed to fetch data: $e';
//         isLoading = false;
//       });
//     }
//   } else {
//     // If items are already loaded, just set loading to false
//     setState(() {
//       isLoading = false;
//     });
//   }
// }
//   @override
//   Widget build(BuildContext context) {
//     if (isLoading) {
//       return const Center(child: CircularProgressIndicator()); // Show a loading indicator
//     }

//     if (errorMessage != null) {
//       return Center(child: Text(errorMessage!)); // Show an error message
//     }

//     if (items == null || items!.isEmpty) {
//       return const Center(child: Text('No items available')); // Show a message if no items are found
//     }

//     return Container(
//       height: 200,
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: items!.length,
//         shrinkWrap: true,
//         physics: const AlwaysScrollableScrollPhysics(),
//         itemBuilder: (context, index) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Container(
//               height: 100,
//               width: 100,
//               decoration: BoxDecoration(
//                 color: Colors.red,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               // You can display item details here if needed
//               child: Center(
//                 child: Text(items![index].name ?? ''), // Example: Display the item name
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


class Grocceyitemdata extends StatefulWidget {
  final List<Item>? items;
  final CategoryController categoryController;
  final String id; // Add ID parameter for fetching

  const Grocceyitemdata({
    super.key,
    required this.items,
    required this.categoryController,
    required this.id,
  });

  @override
  State<Grocceyitemdata> createState() => _GrocceyitemdataState();
}

class _GrocceyitemdataState extends State<Grocceyitemdata> {
  late List<Item> itemdata = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize with existing items if provided
    if (widget.items != null && widget.items!.isNotEmpty) {
      itemdata = List.from(widget.items!);
    } else {
      fetchdata();
    }
  }

  Future<void> fetchdata() async {
    if (_isLoading) return; // Prevent multiple calls
    setState(() {
      _isLoading = true;
    });
    try {
      final ItemModel? itemdatas = await widget.categoryController.categoryitembyId(
        widget.id, // Use the id from the widget
        1, // Assuming page number; adjust as needed
        widget.categoryController.type,
      );
      if (itemdatas != null && itemdatas.items != null) {
        setState(() {
          itemdata.addAll(itemdatas.items!);
        });
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: itemdata.length,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(10),
              ),
              // Display item data here using itemdata[index]
            ),
          );
        },
      ),
    );
  }
}