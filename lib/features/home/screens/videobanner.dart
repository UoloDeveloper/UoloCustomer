import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/loyalty/screens/loyalty_screen.dart';
import 'package:sixam_mart/features/menu/screens/menu_screen.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:video_player/video_player.dart';

// class VideoContainer extends StatefulWidget {
//   @override
//   _VideoContainerState createState() => _VideoContainerState();
// }

// class _VideoContainerState extends State<VideoContainer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.asset('assets/video/your_video.mp4')
//       ..initialize().then((_) {
//         setState(() {}); // Update the UI when the video is initialized
//       });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).disabledColor,
//       ),
//       child: _controller.value.isInitialized
//           ? AspectRatio(
//               aspectRatio: _controller.value.aspectRatio,
//               child: VideoPlayer(_controller),
//             )
//           : Center(child: CircularProgressIndicator()), // Show a loading indicator while the video is loading
//     );
//   }
// }


// class VideoContainer extends StatefulWidget {
//   // final bool isFashion;
//   final String link;

//   const VideoContainer({Key? key, 
//   // required this.isFashion,
//    required this.link}) : super(key: key);

//   @override
//   _VideoContainerState createState() => _VideoContainerState();
// }

// class _VideoContainerState extends State<VideoContainer> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller =
//     VideoPlayerController.asset(
//       widget.link
//       //  widget.isFashion ? 'assets/image/static_banner/pinterestdownloader.com-1738566103.44417.mp4' : "assets/image/static_banner/pinterestdownloader.com-1737569803.046238.mp4"
       
//        ) 
//     //  VideoPlayerController.asset('assets/image/static_banner/pinterestdownloader.com-1737569803.046238.mp4')
//       ..initialize().then((_) {
//         setState(() {}); 
//         _controller.play(); 
//         _controller.setVolume(0);
        
        
//       });



//        _controller.addListener(() {
//       if (_controller.value.position == _controller.value.duration) {
      
//         _controller.seekTo(Duration.zero);
//         _controller.play();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Theme.of(context).disabledColor,
//         borderRadius: const BorderRadius.only(
//           bottomLeft: Radius.circular(19),
//           bottomRight: Radius.circular(19),
//         ),
//       ),
//       width: MediaQuery.of(context).size.width,
//       height: 400,
//       child: Stack(
//         children: [
//           // Video Player
//           _controller.value.isInitialized
//               ? ClipRRect(
//                   borderRadius: const BorderRadius.only(
//                     bottomLeft: Radius.circular(19),
//                     bottomRight: Radius.circular(19),
//                   ),
//                   child: VideoPlayer(_controller,),
//                 )
//               : Center(child: CircularProgressIndicator()), // Loading indicator

//           // Existing content
//           GetBuilder<LocationController>(builder: (locationController) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 top: MediaQuery.of(context).size.height * 0.05,
//                 left: MediaQuery.of(context).size.width * 0.04,
//                 right: MediaQuery.of(context).size.width * 0.04,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   InkWell(
//                     // onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.only(top: 5),
//                           child: SvgPicture.asset(
//                             'assets/image/location_icon.svg',
//                             height: 28.0,
//                             width: 28.0,
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () => Get.find<LocationController>().navigateToLocationScreen('home') ,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               InkWell(
//                                 // onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
//                                 child: Container(
//                                   child: Text(
//                                     AuthHelper.isLoggedIn()
//                                         ? AddressHelper.getUserAddressFromSharedPref()!.addressType!.tr
//                                         : 'your_location'.tr,
//                                     style: robotoMedium.copyWith(
//                                       color: Theme.of(context).cardColor,
//                                       fontSize: Dimensions.fontSizeDefault,
//                                        fontWeight: FontWeight.w800
//                                     ),
//                                     maxLines: 1,
//                                     overflow: TextOverflow.fade,
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: MediaQuery.of(context).size.width * 0.5,
//                                 child: Text(
//                                   AddressHelper.getUserAddressFromSharedPref()!.address ?? "",
//                                   style: robotoRegular.copyWith(
//                                     color: Theme.of(context).cardColor,
//                                     fontSize: Dimensions.fontSizeSmall,
//                                     fontWeight: FontWeight.w700
//                                   ),
//                                   maxLines: 1,
//                                   overflow: TextOverflow.fade,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       GetBuilder<ProfileController>(builder: (ProfileController) {
//                         return Container(
//                           height: 34,
//                           width: 71,
//                           decoration: const BoxDecoration(
//                             color: Colors.white60,
//                             borderRadius: BorderRadius.all(Radius.circular(50)),
//                           ),
//                           child: Row(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20 ),
//                                 child: Text("${ProfileController.userInfoModel?.loyaltyPoint ?? 0}",style: TextStyle(
//                                   color: Theme.of(context).primaryColor,
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 15

//                                 ),),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 0),
//                                 child: Image.asset("assets/image/gift_icon.png", width: 40),
//                               ),
//                             ],
//                           ),
//                         );
//                       }),
//                       const SizedBox(width: 8),
//                       InkWell(
//                         onTap: () {
//                           Get.to(const MenuScreen());
//                         },
//                         child: ClipRRect(
//                          borderRadius: BorderRadius.circular(100),
//                           child: Container(
//                             height: 34,
//                             width: 34,
//                             decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius: BorderRadius.circular(100),
//                             ),
//                             child: Image.asset(
//                                fit: BoxFit.cover,
//                               "assets/image/vecteezy_3d-cartoon-man-with-glasses-and-beard-illustration_51767450.png",
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ],
//       ),
//     );
//   }
// }


class VideoContainer extends StatefulWidget {
  // final String link;
  final bool shouldReinitialize;
  final bool isimage;
  final bool home;

  const VideoContainer({
    Key? key, 
    // required this.link,
    this.shouldReinitialize = false,
    this.isimage = false, required this.home,
  }) : super(key: key);

  @override
  _VideoContainerState createState() => _VideoContainerState();
}

class _VideoContainerState extends State<VideoContainer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    // _initializeController();
  }

  // @override
  // void didUpdateWidget(VideoContainer oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (oldWidget.link != widget.link || widget.shouldReinitialize) {
  //     _controller.dispose();
  //     _initializeController();
  //   }
  // }

  // void _initializeController() {
  //   _controller = VideoPlayerController.asset(widget.link,)
  //     ..initialize().then((_) {
  //       setState(() {}); 
  //       _controller.play(); 
  //       _controller.setVolume(0);
  //     });

  //   _controller.addListener(() {
  //     if (_controller.value.position == _controller.value.duration) {
  //       _controller.seekTo(Duration.zero);
  //       _controller.play();
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).disabledColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(19),
          bottomRight: Radius.circular(19),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: 490,
      child: Container(
        // color: Theme.of(context).cardColor,
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(19),
            bottomRight: Radius.circular(19),
          ),
          image:  DecorationImage(
            image: AssetImage(
              "assets/image/static_banner/Uolo App Cover 00-01.jpg",
            ),
            fit: BoxFit.cover,
          )
          // color: Theme.of(context).disabledColor,
          // borderRadius: const BorderRadius.only(
          //   bottomLeft: Radius.circular(19),
          //   bottomRight: Radius.circular(19),
          // ),
        ),
        child: Stack(
          children: [
            // Video Player
          widget.home ?   ClipRRect(
                   borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(19),
                      bottomRight: Radius.circular(19),
                    ),
                  child: Container(
                    height: 490,
                    width:MediaQuery.of(context).size.width ,
                    child: Image.asset(
                    "assets/image/static_banner/Uolo App Cover 02.jpg",
                      fit: BoxFit.cover,
                       
                    ),
                  ),
                ) :  ClipRRect(
                   borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(19),
                      bottomRight: Radius.circular(19),
                    ),
                  child: Container(
                    height: 490,
                    width:MediaQuery.of(context).size.width ,
                    child: Image.asset(
                       "assets/image/static_banner/Uolo App Cover 00-01.jpg",
                      fit: BoxFit.cover,
                       
                    ),
                  ),
                ),
                // :    _controller.value.isInitialized
                // ? ClipRRect(
                //     borderRadius: const BorderRadius.only(
                //       bottomLeft: Radius.circular(19),
                //       bottomRight: Radius.circular(19),
                //     ),
                //     child: VideoPlayer(_controller,),
                //   )
                // :  ClipRRect(
                //    borderRadius: const BorderRadius.only(
                //       bottomLeft: Radius.circular(19),
                //       bottomRight: Radius.circular(19),
                //     ),
                //   child: Container(
                //     height: 415,
                //     width:MediaQuery.of(context).size.width ,
                //     child: Image.asset(
                //       "assets/image/static_banner/Copy of Copy of black purple modern christmas food pinterest pin (500 x 500_20250219_123752_0000.png",
                //       fit: BoxFit.cover,
                       
                //     ),
                //   ),
                // ),
        
            // Existing content
            GetBuilder<LocationController>(builder: (locationController) {
              return Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: MediaQuery.of(context).size.width * 0.04,
                  right: MediaQuery.of(context).size.width * 0.04,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: SvgPicture.asset(
                              'assets/image/location_icon.svg',
                              height: 28.0,
                              width: 28.0,
                            ),
                          ),
                          InkWell(
                            // onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
                                  child: Text(
                                    AuthHelper.isLoggedIn()
                                        ? AddressHelper.getUserAddressFromSharedPref()!.addressType!.tr
                                        : 'your_location'.tr,
                                    style: robotoMedium.copyWith(
                                      color: Theme.of(context).cardColor,
                                      fontSize: Dimensions.fontSizeDefault,
                                      fontWeight: FontWeight.w800
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                CustomInkWell(
                                   onTap: () => Get.find<LocationController>().navigateToLocationScreen('home'),
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.5,
                                    child: Text(
                                      AddressHelper.getUserAddressFromSharedPref()?.address ?? "",
                                      style: robotoRegular.copyWith(
                                        color: Theme.of(context).cardColor,
                                        fontSize: Dimensions.fontSizeSmall,
                                        fontWeight: FontWeight.w700
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        GetBuilder<ProfileController>(builder: (profileController) {
                          return CustomInkWell(
                            onTap: (){
                                   Get.to(LoyaltyScreen(fromNotification: false));
                            },
                            child: Container(
                              height: 34,
                              // width: 71,
                              decoration: const BoxDecoration(
                                color: Colors.white60,
                                borderRadius: BorderRadius.all(Radius.circular(50)),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(
                                      "${profileController.userInfoModel?.loyaltyPoint ?? 0}",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 0),
                                    child: Image.asset(
                                      "assets/image/gift_icon.png",
                                      width: 40
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.to(const MenuScreen());
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Container(
                              height: 34,
                              width: 34,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Image.asset(
                                "assets/image/vecteezy_3d-cartoon-man-with-glasses-and-beard-illustration_51767450.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}