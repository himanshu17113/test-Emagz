import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../../constant/colors.dart';

class MyGradientButton extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool? isEnabled;
  const MyGradientButton({
    this.title = "Submit",
    this.isEnabled,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Align(
        alignment: Alignment.center,
        child: Container(
          alignment: Alignment.center,
          height: 45,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors:
              isEnabled ?? true? [
              Color(0xFF020AFF),
                Color(0xFF23A3FF),
                Color(0xFF23A3FF),
                // Color(0xFF2489D2),
                Color(0xFF23A3FF),

                Color(0xFF020EFF)
                ]: [Colors.grey,Colors.grey],

              // stops: [-0.082, 0.4, 0.6848, 0.9257],
              transform: GradientRotation(
                7843 * (math.pi / 10000),
              ),
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(.25),
                  offset: const Offset(0, 4.5),
                  blurRadius: 17),
            ],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            title,
            style: TextStyle(color: whiteColor, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
