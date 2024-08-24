import 'package:flutter/material.dart';

class ApprovalFormHeading extends StatelessWidget {
  final String tittle;
 final bool? isRequired;
 const ApprovalFormHeading({super.key, required this.tittle, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
          text: tittle,
          style: const TextStyle(color: Colors.white, fontSize: 12),
          children: [
            TextSpan(
                text: isRequired == true ? ' *' : "",
                style: const TextStyle(color: Colors.white, fontSize: 12))
          ]),
    );
  }
}
