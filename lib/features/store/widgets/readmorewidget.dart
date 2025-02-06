import 'package:flutter/material.dart';

class AddressText extends StatefulWidget {
  final String address;
  const AddressText({required this.address, Key? key}) : super(key: key);

  @override
  _AddressTextState createState() => _AddressTextState();
}

class _AddressTextState extends State<AddressText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String displayText = _isExpanded
        ? widget.address
        : widget.address.length > 20
            ? "${widget.address.substring(0, 20)}..."
            : widget.address;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayText,
          style: TextStyle(
            fontSize: 11,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        // if (widget.address.length > 50)
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       _isExpanded = !_isExpanded;
          //     });
          //   },
          //   child: Text(
          //     _isExpanded ? 'Show less' : 'Read more',
          //     style: TextStyle(
          //       color: Colors.blue,
          //       fontWeight: FontWeight.bold,
          //       fontSize: 10,
          //     ),
          //   ),
          // ),
      ],
    );
  }
}
