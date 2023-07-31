import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.symmetric(),
      height: 42,
      decoration: BoxDecoration(
          color: const Color(0xffF0F0F0),
          borderRadius: BorderRadius.circular(10)),
      child: TextField(
        showCursor: false,
        decoration: InputDecoration(
            hintText: "Search",
            hintStyle: TextStyle(fontSize: 13, color: blackButtonColor),
            contentPadding: const EdgeInsets.only(left: 10, top: 5),
            prefixIcon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            border: InputBorder.none),
      ),
    );
  }
}
