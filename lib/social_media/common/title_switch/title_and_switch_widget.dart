import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TitleAndSwitchWidget extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Function(bool isActive)? onToggle;
  final EdgeInsetsGeometry? padding;
  final bool isActive;
  const TitleAndSwitchWidget(
      {super.key,
      required this.title,
      this.subTitle,
      required this.isActive,
      this.onToggle,
      this.padding});

  @override
  Widget build(BuildContext context) {
    bool isOn = isActive;
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: blackButtonColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w600),
              ),
              if (subTitle != null) ...[
                Text(
                  subTitle!,
                  style: const TextStyle(
                      color: toggleInactive,
                      fontSize: 8,
                      fontWeight: FontWeight.w600),
                ),
              ]
            ],
          ),
          StatefulBuilder(
            builder: (BuildContext context, setState) => FlutterSwitch(
                activeColor: whiteAcent,
                toggleColor: blueColor,
                padding: 0,
                height: 15,
                width: 40,
                inactiveColor: lightgrayColor,
                inactiveToggleColor: toggleInactive,
                value: isOn,
                onToggle: (val) {
                  setState(() {
                    isOn = val;
                  });
                  onToggle!(val);
                }),
          )
        ],
      ),
    );
  }
}
