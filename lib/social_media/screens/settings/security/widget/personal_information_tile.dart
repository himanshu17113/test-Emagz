import 'package:flutter/material.dart';

import '../../../../../screens/auth/widgets/form_haeding_text.dart';

class PersonalInformationTile extends StatelessWidget {
  final String heading;
  final String body;
  final Function onTap;
  const PersonalInformationTile({
    this.body = "",
    this.heading = "",
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(left: 17, right: 25, top: 10, bottom: 14),
      // width: double.infinity,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            flex: 6,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FormHeadingText(
                  headings: heading,
                  fontSize: 10,
                  color: const Color(0xff959595),
                ),
                FormHeadingText(
                  headings: body,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          const Spacer(),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: const FormHeadingText(
                headings: "Update",
                fontSize: 10,
                color: Color(0xff1B47C1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
