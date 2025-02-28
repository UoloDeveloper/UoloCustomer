import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

// class BottomNavItemWidget extends StatelessWidget {
//   final String selectedIcon;
//   final String unSelectedIcon;
//   final String title;
//   final Function? onTap;
//   final bool isSelected;
//   const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.title, required this.selectedIcon, required this.unSelectedIcon});

//   @override
//   Widget build(BuildContext context) {
//     return Expanded(
//       child: InkWell(
//         onTap: onTap as void Function()?,
//         child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [

//           Image.asset(
//             isSelected ? selectedIcon : unSelectedIcon, height: 25, width: 25,
//             color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!,
//           ),

//           SizedBox(height: isSelected ? Dimensions.paddingSizeExtraSmall : Dimensions.paddingSizeSmall),

//           Text(
//             title,
//             style: robotoRegular.copyWith(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!, fontSize: 12),
//           ),

//         ]),
//       ),
//     );
//   }
// }

class BottomNavItemWidget extends StatelessWidget {
  final String selectedIcon;
  final String unSelectedIcon;
  final String title;
  final Function? onTap;
  final bool isSelected;
  final bool isfood;
  const BottomNavItemWidget({super.key, this.onTap, this.isSelected = false, required this.title, required this.selectedIcon, required this.unSelectedIcon,  this.isfood = false});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap as void Function()?,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
SizedBox(height:  isfood ?  Dimensions.paddingSizeExtraSmall  : Dimensions.paddingSizeSmall),
          SvgPicture.asset(
            isSelected ? selectedIcon : unSelectedIcon, 
            height: isfood ? 25 : 21,
            width:isfood ? 25 : 21,
            color: isSelected ? 
            
            // const Color(0xFFFF5200) 
             const Color.fromARGB(255, 97, 38, 140)
            : const Color(0xFF818181),

          ),


          SizedBox(height: isfood ?  Dimensions.paddingSizeExtraSmall  : Dimensions.paddingSizeExtraSmall ),

          Text(
            title,
            style: robotoMedium.copyWith(color: isSelected ? Theme.of(context).primaryColor : Theme.of(context).textTheme.bodyMedium!.color!, fontSize: 13,fontWeight: FontWeight.w500),
          ),

          // SizedBox(height: 5,)

        ]),
      ),
    );
  }
}
