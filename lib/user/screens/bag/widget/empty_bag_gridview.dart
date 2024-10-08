import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/user/models/product_model.dart';
import 'package:flutter/material.dart';

class EmptyBagGridView extends StatelessWidget {
  const EmptyBagGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(left: 10),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 1 / 1.7),
      
      itemCount: products.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            // Get.to(() => const ProductDetailsScreen());
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 110,
                width: 106,
                child: Image.network(
                  products[index].image.toString(),
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                products[index].title.toString(),
                style: const TextStyle(
                    color: blackButtonColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "₹ ${products[index].price.toString()}",
                style: const TextStyle(
                    color: blackButtonColor,
                    fontSize: 8,
                    fontWeight: FontWeight.w500),
              ),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 5, right: 5),

                // width: size.width / 1.8,
                height: 30,
                decoration: BoxDecoration(
                    color: blueButtonColor,
                    // gradient: LinearGradient(
                    //   begin: Alignment(-0.5, .7),
                    //   end: Alignment(0.5, -5.5),
                    //   colors: [
                    //     darkBlue,
                    //     darkBlueAcent,
                    //   ],
                    // ),
                    borderRadius: BorderRadius.circular(5)),
                child: const Text(
                  "Add to cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 10,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
