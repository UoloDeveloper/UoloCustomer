import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/common/widgets/custom_ink_well.dart';
import 'package:sixam_mart/features/home/widgets/module_view.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class Fashionmoduleview extends StatefulWidget {
    final SplashController splashController;
  const Fashionmoduleview({super.key, required this.splashController});

  @override
  State<Fashionmoduleview> createState() => _FashionmoduleviewState();
}

class _FashionmoduleviewState extends State<Fashionmoduleview> {
  @override
  Widget build(BuildContext context) {
    
  // ModuleModel fashionmodule = widget.splashController.moduleList!.removeWhere((element) {
  //   element.moduleType != AppConstants.ecommerce;
  // },);
    List<ModuleModel> fashionModules = [];
List<int> fashionModuleIndices = [];

for (int i = 0; i < widget.splashController.moduleList!.length; i++) {
  if (widget.splashController.moduleList![i].moduleType == AppConstants.ecommerce) {
    fashionModules.add(widget.splashController.moduleList![i]);
    fashionModuleIndices.add(i);
  }
}


    return Scaffold(
      backgroundColor:Theme.of(context).primaryColor ,
      body: Container(
        // height: 300,
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.splashController.moduleList != null ?widget. splashController.moduleList!.isNotEmpty ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisSpacing: Dimensions.paddingSizeSmall,
                crossAxisSpacing: Dimensions.paddingSizeDefault, childAspectRatio: (1/1.3),
              ),
              padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
              itemCount:fashionModules.length,
              shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return
                  //        Container(
                  //         decoration: BoxDecoration(
                  //           borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                  //           color: Theme.of(context).cardColor,
                  //           // border: Border.all(color: Theme.of(context).primaryColor, width: 0.15),
                  //           boxShadow: [BoxShadow(color: Theme.of(context).disabledColor.withOpacity(0.1), spreadRadius: 1, blurRadius: 3)],
                  //         ),
                  //         child: CustomInkWell(
                  //           onTap: () => splashController.switchModule(index, true),
                  //           radius: Dimensions.radiusDefault,
                  //           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  //  Align(
                  //    alignment: Alignment.centerLeft,
                  //    child: Padding(
                  //  padding: const EdgeInsets.only(left: Dimensions.paddingSizeSmall,right: Dimensions.paddingSizeSmall,top: Dimensions.paddingSizeSmall),
                  //  child: Text(
                  //                   splashController.moduleList![index].moduleName! ,
                  //                   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //                   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  //                 ),
                  //    ),
                  //  ),
                  //   const SizedBox(height: Dimensions.paddingSizeSmall),
                  //             Padding(
                  //               padding: const EdgeInsets.only(left: 20,right: 0,top: 30),
                  //               child: Positioned(
                  //                 // alignment: Alignment.centerRight,
                  //                 right:- 20,
                  //                 bottom: 0,
                  //                 child: ClipRRect(
                  //                   borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  //                   child: CustomImage(
                  //                     image: '${splashController.moduleList![index].iconFullUrl}',
                  //                     height: 100, width: 100,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                     
                  
                  //             // Center(child: Text(
                  //             //   splashController.moduleList![index].moduleName! ,
                  //             //   textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis,
                  //             //   style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                  //             // )),
                  
                  //           ]),
                  //         ),
                  //       );
            index < 2 ?  Container(
            
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge) ,
                 boxShadow: [
            
                     BoxShadow(
                       color: Theme.of(context).disabledColor.withOpacity(0.1),
                       spreadRadius: 5,
                       blurRadius:5,
                     ),
                   ],
              ) ,
               child: ClipRRect(
                borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
                 child: Container(
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
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
                     onTap: () {
                          // Get.back();
                          Navigator.of(context).pop();
                          
                   print("switiching modules to index no ${fashionModuleIndices[index]}");
                      widget.splashController.switchModule(fashionModuleIndices[index], true);
                  
                      },
                     radius: Dimensions.fontSizeLarge,
                     child: Stack(
                       alignment: Alignment.center,
                       children: [
                         // Positioned for the image
                         Positioned(
                  right: -10,
                  bottom: -10,
                  
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    child: Container(
                      color: Theme.of(context).cardColor,
                      width: 195,
                      height :250,
                      child: CustomImage(
                        fit:  BoxFit.contain ,
                        image: '${fashionModules[index].iconFullUrl}',
                        // height: 100,
                        // width: 100,
                        
                      ),
                    ),
                  ),
                         ),
                         // Main content
                         Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
            
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: Dimensions.paddingSizeExtraSmall,
                          // right: Dimensions.paddingSizeSmall,
                          top: Dimensions.paddingSizeDefault,
                        ),
                        child: Text(
                         fashionModules[index].moduleName!.toUpperCase(),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: robotoMedium.copyWith(fontSize: 20,fontWeight: FontWeight.w800,color: const Color.fromARGB(214, 48, 46, 46)),
                        ),
                      ),
                    ),
            
                     Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          // left: Dimensions.paddingSizeDefault,
                                 left: Dimensions.paddingSizeExtraSmall,
                          right: Dimensions.paddingSizeSmall,
                          // top: Dimensions.paddingSizeDefault,
                        ),
                        child: Text(
                          "${removeHtmlTags(  fashionModules[index].description!.toUpperCase(), )}",
                       
                          // textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeSmall,fontWeight: FontWeight.w600,color: Colors.grey[500]),
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimensions.paddingSizeSmall),
                  ],
                         ),
              
            
                      
                       ],
                     ),
                   ),
                 ),
               ),
             ) : null;
            
              },
            ) : Center(child: Padding(
              padding: const EdgeInsets.only(top: Dimensions.paddingSizeSmall), child: Text('no_module_found'.tr),
            
            
            
            )) : ModuleShimmer(isEnabled:widget. splashController.moduleList == null),
          ],
        ),
      ),
    );
  }
}