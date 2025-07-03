import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/address_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/location/domain/models/zone_response_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_loader.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/location/screens/pick_map_screen.dart';

class AddressBottomSheetWidget extends StatelessWidget {
  final bool fromDialog;
  const AddressBottomSheetWidget({super.key, this.fromDialog = false});

  @override
  Widget build(BuildContext context) {
    if(Get.find<AddressController>().addressList == null){
      Get.find<AddressController>().getAddressList();
    }
    return SafeArea(
      top: false,
      bottom: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(height: 50,color: Colors.transparent, width: double.infinity,child: Center(
            child: 
            CustomInkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                        padding:  const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Theme.of(context).primaryColor.withOpacity(0.1), blurRadius: 5)],
                        ),
                        child: const Icon(Icons.close, size: 30,color: Colors.white,),
                    ),
            ),
          ),),
          Container(
            decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius : BorderRadius.only(
                  topLeft: Radius.circular(fromDialog ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraLarge),
                  topRight : Radius.circular(fromDialog ? Dimensions.paddingSizeDefault : Dimensions.paddingSizeExtraLarge),
                  bottomLeft: Radius.circular(fromDialog ? Dimensions.paddingSizeDefault : 0),
                  bottomRight: Radius.circular(fromDialog ? Dimensions.paddingSizeDefault : 0),
                ),
            ),
            child: GetBuilder<AddressController>(
              builder: (addressController) {
                AddressModel? selectedAddress = AddressHelper.getUserAddressFromSharedPref();
                return Column(mainAxisSize: MainAxisSize.min, children: [
          
                  fromDialog ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                          Get.back();
                          },
                        icon: const Icon(Icons.clear),
                      )
                    ]
                  ) : const SizedBox(),
          
                  // fromDialog ? const SizedBox() : Center(
                  //   child: Container(
                  //     margin: const EdgeInsets.only(top: Dimensions.paddingSizeDefault, bottom: Dimensions.paddingSizeDefault),
                  //     height: 3, width: 40,
                  //     decoration: BoxDecoration(
                  //       color: Theme.of(context).highlightColor,
                  //       borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                  //     ),
                  //   ),
                  // ),
          
                  Flexible(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(horizontal: fromDialog ? 50 : Dimensions.paddingSizeLarge, vertical: Dimensions.paddingSizeSmall),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
           SizedBox(height: fromDialog ? 0 : Dimensions.paddingSizeDefault),
                        Center(child: Text('${'hey_welcome_back'.tr}\n${'which_location_do_you_want_to_select'.tr}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),textAlign: TextAlign.center,)),
                        const SizedBox(height: Dimensions.paddingSizeLarge),
          
                        Center(
                          child: addressController.addressList != null && addressController.addressList!.isEmpty ? Column(mainAxisSize: MainAxisSize.max,crossAxisAlignment: CrossAxisAlignment.center, children: [
                            Image.asset("assets/image/freepik__upload__14489.png", width: fromDialog ? 180 : 150),
      
      
      
          
                            fromDialog ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),
                            SizedBox(
                              width: 280,
                              child: Text(
                                'you_dont_have_any_saved_address_yet'.tr, textAlign: TextAlign.center,
                                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
                              ),
                            ),
          
                          ]) : const SizedBox(),
                        ),
          
                        addressController.addressList != null && addressController.addressList!.isEmpty
                            ? const SizedBox(height: Dimensions.paddingSizeLarge) : const SizedBox(),
          
                        (addressController.addressList != null && fromDialog) ? const SizedBox(height: Dimensions.paddingSizeDefault) : const SizedBox(),
                        
                        const SizedBox(height: Dimensions.paddingSizeSmall),
          
                        addressController.addressList != null ? addressController.addressList!.isNotEmpty ? Container(
                          decoration: BoxDecoration(
                            // color: Theme.of(context).primaryColor.withOpacity(0.1)  ,
                            borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall, vertical: Dimensions.paddingSizeSmall),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            itemCount: addressController.addressList!.length > 5 ? 5 : addressController.addressList!.length,
                            itemBuilder: (context, index) {
                              bool selected = false;
                              if(selectedAddress!.id == addressController.addressList![index].id){
                                selected = true;
                              }
                              return Center(child: SizedBox(width: 700, child: AddressWidget(
                                address: addressController.addressList![index],
                                fromAddress: false, isSelected: selected, fromDashBoard: true,
                                onTap: () {
                                  print('============================================================address id: ${addressController.addressList![index].id}===============================================================================');
                                    Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
                              AddressModel address = addressController.addressList![index];
                              Get.find<LocationController>().saveAddressAndNavigate(
                                address, false, null, false, ResponsiveHelper.isDesktop(context),
                              );
      
                              Get.find<LocationController>().hideSuggestedLocation();
                              Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                                },
                              )));
                            }, separatorBuilder: (BuildContext context, int index) { 
                              return const Divider(height: 1);
                             },
                          ),
                        ) : const SizedBox() : const Center(child: CircularProgressIndicator()),
          Align(
                          alignment: addressController.addressList != null && addressController.addressList!.isEmpty && !fromDialog ? Alignment.center : Alignment.topCenter,
                          child: Container(
                            decoration: BoxDecoration(
                               gradient: LinearGradient(
          colors: [
            Colors.deepPurple.shade800,
            Colors.purple.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
                              // color: Theme.of(context).primaryColor.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                            ),
                            child: TextButton.icon(
                              onPressed: (){
                                Get.find<LocationController>().checkPermission(() async {
                                  Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
                                  AddressModel address = await Get.find<LocationController>().getCurrentLocation(true);
                                  ZoneResponseModel response = await Get.find<LocationController>().getZone(address.latitude, address.longitude, false);
                                  if(response.isSuccess) {
                                    if(ResponsiveHelper.isDesktop(Get.context)) {
                                      Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                                    }
                                    Get.find<LocationController>().saveAddressAndNavigate(
                                      address, false, '', false, ResponsiveHelper.isDesktop(Get.context),
                                    );
                                    
                              Get.find<LocationController>().hideSuggestedLocation();
                              Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                                  }else {
                                    Get.back();
                                    if(ResponsiveHelper.isDesktop(Get.context)) {
                                      Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                                      showGeneralDialog(context: Get.context!, pageBuilder: (_,__,___) {
                                        return const SizedBox(
                                            height: 300, width: 300,
                                            child: PickMapScreen(fromSignUp: false, canRoute: false, fromAddAddress: true, route: null),
                                        );
                                      });
                                    }else {
                                      Get.toNamed(RouteHelper.getPickMapRoute(RouteHelper.accessLocation, false));
                                    }
                                    showCustomSnackBar('service_not_available_in_current_location'.tr);
                                  }
                                });
                              },
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.all(5),
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(Dimensions.radiusDefault))),
                                fixedSize: const Size(220, 40),
                                  backgroundColor: addressController.addressList != null && addressController.addressList!.isEmpty
                                ? Colors.transparent : Colors.transparent,
                              ),
                              icon:  Icon( Icons.my_location, color: addressController.addressList != null && addressController.addressList!.isEmpty
                                  ? Theme.of(context).cardColor : Theme.of(context).cardColor),
                              label: Text('use_current_location'.tr, style: fromDialog ? robotoRegular.copyWith(fontSize: Dimensions.fontSizeExtraSmall, color: addressController.addressList != null && addressController.addressList!.isEmpty
                                  ? Theme.of(context).cardColor : Theme.of(context).cardColor) : robotoMedium.copyWith(color: addressController.addressList != null && addressController.addressList!.isEmpty
                                  ? Theme.of(context).cardColor : Theme.of(context).cardColor)),
                            ),
                          ),
                        ),
                     
                     
                        SizedBox(height: addressController.addressList != null && addressController.addressList!.isEmpty ? 0 : Dimensions.paddingSizeSmall),
                           
                        addressController.addressList != null && addressController.addressList!.isNotEmpty ? Center(
                          child: TextButton.icon(
                            onPressed: () {
                              Get.find<SplashController>().saveWebSuggestedLocationStatus(true);
                              Get.toNamed(RouteHelper.getAddAddressRoute(false, false, 0));
                            },
                            icon: const Icon(Icons.add_circle_outline_sharp),
                            label: Text('add_new_address'.tr, style: robotoMedium.copyWith(color: Theme.of(context).primaryColor)),
                          ),
                        ) : const SizedBox(),
          
                      ]),
                    ),
                  ),
                ]);
              }
            ),
          ),
        ],
      ),
    );
  }
}
