import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class TitleAndSwitchWidget extends StatefulWidget {
  final String title;
  final String subTitle;
  Function(bool isActive)? onToggle;
  bool isActive;
  TitleAndSwitchWidget(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.isActive,
        this.onToggle
      })
      : super(key: key);

  @override
  State<TitleAndSwitchWidget> createState() => _TitleAndSwitchWidgetState();
}

class _TitleAndSwitchWidgetState extends State<TitleAndSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                    color: blackButtonColor,
                    fontSize: 10,
                    fontWeight: FontWeight.w600),
              ),
              Text(
                // "53 people",
                widget.subTitle,
                style: const TextStyle(
                    color: toggleInactive,
                    fontSize: 8,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          FlutterSwitch(
              activeColor: whiteAcent,
              toggleColor: blueColor,
              padding: 0,
              height: 15,
              width: 40,
              inactiveColor: lightgrayColor,
              inactiveToggleColor: toggleInactive,
              value: widget.isActive,
              onToggle: widget.onToggle == null ?
                  (val) {
                setState(() {
                  widget.isActive = val;
                });


              } : widget.onToggle!
              )
        ],
      ),
    );
  }
}
