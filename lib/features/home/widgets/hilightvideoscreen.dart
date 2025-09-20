import 'package:carousel_slider/carousel_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';

import 'package:sixam_mart/features/home/controllers/advertisement_controller.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sixam_mart/features/home/domain/models/advertisement_model.dart';
import 'package:sixam_mart/features/home/widgets/highlight_widget.dart';
import 'package:sixam_mart/features/store/controllers/store_controller.dart';
import 'package:sixam_mart/features/store/domain/models/store_model.dart';
import 'package:sixam_mart/features/store/screens/store_screen.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:video_player/video_player.dart';




// class PromotionalVideoSection extends StatefulWidget {
//   const PromotionalVideoSection({super.key});

//   @override
//   State<PromotionalVideoSection> createState() => _PromotionalVideoSectionState();
// }

// class _PromotionalVideoSectionState extends State<PromotionalVideoSection> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AdvertisementController>(builder: (advertisementController) {
//       return advertisementController.advertisementList != null &&
//               advertisementController.advertisementList!.isNotEmpty
//           ? Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: Dimensions.paddingSizeDefault,
//                 horizontal: Dimensions.paddingSizeSmall,
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Optional: Section Title
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: Dimensions.paddingSizeDefault,
//                       bottom: Dimensions.paddingSizeSmall,
//                     ),
//                     child: Text(
//                       'Highlights',
//                       style: TextStyle(
//                         fontSize: Dimensions.fontSizeLarge,
//                         fontWeight: FontWeight.bold,
//                         color: Theme.of(context).textTheme.bodyLarge!.color,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 300, 
//                     child: ListView.separated(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: advertisementController.advertisementList!.length,
//                       itemBuilder: (context, index) {
//                         final advertisement = advertisementController.advertisementList![index];
//                         // final isViewed = advertisementController.isStoryViewed(index); 
//                         return StoryPreviewItem(
//                           advertisement: advertisement,
//                           isViewed: false,
//                           onTap: () {
//                             Get.to(StoryViewScreen(initialIndex: index, advertisements:  advertisementController.advertisementList ?? [],));
//                             // Navigate to full-screen story view
//                             // Get.toNamed(
//                             //   RouteHelper.getStoryViewRoute(),
//                             //   arguments: {
//                             //     'initialIndex': index,
//                             //     'advertisements': advertisementController.advertisementList,
//                             //   },
//                             // );
//                           },
//                         );
//                       },
//                       separatorBuilder: (context, index) => const SizedBox(
//                         width: Dimensions.paddingSizeExtraSmall,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : advertisementController.advertisementList == null
//               ? const StoryShimmer()
//               : const SizedBox();
//     });
//   }
// }

// // class StoryPreviewItem extends StatelessWidget {
// //   final AdvertisementModel advertisement;
// //   final bool isViewed;
// //   final VoidCallback onTap;

// //   const StoryPreviewItem({
// //     super.key,
// //     required this.advertisement,
// //     required this.isViewed,
// //     required this.onTap,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return GetBuilder<StoreController>(builder: (storeController) { 
// //       Store? store = storeController.storeModel?.stores!.firstWhere((store) => store.id == advertisement.storeId);
// //       print( 'Store: ${store?.name} Store id :  ${store?.id} Advertisement id : ${advertisement.storeId}'  );
// //         return GestureDetector(
// //           onTap: onTap,
// //           child: Stack(
// //             alignment: Alignment.center,
// //             children: [
// //               // Gradient Border
// //               Container(
// //                 width: 120,
// //                 height: 150,
// //                 decoration: BoxDecoration(
// //                   // image:  DecorationImage(
// //                   //   image: CachedNetworkImageProvider(advertisement.videoAttachmentFullUrl ?? advertisement.videoAttachmentFullUrl ?? Images.placeholder),
// //                   //   fit: BoxFit.cover,
// //                   // ),
// //                   borderRadius: BorderRadius.circular(12),
// //                   shape: BoxShape.rectangle,
// //                   gradient: isViewed
// //                       ? const LinearGradient(
// //                           colors: [Colors.grey, Colors.grey],
// //                         )
// //                       : const LinearGradient(
// //                           colors: [Colors.pink, Colors.orange],
// //                           begin: Alignment.topLeft,
// //                           end: Alignment.bottomRight,
// //                         ),
// //                 ),
// //                 padding: const EdgeInsets.all(2),
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     color: Theme.of(context).cardColor,
// //                   ),
// //                   child: CachedNetworkImage(
// //                     imageUrl:  advertisement.coverImageFullUrl ?? advertisement.videoAttachmentFullUrl ?? store!.logoFullUrl ?? Images.placeholder,
// //                     width: 80,
// //                     height: 80,
// //                     fit: BoxFit.cover,
// //                     placeholder: (context, url) => Container(
// //                       color: Colors.grey[300],
// //                     ),
// //                     errorWidget: (context, url, error) => Icon(
// //                       Icons.image,
// //                       size: 30,
// //                       color: Theme.of(context).hintColor,
// //                     ),
// //                   ),
// //                 ),
// //               ),
           
// //               // if (advertisement.profileImageFullUrl == null)
// //               //   Positioned(
// //               //     bottom: 0,
// //               //     right: 0,
// //               //     child: Container(
// //               //       decoration: BoxDecoration(
// //               //         shape: BoxShape.circle,
// //               //         border: Border.all(
// //               //           color: Theme.of(context).cardColor,
// //               //           width: 2,
// //               //         ),
// //               //       ),
// //               //       child: CustomImage(image: advertisement!.store!.logoFullUrl  ?? Images.placeholder, width: 40, height: 40, fit: BoxFit.cover),
// //               //     ),
// //               //   ),
// //             ],
// //           ),
// //         );
// //       }
// //     );
// //   }
// // }


// class StoryPreviewItem extends StatefulWidget {
//   final AdvertisementModel advertisement;
//   final bool isViewed;
//   final VoidCallback onTap;

//   const StoryPreviewItem({
//     super.key,
//     required this.advertisement,
//     required this.isViewed,
//     required this.onTap,
//   });

//   @override
//   _StoryPreviewItemState createState() => _StoryPreviewItemState();
// }

// class _StoryPreviewItemState extends State<StoryPreviewItem> {
//   VideoPlayerController? _videoController;
//   bool _isInitialized = false;

//   @override
//   void initState() {
//     super.initState();
//     _initializeVideoThumbnail();
//   }

//   Future<void> _initializeVideoThumbnail() async {
//     if (widget.advertisement.videoAttachmentFullUrl != null &&
//         widget.advertisement.videoAttachmentFullUrl!.isNotEmpty) {
//       _videoController = VideoPlayerController.networkUrl(
//         Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
//       );

//       try {
//         await _videoController!.initialize();
//         if (mounted) {
//           setState(() {
//             _isInitialized = true;
//           });
//           _videoController!.setVolume(0); 
//           _videoController!.seekTo( Duration(seconds: 0)); 
//         }
//       } catch (e) {
//         if (mounted) {
//           setState(() {
//             _isInitialized = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StoreController>(builder: (storeController) {
//       Store? store = storeController.storeModel?.stores
//           ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

//       return GestureDetector(
//         onTap: widget.onTap,
//         child: Stack(
//           alignment: Alignment.center,
//           children: [
//             // Gradient Border
//             Container(
//               width: 180,
//               height: 300,
//               // decoration: BoxDecoration(
//               //   borderRadius: BorderRadius.circular(12),
//               //   gradient: widget.isViewed
//               //       ? const LinearGradient(
//               //           colors: [Colors.grey, Colors.grey],
//               //         )
//               //       : const LinearGradient(
//               //           colors: [Colors.pink, Colors.orange],
//               //           begin: Alignment.topLeft,
//               //           end: Alignment.bottomRight,
//               //         ),
//               // ),
//               padding: const EdgeInsets.all(2),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(10),
//                 child: Container(
//                   color: Theme.of(context).cardColor,
//                   child: _isInitialized && _videoController != null
//                       ? AspectRatio(
//                           aspectRatio: _videoController!.value.aspectRatio,
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               VideoPlayer(_videoController!),
//                               // Play button overlay
//                               // Icon(
//                               //   Icons.play_circle_outline,
//                               //   color: Colors.white.withOpacity(0.7),
//                               //   size: 40,
//                               // ),
//                             ],
//                           ),
//                         )
//                       : CachedNetworkImage(
//                           imageUrl: widget.advertisement.coverImageFullUrl ??
//                               store?.logoFullUrl ??
//                               Images.placeholder,
//                           fit: BoxFit.cover,
//                           placeholder: (context, url) => Container(
//                             color: Colors.grey[300],
//                           ),
//                           errorWidget: (context, url, error) => Icon(
//                             Icons.image,
//                             size: 30,
//                             color: Theme.of(context).hintColor,
//                           ),
//                         ),
//                 ),
//               ),
//             ),
//             // Store logo (if no profile image)
//             // if (widget.advertisement.profileImageFullUrl == null &&
//             //     store?.logoFullUrl != null)
//             //   Positioned(
//             //     bottom: 0,
//             //     right: 0,
//             //     child: Container(
//             //       decoration: BoxDecoration(
//             //         shape: BoxShape.circle,
//             //         border: Border.all(
//             //           color: Theme.of(context).cardColor,
//             //           width: 2,
//             //         ),
//             //       ),
//             //       child: ClipOval(
//             //         child: CachedNetworkImage(
//             //           imageUrl: store!.logoFullUrl!,
//             //           width: 40,
//             //           height: 40,
//             //           fit: BoxFit.cover,
//             //           placeholder: (context, url) => Container(
//             //             color: Colors.grey[300],
//             //           ),
//             //           errorWidget: (context, url, error) => Icon(
//             //             Icons.store,
//             //             size: 20,
//             //             color: Theme.of(context).hintColor,
//             //           ),
//             //         ),
//             //       ),
//             //     ),
//             //   ),
        
        
//           ],
//         ),
//       );
//     });
//   }
// }
// class StoryShimmer extends StatelessWidget {
//   const StoryShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//         vertical: Dimensions.paddingSizeDefault,
//         horizontal: Dimensions.paddingSizeSmall,
//       ),
//       child: SizedBox(
//         height: 90,
//         child: Shimmer(
//           child: ListView.separated(
//             scrollDirection: Axis.horizontal,
//             itemCount: 5, // Placeholder count
//             itemBuilder: (context, index) {
//               return Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: Colors.grey[300],
//                 ),
//               );
//             },
//             separatorBuilder: (context, index) => const SizedBox(
//               width: Dimensions.paddingSizeSmall,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


// class StoryViewScreen extends StatelessWidget {
//   final int initialIndex;
//   final List<AdvertisementModel> advertisements;

//   const StoryViewScreen({
//     super.key,
//     required this.initialIndex,
//     required this.advertisements,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Carousel of Stories
//           CarouselSlider.builder(
//             options: CarouselOptions(
//               initialPage: initialIndex,
//               height: MediaQuery.of(context).size.height,
//               viewportFraction: 1.0,
//               enableInfiniteScroll: false,
//               enlargeCenterPage: false,
//               onPageChanged: (index, reason) {
//                 Get.find<AdvertisementController>().setCurrentIndex(index, true);
//               },
//             ),
//             itemCount: advertisements.length,
//             itemBuilder: (context, index, realIndex) {
//               return SafeArea(
//                 child: HighlightVideoWidget (
//                   advertisement: advertisements[index],
//                   carouselController: CarouselSliderController(),
//                   index: index,
//                 ),
//               );
//             },
//           ),
//           // Close Button
//           Positioned(
//             top: 50,
//             right: 16,
//             child: IconButton(
//               icon: const Icon(Icons.close, color: Colors.white, size: 30),
//               onPressed: () => Get.back(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



// class HighlightVideoWidget extends StatefulWidget {
//   final AdvertisementModel advertisement;
//   final CarouselSliderController carouselController;
//   final int index;

//   const HighlightVideoWidget({
//     super.key,
//     required this.advertisement,
//     required this.carouselController,
//     required this.index,
//   });

//   @override
//   State<HighlightVideoWidget> createState() => _HighlightVideoWidgetState();
// }

// class _HighlightVideoWidgetState extends State<HighlightVideoWidget> with TickerProviderStateMixin {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   late AnimationController _progressController;
//   late AnimationController _buttonAnimationController;
//   late Animation<double> _progressAnimation;
//   late Animation<double> _buttonScaleAnimation;
//   bool _isVideoInitialized = false;
//   bool _hasError = false;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();

//     _progressController = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 8),
//     );
//     _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//       CurvedAnimation(parent: _progressController, curve: Curves.linear),
//     );

//     _buttonAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 600),
//     )..repeat(reverse: true);
//     _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
//       CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeInOut),
//     );
//   }

//   Future<void> initializePlayer() async {
//     if (widget.advertisement.videoAttachmentFullUrl == null || widget.advertisement.videoAttachmentFullUrl!.isEmpty) {
//       setState(() {
//         _hasError = true;
//       });
//       return;
//     }

//     _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.advertisement.videoAttachmentFullUrl!));

//     try {
//       await _videoPlayerController.initialize();
//       if (!mounted) return;

//       setState(() {
//         _isVideoInitialized = true;
//         _hasError = false;
//       });

//       _createChewieController();
//       _videoPlayerController.addListener(_videoListener);
//       _progressController.forward();
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _hasError = true;
//         });
//       }
//     }
//   }

//   void _createChewieController() {
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: false,
//       // aspectRatio: 9 / 16,
//       showControls: false,
//       materialProgressColors: ChewieProgressColors(
//         playedColor: Theme.of(context).primaryColor,
//         handleColor: Theme.of(context).primaryColor,
//         backgroundColor: Colors.white.withOpacity(0.3),
//         bufferedColor: Theme.of(context).primaryColor.withOpacity(0.5),
//       ),
//       errorBuilder: (context, errorMessage) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(Icons.error, color: Colors.white, size: 50),
//             const SizedBox(height: 8),
//             Text(
//               'Failed to load video',
//               style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
//             ),
//           ],
//         ),
//       ),
//     );
//     _chewieController?.setVolume(5);
//   }

//   void _videoListener() {
//     if (!_videoPlayerController.value.isInitialized) return;

//     if (_videoPlayerController.value.isPlaying && !_progressController.isAnimating) {
//       _progressController.forward();
//     } else if (!_videoPlayerController.value.isPlaying) {
//       _progressController.stop();
//     }

//     if (_videoPlayerController.value.position >= _videoPlayerController.value.duration) {
//       _progressController.forward(from: 1.0);
//       Future.delayed(Duration(seconds: GetPlatform.isWeb ? 2 : 0), () {
//         if (mounted) {
//           Get.find<AdvertisementController>().updateAutoPlayStatus(status: true, shouldUpdate: true);
//           widget.carouselController.nextPage();
//         }
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.removeListener(_videoListener);
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     _progressController.dispose();
//     _buttonAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AdvertisementController>(builder: (advertisementController) {
//       final advertisementList = advertisementController.advertisementList ?? [];
//       return Stack(
//         children: [
//           _hasError
//               ? Container(
//                   color: Colors.black,
//                   child: Center(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Icon(Icons.error, color: Colors.white, size: 50),
//                         const SizedBox(height: 8),
//                         Text(
//                           'Unable to load video',
//                           style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               : _isVideoInitialized && _chewieController != null
//                   ? Chewie(controller: _chewieController!)
//                   : Container(
//                       color: Colors.black,
//                       child: const Center(child: CircularProgressIndicator(color: Colors.white)),
//                     ),
//           Positioned.fill(
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTapDown: (details) {
//                 final screenWidth = MediaQuery.of(context).size.width;
//                 if (details.globalPosition.dx < screenWidth * 0.3) {
//                   _progressController.reset();
//                   widget.carouselController.previousPage();
//                 } else if (details.globalPosition.dx > screenWidth * 0.7) {
//                   _progressController.reset();
//                   widget.carouselController.nextPage();
//                 } else {
//                   if (_isVideoInitialized && _videoPlayerController.value.isPlaying) {
//                     _videoPlayerController.pause();
//                     _progressController.stop();
//                   } else if (_isVideoInitialized) {
//                     _videoPlayerController.play();
//                     _progressController.forward();
//                   }
//                 }
//               },
//               onLongPress: () {
//                 if (_isVideoInitialized) {
//                   _videoPlayerController.pause();
//                   _progressController.stop();
//                 }
//               },
//               onLongPressEnd: (_) {
//                 if (_isVideoInitialized) {
//                   _videoPlayerController.play();
//                   _progressController.forward();
//                 }
//               },
//             ),
//           ),
//           Positioned(
//             top: 16,
//             left: 16,
//             right: 16,
//             child: Row(
//               children: List.generate(
//                 advertisementList.length,
//                 (index) => Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 2),
//                     child: AnimatedBuilder(
//                       animation: _progressAnimation,
//                       builder: (context, child) {
//                         return LinearProgressIndicator(
//                           value: index == widget.index
//                               ? _progressAnimation.value
//                               : (index < widget.index ? 1.0 : 0.0),
//                           backgroundColor: Colors.white.withOpacity(0.3),
//                           valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
//                           minHeight: 3,
//                         );
//                       },
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
//                 ),
//               ),
//               padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     widget.advertisement.title ?? 'Untitled Story',
//                     style: TextStyle(
//                       fontSize: Dimensions.fontSizeLarge,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           blurRadius: 4,
//                           color: Colors.black.withOpacity(0.5),
//                           offset: const Offset(1, 1),
//                         ),
//                       ],
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 6),
//                   Text(
//                     widget.advertisement.description ?? 'No description available',
//                     style: TextStyle(
//                       fontSize: Dimensions.fontSizeSmall,
//                       color: Colors.white.withOpacity(0.9),
//                     ),
//                     maxLines: 2,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const SizedBox(height: 12),
//                   ScaleTransition(
//                     scale: _buttonScaleAnimation,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Get.toNamed(
//                         //   RouteHelper.getStoreRoute(id: widget.advertisement.storeId, page: 'store'),
//                         //   arguments: StoreScreen(
//                         //     store: Store(id: widget.advertisement.storeId),
//                         //     fromModule: false,
//                         //   ),
//                         // );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Theme.of(context).primaryColor,
//                         foregroundColor: Theme.of(context).cardColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         elevation: 2,
//                       ),
//                       child: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             'Visit Store',
//                             style: TextStyle(fontSize: Dimensions.fontSizeDefault),
//                           ),
//                           const SizedBox(width: 8),
//                           const Icon(Icons.arrow_forward_ios, size: 16),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           if (widget.advertisement.profileImageFullUrl != null && widget.advertisement.profileImageFullUrl!.isNotEmpty)
//             Positioned(
//               top: 60,
//               left: 16,
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Theme.of(context).cardColor, width: 2),
//                 ),
//                 child: ClipOval(
//                   child: CachedNetworkImage(
//                     imageUrl: widget.advertisement.profileImageFullUrl!,
//                     width: 40,
//                     height: 40,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => Container(color: Colors.grey[300]),
//                     errorWidget: (context, url, error) => Icon(
//                       Icons.store,
//                       size: 20,
//                       color: Theme.of(context).hintColor,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       );
//     });
//   }
// }






// class PromotionalVideoSection extends StatefulWidget {
//   const PromotionalVideoSection({super.key});

//   @override
//   State<PromotionalVideoSection> createState() => _PromotionalVideoSectionState();
// }

// class _PromotionalVideoSectionState extends State<PromotionalVideoSection> {
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AdvertisementController>(builder: (advertisementController) {
//       return advertisementController.advertisementList != null &&
//               advertisementController.advertisementList!.isNotEmpty
//           ? Container(
//               margin: const EdgeInsets.symmetric(vertical: 16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Section Header
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: Row(
//                       children: [
//                         Container(
//                           width: 4,
//                           height: 24,
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             borderRadius: BorderRadius.circular(2),
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Text(
//                           'HIGHLIGHTS',
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w700,
//                             color: Theme.of(context).textTheme.bodyLarge!.color,
//                             letterSpacing: -0.1,
//                           ),
//                         ),
//                         const Spacer(),
//                         GestureDetector(
//                           onTap: () {
//                             // Navigate to all reels
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).primaryColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   'View All',
//                                   style: TextStyle(
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w600,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 4),
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 12,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   // Reels List
//                   SizedBox(
//                     height: 230,
//                     child: ListView.separated(
//                       padding: const EdgeInsets.symmetric(horizontal: 16),
//                       scrollDirection: Axis.horizontal,
//                       physics: const BouncingScrollPhysics(),
//                       itemCount: advertisementController.advertisementList!.length,
//                       itemBuilder: (context, index) {
//                         final advertisement = advertisementController.advertisementList![index];
//                         return ReelsPreviewItem(
//                           advertisement: advertisement,
//                           isViewed: false,
//                           onTap: () {
//                             Get.to(
//                               () => ReelsViewScreen(
//                                 initialIndex: index,
//                                 advertisements: advertisementController.advertisementList ?? [],
//                               ),
//                               transition: Transition.fadeIn,
//                               duration: const Duration(milliseconds: 300),
//                             );
//                           },
//                         );
//                       },
//                       separatorBuilder: (context, index) => const SizedBox(width: 12),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           : advertisementController.advertisementList == null
//               ? const ReelsShimmer()
//               : const SizedBox();
//     });
//   }
// }

// class ReelsPreviewItem extends StatefulWidget {
//   final AdvertisementModel advertisement;
//   final bool isViewed;
//   final VoidCallback onTap;

//   const ReelsPreviewItem({
//     super.key,
//     required this.advertisement,
//     required this.isViewed,
//     required this.onTap,
//   });

//   @override
//   _ReelsPreviewItemState createState() => _ReelsPreviewItemState();
// }

// class _ReelsPreviewItemState extends State<ReelsPreviewItem>
//     with SingleTickerProviderStateMixin {
//   VideoPlayerController? _videoController;
//   bool _isInitialized = false;
//   late AnimationController _animationController;
//   late Animation<double> _scaleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
//       CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
//     );
//     _initializeVideoThumbnail();
//   }

//   Future<void> _initializeVideoThumbnail() async {
//     if (widget.advertisement.videoAttachmentFullUrl != null &&
//         widget.advertisement.videoAttachmentFullUrl!.isNotEmpty) {
//       _videoController = VideoPlayerController.networkUrl(
//         Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
//       );

//       try {
//         await _videoController!.initialize();
//         if (mounted) {
//           setState(() {
//             _isInitialized = true;
//           });
//           _videoController!.setVolume(0);
//           _videoController!.seekTo(const Duration(seconds: 1));
//         }
//       } catch (e) {
//         if (mounted) {
//           setState(() {
//             _isInitialized = false;
//           });
//         }
//       }
//     }
//   }

//   @override
//   void dispose() {
//     _videoController?.dispose();
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<StoreController>(builder: (storeController) {
//       Store? store = storeController.storeModel?.stores
//           ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

//       return GestureDetector(
//         onTapDown: (_) => _animationController.forward(),
//         onTapUp: (_) {
//           _animationController.reverse();
//           widget.onTap();
//         },
//         onTapCancel: () => _animationController.reverse(),
//         child: AnimatedBuilder(
//           animation: _scaleAnimation,
//           builder: (context, child) {
//             return Transform.scale(
//               scale: _scaleAnimation.value,
//               child: Container(
//                 width: 140,
//                 height: 230,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.1),
//                       blurRadius: 12,
//                       offset: const Offset(0, 4),
//                     ),
//                   ],
//                 ),
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(16),
//                   child: Stack(
//                     fit: StackFit.expand,
//                     children: [
//                       // Video/Image Background
//                       _isInitialized && _videoController != null
//                           ? FittedBox(
//                               fit: BoxFit.cover,
//                               child: SizedBox(
//                                 width: _videoController!.value.size.width,
//                                 height: _videoController!.value.size.height,
//                                 child: VideoPlayer(_videoController!),
//                               ),
//                             )
//                           : CachedNetworkImage(
//                               imageUrl: widget.advertisement.coverImageFullUrl ??
//                                   store?.logoFullUrl ??
//                                   Images.placeholder,
//                               fit: BoxFit.cover,
//                               placeholder: (context, url) => Container(
//                                 color: Colors.grey[200],
//                                 child: const Center(
//                                   child: CircularProgressIndicator(strokeWidth: 2),
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => Container(
//                                 color: Colors.grey[200],
//                                 child: Icon(
//                                   Icons.video_library_outlined,
//                                   size: 40,
//                                   color: Colors.grey[400],
//                                 ),
//                               ),
//                             ),
                      
//                       // Gradient Overlay
//                       Container(
//                         decoration: BoxDecoration(
//                           gradient: LinearGradient(
//                             begin: Alignment.topCenter,
//                             end: Alignment.bottomCenter,
//                             colors: [
//                               Colors.transparent,
//                               Colors.transparent,
//                               Colors.black.withOpacity(0.3),
//                               Colors.black.withOpacity(0.7),
//                             ],
//                             stops: const [0.0, 0.4, 0.7, 1.0],
//                           ),
//                         ),
//                       ),
                      
//                       // Play Icon
//                       Center(
//                         child: Container(
//                           width: 56,
//                           height: 56,
//                           decoration: BoxDecoration(
//                             color: Colors.white.withOpacity(0.9),
//                             shape: BoxShape.circle,
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(0.2),
//                                 blurRadius: 8,
//                                 offset: const Offset(0, 2),
//                               ),
//                             ],
//                           ),
//                           child: Icon(
//                             Icons.play_arrow_rounded,
//                             size: 32,
//                             color: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
                      
//                       // Bottom Content
//                       Positioned(
//                         bottom: 0,
//                         left: 0,
//                         right: 0,
//                         child: Container(
//                           padding: const EdgeInsets.all(12),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               // Store Info
//                               if (store != null)
//                                 Row(
//                                   children: [
//                                     Container(
//                                       width: 24,
//                                       height: 24,
//                                       decoration: BoxDecoration(
//                                         shape: BoxShape.circle,
//                                         border: Border.all(
//                                           color: Colors.white,
//                                           width: 1.5,
//                                         ),
//                                       ),
//                                       child: ClipOval(
//                                         child: CachedNetworkImage(
//                                           imageUrl: store.logoFullUrl ?? Images.placeholder,
//                                           fit: BoxFit.cover,
//                                           errorWidget: (context, url, error) =>
//                                               Container(
//                                             color: Colors.grey[300],
//                                             child: Icon(
//                                               Icons.store,
//                                               size: 12,
//                                               color: Colors.grey[600],
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Expanded(
//                                       child: Text(
//                                         store.name ?? 'Store',
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 11,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               const SizedBox(height: 6),
                              
//                               // Title
//                               Text(
//                                 widget.advertisement.title ?? 'Reel',
//                                 style: const TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                   height: 1.2,
//                                 ),
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
                              
//                               // View indicator
//                               const SizedBox(height: 4),
//                               Row(
//                                 children: [
//                                   const Icon(
//                                     Icons.play_arrow_rounded,
//                                     color: Colors.white70,
//                                     size: 14,
//                                   ),
//                                   const SizedBox(width: 2),
//                                   Text(
//                                     '${(widget.advertisement.id ?? 0) * 127 + 45}', // Mock view count
//                                     style: const TextStyle(
//                                       color: Colors.white70,
//                                       fontSize: 10,
//                                       fontWeight: FontWeight.w400,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
                      
//                       // Viewed Indicator
//                       if (widget.isViewed)
//                         Positioned(
//                           top: 8,
//                           right: 8,
//                           child: Container(
//                             width: 20,
//                             height: 20,
//                             decoration: BoxDecoration(
//                               color: Colors.white.withOpacity(0.9),
//                               shape: BoxShape.circle,
//                             ),
//                             child: Icon(
//                               Icons.check,
//                               size: 12,
//                               color: Theme.of(context).primaryColor,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//       );
//     });
//   }
// }

// class ReelsShimmer extends StatelessWidget {
//   const ReelsShimmer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Header Shimmer
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 // Shimmer.fromColors(
//                 //   baseColor: Colors.grey[300]!,
//                 //   highlightColor: Colors.grey[100]!,
//                 //   child: Container(
//                 //     width: 4,
//                 //     height: 24,
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.grey[300],
//                 //       borderRadius: BorderRadius.circular(2),
//                 //     ),
//                 //   ),
//                 // ),
//                 const SizedBox(width: 12),
//                 // Shimmer.fromColors(
//                 //   baseColor: Colors.grey[300]!,
//                 //   highlightColor: Colors.grey[100]!,
//                 //   child: Container(
//                 //     width: 80,
//                 //     height: 24,
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.grey[300],
//                 //       borderRadius: BorderRadius.circular(4),
//                 //     ),
//                 //   ),
//                 // ),
//                 const Spacer(),
//                 // Shimmer.fromColors(
//                 //   baseColor: Colors.grey[300]!,
//                 //   highlightColor: Colors.grey[100]!,
//                 //   child: Container(
//                 //     width: 60,
//                 //     height: 20,
//                 //     decoration: BoxDecoration(
//                 //       color: Colors.grey[300],
//                 //       borderRadius: BorderRadius.circular(10),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 16),
//           // Items Shimmer
//           // SizedBox(
//           //   height: 280,
//           //   child: ListView.separated(
//           //     padding: const EdgeInsets.symmetric(horizontal: 16),
//           //     scrollDirection: Axis.horizontal,
//           //     itemCount: 3,
//           //     itemBuilder: (context, index) {
//           //       return Shimmer.fromColors(
//           //         baseColor: Colors.grey[300]!,
//           //         highlightColor: Colors.grey[100]!,
//           //         child: Container(
//           //           width: 160,
//           //           height: 280,
//           //           decoration: BoxDecoration(
//           //             color: Colors.grey[300],
//           //             borderRadius: BorderRadius.circular(16),
//           //           ),
//           //         ),
//           //       );
//           //     },
//           //     separatorBuilder: (context, index) => const SizedBox(width: 12),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class ReelsViewScreen extends StatelessWidget {
//   final int initialIndex;
//   final List<AdvertisementModel> advertisements;

//   const ReelsViewScreen({
//     super.key,
//     required this.initialIndex,
//     required this.advertisements,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           // Page View for Reels
//           PageView.builder(
//             controller: PageController(initialPage: initialIndex),
//             scrollDirection: Axis.vertical,
//             physics: const BouncingScrollPhysics(),
//             onPageChanged: (index) {
//               Get.find<AdvertisementController>().setCurrentIndex(index, true);
//             },
//             itemCount: advertisements.length,
//             itemBuilder: (context, index) {
//               return ReelsVideoWidget(
//                 advertisement: advertisements[index],
//                 index: index,
//               );
//             },
//           ),
          
//           // Top Gradient
//           Positioned(
//             top: 0,
//             left: 0,
//             right: 0,
//             child: Container(
//               height: 100,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.6),
//                     Colors.transparent,
//                   ],
//                 ),
//               ),
//             ),
//           ),
          
//           // Header
//           Positioned(
//             top: MediaQuery.of(context).padding.top + 8,
//             left: 0,
//             right: 0,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
//                   onPressed: () => Get.back(),
//                 ),
//                 const Text(
//                   'Reels',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
//                   onPressed: () {
//                     // Show more options
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ReelsVideoWidget extends StatefulWidget {
//   final AdvertisementModel advertisement;
//   final int index;

//   const ReelsVideoWidget({
//     super.key,
//     required this.advertisement,
//     required this.index,
//   });

//   @override
//   State<ReelsVideoWidget> createState() => _ReelsVideoWidgetState();
// }

// class _ReelsVideoWidgetState extends State<ReelsVideoWidget>
//     with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
//   late VideoPlayerController _videoPlayerController;
//   ChewieController? _chewieController;
//   late AnimationController _heartAnimationController;
//   late AnimationController _likeAnimationController;
//   late Animation<double> _heartScaleAnimation;
//   late Animation<double> _likeScaleAnimation;
//   bool _isVideoInitialized = false;
//   bool _hasError = false;
//   bool _isLiked = false;
//   bool _showHeart = false;

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   void initState() {
//     super.initState();
//     initializePlayer();
    
//     _heartAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     );
//     _likeAnimationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
    
//     _heartScaleAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
//       CurvedAnimation(parent: _heartAnimationController, curve: Curves.elasticOut),
//     );
//     _likeScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
//       CurvedAnimation(parent: _likeAnimationController, curve: Curves.easeInOut),
//     );
//   }

//   Future<void> initializePlayer() async {
//     if (widget.advertisement.videoAttachmentFullUrl == null || 
//         widget.advertisement.videoAttachmentFullUrl!.isEmpty) {
//       setState(() {
//         _hasError = true;
//       });
//       return;
//     }

//     _videoPlayerController = VideoPlayerController.networkUrl(
//       Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
//     );

//     try {
//       await _videoPlayerController.initialize();
//       if (!mounted) return;

//       setState(() {
//         _isVideoInitialized = true;
//         _hasError = false;
//       });

//       _createChewieController();
//       _videoPlayerController.addListener(_videoListener);
//     } catch (e) {
//       if (mounted) {
//         setState(() {
//           _hasError = true;
//         });
//       }
//     }
//   }

//   void _createChewieController() {
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: true,
//       showControls: false,
//       aspectRatio: _videoPlayerController.value.aspectRatio,
//     );
//   }

//   void _videoListener() {
//     // Handle video state changes if needed
//   }

//   void _onDoubleTap() {
//     setState(() {
//       _isLiked = !_isLiked;
//       _showHeart = true;
//     });
    
//     _heartAnimationController.forward().then((_) {
//       Future.delayed(const Duration(milliseconds: 500), () {
//         if (mounted) {
//           setState(() {
//             _showHeart = false;
//           });
//           _heartAnimationController.reset();
//         }
//       });
//     });
//   }

//   void _toggleLike() {
//     setState(() {
//       _isLiked = !_isLiked;
//     });
    
//     _likeAnimationController.forward().then((_) {
//       _likeAnimationController.reverse();
//     });
//   }

//   @override
//   void dispose() {
//     _videoPlayerController.removeListener(_videoListener);
//     _videoPlayerController.dispose();
//     _chewieController?.dispose();
//     _heartAnimationController.dispose();
//     _likeAnimationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
    
//     return GetBuilder<StoreController>(builder: (storeController) {
//       Store? store = storeController.storeModel?.stores
//           ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

//       return Stack(
//         fit: StackFit.expand,
//         children: [
//           // Video Player
//           GestureDetector(
//             onDoubleTap: _onDoubleTap,
//             onTap: () {
//               if (_isVideoInitialized) {
//                 if (_videoPlayerController.value.isPlaying) {
//                   _videoPlayerController.pause();
//                 } else {
//                   _videoPlayerController.play();
//                 }
//               }
//             },
//             child: _hasError
//                 ? Container(
//                     color: Colors.black,
//                     child: const Center(
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(Icons.error_outline, color: Colors.white, size: 64),
//                           SizedBox(height: 16),
//                           Text(
//                             'Unable to load video',
//                             style: TextStyle(color: Colors.white, fontSize: 16),
//                           ),
//                         ],
//                       ),
//                     ),
//                   )
//                 : _isVideoInitialized && _chewieController != null
//                     ? Chewie(controller: _chewieController!)
//                     : Container(
//                         color: Colors.black,
//                         child: const Center(
//                           child: CircularProgressIndicator(color: Colors.white),
//                         ),
//                       ),
//           ),

//           // Double Tap Heart Animation
//           if (_showHeart)
//             Center(
//               child: AnimatedBuilder(
//                 animation: _heartScaleAnimation,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _heartScaleAnimation.value,
//                     child: const Icon(
//                       Icons.favorite,
//                       color: Colors.white,
//                       size: 100,
//                     ),
//                   );
//                 },
//               ),
//             ),

//           // Right Side Actions
//           Positioned(
//             right: 12,
//             bottom: 80,
//             child: Column(
//               children: [
//                 // Like Button
//                 GestureDetector(
//                   onTap: _toggleLike,
//                   child: AnimatedBuilder(
//                     animation: _likeScaleAnimation,
//                     builder: (context, child) {
//                       return Transform.scale(
//                         scale: _likeScaleAnimation.value,
//                         child: Column(
//                           children: [
//                             Icon(
//                               _isLiked ? Icons.favorite : Icons.favorite_border,
//                               color: _isLiked ? Colors.red : Colors.white,
//                               size: 32,
//                             ),
//                             const SizedBox(height: 4),
//                             Text(
//                               '${(widget.advertisement.id ?? 0) * 23 + 156}', // Mock likes
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//                 const SizedBox(height: 24),
                
//                 // Comment Button
//                 GestureDetector(
//                   onTap: () {
//                     // Show comments
//                   },
//                   child: const Column(
//                     children: [
//                       Icon(
//                         Icons.chat_bubble_outline,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         '24',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
                
//                 // Share Button
//                 GestureDetector(
//                   onTap: () {
//                     // Share functionality
//                   },
//                   child: const Column(
//                     children: [
//                       Icon(
//                         Icons.share_outlined,
//                         color: Colors.white,
//                         size: 32,
//                       ),
//                       SizedBox(height: 4),
//                       Text(
//                         'Share',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),
                
//                 // Store Avatar
//                 if (store != null)
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to store
//                     },
//                     child: Container(
//                       width: 40,
//                       height: 40,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         border: Border.all(color: Colors.white, width: 2),
//                       ),
//                       child: ClipOval(
//                         child: CachedNetworkImage(
//                           imageUrl: store.logoFullUrl ?? Images.placeholder,
//                           fit: BoxFit.cover,
//                           errorWidget: (context, url, error) => Container(
//                             color: Colors.grey[300],
//                             child: const Icon(Icons.store, size: 20),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//           ),

//           // Bottom Content
//           Positioned(
//             bottom: 0,
//             left: 0,
//             right: 70,
//             child: Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.transparent,
//                     Colors.black.withOpacity(0.8),
//                   ],
//                 ),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Store name and follow button
//                   if (store != null)
//                     Row(
//                       children: [
//                         Text(
//                           store.name ?? 'Store',
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Container(
//                           padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: const Text(
//                             'Follow',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   const SizedBox(height: 8),
                  
//                   // Description
//                   if (widget.advertisement.description != null)
//                     Text(
//                       widget.advertisement.description!,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         height: 1.3,
//                       ),
//                       maxLines: 3,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   const SizedBox(height: 8),
                  
//                   // Visit Store Button
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to store
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                       decoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                       child: const Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Icon(
//                             Icons.storefront,
//                             color: Colors.white,
//                             size: 16,
//                           ),
//                           SizedBox(width: 6),
//                           Text(
//                             'Visit Store',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 12,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),

//           // Pause/Play Indicator
//           if (_isVideoInitialized)
//             Center(
//               child: AnimatedOpacity(
//                 opacity: _videoPlayerController.value.isPlaying ? 0.0 : 1.0,
//                 duration: const Duration(milliseconds: 300),
//                 child: Container(
//                   width: 80,
//                   height: 80,
//                   decoration: BoxDecoration(
//                     color: Colors.black.withOpacity(0.6),
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.play_arrow,
//                     color: Colors.white,
//                     size: 40,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       );
//     });
//   }
// }




class PromotionalVideoSection extends StatefulWidget {
  const PromotionalVideoSection({super.key});

  @override
  State<PromotionalVideoSection> createState() => _PromotionalVideoSectionState();
}

class _PromotionalVideoSectionState extends State<PromotionalVideoSection> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertisementController>(builder: (advertisementController) {
      return advertisementController.advertisementList != null &&
              advertisementController.advertisementList!.isNotEmpty
          ? Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section Header
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Container(
                          width: 4,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'HIGHLIGHTS',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Theme.of(context).textTheme.bodyLarge!.color,
                            letterSpacing: -0.1,
                          ),
                        ),
                        const Spacer(),
                        // GestureDetector(
                        //   onTap: () {
                        //     // Navigate to all reels
                        //   },
                        //   child: Container(
                        //     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        //     decoration: BoxDecoration(
                        //       color: Theme.of(context).primaryColor.withOpacity(0.1),
                        //       borderRadius: BorderRadius.circular(20),
                        //     ),
                        //     child: Row(
                        //       mainAxisSize: MainAxisSize.min,
                        //       children: [
                        //         Text(
                        //           'View All',
                        //           style: TextStyle(
                        //             fontSize: 12,
                        //             fontWeight: FontWeight.w600,
                        //             color: Theme.of(context).primaryColor,
                        //           ),
                        //         ),
                        //         const SizedBox(width: 4),
                        //         Icon(
                        //           Icons.arrow_forward_ios,
                        //           size: 12,
                        //           color: Theme.of(context).primaryColor,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                   
                   
                   
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Reels List
                  SizedBox(
                    height: 230,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: advertisementController.advertisementList!.length,
                      itemBuilder: (context, index) {
                        final advertisement = advertisementController.advertisementList![index];
                        return ReelsPreviewItem(
                          advertisement: advertisement,
                          isViewed: false,
                          onTap: () {
                            // Check if context is still valid before navigation
                            if (mounted && context.mounted) {
                              Get.to(
                                () => ReelsViewScreen(
                                  initialIndex: index,
                                  advertisements: advertisementController.advertisementList ?? [],
                                ),
                                transition: Transition.fadeIn,
                                duration: const Duration(milliseconds: 300),
                              );
                            }
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(width: 12),
                    ),
                  ),
                ],
              ),
            )
          : advertisementController.advertisementList == null
              ? const ReelsShimmer()
              : const SizedBox();
    });
  }
}

class ReelsPreviewItem extends StatefulWidget {
  final AdvertisementModel advertisement;
  final bool isViewed;
  final VoidCallback onTap;

  const ReelsPreviewItem({
    super.key,
    required this.advertisement,
    required this.isViewed,
    required this.onTap,
  });

  @override
  _ReelsPreviewItemState createState() => _ReelsPreviewItemState();
}

class _ReelsPreviewItemState extends State<ReelsPreviewItem>
    with SingleTickerProviderStateMixin {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _initializeVideoThumbnail();
  }

  Future<void> _initializeVideoThumbnail() async {
    if (_isDisposed) return;
    
    if (widget.advertisement.videoAttachmentFullUrl != null &&
        widget.advertisement.videoAttachmentFullUrl!.isNotEmpty) {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
      );

      try {
        await _videoController!.initialize();
        if (!_isDisposed && mounted) {
          setState(() {
            _isInitialized = true;
          });
          _videoController!.setVolume(0);
          _videoController!.seekTo(const Duration(seconds: 1));
        }
      } catch (e) {
        if (!_isDisposed && mounted) {
          setState(() {
            _isInitialized = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoController?.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      Store? store = storeController.storeModel?.stores
          ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

      return GestureDetector(
        onTapDown: (_) {
          if (!_isDisposed && mounted) {
            _animationController.forward();
          }
        },
        onTapUp: (_) {
          if (!_isDisposed && mounted) {
            _animationController.reverse();
            widget.onTap();
          }
        },
        onTapCancel: () {
          if (!_isDisposed && mounted) {
            _animationController.reverse();
          }
        },
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: 140,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Video/Image Background
                      _isInitialized && _videoController != null
                          ? FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController!.value.size.width,
                                height: _videoController!.value.size.height,
                                child: VideoPlayer(_videoController!),
                              ),
                            )
                          : CachedNetworkImage(
                              imageUrl: widget.advertisement.coverImageFullUrl ??
                                  store?.logoFullUrl ??
                                  Images.placeholder,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: CircularProgressIndicator(strokeWidth: 2),
                                ),
                              ),
                              errorWidget: (context, url, error) => Container(
                                color: Colors.grey[200],
                                child: Icon(
                                  Icons.video_library_outlined,
                                  size: 40,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                      
                      // Gradient Overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                            ],
                            stops: const [0.0, 0.4, 0.7, 1.0],
                          ),
                        ),
                      ),
                      
                      // Play Icon
                      Center(
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.play_arrow_rounded,
                            size: 32,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      
                      // Bottom Content
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Store Info
                              if (store != null)
                                Row(
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl: store.logoFullUrl ?? Images.placeholder,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            color: Colors.grey[300],
                                            child: Icon(
                                              Icons.store,
                                              size: 12,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        store.name ?? 'Store',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              const SizedBox(height: 6),
                              
                              // Title
                              Text(
                                widget.advertisement.title ?? 'Reel',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  height: 1.2,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              
                              // View indicator
                              // const SizedBox(height: 4),
                              // Row(
                              //   children: [
                              //     const Icon(
                              //       Icons.play_arrow_rounded,
                              //       color: Colors.white70,
                              //       size: 14,
                              //     ),
                              //     const SizedBox(width: 2),
                              //     Text(
                              //       '${(widget.advertisement.id ?? 0) * 127 + 45}', // Mock view count
                              //       style: const TextStyle(
                              //         color: Colors.white70,
                              //         fontSize: 10,
                              //         fontWeight: FontWeight.w400,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                            ],
                          ),
                        ),
                      ),
                      
                      // Viewed Indicator
                      if (widget.isViewed)
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.check,
                              size: 12,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}

class ReelsViewScreen extends StatelessWidget {
  final int initialIndex;
  final List<AdvertisementModel> advertisements;

  const ReelsViewScreen({
    super.key,
    required this.initialIndex,
    required this.advertisements,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Page View for Reels
          PageView.builder(
            controller: PageController(initialPage: initialIndex),
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            onPageChanged: (index) {
              // Use try-catch to prevent errors if controller is disposed
              try {
                Get.find<AdvertisementController>().setCurrentIndex(index, true);
              } catch (e) {
                // Handle case where controller might be disposed
                print('Error updating current index: $e');
              }
            },
            itemCount: advertisements.length,
            itemBuilder: (context, index) {
              return ReelsVideoWidget(
                advertisement: advertisements[index],
                index: index,
              );
            },
          ),
          
          // Top Gradient
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          
          // Header
          Positioned(
            top: MediaQuery.of(context).padding.top + 8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 24),
                  onPressed: () {
                    if (context.mounted) {
                      Get.back();
                    }
                  },
                ),
                const Text(
                  'Highlight Videos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(width: 24),
                // IconButton(
                //   icon: const Icon(Icons.more_vert, color: Colors.white, size: 24),
                //   onPressed: () {
                //     // Show more options
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ReelsVideoWidget extends StatefulWidget {
  final AdvertisementModel advertisement;
  final int index;

  const ReelsVideoWidget({
    super.key,
    required this.advertisement,
    required this.index,
  });

  @override
  State<ReelsVideoWidget> createState() => _ReelsVideoWidgetState();
}

class _ReelsVideoWidgetState extends State<ReelsVideoWidget>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late AnimationController _heartAnimationController;
  late AnimationController _likeAnimationController;
  late Animation<double> _heartScaleAnimation;
  late Animation<double> _likeScaleAnimation;
  bool _isVideoInitialized = false;
  bool _hasError = false;
  bool _isLiked = false;
  bool _showHeart = false;
  bool _isDisposed = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    initializePlayer();
    
    _heartAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _likeAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    
    _heartScaleAnimation = Tween<double>(begin: 0.0, end: 1.2).animate(
      CurvedAnimation(parent: _heartAnimationController, curve: Curves.elasticOut),
    );
    _likeScaleAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _likeAnimationController, curve: Curves.easeInOut),
    );
  }

  Future<void> initializePlayer() async {
    if (_isDisposed) return;
    
    if (widget.advertisement.videoAttachmentFullUrl == null || 
        widget.advertisement.videoAttachmentFullUrl!.isEmpty) {
      if (!_isDisposed && mounted) {
        setState(() {
          _hasError = true;
        });
      }
      return;
    }

    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
    );

    try {
      await _videoPlayerController.initialize();
      if (_isDisposed || !mounted) return;

      setState(() {
        _isVideoInitialized = true;
        _hasError = false;
      });

      _createChewieController();
      _videoPlayerController.addListener(_videoListener);
    } catch (e) {
      if (!_isDisposed && mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _createChewieController() {
    if (_isDisposed) return;
    
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      showControls: false,
      aspectRatio: _videoPlayerController.value.aspectRatio,
    );
  }

  void _videoListener() {
    // Handle video state changes if needed
    if (_isDisposed || !mounted) return;
    // Add any video state change logic here
  }

  void _onDoubleTap() {
    if (_isDisposed || !mounted) return;
    
    setState(() {
      _isLiked = !_isLiked;
      _showHeart = true;
    });
    
    _heartAnimationController.forward().then((_) {
      if (_isDisposed || !mounted) return;
      
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!_isDisposed && mounted) {
          setState(() {
            _showHeart = false;
          });
          _heartAnimationController.reset();
        }
      });
    });
  }

  void _toggleLike() {
    if (_isDisposed || !mounted) return;
    
    setState(() {
      _isLiked = !_isLiked;
    });
    
    _likeAnimationController.forward().then((_) {
      if (!_isDisposed && mounted) {
        _likeAnimationController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _heartAnimationController.dispose();
    _likeAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    
    return GetBuilder<StoreController>(builder: (storeController) {
      Store? store = storeController.storeModel?.stores
          ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

      return Stack(
        fit: StackFit.expand,
        children: [
          // Video Player
          GestureDetector(
            onDoubleTap: _onDoubleTap,
            onTap: () {
              if (_isDisposed || !mounted) return;
              
              if (_isVideoInitialized) {
                if (_videoPlayerController.value.isPlaying) {
                  _videoPlayerController.pause();
                } else {
                  _videoPlayerController.play();
                }
              }
            },
            child: _hasError
                ? Container(
                    color: Colors.black,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.white, size: 64),
                          SizedBox(height: 16),
                          Text(
                            'Unable to load video',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  )
                : _isVideoInitialized && _chewieController != null
                    ? Chewie(controller: _chewieController!)
                    : Container(
                        color: Colors.black,
                        child: const Center(
                          child: CircularProgressIndicator(color: Colors.white),
                        ),
                      ),
          ),

          // Double Tap Heart Animation
          if (_showHeart)
            Center(
              child: AnimatedBuilder(
                animation: _heartScaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _heartScaleAnimation.value,
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 100,
                    ),
                  );
                },
              ),
            ),

          // Right Side Actions
          // Positioned(
          //   right: 12,
          //   bottom: 80,
          //   child: Column(
          //     children: [
          //       // Like Button
          //       GestureDetector(
          //         onTap: _toggleLike,
          //         child: AnimatedBuilder(
          //           animation: _likeScaleAnimation,
          //           builder: (context, child) {
          //             return Transform.scale(
          //               scale: _likeScaleAnimation.value,
          //               child: Column(
          //                 children: [
          //                   Icon(
          //                     _isLiked ? Icons.favorite : Icons.favorite_border,
          //                     color: _isLiked ? Colors.red : Colors.white,
          //                     size: 32,
          //                   ),
          //                   const SizedBox(height: 4),
          //                   Text(
          //                     '${(widget.advertisement.id ?? 0) * 23 + 156}', // Mock likes
          //                     style: const TextStyle(
          //                       color: Colors.white,
          //                       fontSize: 12,
          //                       fontWeight: FontWeight.w500,
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //             );
          //           },
          //         ),
          //       ),
          //       const SizedBox(height: 24),
                
          //       // Comment Button
          //       GestureDetector(
          //         onTap: () {
          //           // Show comments
          //         },
          //         child: const Column(
          //           children: [
          //             Icon(
          //               Icons.chat_bubble_outline,
          //               color: Colors.white,
          //               size: 32,
          //             ),
          //             SizedBox(height: 4),
          //             Text(
          //               '24',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(height: 24),
                
          //       // Share Button
          //       GestureDetector(
          //         onTap: () {
          //           // Share functionality
          //         },
          //         child: const Column(
          //           children: [
          //             Icon(
          //               Icons.share_outlined,
          //               color: Colors.white,
          //               size: 32,
          //             ),
          //             SizedBox(height: 4),
          //             Text(
          //               'Share',
          //               style: TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //                 fontWeight: FontWeight.w500,
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       const SizedBox(height: 24),
                
          //       // Store Avatar
          //       if (store != null)
          //         GestureDetector(
          //           onTap: () {
          //             // Navigate to store
          //           },
          //           child: Container(
          //             width: 40,
          //             height: 40,
          //             decoration: BoxDecoration(
          //               shape: BoxShape.circle,
          //               border: Border.all(color: Colors.white, width: 2),
          //             ),
          //             child: ClipOval(
          //               child: CachedNetworkImage(
          //                 imageUrl: store.logoFullUrl ?? Images.placeholder,
          //                 fit: BoxFit.cover,
          //                 errorWidget: (context, url, error) => Container(
          //                   color: Colors.grey[300],
          //                   child: const Icon(Icons.store, size: 20),
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //     ],
          //   ),
          // ),

          // Bottom Content
          Positioned(
            bottom: 0,
            left: 0,
            right: 70,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Store name and follow button
                  if (store != null)
                    Row(
                      children: [
                        Text(
                          store.name ?? 'Store',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // const SizedBox(width: 12),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(color: Colors.white),
                        //     borderRadius: BorderRadius.circular(4),
                        //   ),
                        //   child: const Text(
                        //     'Follow',
                        //     style: TextStyle(
                        //       color: Colors.white,
                        //       fontSize: 12,
                        //       fontWeight: FontWeight.w500,
                        //     ),
                        //   ),
                        // ),
                   
                   
                      ],
                    ),
                  const SizedBox(height: 8),
                  
                  // Description
                  if (widget.advertisement.description != null)
                    Text(
                      widget.advertisement.description!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        height: 1.3,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  const SizedBox(height: 8),
                  
                  // Visit Store Button
                  GestureDetector(
                    onTap: () {
                   Get.toNamed(
            RouteHelper.getStoreRoute(id: store!.id, page: 'store'),
            arguments: StoreScreen(store: store, fromModule: false),
          );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.storefront,
                            color: Colors.white,
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Visit Store',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Pause/Play Indicator
          if (_isVideoInitialized)
            Center(
              child: AnimatedOpacity(
                opacity: _videoPlayerController.value.isPlaying ? 0.0 : 1.0,
                duration: const Duration(milliseconds: 300),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}

class ReelsShimmer extends StatelessWidget {
  const ReelsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Shimmer
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Shimmer.fromColors(
                //   baseColor: Colors.grey[300]!,
                //   highlightColor: Colors.grey[100]!,
                //   child: Container(
                //     width: 4,
                //     height: 24,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(2),
                //     ),
                //   ),
                // ),
                const SizedBox(width: 12),
                // Shimmer.fromColors(
                //   baseColor: Colors.grey[300]!,
                //   highlightColor: Colors.grey[100]!,
                //   child: Container(
                //     width: 80,
                //     height: 24,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(4),
                //     ),
                //   ),
                // ),
                const Spacer(),
                // Shimmer.fromColors(
                //   baseColor: Colors.grey[300]!,
                //   highlightColor: Colors.grey[100]!,
                //   child: Container(
                //     width: 60,
                //     height: 20,
                //     decoration: BoxDecoration(
                //       color: Colors.grey[300],
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Items Shimmer
          // SizedBox(
          //   height: 280,
          //   child: ListView.separated(
          //     padding: const EdgeInsets.symmetric(horizontal: 16),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 3,
          //     itemBuilder: (context, index) {
          //       return Shimmer.fromColors(
          //         baseColor: Colors.grey[300]!,
          //         highlightColor: Colors.grey[100]!,
          //         child: Container(
          //           width: 160,
          //           height: 280,
          //           decoration: BoxDecoration(
          //             color: Colors.grey[300],
          //             borderRadius: BorderRadius.circular(16),
          //           ),
          //         ),
          //       );
          //     },
          //     separatorBuilder: (context, index) => const SizedBox(width: 12),
          //   ),
          // ),
        ],
      ),
    );
  }
}