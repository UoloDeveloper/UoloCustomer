import 'package:lottie/lottie.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLoaderWidget extends StatelessWidget {
  const CustomLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child:
     Container(
          height: 200,
          width: 200,
          child: Lottie.asset('assets/animations/Animation - 1740696483528 (4).json', repeat: true,
        fit: BoxFit.cover,
        height: 100,
        width: 100
             ),
        ),
    //  Container(
    //   height: 100, width: 100,
    //   decoration: BoxDecoration(color: Colors.transparent, borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
    //   alignment: Alignment.center,
    //   child: const CircularProgressIndicator(),
    // )
    
    );
  }
}
