import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/address/add_address.dart';
import 'package:emagz_vendor/user/screens/address/widgets/save_address_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySaveAddressScreen extends StatefulWidget {
  const MySaveAddressScreen({super.key});

  @override
  State<MySaveAddressScreen> createState() => _MySaveAddressScreenState();
}

class _MySaveAddressScreenState extends State<MySaveAddressScreen> {
  bool currentaddress = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const UserTopBar(title: "Manage Address"),
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            MyAddressCard(
              isCurrent: true,
            ),
            MyAddressCard(),
            MyAddressCard(),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                // Get.back();
              },
              child: Container(
                width: size.width / 2.15,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(color: blackButtonColor, borderRadius: BorderRadius.circular(1)),
                child: const Text("Manage Address ", style: TextStyle(color: whiteColor)),
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => const ManageAddressScreen());
              },
              child: Container(
                width: size.width / 2.15,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(color: blueButtonColor, borderRadius: BorderRadius.circular(1)),
                child: const Text(
                  "Add New Address",
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
