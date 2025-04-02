import 'package:geolocator/geolocator.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/location/widgets/customflotingaction.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_button.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/common/widgets/menu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sixam_mart/features/location/widgets/serach_location_widget.dart';

class PickMapScreen extends StatefulWidget {
  final bool fromSignUp;
  final bool fromAddAddress;
  final bool canRoute;
  final String? route;
  final GoogleMapController? googleMapController;
  final Function(AddressModel address)? onPicked;
  final bool fromLandingPage;

  const PickMapScreen({
    super.key,
    required this.fromSignUp,
    required this.fromAddAddress,
    required this.canRoute,
    required this.route,
    this.googleMapController,
    this.onPicked,
    this.fromLandingPage = false,
  });

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  GoogleMapController? _mapController;
  CameraPosition? _cameraPosition;
  late LatLng _initialPosition;
  bool locationAlreadyAllow = false;

  @override
  void initState() {
    super.initState();
 Get.find<LocationController>().checkPermission(() {
                        Get.find<LocationController>().getCurrentLocation(false, mapController: _mapController);
                      });
    if (widget.fromAddAddress) {
      Get.find<LocationController>().setPickData();
    }
    _initialPosition = LatLng(
      double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lat ?? '0'),
      double.parse(Get.find<SplashController>().configModel!.defaultLocation!.lng ?? '0'),
    );
    _checkAlreadyLocationEnable();
  }

  _checkAlreadyLocationEnable() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.whileInUse) {
      locationAlreadyAllow = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResponsiveHelper.isDesktop(context) ? Colors.transparent : Theme.of(context).cardColor,
      appBar: AppBar(
        title: Text('Select Delivery Location', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
          onPressed: () => Get.back(),
        ),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: GetBuilder<LocationController>(builder: (locationController) {
          return Stack(
            children: [
              // Full-Screen Google Map
              GoogleMap(
                // mapType: MapType.satellite,
                // myLocat
                //ionEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: widget.fromAddAddress
                      ? LatLng(locationController.position.latitude, locationController.position.longitude)
                      : _initialPosition,
                  zoom: 16,
                ),
                minMaxZoomPreference: const MinMaxZoomPreference(0, 20), // Allow zooming from 0 to 20
                myLocationButtonEnabled: false,
                onMapCreated: (GoogleMapController mapController) {
                  _mapController = mapController;
                  if (!widget.fromAddAddress && widget.route != RouteHelper.onBoarding) {
                    Get.find<LocationController>().getCurrentLocation(false, mapController: mapController);
                  }
                },
                scrollGesturesEnabled: true, // Enable scroll gestures
                zoomGesturesEnabled: true, // Enable zoom gestures
                zoomControlsEnabled: false, // Hide default zoom controls (optional)
                onCameraMove: (CameraPosition cameraPosition) {
                  _cameraPosition = cameraPosition;
                },
                onCameraMoveStarted: () {
                  locationController.disableButton();
                },
                onCameraIdle: () {
                  Get.find<LocationController>().updatePosition(_cameraPosition, false);
                },
                style: Get.isDarkMode ? Get.find<ThemeController>().darkMap : Get.find<ThemeController>().lightMap,
              ),

              // Search Location Widget (Positioned on top of the map)
              Positioned(
                top: 16,
                left: 16,
                right: 16,
                child: SearchLocationWidget(
                  mapController: _mapController,
                  pickedAddress: locationController.pickAddress,
                  isEnabled: null,
                  fromDialog: true,
                ),
              ),

              // Marker Image (Centered on the map)
              Positioned(
                bottom: MediaQuery.of(context).size.height * 0.4, // Adjust position as needed
                left: 0,
                right: 0,
                child: Center(
                  child: !locationController.loading
                      ? Image.asset(
                          "assets/image/Untitled (600 x 1200 px) (600 x 800 px) (500 x 500 px)_20250130_121855_0000.png",
                          height: 250,
                          width: 250,
                        )
                      : const CircularProgressIndicator(),
                ),
              ),

              // Floating Action Button for Current Location
              Padding(
                padding: const EdgeInsets.only(bottom: 190),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomFloatingActionButton(
            
                    onPressed: () {
                      Get.find<LocationController>().checkPermission(() {
                        Get.find<LocationController>().getCurrentLocation(false, mapController: _mapController);
                      });
                    },
                    icon: Icons.my_location,
                    label: "Select Current Location",
                  ),
                ),
              ),

              // Bottom Container for Address and Button
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Address',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        locationController.pickAddress ?? 'No address selected',
                        style: TextStyle(fontSize: 14, color: Theme.of(context).hintColor, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 16),
                      CustomButton(
                         gradient: LinearGradient(
          colors:   [
            Colors.deepPurple.shade800 ,
            Colors.purple.shade400  
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
                        isBold: true,
                        radius: Dimensions.radiusSmall,
                        buttonText: locationController.inZone
                            ? widget.fromAddAddress
                                ? 'Pick Address'
                                : 'Pick Location'
                            : 'Service Not Available in This Area',
                        isLoading: locationController.isLoading,
                        onPressed: locationController.isLoading
                            ? () {}
                            : (locationController.buttonDisabled || locationController.loading)
                                ? null
                                : () {
                                    _onPickAddressButtonPressed(locationController);
                                  },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  void _onPickAddressButtonPressed(LocationController locationController) {
    if (locationController.pickPosition.latitude != 0 && locationController.pickAddress!.isNotEmpty) {
      if (widget.onPicked != null) {
        AddressModel address = AddressModel(
          latitude: locationController.pickPosition.latitude.toString(),
          longitude: locationController.pickPosition.longitude.toString(),
          addressType: 'others',
          address: locationController.pickAddress,
          contactPersonName: AddressHelper.getUserAddressFromSharedPref()!.contactPersonName,
          contactPersonNumber: AddressHelper.getUserAddressFromSharedPref()!.contactPersonNumber,
        );
        widget.onPicked!(address);
        Get.back();
      } else if (widget.fromAddAddress) {
        if (widget.googleMapController != null) {
          widget.googleMapController!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: LatLng(locationController.pickPosition.latitude, locationController.pickPosition.longitude),
            zoom: 16,
          )));
          locationController.setAddAddressData();
        }
        Get.back();
      } else {
        AddressModel address = AddressModel(
          latitude: locationController.pickPosition.latitude.toString(),
          longitude: locationController.pickPosition.longitude.toString(),
          addressType: 'others',
          address: locationController.pickAddress,
        );

        if (widget.fromLandingPage) {
          if (!AuthHelper.isGuestLoggedIn() && !AuthHelper.isLoggedIn()) {
            Get.find<AuthController>().guestLogin().then((response) {
              if (response.isSuccess) {
                Get.find<ProfileController>().setForceFullyUserEmpty();
                Get.back();
                locationController.saveAddressAndNavigate(
                  address,
                  widget.fromSignUp,
                  widget.route,
                  widget.canRoute,
                  ResponsiveHelper.isDesktop(Get.context),
                );
              }
            });
          } else {
            Get.back();
            locationController.saveAddressAndNavigate(
              address,
              widget.fromSignUp,
              widget.route,
              widget.canRoute,
              ResponsiveHelper.isDesktop(context),
            );
          }
        } else {
          locationController.saveAddressAndNavigate(
            address,
            widget.fromSignUp,
            widget.route,
            widget.canRoute,
            ResponsiveHelper.isDesktop(context),
          );
        }
      }
    } else {
      showCustomSnackBar('Pick an address');
    }
  }

  Future<bool> _locationCheck() async {
    bool locationServiceEnabled = true;
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      locationServiceEnabled = false;
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.deniedForever) {
      locationServiceEnabled = false;
    }
    return locationServiceEnabled;
  }
}