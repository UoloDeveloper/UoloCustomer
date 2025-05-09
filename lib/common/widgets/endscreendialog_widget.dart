import 'package:flutter/material.dart';

class EndScreenDialog extends StatelessWidget {
  const EndScreenDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return HungerFixWidget();
  }
}




class HungerFixWidget extends StatelessWidget {
  const HungerFixWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment:  MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
      // mainAxisAlignmet : Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: const Text(
            "Hungry?",
            
            style: TextStyle(
          
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
           padding: const EdgeInsets.only(left: 20),
          child: const Text(
            "Let's Fix that",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        const SizedBox(height: 100),
        Center(
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "Powered by ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                TextSpan(
                  text: "KHRA",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        Center(
          child: const Text(
            "(Kerala Hotel & Restaurant Association)",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ),

        SizedBox (
          height: 100,
        ),
      ],
    );
  }
}