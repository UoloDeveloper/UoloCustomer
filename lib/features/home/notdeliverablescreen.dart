import 'package:flutter/material.dart';

// class Notdeliverablescreen extends StatelessWidget {
//   const Notdeliverablescreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Image.asset('assets/image/freepik__background__9404.png', height: 200,width: 200,),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';

// class NotDeliverableScreen extends StatelessWidget {
//   bool restaurantempty;
//    NotDeliverableScreen({super.key  ,required this.restaurantempty});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: 
        
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
           
//             Image.asset(
//               'assets/image/freepik__background__9404.png',
//               height: 300,
//               width: 300,
//               fit: BoxFit.contain,
//             ),
//             const SizedBox(height: 20), 

        
//             Text(
//               'Delivery Not Available'.tr,
//               style:  TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//                 color: Theme.of(context).primaryColor,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 10),

//             Text(
//               'We’re sorry, but we currently do not deliver to your location. Please check back later or try a different address.'.tr,
//               style: const TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height: 30), 

      
//             ElevatedButton(
//               onPressed: () {
               
//                 // Get.back();
//                 Get.find<SplashController>().removeModule();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).primaryColor, 
//                 padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//               ),
//               child: Text(
//               restaurantempty ? " Chanage Location " :  ' Go Back'.tr,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
          
//           ],
//         ),
   
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Assuming you're using GetX for state management

class NotDeliverableScreen extends StatelessWidget {
  final bool restaurantempty;

  const NotDeliverableScreen({
    Key? key,
    required this.restaurantempty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/image/freepik__background__9404.png',
              height: 300,
              width: 300,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 20),

            Text(
              'Delivery Not Available'.tr,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),

            Text(
              'We’re sorry, but we currently do not deliver to your location. Please check back later or try a different address.'.tr,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: () {
                // Handle button press based on the restaurantempty property
                if (restaurantempty) {
                   Get.find<LocationController>().navigateToLocationScreen('home');
                  // Logic for changing location
                } else {
                  // Logic for going back
                  // Get.back();
                        Get.find<SplashController>().removeModule();
                }
                // Additional logic if needed
          
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                restaurantempty ? "Change Location" : 'Go Back'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}