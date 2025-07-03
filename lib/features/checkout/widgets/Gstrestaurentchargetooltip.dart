import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';


// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class TooltipExample extends StatefulWidget {
//   const TooltipExample({super.key});

//   @override
//   _TooltipExampleState createState() => _TooltipExampleState();
// }

// class _TooltipExampleState extends State<TooltipExample> {
//   final GlobalKey<TooltipState> _tooltipKey = GlobalKey<TooltipState>();

//   void _showTooltip() {
//     _tooltipKey.currentState?.ensureTooltipVisible();
//   }

//   @override
//   Widget build(BuildContext context) {
//     const String currency = "₹";
//     const double tax = 210.72;

//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Row(
//         children: [
//           Row(
//             children: [
//               SvgPicture.asset(
//                 "assets/image/icons/Group 14459.svg",
//                 height: 17,
//                 width: 17,
//                 color: Colors.black87,
//               ),
//               const SizedBox(width: 5),
//               GestureDetector(
//                 onTap: _showTooltip, // Trigger tooltip on tap
//                 child: Tooltip(
//                   key: _tooltipKey,
//                   message: "GST & Other Charges\n"
//                       "Restaurant Packaging: ₹20.00\n"
//                       "Restaurant GST: ₹180.10\n"
//                       "Swiggy plays no role in the taxes and charges levied by the govt. and restaurant\n"
//                       "Item Total: ₹995\n"
//                       "Delivery Fee: ₹76.00\n"
//                       "Platform Fee: ₹11.89\n"
//                       "Inclusive of GST. This fee helps us operate and maintain Swiggy platform\n"
//                       "Free cancellation on restaurants",
//                   preferBelow: false,
//                   textStyle: const TextStyle(
//                     fontSize: 12,
//                     color: Colors.black,
//                     fontWeight: FontWeight.w400,
//                   ),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(8),
//                     boxShadow: const [
//                       BoxShadow(
//                         color: Colors.black26,
//                         blurRadius: 4,
//                         offset: Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Text(
//                     "GST and restaurant charge",
//                     style: TextStyle(
//                       fontSize: Dimensions.fontSizeDefault,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           const Spacer(),
//           Text(
//             PriceConverter.convertPrice(tax, currency: currency),
//             style: TextStyle(
//               fontSize: Dimensions.fontSizeDefault,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(width: 10),
//           IconButton(
//             icon: const Icon(Icons.info, size: 20),
//             onPressed: _showTooltip, // Trigger tooltip via button
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TooltipExample extends StatefulWidget {
  final CheckoutController checkoutController ;
  final String currency;
  final double tax;
//  final double packagingCharge; 
   TooltipExample({super.key, required this.checkoutController, required this.currency, required this.tax,  });

  @override
  _TooltipExampleState createState() => _TooltipExampleState();
}


SplashController splashController = Get.find<SplashController>();

class _TooltipExampleState extends State<TooltipExample> {
  void _showCustomTooltip(BuildContext context) {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final Offset position = button.localToGlobal(Offset.zero);

    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy - 10, 
        position.dx,
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: false,
          child: Container(
            width: 280, 
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
               
                // const Text(
                //   'GST & Other Charges',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.black,
                //   ),
                // ),
                // const SizedBox(height: 8),
              
        widget.checkoutController.store!.extraPackagingStatus!   ?         Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      'GST & Other Charges',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Text(
                     PriceConverter.convertPrice(widget.checkoutController.store!.extraPackagingAmount!,currency: widget.currency),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color:Color(0xFF666666),
                      ),
                    ),
                  ],
                ) : const SizedBox(),
                const SizedBox(height: 4),
             widget.tax < 0 ? SizedBox() :   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      'GST & Other Charges',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Text(
                      PriceConverter.convertPrice(widget.tax,currency: widget.currency),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ),
           widget.tax < 0 ? SizedBox() :      const SizedBox(height: 4),
 
       widget.tax < 0 ? SizedBox() :
        widget.checkoutController.store!.tax!.toDouble()
         < 5.5 ? Text(
                  'Uolo plays no role in the taxes and charges levied by the government and restaurant.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(165, 102, 102, 102),
                  ),
                ): const Text(
                  'Government taxes like GST are levied as per applicable laws.\nUolo charges a handling fee solely for supporting and maintaining the app.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(165, 102, 102, 102),
                  ),
                ),
           
          
         
             
                const SizedBox(height: 8),
                // Platform Fee Section
       splashController.configModel!.additionCharge! < 0 ?         Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:  [
                    Text(
                      '${splashController.configModel!.additionalChargeName!}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
                    Text(
                    ' ${PriceConverter.convertPrice(splashController.configModel!.additionCharge,currency:widget.currency)}',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF666666),
                      ),
                    ),
                  ],
                ) : const SizedBox(),
           
           
                const SizedBox(height: 4),
                
             splashController.configModel!.additionCharge! < 0  ?   Text(
                  'Inclusive of GST. This fee helps us operate and maintain Uolo platform',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(165, 102, 102, 102),
                  ),
                ) : const SizedBox(),
              
              ],
            ),
          ),
        ),
      ],
      elevation: 4,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
 

    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        children: [
          Row(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/image/icons/Group 14459.svg",
                    height: 17,
                    width: 17,
                    color: Colors.black87,
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () => _showCustomTooltip(context), 
                    child: Column(
                      children: [
                        Text(
                          "GST and Other Charges",
                          style: TextStyle(
                            fontSize: Dimensions.fontSizeDefault,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          width: 180,
                          child: CustomPaint(
                                            painter: DashedLinePainter(),
                                            child: const SizedBox(height: 1, width: double.infinity),
                                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                PriceConverter.convertPrice(widget.tax + widget.checkoutController.store!.extraPackagingAmount!+splashController.configModel!.additionCharge!, currency: widget.currency),
                style: TextStyle(
                  fontSize: Dimensions.fontSizeDefault,
                  fontWeight: FontWeight.w500,
                ),
              ),
           
            ],
          ),
             
        ],
      ),
    );
  }
}


class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1;
    const dashWidth = 5;
    const dashSpace = 3;
    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

