import 'package:flutter/material.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;

  const CustomFloatingActionButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 2.0,
      fillColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(horizontal: 19.0, vertical: 9.0), // Reduced padding
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Theme.of(context).cardColor,
            size: 20.0, // Adjust icon size if needed
          ),
          SizedBox(width: 5.0),
          Text(
            label,
            style: TextStyle(
              color: Theme.of(context).cardColor,
              fontSize: 14.0, 
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Usage
