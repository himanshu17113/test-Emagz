import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';

import '../../../constant/colors.dart';

class PostInsightScreen extends StatelessWidget {
  const PostInsightScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                Color(0xffDCE5FF),
                Color(0xffF8F8F8),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.center,
                height: 38,
                width: 38,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: purpleColor,
                ),
                child: const Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios,
                    size: 25,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormHeadingText(
                        headings: "Post Analyse",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                      FormHeadingText(
                        headings: "Take a deep look on your audience",
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.center,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xffDDE0FF).withOpacity(.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Row(
                      children: [
                        FormHeadingText(
                          headings: "10 Days",
                          // fontWeight: FontWeight,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                        Icon(Icons.keyboard_arrow_down)
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(templateFiveImage[0]),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const PostInsighntProgressWidget(width: 2),
              const SizedBox(
                height: 10,
              ),
              const PostInsighntProgressWidget(
                width: 3,
                title: "Total Like",
                percentage: "14%",
              ),
              const SizedBox(
                height: 10,
              ),
              const PostInsighntProgressWidget(
                width: 1.8,
                title: "Total Comment",
                percentage: "44%",
              ),
              const SizedBox(
                height: 10,
              ),
              const PostInsighntProgressWidget(
                width: 3.5,
                title: "Total Share",
                percentage: "12%",
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                alignment: Alignment.center,
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xffDDE0FF).withOpacity(.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const FormHeadingText(
                  headings: "View All",
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PostInsighntProgressWidget extends StatelessWidget {
  final double width;
  final String title;
  final String percentage;
  const PostInsighntProgressWidget({
    super.key,
    this.title = "Total Reach",
    this.percentage = "24%",
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // const SizedBox(
            //   width: 10,
            // ),
            FormHeadingText(
              headings: title,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            const Spacer(),
            FormHeadingText(
              headings: percentage,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 18,
          width: size.width / width,
          color: purpleColor,
        )
      ],
    );
  }
}
