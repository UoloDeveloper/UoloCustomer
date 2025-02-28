import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

// class Bottomsheetcontroller extends GetxController {
//   // final ScrollController scrollController = ScrollController();

//   // Make showBottomSheet reactive
//   // var showBottomSheet = true;
//    var showBottomSheet = true;

//   // Method to toggle the bottom sheet visibility
//   void toggleBottomSheet() {
//     showBottomSheet = !showBottomSheet;
//   //   // Print or notify when the value changes
//     print("Bottom sheet visibility changed: ${showBottomSheet}");
    
//   }
// }


import 'package:get/get.dart';

class Bottomsheetcontroller extends GetxController {
  // Make showBottomSheet reactive
  var showBottomSheet = true.obs; // Use RxBool

  // Method to toggle the bottom sheet visibility
  void toggleBottomSheet() {
    showBottomSheet.value = !showBottomSheet.value; // Update the value
    print("Bottom sheet visibility changed: ${showBottomSheet.value}");
    update(); // Notify listeners
  }
}