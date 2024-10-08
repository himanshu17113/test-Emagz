import 'package:emagz_vendor/constant/colors.dart';
import 'package:flutter/material.dart';
import '../../common/common_appbar.dart';

class PersonalProfileInsightScreen extends StatefulWidget {
  const PersonalProfileInsightScreen({super.key});

  @override
  State<PersonalProfileInsightScreen> createState() =>
      _PersonalProfileInsightScreenState();
}

class _PersonalProfileInsightScreenState
    extends State<PersonalProfileInsightScreen> {
  String daysValue = "";
  List<String> daysItem = ["10", "20", "30", "40"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: socialBack,
      appBar: const SocialMediaSettingAppBar(title: "Profile"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Profile Insights",
                style: TextStyle(
                    fontSize: 20,
                    color: blackButtonColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "Take a deep look at how your account and content are performing",
                style: TextStyle(
                    fontSize: 12,
                    color: blackButtonColor,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Text(
                      "Profile Activity",
                      style: TextStyle(
                          fontSize: 12.5,
                          color: blackButtonColor,
                          fontWeight: FontWeight.w600),
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 80,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField(
                          decoration: const InputDecoration(
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: InputBorder.none,
                              border: InputBorder.none),
                          focusColor: Colors.white,
                          hint: const Text(
                            "Duration",
                            style: TextStyle(
                                fontSize: 12.5,
                                color: blackButtonColor,
                                fontWeight: FontWeight.w600),
                          ),
                          isExpanded: true,
                          style: const TextStyle(
                              fontSize: 12.5,
                              color: blackButtonColor,
                              fontWeight: FontWeight.w600),
                          icon: const Align(
                              alignment: Alignment.centerRight,
                              child: Icon(Icons.keyboard_arrow_down)),
                          items: daysItem.map((list) {
                            return DropdownMenuItem<String>(
                              value: list,
                              child: Text("$list Days"),
                            );
                          }).toList(),
                          value: daysValue.isEmpty ? null : daysValue,
                          onChanged: (val) {
                            setState(() {
                              daysValue = val.toString();
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Select Your Primary Person';
                            } else {}

                            return null;
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                width: double.infinity,
                height: 340,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: chipColor),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        "Account Reached",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    // SizedBox(
                    //   height: 190,
                    //   child: SfCartesianChart(
                    //     margin: const EdgeInsets.only(right: 20, left: 10),
                    //     // enableSideBySideSeriesPlacement: false,
                    //     borderWidth: 0,
                    //     plotAreaBorderWidth: 0,
                    //     primaryXAxis: const CategoryAxis(
                    //       tickPosition: TickPosition.outside,
                    //       // minorTicksPerInterval: 0,
                    //       majorTickLines: MajorTickLines(
                    //           size: 2, color: Colors.transparent),
                    //       axisLine: AxisLine(width: 0),

                    //       maximumLabels: 8,
                    //       labelStyle: TextStyle(
                    //           color: Colors.transparent, fontSize: 0),
                    //       majorGridLines: MajorGridLines(width: 0),
                    //     ),
                    //     primaryYAxis: const NumericAxis(isVisible: false),
                    //     tooltipBehavior: TooltipBehavior(enable: true),
                    //     series: <CartesianSeries<ChartData, String>>[
                    //       ColumnSeries<ChartData, String>(
                    //           borderRadius: BorderRadius.circular(0),
                    //           dataSource: [
                    //             ChartData('jan', 30, Colors.red),
                    //             ChartData('Feb', 20, Colors.amber),
                    //             ChartData('Mar', 40, Colors.green),
                    //             ChartData('Apr', 25, Colors.blueAccent),
                    //             ChartData('May', 20, Colors.indigo),
                    //             ChartData('Jun', 30, Colors.cyan),
                    //             // ChartData('Jul', 35),
                    //             // ChartData('Aug', 45),
                    //           ],
                    //           pointColorMapper: (ChartData data, _) =>
                    //               data.color,
                    //           width: 0.92,
                    //           trackColor: Colors.black,
                    //           xValueMapper: (ChartData data, _) => data.x,
                    //           yValueMapper: (ChartData data, _) => data.y,
                    //           name: 'Month',
                    //           color: Colors.white.withOpacity(.22)),
                    //     ],
                    //   ),
                    // ),
                 
                    Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 10),
                      child: const Text(
                        "Account reached  - 32K",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        "Profile Visit  - 132K",
                        style: TextStyle(
                            color: whiteColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Account Insights",
                style: TextStyle(
                    fontSize: 20,
                    color: blackButtonColor,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: chipColor),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Account reached",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "20%",
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), color: whiteColor),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Impression",
                      style: TextStyle(
                          color: blackButtonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      "8%",
                      style: TextStyle(
                          color: blackButtonColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double? y;
  final Color? color;
}
