import 'package:flutter/material.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class StoreFilterButtonWidget extends StatelessWidget {
  const StoreFilterButtonWidget({super.key, this.isSelected, this.onTap, required this.buttonText});

  final bool? isSelected;
  final void Function()? onTap;
  final String buttonText;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
        decoration: BoxDecoration(
          color:  isSelected == true ? Colors.black : Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: isSelected == true ? Colors.black : const Color.fromARGB(185, 222, 219, 219)),
        ),
        child:  Center(child: Text(buttonText, style: robotoRegular.copyWith( fontSize: Dimensions.fontSizeSmall,
            fontWeight: isSelected == true ? FontWeight.values[4] : FontWeight.values[4] ,
            color: isSelected == true ? Colors.white : const Color.fromARGB(193, 61, 61, 61)))),
      ),
    );
  }
}
