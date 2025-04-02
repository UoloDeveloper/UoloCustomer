import 'package:flutter/material.dart';

// class RatingDialog extends StatefulWidget {
//   @override
//   _RatingDialogState createState() => _RatingDialogState();
// }

// class _RatingDialogState extends State<RatingDialog> {
//   int _stars = 0;
//   final TextEditingController _feedbackController = TextEditingController();

//   Widget _buildStar(int starCount) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _stars = starCount;
//         });
//       },
//       child: Icon(
//         Icons.star,
//         size: 40,
//         color: _stars >= starCount ? Colors.orange : Colors.grey,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: 
      
      
//       Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black26,
//               blurRadius: 10,
//               offset: Offset(0, 10),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               "How was your order?",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) => _buildStar(index + 1)),
//             ),
//             SizedBox(height: 20),
//             TextField(
//               controller: _feedbackController,
//               decoration: InputDecoration(
//                 hintText: "Leave your feedback (optional)",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 10),
//               ),
//               maxLines: 3,
//             ),
//             SizedBox(height: 20),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle submission logic here
//                     String feedback = _feedbackController.text;
//                     print("Rating: $_stars, Feedback: $feedback");
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("Submit"),
//                 ),
//                 TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text("Skip"),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
  
  
  
  
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/features/order/domain/models/order_details_model.dart';
import 'package:sixam_mart/features/order/domain/models/order_model.dart';
import 'package:sixam_mart/features/review/controllers/review_controller.dart';
import 'package:sixam_mart/features/review/domain/models/review_body_model.dart';
import 'package:sixam_mart/features/review/widgets/item_review_widget.dart';

// class RatingDialog extends StatefulWidget {
//   final List<OrderDetailsModel> orderDetailsList;
//   const RatingDialog({super.key, required this.orderDetailsList});
//   @override
//   _RatingDialogState createState() => _RatingDialogState();
// }

// class _RatingDialogState extends State<RatingDialog> {
//   int _stars = 0;
//   final TextEditingController _feedbackController = TextEditingController();

//   Widget _buildStar(int starCount) {
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _stars = starCount;
//         });
//       },
//       child: Icon(
//         Icons.star,
//         size: 30,
//         color: _stars >= starCount ? Colors.orange : Colors.grey[300],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child: 
//       //  ItemReviewWidget(orderDetailsList: widget.orderDetailsList),
      
//        Container(
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black12,
//               blurRadius: 10,
//               offset: Offset(0, 5),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Header
//             Text(
//               "Rate Your Order",
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black87,
//               ),
//             ),
//             SizedBox(height: 10),
//             Text(
//               "How was your experience with us?",
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey[600],
//               ),
//             ),
//             SizedBox(height: 10),

//             // Star Rating
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: List.generate(5, (index) => _buildStar(index + 1)),
//             ),
//             SizedBox(height: 10),

//             // Feedback Input
//             TextField(
//               controller: _feedbackController,
//               decoration: InputDecoration(
//                 hintText: "Add a comment...",
//                 hintStyle: TextStyle(color: Colors.grey[500]),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.grey[300]!),
//                 ),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide(color: Colors.orange),
//                 ),
//                 contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
//               ),
//               maxLines: 2,
//             ),
//             SizedBox(height: 10),

//             // Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 // Skip Button
//                 // TextButton(
//                 //   onPressed: () {
//                 //     Navigator.of(context).pop();
//                 //   },
//                 //   child: Text(
//                 //     "Skip",
//                 //     style: TextStyle(
//                 //       fontSize: 16,
//                 //       color: Colors.grey[600],
//                 //     ),
//                 //   ),
//                 // ),

//                 // Submit Button
//                 ElevatedButton(
//                   onPressed: () {
//                     // Handle submission logic here
//                     String feedback = _feedbackController.text;
//                     print("Rating: $_stars, Feedback: $feedback");
//                     Navigator.of(context).pop();
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.orange,
//                     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   child: Text(
//                     "Submit",
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
  
//     );
//   }
// }


class RatingDialog extends StatefulWidget {
  final OrderDetailsModel orderDetails;
  const RatingDialog({super.key, required this.orderDetails});

  @override
  _RatingDialogState createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _stars = 0;
  final TextEditingController _feedbackController = TextEditingController();

  Widget _buildStar(int starCount) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _stars = starCount;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 5,right: 5),
        child: Icon(
          Icons.star,
          size: 30,
          color: _stars >= starCount ? Colors.amber : Colors.grey[300],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: GetBuilder<ReviewController>(builder: (reviewController){
          return Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with Food Icon
                // Icon(
                //   Icons.fastfood,
                //   size: 50,
                //   color: Colors.orange,
                // ),
                // SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rate Your Order",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),


                    Container(
                      height: 35,
                      width: 35,
                   
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                           color: const Color.fromARGB(177, 0, 0, 0),
                      ),
                      child: Icon(Icons.close,color: Colors.white,size: 23,),
                    )
                  ],
                ),

                //  Text(
                //   "${widget.orderDetails.orderId ?? "No data"} ${widget.orderDetails.toJson()?? "No data"}",
                //   style: TextStyle(
                //     fontSize: 22,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black87,
                //   ),
                // ),
                SizedBox(height: 5),
                Text(
                  "How was your food experience?",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 20),
          
                 Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) => _buildStar(index + 1)),
            ),
                SizedBox(height: 20),
          
                // Feedback Input
                TextField(
                  style: TextStyle(
                    fontSize: 15
                  ),
                  controller: _feedbackController,
                  decoration: InputDecoration(

                    hintText: "Tell us more.....",

                    hintStyle: TextStyle(color: Colors.grey[500]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 20),
          
                // Buttons
                Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Skip Button
                    // TextButton(
                    //   onPressed: () {
                    //     Navigator.of(context).pop();
                    //   },
                    //   child: Text(
                    //     "Skip",
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       color: Colors.grey[600],
                    //     ),
                    //   ),
                    // ),
          
                    // Submit Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle submission logic here
                          String feedback = _feedbackController.text;
                          print("Rating: $_stars, Feedback: $feedback");
                          // Navigator.of(context).pop();
                      
                          ReviewBodyModel reviewBody = ReviewBodyModel(
                            // orderId: widget.orderDetailsList[0].orderId,
                            rating: "$_stars",
                            comment:"$feedback",
                            orderId: widget.orderDetails.orderId.toString(),
                            // deliveryManId: widget.orderDetails..toString(),
                            productId: widget.orderDetails.itemId.toString(),
                            // deliveryManId: /
                            // feedback: feedback
                          );
                          reviewController.submitReviewfromdialog(reviewBody);
                        Get.back();  
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}