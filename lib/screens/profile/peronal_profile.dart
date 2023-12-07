import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/coupon/widgets/add_coupon_heading.dart';
import 'package:emagz_vendor/screens/coupon/widgets/add_coupon_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalProfile extends StatelessWidget {
  const PersonalProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: const [
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCouponHeadingText(
                      headings: "Name",
                    ),
                    AddCouponTextfiled()
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCouponHeadingText(
                      headings: "Phone No",
                    ),
                    AddCouponTextfiled(
                      inputType: TextInputType.phone,
                    )
                  ],
                ),
              ),
            ],
          ),
          AddCouponHeadingText(
            headings: "E-mail",
          ),
          AddCouponTextfiled(),
          AddCouponHeadingText(
            headings: "Address",
          ),
          AddCouponTextfiled(
            maxLines: 3,
          ),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCouponHeadingText(
                      headings: "City",
                    ),
                    AddCouponTextfiled()
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AddCouponHeadingText(
                      headings: "State",
                    ),
                    AddCouponTextfiled(
                      inputType: TextInputType.phone,
                    )
                  ],
                ),
              ),
            ],
          ),
          AddCouponHeadingText(
            headings: "Pin Code",
          ),
          AddCouponTextfiled(
              // maxLines: 3,
              ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Get.back();
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.21,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(color: blackButtonColor, borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Customer View",
                  style: TextStyle(color: whiteColor),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () {
                // Get.to(() => const ManageCouponScreen());
              },
              child: Container(
                width: MediaQuery.of(context).size.width / 2.21,
                alignment: Alignment.center,
                height: 45,
                decoration: BoxDecoration(color: blueButtonColor, borderRadius: BorderRadius.circular(10)),
                child: const Text(
                  "Edit",
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
