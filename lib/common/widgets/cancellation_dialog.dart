import 'package:sixam_mart/features/order/controllers/order_controller.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class CancellationDialog extends StatelessWidget {
  final String icon;
  final String? title;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;
  const CancellationDialog({super.key, 
    required this.icon,
    this.title,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: PointerInterceptor(
        child: SizedBox(width: 500, child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(mainAxisSize: MainAxisSize.min, children: [

            Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
              child: Image.asset(icon, width: 50, height: 50,),
            ),
            const SizedBox(height: Dimensions.paddingSizeDefault),

            title != null ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
              child: Text(
                title!, textAlign: TextAlign.center,
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault, ),
              ),
            ) : const SizedBox(),
            const SizedBox(height: 50),

            GetBuilder<OrderController>(builder: (orderController) {
              return !orderController.isLoading ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                TextButton(
                  onPressed: () => onNoPressed != null ? onNoPressed!() : Get.back(),
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).disabledColor.withOpacity(0.3), minimumSize: const Size(80, 50), padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
                  ),
                  child: Text('no'.tr, textAlign: TextAlign.center,
                    style: robotoBold.copyWith(color: Theme.of(context).textTheme.bodyLarge!.color),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeLarge),

                Container(
                  height: 50,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.error.withOpacity(.7),
                    borderRadius: const BorderRadius.all(Radius.circular(8))
                  ),
                  child: Center(child: Text('yes'.tr,style: robotoRegular.copyWith(color: Theme.of(context).cardColor),)),
                ),
              ]) : const Center(child: CircularProgressIndicator());
            }),

          ]),
        )),
      ),
    );
  }
}





// class CancellationDialog1 extends StatelessWidget {
//   final String icon;
//   final String? title;
//   final Function onYesPressed;
//   final bool isLogOut;
//   final Function? onNoPressed;
//   const CancellationDialog1({super.key, 
//     required this.icon,
//     this.title,
//     required this.onYesPressed,
//     this.isLogOut = false,
//     this.onNoPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
//       insetPadding: const EdgeInsets.all(30),
//       clipBehavior: Clip.antiAliasWithSaveLayer,
//       child: PointerInterceptor(
//         child: SizedBox(width: 500, child: Padding(
//           padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//           child: Column(mainAxisSize: MainAxisSize.min, children: [

//             Padding(
//               padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
//               child: Image.asset(icon, width: 50, height: 50,),
//             ),
//             const SizedBox(height: Dimensions.paddingSizeDefault),

//             title != null ? Padding(
//               padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
//               child: Text(
//                 title!, textAlign: TextAlign.center,
//                 style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault , fontWeight: FontWeight.w600 ),
//               ),
//             ) : const SizedBox(),
//             const SizedBox(height: 50),

//         //  
//              InkWell(
//               onTap: (){
//                 onYesPressed;
//               },
//                child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 40,
//                 child: Center(child: Text("Yes, Cancel the order"))),
//              ),
//              SizedBox(height: 5,),
//              InkWell(
//               onTap: (){
//                 onNoPressed;
//               },
//                child: Container(
//                 width: MediaQuery.of(context).size.width,
//                 height: 40,
//                 child: Center(child: Text("No, Don't cancel"))),
//              )
//           ]),
//         )),
//       ),
//     );
//   }
// }


class CancellationDialog1 extends StatelessWidget {
  final String icon;
  final String? title;
  final Function onYesPressed;
  final bool isLogOut;
  final Function? onNoPressed;

  const CancellationDialog1({
    super.key,
    required this.icon,
    this.title,
    required this.onYesPressed,
    this.isLogOut = false,
    this.onNoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      insetPadding: const EdgeInsets.all(30),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: SizedBox(
        width: 500,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(icon, width: 50, height: 50),
              ),
              const SizedBox(height: 20),
              title != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        title!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(height: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      onYesPressed();
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "Yes, Cancel the order",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  InkWell(
                    onTap: () {
                      if (onNoPressed != null) {
                        onNoPressed!();
                      }
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          "No, Don't cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}