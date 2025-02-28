import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

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
SizedBox(height: isSelected ? Dimensions.paddingSizeExtraSmall : isfood ?  Dimensions.paddingSizeExtraSmall - 3 : Dimensions.paddingSizeSmall),
          SvgPicture.asset(
            isSelected ? selectedIcon : unSelectedIcon, 
            height: isfood ? 25 : 21,
            width:isfood ? 25 : 21,
            color: isSelected ? 
            
            // const Color(0xFFFF5200) 
             const Color.fromARGB(255, 97, 38, 140)
            : const Color(0xFF818181),

          ),


          SizedBox(height: isSelected ? Dimensions.paddingSizeExtraSmall : isfood ?  Dimensions.paddingSizeExtraSmall - 3 : Dimensions.paddingSizeExtraSmall ),

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
