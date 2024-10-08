import 'package:emagz_vendor/user/common/user_top_bar.dart';
import 'package:emagz_vendor/user/screens/coupon/widgets/user_coupon.dart';
import 'package:flutter/material.dart';

class CouponScreen extends StatelessWidget {
  const CouponScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: UserTopBar(title: "Coupon"),
      body: SingleChildScrollView(
        child: Column(children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: UserCouponWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: UserCouponWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: UserCouponWidget(),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
            child: UserCouponWidget(),
          ),
        ]),
      ),
    );
  }
}
