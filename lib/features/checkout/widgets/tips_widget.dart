import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class TipsWidget extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;
  final bool isSuggested;

  const TipsWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    required this.isSuggested,
  });

  @override
  Widget build(BuildContext context) {
    // Set a fixed size for the cards
    const double cardHeight = 40.0;
    const double cardWidth = 70.0;

    return Padding(
      padding: const EdgeInsets.only(
        right: Dimensions.paddingSizeSmall,
        top: Dimensions.paddingSizeExtraSmall ,
        bottom: 0,
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onTap as void Function()?,
            child: SizedBox(
              height: cardHeight,
              width: cardWidth, 
              child: Material(
                // elevation: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(    Dimensions.radiusDefault),
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).cardColor,
                          width: .5
                    ),
                    boxShadow: const [BoxShadow(color: Colors.black12, spreadRadius: 0.5, blurRadius: 0.5)],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Text(
                          title,
                          textAlign: TextAlign.center, 
                          style: robotoRegular.copyWith(
                            color: isSelected
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor,
                            fontSize: Dimensions.fontSizeExtraSmall + 2, 
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      
                      isSuggested
                          ? Container(
                        decoration:  BoxDecoration(
                          color: Theme.of(context).primaryColor
                          //  Color(0xFFFE5002)
,

                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(Dimensions.radiusSmall),
                            bottomRight: Radius.circular(Dimensions.radiusSmall),
                          ),
                        ),

                        height: 20,
                        width: double.infinity,
                        // alignment: Alignment.center,

                        child: Center(
                          child: Text(
                            'most_tipped'.tr,
                            style: robotoRegular.copyWith(
                              color: Theme.of(context).cardColor,
                              fontSize: Dimensions.fontSizeOverSmall,
                            ),
                          ),
                        ),
                      )
                          : const SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
