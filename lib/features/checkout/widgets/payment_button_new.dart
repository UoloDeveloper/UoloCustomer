import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';

// class PaymentButtonNew extends StatelessWidget {
//   final String icon;
//   final String title;
//   final bool isSelected;
//   final Function onTap;
//   const PaymentButtonNew({super.key, required this.isSelected, required this.icon, required this.title, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeSmall),
//       child: InkWell(
//         onTap: onTap as void Function()?,
//         child: Container(
//           decoration: BoxDecoration(
//             color: Theme.of(context).cardColor,
//               borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
//               border: Border.all(color: isSelected ? Colors.transparent : Colors.transparent   )
//           ),
//           padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical:0),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(children: [
//               Container(
//                 padding: const EdgeInsets.all(10),
//                 decoration: BoxDecoration(
//                   color: Theme.of(context).primaryColor.withOpacity(0.1),
//                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
//                   border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3)),
//                 ),
//                 child: Image.asset(
//                   icon, width: 25, height: 25,
//                 ),
//               ),
//               const SizedBox(width: Dimensions.paddingSizeSmall),
            
//               Expanded(
//                 child: Text(
//                   title, maxLines: 2, overflow: TextOverflow.ellipsis,
//                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
//                 ),
//               ),
            
//               isSelected ? Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Theme.of(context).primaryColor,
//                 ),
//                 padding: const EdgeInsets.all(2),
//                 child: const Icon(Icons.check, color: Colors.white, size: 18),
//               ) : const SizedBox(),
            
//             ]),
//           ),

//         ),
//       ),
//     );
//   }
// }


class PaymentButtonNew extends StatelessWidget {
  final String icon;
  final String title;
    final String? subtitle;
  final bool isSelected;
  final bool dynamic;
  final Function onTap;
  
  const PaymentButtonNew({
    super.key,
    required this.isSelected,
    required this.icon,
    required this.title,
    required this.onTap,  this.subtitle,  this.dynamic = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: InkWell(
        onTap: () => onTap(),
        borderRadius: BorderRadius.circular(8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(15),
            // border: Border.all(
            //   color: isSelected 
            //       ? Theme.of(context).primaryColor 
            //       : Colors.grey.shade300,
            //   width: 1.5,
            // ),
            boxShadow: isSelected
                ? [BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  )]
                : [],
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon Container
              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  // color: Colors.grey.shade50,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: !dynamic ? Image.asset(icon) : CustomImage(image: icon),
                  
                  //  Image.asset(icon),
                ),
              ),
              const SizedBox(width: 16),

              // Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade800,
                      ),
                    ),

                     Text(
                     subtitle ?? '',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),

              // Radio-style selector
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected 
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}