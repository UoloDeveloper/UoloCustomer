
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixam_mart/common/widgets/address_widget.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/common/widgets/custom_text_field.dart';
import 'package:sixam_mart/features/address/controllers/address_controller.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
class AddressDropdownSheet extends StatelessWidget {
  const AddressDropdownSheet({Key? key}) : super(key: key);

  List<AddressModel> _getAddressList(AddressController addressController, Store? store) {
    final addresses = <AddressModel>[];

    final userAddress = AddressHelper.getUserAddressFromSharedPref();
    if (userAddress != null) {
      addresses.add(userAddress);
    }

    if (addressController.addressList != null && store != null) {
      addresses.addAll(
        addressController.addressList!
            .where((address) => address.zoneIds?.contains(store.zoneId) ?? false),
      );
    }
    return addresses;
  }

  @override
  Widget build(BuildContext context) {
    // Trigger address fetch once when widget loads
    final addressController = Get.find<AddressController>();
    final checkoutController = Get.find<CheckoutController>();

    // Make sure latest addresses are fetched
    addressController.getAddressList();

    return SafeArea(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.5,
        ),
        child: GetBuilder<CheckoutController>(
          builder: (checkoutController) {
            if (checkoutController.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
      
            final addressList = _getAddressList(addressController, checkoutController.store);
      
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCloseButton(),
                const SizedBox(height: 5),
                Expanded(
                  child: _buildMainContent(context, addressList, checkoutController),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: Center(
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: const Color.fromARGB(146, 0, 0, 0),
            borderRadius: BorderRadius.circular(100),
          ),
          child: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(Icons.close, color: Color.fromARGB(209, 255, 255, 255), size: 25),
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context, List<AddressModel> addresses, CheckoutController checkoutController) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radiusExtraLarge + 5),
          topRight: Radius.circular(Dimensions.radiusExtraLarge + 5),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 10, top: 10),
              child: Text(
                'Choose a delivery address',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(child: _buildAddressList(addresses, checkoutController)),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            _buildStreetNumberField(checkoutController),
            const SizedBox(height: Dimensions.paddingSizeLarge),
            _buildHouseAndFloorFields(checkoutController),
            const SizedBox(height: Dimensions.paddingSizeSmall),
            _buildAddAddressButton(context, checkoutController),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressList(List<AddressModel> addresses, CheckoutController checkoutController) {
    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (context, index) {
        final address = addresses[index];
        return InkWell(
          onTap: () {
            checkoutController.getDistanceInKM(
              LatLng(double.parse(address.latitude!), double.parse(address.longitude!)),
              LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
            );
            checkoutController.setAddressIndex(index);
            checkoutController.setSelectedAddress(address);
            Get.back();
          },
          child: AddressWidget(
            address: address,
            fromAddress: false,
            fromCheckout: true,
          ),
        );
      },
    );
  }

  Widget _buildStreetNumberField(CheckoutController checkoutController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: CustomTextField(
        radius: Dimensions.radiusLarge,
        labelText: 'street_number'.tr,
        titleText: 'write_street_number'.tr,
        inputType: TextInputType.streetAddress,
        focusNode: checkoutController.streetNode,
        nextFocus: checkoutController.houseNode,
        controller: checkoutController.streetNumberController,
      ),
    );
  }

  Widget _buildHouseAndFloorFields(CheckoutController checkoutController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
              radius: Dimensions.radiusLarge,
              titleText: 'write_house_number'.tr,
              labelText: 'house'.tr,
              inputType: TextInputType.text,
              focusNode: checkoutController.houseNode,
              nextFocus: checkoutController.floorNode,
              controller: checkoutController.houseController,
            ),
          ),
          const SizedBox(width: Dimensions.paddingSizeSmall),
          Expanded(
            child: CustomTextField(
              radius: Dimensions.radiusLarge,
              titleText: 'write_floor_number'.tr,
              labelText: 'floor'.tr,
              inputType: TextInputType.text,
              focusNode: checkoutController.floorNode,
              inputAction: TextInputAction.done,
              controller: checkoutController.floorController,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddAddressButton(BuildContext context, CheckoutController checkoutController) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: CustomInkWell(
        onTap: () async {
          Get.back();
          var newAddress = await Get.toNamed(
            RouteHelper.getAddAddressRoute(
              true,
              false,
              checkoutController.store!.zoneId,
            ),
          );
          if (newAddress != null) {
            checkoutController.getDistanceInKM(
              LatLng(double.parse(newAddress.latitude), double.parse(newAddress.longitude)),
              LatLng(double.parse(checkoutController.store!.latitude!), double.parse(checkoutController.store!.longitude!)),
            );
            checkoutController.streetNumberController.text = newAddress.streetNumber ?? '';
            checkoutController.houseController.text = newAddress.house ?? '';
            checkoutController.floorController.text = newAddress.floor ?? '';
            checkoutController.update(); // Rebuild UI
          }
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(color: Theme.of(context).primaryColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
                child: Icon(Icons.add, size: 18, color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              'Add New Address'.tr,
              style: robotoMedium.copyWith(
                fontSize: Dimensions.fontSizeLarge,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const Spacer(),
            const Icon(Icons.arrow_right),
          ],
        ),
      ),
    );
  }
}
