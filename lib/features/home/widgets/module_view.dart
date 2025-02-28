import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/home/widgets/web/customcards.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/title_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/home/widgets/banner_view.dart';

class ModuleView extends StatelessWidget {
  final SplashController splashController;
  const ModuleView({super.key, required this.splashController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

        SizedBox(height: 10,)
        // GetBuilder<BannerController>(builder: (bannerController) {
        //   return const BannerView(isFeatured: true);
        // }),

//         Padding(
//           padding: const EdgeInsets.only(left: 8,right: 8),
//           child: CustomInkWell(
//             onTap: (){
//               // Get.reset(); // Close all controllers
// // Get.offAll(Fashionmoduleview(splashController: splashController,)); // Close all routes and navigate to NewScreen
//               Get.to(Fashionmoduleview(splashController: splashController,));
//             },
//             child: Customcard3(
//                       isofferd: false,
//                       imageBottomPosition: -9
//                       ,

//                       // imageLeftPosition: 10,
//                       imageRightPosition: 0,
//                       title: " Uolo Fashion",
//                       image: "assets/image/pngwing.com (1).png",
//                       imageHeight: 200,
//                       imagewidth: 180,

//                       imageTopPosition: 0,
//                       title2: "",
//                       height: containerHeight ,
//                       width: MediaQuery.of(context).size.width,
//                     ),
//           ),
//         ),,

       , splashController.moduleList != null
            ? splashController.moduleList!.isNotEmpty
                ? GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: Dimensions.paddingSizeSmall,
                      crossAxisSpacing: Dimensions.paddingSizeDefault,
                      childAspectRatio: (1 / 1.3),
                    ),
                    padding: const EdgeInsets.all(5),
                    itemCount: splashController.moduleList!.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return index < 2
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusExtraLarge),
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .disabledColor
                                        .withOpacity(0.1),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusExtraLarge),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusExtraLarge),
                                    color: Theme.of(context).cardColor,
                                    boxShadow: [
                                      //     BoxShadow(
                                      //    color: Theme.of(context).disabledColor.withOpacity(0.1),
                                      //    spreadRadius: 5,
                                      //    blurRadius:1,
                                      //  ),
                                    ],
                                  ),
                                  child: CustomInkWell(
                                    onTap: () => splashController.switchModule(
                                        index, true),
                                    radius: Dimensions.fontSizeLarge,
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        // Positioned for the image
                                        Positioned(
                                          right: -10,
                                          bottom: -10,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                                Dimensions.radiusSmall),
                                            child: Container(
                                              color:
                                                  Theme.of(context).cardColor,
                                              width: 195,
                                              height: 250,
                                              child: CustomImage(
                                                fit: BoxFit.cover,
                                                image:
                                                    '${splashController.moduleList![index].iconFullUrl}',
                                                // height: 100,
                                                // width: 100,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Main content
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  left: Dimensions
                                                      .paddingSizeExtraSmall,
                                                  // right: Dimensions.paddingSizeSmall,
                                                  top: Dimensions
                                                      .paddingSizeDefault,
                                                ),
                                                child: Text(

                                                     splashController
                                                      .moduleList![index]
                                                      .moduleName!
                                                      .toUpperCase() == "." ? "" :
                                                  splashController
                                                      .moduleList![index]
                                                      .moduleName!
                                                      .toUpperCase(),
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: robotoMedium.copyWith(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color:
                                                          const Color.fromARGB(
                                                              214, 48, 46, 46)),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                  // left: Dimensions.paddingSizeDefault,
                                                  left: Dimensions
                                                      .paddingSizeExtraSmall,
                                                  right: Dimensions
                                                      .paddingSizeSmall,
                                                  // top: Dimensions.paddingSizeDefault,
                                                ),
                                                child: Text(
                                               removeHtmlTags(
                                                    splashController
                                                        .moduleList![index]
                                                        .description!
                                                        .toUpperCase(),
                                                  ) == "." ? "" :   "${removeHtmlTags(
                                                    splashController
                                                        .moduleList![index]
                                                        .description!
                                                        .toUpperCase(),
                                                  )}",

                                                  // textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: robotoMedium.copyWith(
                                                      fontSize: Dimensions
                                                          .fontSizeSmall ,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.grey[500]),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                                height: Dimensions
                                                    .paddingSizeSmall),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : null;
                    },
                  )
                :
                ModuleShimmer(isEnabled: splashController.moduleList == null)
                //  Center(
                //     child: Padding(
                //     padding:
                //         const EdgeInsets.only(top: Dimensions.paddingSizeSmall),
                //     child: Text('no_module_found'.tr),
                //   ))
            : ModuleShimmer(isEnabled: splashController.moduleList == null),

        // Address Section

        // GetBuilder<AddressController>(builder: (locationController) {
        //   List<AddressModel?> addressList = [];
        //   if(AuthHelper.isLoggedIn() && locationController.addressList != null) {
        //     addressList = [];
        //     bool contain = false;
        //     if(AddressHelper.getUserAddressFromSharedPref()!.id != null) {
        //       for(int index=0; index<locationController.addressList!.length; index++) {
        //         if(locationController.addressList![index].id == AddressHelper.getUserAddressFromSharedPref()!.id) {
        //           contain = true;
        //           break;
        //         }
        //       }
        //     }
        //     if(!contain) {
        //       addressList.add(AddressHelper.getUserAddressFromSharedPref());
        //     }
        //     addressList.addAll(locationController.addressList!);
        //   }
        //   return (!AuthHelper.isLoggedIn() || locationController.addressList != null) ? addressList.isNotEmpty ? Column(
        //     children: [

        //       const SizedBox(height: Dimensions.paddingSizeLarge),

        //       Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
        //         child: TitleWidget(title: 'deliver_to'.tr),
        //       ),
        //       const SizedBox(height: Dimensions.paddingSizeExtraSmall),

        //       SizedBox(
        //         height: 80,
        //         child: ListView.builder(
        //           physics: const BouncingScrollPhysics(),
        //           itemCount: addressList.length,
        //           scrollDirection: Axis.horizontal,
        //           padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall, right: Dimensions.paddingSizeSmall, top: Dimensions.paddingSizeExtraSmall),
        //           itemBuilder: (context, index) {
        //             return Container(
        //               width: 300,
        //               padding: const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
        //               child: AddressWidget(
        //                 address: addressList[index],
        //                 fromAddress: false,
        //                 onTap: () {
        //                   if(AddressHelper.getUserAddressFromSharedPref()!.id != addressList[index]!.id) {
        //                     Get.dialog(const CustomLoaderWidget(), barrierDismissible: false);
        //                     Get.find<LocationController>().saveAddressAndNavigate(
        //                       addressList[index], false, null, false, ResponsiveHelper.isDesktop(context),
        //                     );
        //                   }
        //                 },
        //               ),
        //             );
        //           },
        //         ),
        //       ),
        //     ],
        //   ) : const SizedBox() : AddressShimmer(isEnabled: AuthHelper.isLoggedIn() && locationController.addressList == null);
        // }),

        // const PopularStoreView(isPopular: false, isFeatured: true),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5),
          child: Column(children: [
        
            // Container(
            //   height: 80,
            //   width: MediaQuery.of(context).size.width,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(15),
            //     color: Theme.of(context).primaryColor,
            //     gradient: LinearGradient(colors: [
            //       Color.fromARGB(15, 148, 148, 148),
            //       Color.fromARGB(164, 139, 9, 233)
            //     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
            //     boxShadow: [
            //       //  BoxShadow(
            //       //    color: Theme.of(context).disabledColor.withOpacity(0.1),
            //       //    spreadRadius: 5,
            //       //    blurRadius:1,
            //       //  ),
            //     ],
            //   ),
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(left: 10, top: 10),
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Text(
            //                 "Uolo Coins".toUpperCase(),
            //                 style: TextStyle(
            //                     color: Color.fromARGB(255, 52, 4, 87),
            //                     fontSize: 21,
            //                     fontWeight: FontWeight.w800),
            //               ),
            //               Flexible(
            //                   child: Text(
            //                 "Uolo Coins can be used for all your orders ",
            //                 style: TextStyle(
            //                   color: Theme.of(context).cardColor,
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //                 maxLines: 2,
            //               )),
            //               Flexible(
            //                   child: Text(
            //                 "Across categories ",
            //                 style: TextStyle(
            //                   color: Theme.of(context).cardColor,
            //                   fontSize: 12,
            //                   fontWeight: FontWeight.bold,
            //                 ),
            //                 maxLines: 2,
            //               )),
            //             ],
            //           ),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Container(
            //             width: 80,
            //             height: 40,
            //             decoration: BoxDecoration(
            //               color: Colors.white60,
            //               borderRadius: BorderRadius.circular(15),
            //             ),
            //             child: Center(
            //                 child: Text(
            //               'ADD',
            //               style: TextStyle(
            //                   color: Color.fromARGB(255, 52, 4, 87),
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w800),
            //             )),
            //           ),
            //         )
            //       ]),
            // ),

            ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15),
                  bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
              child: Image.asset("assets/image/static_banner/uolo app 2 copy 2.jpg",fit: BoxFit.cover,)),

            SizedBox(
              height: 20,
            ),
//

            splashController.moduleList != null
                ? splashController.moduleList!.isNotEmpty
                    ? GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              splashController.moduleList!.length - 2 == 1
                                  ? 1
                                  : 2,
                          mainAxisSpacing: Dimensions.paddingSizeSmall,
                          crossAxisSpacing: Dimensions.paddingSizeDefault + 5,
                          childAspectRatio:  splashController.moduleList!.length - 2 != 1 ? 1.6 : (3.7 / 1.5),
                        ),
                        padding:
                            const EdgeInsets.only( top : Dimensions.paddingSizeSmall,bottom:Dimensions.paddingSizeSmall ),
                        itemCount: splashController.moduleList!.length - 2,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final actualIndex = index + 2;

                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusExtraLarge),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context)
                                      .disabledColor
                                      .withOpacity(0.1),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusExtraLarge),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      Dimensions.radiusExtraLarge),
                                  color: Theme.of(context).cardColor,
                                ),
                                child: CustomInkWell(
                                    onTap: () => splashController.switchModule(
                                        actualIndex, true),
                                    radius: Dimensions.fontSizeLarge,
                                    child: Customcard2(
                                      isdynamic: true,

                                      title: splashController
                                                      .moduleList![index]
                                                      .moduleName!
                                                      .toUpperCase() == "." ? "" :
                                                  splashController
                                                      .moduleList![index]
                                                      .moduleName!
                                                      .toUpperCase(),
                                      image:
                                          '${splashController.moduleList![actualIndex].iconFullUrl}',

                                      title2:
                                          "${     removeHtmlTags(
                                                    splashController
                                                        .moduleList![index]
                                                        .description!
                                                        .toUpperCase(),
                                                  ) == "." ? "" :   "${removeHtmlTags(
                                                    splashController
                                                        .moduleList![index]
                                                        .description!
                                                        .toUpperCase(),
                                                  )}"}",

                                      // isdynamic: true,
                                    )),
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Padding(
                        padding: const EdgeInsets.only(
                            top: Dimensions.paddingSizeSmall),
                        child: Text('no_module_found'.tr),
                      ))
                : ModuleShimmer(isEnabled: splashController.moduleList == null),
          ]),
        ),
      
      
        BannerView(
          isFeatured: false,
        ),
        const SizedBox(height: 40),

        //  Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Customcard2(
        //         isofferd: true,
        //         imageBottomPosition: 0,
        //         imageLeftPosition: 60,
        //         imageRightPosition: 0,
        //         title: "PARCEL",
        //         image: "assets/image/b44217f7300fb90c5b36e978e1563e70 1.png",
        //         imageHeight: 130,
        //         // imagewidth: 110,

        //         imageTopPosition: 0,
        //         title2: "PICKUP & DROP",
        //         height: containerHeight * 0.8,
        //         width: containerWidth * 1.7,
        //         // isdynamic: false,
        //       ),
        //       const SizedBox(width: 20),
        //       Customcard2(
        //         imageBottomPosition: 0,
        //         imageLeftPosition: 50,
        //         imageRightPosition: 0,
        //         title: "LOUNDRY",
        //         image: "assets/image/Patagonia.Pkg.D.byCapsule 2.png",
        //          imageHeight: 130,
        //         // imagewidth: 110,
        //         imageTopPosition: 0,
        //         title2: "PICKUP & DROP",
        //         height: containerHeight * 0.8,
        //         width: containerWidth * 1.7,
        //         //  isdynamic: false,
        //       ),
        //     ],
        //   ),

        const SizedBox(height: 150),

        //  EnhancedCardStackToGrid(images: [

        //   "Taxi",
        //     "Car Repair",
        //       "Taxi",
        //         "Plumber",
        //         "Electrician",
        //         "pAINTER",
        //         "ELECTRONICS SERVICES",
        //           "Ac repair",
        //           "Cleaning",
        //           "Laundry",

        //  ], zoneNames: [

        //   "Taxi",
        //     "Car Repair",
        //       "Taxi",
        //         "Plumber",
        //         "Electrician",
        //         "pAINTER",
        //         "ELECTRONICS SERVICES",
        //           "Ac repair",
        //           "Cleaning",
        //           "Laundry",
        //  ],)
      ]),
    );
  }
}

class ModuleShimmer extends StatelessWidget {
  final bool isEnabled;
  const ModuleShimmer({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: Dimensions.paddingSizeSmall,
        crossAxisSpacing: Dimensions.paddingSizeSmall,
        childAspectRatio: (1 / 1.3),
      ),
      padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      itemCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
               image: DecorationImage(
                      image: const AssetImage(
                          Images.placeholder),
                      fit: BoxFit.cover,
                    ),
           borderRadius: BorderRadius.circular(
                                    Dimensions.radiusExtraLarge),
            color: Theme.of(context).cardColor,
            boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)
            ],
          ),
          // child: 
          // Shimmer(
          //   duration: const Duration(seconds: 2),
          //   enabled: isEnabled,
          //   child:
          //       Column(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment:CrossAxisAlignment.start , children: [
          //     Padding(
          //       padding: const EdgeInsets.only(left: 15, right: 8.0, top: 15, bottom: 8.0),
          //       child: Container(
          //         height: 20,
          //         width: 130,
          //         decoration: BoxDecoration(
          //           image: DecorationImage(
          //             image: const AssetImage(
          //                 Images.placeholder),
          //             fit: BoxFit.cover,
          //           ),
          //             borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          //             color: Colors.grey[300]),
          //       ),
          //     ),
          //     const SizedBox(height: Dimensions.paddingSizeSmall),
          //     Padding(
          //      padding: const EdgeInsets.only(left: 15, right: 8.0, top: 0, bottom: 8.0),
          //       child: Container(
          //           height: 20, width: 70, color: Colors.grey[300]),
          //     ),
          //   ]),
          // ),
     
     
        );
      },
    );
  }
}

class AddressShimmer extends StatelessWidget {
  final bool isEnabled;
  const AddressShimmer({super.key, required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: Dimensions.paddingSizeLarge),
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),
          child: TitleWidget(title: 'deliver_to'.tr),
        ),
        const SizedBox(height: Dimensions.paddingSizeExtraSmall),
        SizedBox(
          height: 70,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeSmall),
            itemBuilder: (context, index) {
              return Container(
                width: 300,
                padding:
                    const EdgeInsets.only(right: Dimensions.paddingSizeSmall),
                child: Container(
                  padding: EdgeInsets.all(ResponsiveHelper.isDesktop(context)
                      ? Dimensions.paddingSizeDefault
                      : Dimensions.paddingSizeSmall),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12, blurRadius: 5, spreadRadius: 1)
                    ],
                  ),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(
                      Icons.location_on,
                      size: ResponsiveHelper.isDesktop(context) ? 50 : 40,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(width: Dimensions.paddingSizeSmall),
                    Expanded(
                      child: Shimmer(
                        duration: const Duration(seconds: 2),
                        enabled: isEnabled,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                  height: 15,
                                  width: 100,
                                  color: Colors.grey[300]),
                              const SizedBox(
                                  height: Dimensions.paddingSizeExtraSmall),
                              Container(
                                  height: 10,
                                  width: 150,
                                  color: Colors.grey[300]),
                            ]),
                      ),
                    ),
                  ]),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

String removeHtmlTags(String htmlString) {
  final RegExp exp = RegExp(r'<[^>]*>', multiLine: true, caseSensitive: true);
  return htmlString.replaceAll(exp, '').trim();
}
