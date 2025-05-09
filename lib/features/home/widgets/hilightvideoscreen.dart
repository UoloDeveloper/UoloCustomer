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
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:video_player/video_player.dart';




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
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: Dimensions.paddingSizeDefault,
                horizontal: Dimensions.paddingSizeSmall,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Optional: Section Title
                  Padding(
                    padding: const EdgeInsets.only(
                      left: Dimensions.paddingSizeDefault,
                      bottom: Dimensions.paddingSizeSmall,
                    ),
                    child: Text(
                      'Highlights',
                      style: TextStyle(
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).textTheme.bodyLarge!.color,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 300, 
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: advertisementController.advertisementList!.length,
                      itemBuilder: (context, index) {
                        final advertisement = advertisementController.advertisementList![index];
                        // final isViewed = advertisementController.isStoryViewed(index); 
                        return StoryPreviewItem(
                          advertisement: advertisement,
                          isViewed: false,
                          onTap: () {
                            Get.to(StoryViewScreen(initialIndex: index, advertisements:  advertisementController.advertisementList ?? [],));
                            // Navigate to full-screen story view
                            // Get.toNamed(
                            //   RouteHelper.getStoryViewRoute(),
                            //   arguments: {
                            //     'initialIndex': index,
                            //     'advertisements': advertisementController.advertisementList,
                            //   },
                            // );
                          },
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                        width: Dimensions.paddingSizeExtraSmall,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : advertisementController.advertisementList == null
              ? const StoryShimmer()
              : const SizedBox();
    });
  }
}

// class StoryPreviewItem extends StatelessWidget {
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
//   Widget build(BuildContext context) {
//     return GetBuilder<StoreController>(builder: (storeController) { 
//       Store? store = storeController.storeModel?.stores!.firstWhere((store) => store.id == advertisement.storeId);
//       print( 'Store: ${store?.name} Store id :  ${store?.id} Advertisement id : ${advertisement.storeId}'  );
//         return GestureDetector(
//           onTap: onTap,
//           child: Stack(
//             alignment: Alignment.center,
//             children: [
//               // Gradient Border
//               Container(
//                 width: 120,
//                 height: 150,
//                 decoration: BoxDecoration(
//                   // image:  DecorationImage(
//                   //   image: CachedNetworkImageProvider(advertisement.videoAttachmentFullUrl ?? advertisement.videoAttachmentFullUrl ?? Images.placeholder),
//                   //   fit: BoxFit.cover,
//                   // ),
//                   borderRadius: BorderRadius.circular(12),
//                   shape: BoxShape.rectangle,
//                   gradient: isViewed
//                       ? const LinearGradient(
//                           colors: [Colors.grey, Colors.grey],
//                         )
//                       : const LinearGradient(
//                           colors: [Colors.pink, Colors.orange],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                 ),
//                 padding: const EdgeInsets.all(2),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Theme.of(context).cardColor,
//                   ),
//                   child: CachedNetworkImage(
//                     imageUrl:  advertisement.coverImageFullUrl ?? advertisement.videoAttachmentFullUrl ?? store!.logoFullUrl ?? Images.placeholder,
//                     width: 80,
//                     height: 80,
//                     fit: BoxFit.cover,
//                     placeholder: (context, url) => Container(
//                       color: Colors.grey[300],
//                     ),
//                     errorWidget: (context, url, error) => Icon(
//                       Icons.image,
//                       size: 30,
//                       color: Theme.of(context).hintColor,
//                     ),
//                   ),
//                 ),
//               ),
           
//               // if (advertisement.profileImageFullUrl == null)
//               //   Positioned(
//               //     bottom: 0,
//               //     right: 0,
//               //     child: Container(
//               //       decoration: BoxDecoration(
//               //         shape: BoxShape.circle,
//               //         border: Border.all(
//               //           color: Theme.of(context).cardColor,
//               //           width: 2,
//               //         ),
//               //       ),
//               //       child: CustomImage(image: advertisement!.store!.logoFullUrl  ?? Images.placeholder, width: 40, height: 40, fit: BoxFit.cover),
//               //     ),
//               //   ),
//             ],
//           ),
//         );
//       }
//     );
//   }
// }


class StoryPreviewItem extends StatefulWidget {
  final AdvertisementModel advertisement;
  final bool isViewed;
  final VoidCallback onTap;

  const StoryPreviewItem({
    super.key,
    required this.advertisement,
    required this.isViewed,
    required this.onTap,
  });

  @override
  _StoryPreviewItemState createState() => _StoryPreviewItemState();
}

class _StoryPreviewItemState extends State<StoryPreviewItem> {
  VideoPlayerController? _videoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoThumbnail();
  }

  Future<void> _initializeVideoThumbnail() async {
    if (widget.advertisement.videoAttachmentFullUrl != null &&
        widget.advertisement.videoAttachmentFullUrl!.isNotEmpty) {
      _videoController = VideoPlayerController.networkUrl(
        Uri.parse(widget.advertisement.videoAttachmentFullUrl!),
      );

      try {
        await _videoController!.initialize();
        if (mounted) {
          setState(() {
            _isInitialized = true;
          });
          _videoController!.setVolume(0); 
          _videoController!.seekTo( Duration(seconds: 0)); 
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isInitialized = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StoreController>(builder: (storeController) {
      Store? store = storeController.storeModel?.stores
          ?.firstWhereOrNull((store) => store.id == widget.advertisement.storeId);

      return GestureDetector(
        onTap: widget.onTap,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Gradient Border
            Container(
              width: 180,
              height: 300,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(12),
              //   gradient: widget.isViewed
              //       ? const LinearGradient(
              //           colors: [Colors.grey, Colors.grey],
              //         )
              //       : const LinearGradient(
              //           colors: [Colors.pink, Colors.orange],
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //         ),
              // ),
              padding: const EdgeInsets.all(2),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  color: Theme.of(context).cardColor,
                  child: _isInitialized && _videoController != null
                      ? AspectRatio(
                          aspectRatio: _videoController!.value.aspectRatio,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              VideoPlayer(_videoController!),
                              // Play button overlay
                              // Icon(
                              //   Icons.play_circle_outline,
                              //   color: Colors.white.withOpacity(0.7),
                              //   size: 40,
                              // ),
                            ],
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: widget.advertisement.coverImageFullUrl ??
                              store?.logoFullUrl ??
                              Images.placeholder,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) => Icon(
                            Icons.image,
                            size: 30,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                ),
              ),
            ),
            // Store logo (if no profile image)
            // if (widget.advertisement.profileImageFullUrl == null &&
            //     store?.logoFullUrl != null)
            //   Positioned(
            //     bottom: 0,
            //     right: 0,
            //     child: Container(
            //       decoration: BoxDecoration(
            //         shape: BoxShape.circle,
            //         border: Border.all(
            //           color: Theme.of(context).cardColor,
            //           width: 2,
            //         ),
            //       ),
            //       child: ClipOval(
            //         child: CachedNetworkImage(
            //           imageUrl: store!.logoFullUrl!,
            //           width: 40,
            //           height: 40,
            //           fit: BoxFit.cover,
            //           placeholder: (context, url) => Container(
            //             color: Colors.grey[300],
            //           ),
            //           errorWidget: (context, url, error) => Icon(
            //             Icons.store,
            //             size: 20,
            //             color: Theme.of(context).hintColor,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
        
        
          ],
        ),
      );
    });
  }
}
class StoryShimmer extends StatelessWidget {
  const StoryShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: Dimensions.paddingSizeDefault,
        horizontal: Dimensions.paddingSizeSmall,
      ),
      child: SizedBox(
        height: 90,
        child: Shimmer(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5, // Placeholder count
            itemBuilder: (context, index) {
              return Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey[300],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: Dimensions.paddingSizeSmall,
            ),
          ),
        ),
      ),
    );
  }
}


class StoryViewScreen extends StatelessWidget {
  final int initialIndex;
  final List<AdvertisementModel> advertisements;

  const StoryViewScreen({
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
          // Carousel of Stories
          CarouselSlider.builder(
            options: CarouselOptions(
              initialPage: initialIndex,
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              enableInfiniteScroll: false,
              enlargeCenterPage: false,
              onPageChanged: (index, reason) {
                Get.find<AdvertisementController>().setCurrentIndex(index, true);
              },
            ),
            itemCount: advertisements.length,
            itemBuilder: (context, index, realIndex) {
              return SafeArea(
                child: HighlightVideoWidget (
                  advertisement: advertisements[index],
                  carouselController: CarouselSliderController(),
                  index: index,
                ),
              );
            },
          ),
          // Close Button
          Positioned(
            top: 50,
            right: 16,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Get.back(),
            ),
          ),
        ],
      ),
    );
  }
}



class HighlightVideoWidget extends StatefulWidget {
  final AdvertisementModel advertisement;
  final CarouselSliderController carouselController;
  final int index;

  const HighlightVideoWidget({
    super.key,
    required this.advertisement,
    required this.carouselController,
    required this.index,
  });

  @override
  State<HighlightVideoWidget> createState() => _HighlightVideoWidgetState();
}

class _HighlightVideoWidgetState extends State<HighlightVideoWidget> with TickerProviderStateMixin {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  late AnimationController _progressController;
  late AnimationController _buttonAnimationController;
  late Animation<double> _progressAnimation;
  late Animation<double> _buttonScaleAnimation;
  bool _isVideoInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.linear),
    );

    _buttonAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _buttonAnimationController, curve: Curves.easeInOut),
    );
  }

  Future<void> initializePlayer() async {
    if (widget.advertisement.videoAttachmentFullUrl == null || widget.advertisement.videoAttachmentFullUrl!.isEmpty) {
      setState(() {
        _hasError = true;
      });
      return;
    }

    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.advertisement.videoAttachmentFullUrl!));

    try {
      await _videoPlayerController.initialize();
      if (!mounted) return;

      setState(() {
        _isVideoInitialized = true;
        _hasError = false;
      });

      _createChewieController();
      _videoPlayerController.addListener(_videoListener);
      _progressController.forward();
    } catch (e) {
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
      // aspectRatio: 9 / 16,
      showControls: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Theme.of(context).primaryColor,
        handleColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white.withOpacity(0.3),
        bufferedColor: Theme.of(context).primaryColor.withOpacity(0.5),
      ),
      errorBuilder: (context, errorMessage) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, color: Colors.white, size: 50),
            const SizedBox(height: 8),
            Text(
              'Failed to load video',
              style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
            ),
          ],
        ),
      ),
    );
    _chewieController?.setVolume(5);
  }

  void _videoListener() {
    if (!_videoPlayerController.value.isInitialized) return;

    if (_videoPlayerController.value.isPlaying && !_progressController.isAnimating) {
      _progressController.forward();
    } else if (!_videoPlayerController.value.isPlaying) {
      _progressController.stop();
    }

    if (_videoPlayerController.value.position >= _videoPlayerController.value.duration) {
      _progressController.forward(from: 1.0);
      Future.delayed(Duration(seconds: GetPlatform.isWeb ? 2 : 0), () {
        if (mounted) {
          Get.find<AdvertisementController>().updateAutoPlayStatus(status: true, shouldUpdate: true);
          widget.carouselController.nextPage();
        }
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController.removeListener(_videoListener);
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    _progressController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AdvertisementController>(builder: (advertisementController) {
      final advertisementList = advertisementController.advertisementList ?? [];
      return Stack(
        children: [
          _hasError
              ? Container(
                  color: Colors.black,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error, color: Colors.white, size: 50),
                        const SizedBox(height: 8),
                        Text(
                          'Unable to load video',
                          style: TextStyle(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
                        ),
                      ],
                    ),
                  ),
                )
              : _isVideoInitialized && _chewieController != null
                  ? Chewie(controller: _chewieController!)
                  : Container(
                      color: Colors.black,
                      child: const Center(child: CircularProgressIndicator(color: Colors.white)),
                    ),
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapDown: (details) {
                final screenWidth = MediaQuery.of(context).size.width;
                if (details.globalPosition.dx < screenWidth * 0.3) {
                  _progressController.reset();
                  widget.carouselController.previousPage();
                } else if (details.globalPosition.dx > screenWidth * 0.7) {
                  _progressController.reset();
                  widget.carouselController.nextPage();
                } else {
                  if (_isVideoInitialized && _videoPlayerController.value.isPlaying) {
                    _videoPlayerController.pause();
                    _progressController.stop();
                  } else if (_isVideoInitialized) {
                    _videoPlayerController.play();
                    _progressController.forward();
                  }
                }
              },
              onLongPress: () {
                if (_isVideoInitialized) {
                  _videoPlayerController.pause();
                  _progressController.stop();
                }
              },
              onLongPressEnd: (_) {
                if (_isVideoInitialized) {
                  _videoPlayerController.play();
                  _progressController.forward();
                }
              },
            ),
          ),
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Row(
              children: List.generate(
                advertisementList.length,
                (index) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: AnimatedBuilder(
                      animation: _progressAnimation,
                      builder: (context, child) {
                        return LinearProgressIndicator(
                          value: index == widget.index
                              ? _progressAnimation.value
                              : (index < widget.index ? 1.0 : 0.0),
                          backgroundColor: Colors.white.withOpacity(0.3),
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          minHeight: 3,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.advertisement.title ?? 'Untitled Story',
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeLarge,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 4,
                          color: Colors.black.withOpacity(0.5),
                          offset: const Offset(1, 1),
                        ),
                      ],
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.advertisement.description ?? 'No description available',
                    style: TextStyle(
                      fontSize: Dimensions.fontSizeSmall,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  ScaleTransition(
                    scale: _buttonScaleAnimation,
                    child: ElevatedButton(
                      onPressed: () {
                        // Get.toNamed(
                        //   RouteHelper.getStoreRoute(id: widget.advertisement.storeId, page: 'store'),
                        //   arguments: StoreScreen(
                        //     store: Store(id: widget.advertisement.storeId),
                        //     fromModule: false,
                        //   ),
                        // );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Theme.of(context).cardColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        elevation: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Visit Store',
                            style: TextStyle(fontSize: Dimensions.fontSizeDefault),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (widget.advertisement.profileImageFullUrl != null && widget.advertisement.profileImageFullUrl!.isNotEmpty)
            Positioned(
              top: 60,
              left: 16,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Theme.of(context).cardColor, width: 2),
                ),
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: widget.advertisement.profileImageFullUrl!,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(color: Colors.grey[300]),
                    errorWidget: (context, url, error) => Icon(
                      Icons.store,
                      size: 20,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ),
              ),
            ),
        ],
      );
    });
  }
}