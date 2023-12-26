import 'package:flutter/material.dart';
import '../../../../../constant/colors.dart';

class PreferenceTile extends StatelessWidget {
  final String title;
  final String? textDesc;
  final VoidCallback? onTap;
  const PreferenceTile(
      {Key? key, required this.title, this.onTap, this.textDesc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        onTap: () => onTap!(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        selectedTileColor: chipColor,
        hoverColor: chipColor,
        focusColor: chipColor,
        tileColor: whiteColor,
        contentPadding: const EdgeInsets.only(left: 25, right: 20),
        dense: true,
        title: Text(
          title,
          style: const TextStyle(
              //   color: isBlue == true ? whiteColor : blackButtonColor,
              fontSize: 12,
              fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          textDesc ?? "Manage Your Privacy",
          style: const TextStyle(
              //  color: isBlue == true ? whiteColor : blackButtonColor,
              fontSize: 10,
              fontWeight: FontWeight.w500),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          //  color: isBlue == true ? whiteAcent : blackButtonColor,
          size: 15,
        ),
      ),
    );
  }
}
