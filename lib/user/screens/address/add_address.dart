import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/address/widgets/manage_address_heading.dart';
import 'package:emagz_vendor/user/screens/address/widgets/manage_address_textfield.dart';
import 'package:flutter/material.dart';

class ManageAddressScreen extends StatefulWidget {
  const ManageAddressScreen({super.key});

  @override
  State<ManageAddressScreen> createState() => _ManageAddressScreenState();
}

class _ManageAddressScreenState extends State<ManageAddressScreen> {
  bool currentaddress = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const UserTopBar(title: "Manage Address"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            const ManageAddressHeading(
              title: "New Address",
            ),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "Name",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "Phone Number",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const ManageAddressHeading(
              title: "Address",
            ),
            const ManageAddressTextfiled(
              maxLines: 3,
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "City",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "State",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "Locality",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ManageAddressHeading(
                        title: "Pincode",
                      ),
                      ManageAddressTextfiled(),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Checkbox(
                    activeColor: blackButtonColor,
                    value: currentaddress,
                    onChanged: (val) {
                      setState(() {
                        currentaddress = val!;
                      });
                    }),
                const Text(
                  "Set as current address",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: blackButtonColor, fontSize: 11, fontWeight: FontWeight.w600),
                )
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
                height: 45,
                alignment: Alignment.center,
                child: const Text("Back ", textAlign: TextAlign.center, style: TextStyle(color: blackButtonColor, fontSize: 15)),
              ),
            ),
            InkWell(
              onTap: () {
                // Get.to(() => const OrderScreen());
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
