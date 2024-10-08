
import 'package:emagz_vendor/model/order_list_model.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class CouponListCard extends StatelessWidget {
  final OrderList orderList;
  const CouponListCard({
    required this.orderList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: borderColor, width: 1, style: BorderStyle.solid)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            orderList.orderid,
            // "5415asd518",
            style: const TextStyle(
              color: blackButtonColor,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "₹ ${orderList.totalAmount}",
            style: const TextStyle(
              color: blackButtonColor,
              fontSize: 9,
              fontWeight: FontWeight.w500,
            ),
          ),
          CircleAvatar(
            backgroundColor: blackButtonColor,
            radius: 14,
            child: Text(
              "0${orderList.quantity}",
              // "01",
              style: const TextStyle(color: whiteColor, fontSize: 10),
            ),
          ),
          Container(
            width: 58,
            height: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: orderList.orderStatus == "Ongoing"
                  ? pendingColor
                  : orderList.orderStatus == "Delivered"
                      ? deliverColor
                      : orderList.orderStatus == "Dispatch"
                          ? dispatchColor
                          : cancledColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              orderList.orderStatus,
              // "Dispatch",
              style: const TextStyle(
                  fontSize: 8, fontWeight: FontWeight.w500, color: whiteColor),
            ),
          )
        ],
      ),
    );
  }
}
