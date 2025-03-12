import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:sixam_mart/features/coupon/controllers/coupon_controller.dart';
import 'package:sixam_mart/features/coupon/domain/models/coupon_model.dart';
import 'package:sixam_mart/helper/price_converter.dart';

// class CouponCarousel extends StatelessWidget {
//   final int? storeid;

//  CouponCarousel({ required this.storeid});
//   @override

  
//   Widget build(BuildContext context) {
//     return GetBuilder<CouponController>(builder: (couponController) {


//       List filteredData = couponController.couponList!.where((data) {
//               return data.store!.id  == storeid ;
//             }).toList();




// if (filteredData == null || filteredData.isEmpty) {
//       return SizedBox();
//     }
//       return  Padding(
//          padding: const EdgeInsets.only(left: 30,right: 30),
//         child: Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(20),
//             border: Border.all(color: Colors.grey.shade300),
//           ),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(20),
//             child: CarouselSlider.builder(
            
//               itemCount: filteredData!.length,
//               itemBuilder: (context, index, realIndex) {
//                 return Container(
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   alignment: Alignment.center,
//                   child: Text(
//                     '${filteredData[index].code ?? ''}',
//                     style: TextStyle(color: Colors.black, fontSize: 18),
//                   ),
//                 );
//               },
//               options: CarouselOptions(
//                 height: 60,
//                 enlargeCenterPage: false,
//                 // aspectRatio: 16 / 9,
//                 viewportFraction: 1,

//                 autoPlay: true,
//                 autoPlayInterval: Duration(seconds: 3),
//                 autoPlayAnimationDuration: Duration(milliseconds: 800),
//                 autoPlayCurve: Curves.easeInOut,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//           ),
//         ),
//       );
//     });
//   }
// }


// class CouponCarousel extends StatelessWidget {
//   final int? storeid;

//   CouponCarousel({required this.storeid});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CouponController>(builder: (couponController) {
//       List filteredData = couponController.couponList!.where((data) {
//         return data.store!.id == storeid;
//       }).toList();

//       if (filteredData == null || filteredData.isEmpty) {
//         return SizedBox();
//       }

//       // Track the current index of the carousel
//       int currentIndex = 0;

//       return Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 30, right: 30),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Row(
//                   children: [
//                     CarouselSlider.builder(
//                       itemCount: filteredData.length,
//                       itemBuilder: (context, index, realIndex) {
//                         return Container(
//                           height: 80,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             '${filteredData[index].code ?? ''}',
//                             style: TextStyle(color: Colors.black, fontSize: 18),
//                           ),
//                         );
//                       },
//                       options: CarouselOptions(
//                         height: 60,
//                         enlargeCenterPage: false,
//                         viewportFraction: 1,
//                         autoPlay: true,
//                         autoPlayInterval: Duration(seconds: 3),
//                         autoPlayAnimationDuration: Duration(milliseconds: 800),
//                         autoPlayCurve: Curves.easeInOut,
//                         scrollDirection: Axis.horizontal,
//                         onPageChanged: (index, reason) {
//                           // Update the current index when the page changes
//                           currentIndex = index;
//                           couponController.update(); // Update the UI
//                         },
//                       ),
//                     ),

//                     Column(
//                       children: [
//                         Text(
//                                     '${currentIndex + 1} / ${filteredData.length}',
//                                     style: TextStyle(fontSize: 16, color: Colors.black),
//                                   ),
//                                    Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               filteredData.length,
//               (index) => Container(
//                 width: 8,
//                 height: 8,
//                 margin: EdgeInsets.symmetric(horizontal: 4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: currentIndex == index ? Colors.blue : Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
         
         
         
//         ],
//       );
//     });
//   }
// }


// class CouponCarousel extends StatelessWidget {
//   final int? storeid;

//   CouponCarousel({required this.storeid});

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CouponController>(builder: (couponController) {
//       List<CouponModel>  filteredData = couponController.couponList!.where((data) {
//         return data.store!.id == storeid;
//       }).toList();

//       if (filteredData == null || filteredData.isEmpty) {
//         return SizedBox();
//       }

//       // Track the current index of the carousel
//       int currentIndex = 0;

//       return Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CarouselSlider.builder(
//                         itemCount: filteredData.length,
//                         itemBuilder: (context, index, realIndex) {
//                           return Container(
//                             height: 80,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             alignment: Alignment.center,
//                             child:
//                              Row(
//                                children: [

//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 10,right: 10),
//                                   child: Image.asset('assets/image/sale.png',height: 40,width: 40,),
//                                 ),
//                                  Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     // Text("${filteredData[index].discountType }",
//                                     //   style: TextStyle(color: Colors.black, fontSize: 18),
//                                     // ),
//                                     Text(
//                                       filteredData[index].discountType == 'amount' ? 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} off' : 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} % off',
//                                       style: TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                            'USE ${filteredData[index].code ?? ''}',
//                                           style: TextStyle(color: Colors.grey, fontSize: 13,fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(width: 5),
//                                        Container(
//                                         height: 10,width: 1,color: Colors.grey
//                                        ),
//                                         SizedBox(width: 5),
//                                         Text(
//                                            'ABOVE ${filteredData[index].minPurchase ?? ''}',
//                                           style: TextStyle(color: Colors.grey, fontSize: 13,fontWeight: FontWeight.bold),
//                                         )
//                                       ],
//                                     ),
//                                   ],
//                                                              ),
//                                ],
//                              ),
//                           );
//                         },
//                         options: CarouselOptions(
//                           height: 60,
//                           enlargeCenterPage: false,
//                           viewportFraction: 1,
//                           autoPlay: true,
//                           autoPlayInterval: Duration(seconds: 3),
//                           autoPlayAnimationDuration: Duration(milliseconds: 800),
//                           autoPlayCurve: Curves.easeInOut,
//                           scrollDirection: Axis.horizontal,
//                           onPageChanged: (index, reason) {
//                             // Update the current index when the page changes
//                             currentIndex = index;
//                             couponController.update(); // Update the UI
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10), // Add some spacing
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${currentIndex + 1} / ${filteredData.length}',
//                           style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold ),
//                         ),
//                         SizedBox(height: 5), // Add some spacing
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             filteredData.length,
//                             (index) => Container(
//                               width: 4,
//                               height: 4,
//                               margin: EdgeInsets.symmetric(horizontal: 4),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: currentIndex == index ? Colors.blue : Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                      SizedBox(width: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }


// class CouponCarousel extends StatefulWidget {
//   final int? storeid;

//   CouponCarousel({required this.storeid});

//   @override
//   State<CouponCarousel> createState() => _CouponCarouselState();
// }

// class _CouponCarouselState extends State<CouponCarousel> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<CouponController>(builder: (couponController) {
//       // Check if couponList is null
//       if (couponController.couponList == null) {
//         return SizedBox(); // or some placeholder widget
//       }

//       // Filter the coupons based on storeid
//       List<CouponModel> filteredData = couponController.couponList!.where((data) {
//         // Check if data.store is null
//         return data.store != null && data.store!.id == widget.storeid;
//       }).toList();

//       // Check if filteredData is empty
//       if (filteredData.isEmpty) {
//         return SizedBox(); // or some placeholder widget
//       }

//       // Track the current index of the carousel
//       int currentIndex = 0;

//       return Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 15, right: 15,bottom: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(color: Colors.grey.shade300,width: .5),
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(20),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: CarouselSlider.builder(
//                         itemCount: filteredData.length,
//                         itemBuilder: (context, index, realIndex) {
//                           return Container(
//                             height: 60,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             alignment: Alignment.center,
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 10, right: 10),
//                                   child: filteredData[index].discountType == 'amount' ? Image.asset('assets/image/coupon.png', height: 40, width: 40) : Image.asset('assets/image/sale.png', height: 40, width: 40),
//                                 ),
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       filteredData[index].discountType == 'amount'
//                                           ? 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} off'
//                                           : 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} % off UPTO ${PriceConverter.convertPrice(filteredData[index].maxDiscount ?? 0.0)}',
//                                       style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           'USE ${filteredData[index].code ?? ''}',
//                                           style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
//                                         ),
//                                         SizedBox(width: 5),
//                                         Container(height: 10, width: 1, color: Colors.grey),
//                                         SizedBox(width: 5),
//                                         Text(
//                                           'ABOVE ${filteredData[index].minPurchase ?? ''}',
//                                           style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           );
//                         },
//                         options: CarouselOptions(
//                           height: 60,
//                           enlargeCenterPage: false,
//                           viewportFraction: 1,
//                           autoPlay: true,
//                           autoPlayInterval: Duration(seconds: 3),
//                           autoPlayAnimationDuration: Duration(milliseconds: 800),
//                           autoPlayCurve: Curves.easeInOut,
//                           scrollDirection: Axis.horizontal,
//                           onPageChanged: (index, reason) {
//                             // Update the current index when the page changes
                          
//                             setState(() {
//   currentIndex = index;
//                             }); // Update the UI
//                             couponController.update(); // Update the UI
//                           },
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: 10), // Add some spacing
//                     Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           '${currentIndex + 1} / ${filteredData.length}',
//                           style: TextStyle(fontSize: 12, color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold),
//                         ),
//                         SizedBox(height: 5), // Add some spacing
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: List.generate(
//                             filteredData.length,
//                             (index) => Container(
//                               width: 4,
//                               height: 4,
//                               margin: EdgeInsets.symmetric(horizontal: 4),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: currentIndex == index ? Colors.blue : Colors.grey,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     SizedBox(width: 20),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }



class CouponCarousel extends StatefulWidget {
  final int? storeid;

  CouponCarousel({required this.storeid});

  @override
  State<CouponCarousel> createState() => _CouponCarouselState();
}

class _CouponCarouselState extends State<CouponCarousel> {
  int currentIndex = 0; // Move currentIndex to the state class

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CouponController>(builder: (couponController) {
      if (couponController.couponList == null) {
        return SizedBox();
      }

      List<CouponModel> filteredData = couponController.couponList!.where((data) {
    
        return data.store != null && data.store!.id == widget.storeid || data.store == null &&  (!RegExp(r'^[0]+$').hasMatch(data.title.toString().trim())) ;
      }).toList();

      if (filteredData.isEmpty) {
        return SizedBox();
      }

      return 
      
      Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, right: 15, bottom: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300, width: .5),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Row(
                  children: [
                    Expanded(
                      child: CarouselSlider.builder(
                        itemCount: filteredData.length,
                        itemBuilder: (context, index, realIndex) {
                          return Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10, right: 10),
                                  child: filteredData[index].discountType == 'amount' ? Image.asset('assets/image/coupon.png', height: 40, width: 40) : Image.asset('assets/image/sale.png', height: 40, width: 40),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      filteredData[index].discountType == 'amount'
                                          ? 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} off'
                                          : 'Flat ${PriceConverter.convertPrice(filteredData[index].discount ?? 0.0)} % ${ filteredData[index].maxDiscount == 0 ? "off": "off UPTO ${PriceConverter.convertPrice(filteredData[index].maxDiscount ?? 0.0)}"}',
                                      style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'USE ${filteredData[index].code ?? ''}',
                                          style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(width: 5),
                                        Container(height: 10, width: 1, color: Colors.grey),
                                        SizedBox(width: 5),
                                        Text(
                                          'ABOVE ${filteredData[index].minPurchase ?? ''}',
                                          style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 60,
                          enlargeCenterPage: false,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          autoPlayCurve: Curves.easeInOut,
                          scrollDirection: Axis.horizontal,
                          onPageChanged: (index, reason) {
                            setState(() {
                              currentIndex = index; 
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${currentIndex + 1} / ${filteredData.length}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            filteredData.length,
                            (index) => Container(
                              width: currentIndex == index ?  6 :4,
                              height: currentIndex == index ?  6 :4,
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: currentIndex == index 
                                    ? Theme.of(context).primaryColor 
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
   
   
   
    });
  }
}