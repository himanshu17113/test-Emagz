import 'package:flutter/material.dart';

import '../../../../../constant/colors.dart';
import '../../../../../screens/auth/widgets/form_haeding_text.dart';

class OtherSecurityTile extends StatelessWidget {
  final String heading;
  final String body;
  final Function onTap;
  const OtherSecurityTile({
    this.heading = "Privacy Policy",
    this.body = "Learn about our privacy policy",
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding:
            const EdgeInsets.only(left: 17, right: 25, top: 10, bottom: 14),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeadingText(
                    headings: heading,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.black),
                SizedBox(
                  width: 110,
                  child: FormHeadingText(
                    headings: body,
                    fontSize: 8,
                    color: toggleInactive,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Image.asset(
              "assets/png/redirect.png",
              width: 15,
            )
          ],
        ),
      ),
    );
  }
}
