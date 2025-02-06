import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class FilterView extends StatelessWidget {
  final StoreController storeController;
  const FilterView({super.key, required this.storeController});

  @override
  Widget build(BuildContext context) {
    return storeController.storeModel != null ? PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            value: 'all',
            child: Text('all'.tr, style: robotoMedium.copyWith(
              color: storeController.filterType == 'all'
              ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).disabledColor,
            )),
          ),
          PopupMenuItem(
            value: 'take_away',
            child: Text('take_away'.tr, style: robotoMedium.copyWith(
              color: storeController.filterType == 'take_away'
                ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).disabledColor,
            )),
          ),
          PopupMenuItem(
            value: 'delivery',
            child: Text('delivery'.tr, style: robotoMedium.copyWith(
              color: storeController.filterType == 'delivery'
              ? Theme.of(context).textTheme.bodyLarge!.color : Theme.of(context).disabledColor,
            )),
          ),
        ];
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          height: 40, width: 70,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
            border: Border.all(color: Theme.of(context).disabledColor),),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Filter" ,style: TextStyle(
                  color: Colors.black,
                  fontSize:  13,
                  fontWeight: FontWeight.w500
                ),),

                const SizedBox(width: 5),
                SvgPicture.asset(
                  "assets/image/icons/rivet-icons_filter.svg"
                )
              ],
            ),
          ),
        ),
      ),
      onSelected: (dynamic value) => storeController.setFilterType(value),
    ) : Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        height: 40, width: 70,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
          border: Border.all(color: Theme.of(context).disabledColor),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Text("Filter" ,style: TextStyle(
                 color:  Colors.black  ,
                  fontSize:  13,
                  fontWeight: FontWeight.w500
                ),),
           const SizedBox(width: 5),
                SvgPicture.asset(
                  "assets/image/icons/rivet-icons_filter.svg"
                ),
          ],
        ),
      ),
    );
  }
}

