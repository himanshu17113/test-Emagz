import 'package:emagz_vendor/constant/colors.dart';
import 'package:emagz_vendor/screens/auth/widgets/form_haeding_text.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../common/common_appbar.dart';

class ProfileInsightScreen extends StatefulWidget {
  const ProfileInsightScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInsightScreen> createState() => _ProfileInsightScreenState();
}

class _ProfileInsightScreenState extends State<ProfileInsightScreen> {
  String daysValue = "";
  List<String> daysItem = ["10", "20", "30", "40"];

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = <ChartData>[
      ChartData("Sun", .9, 1),
      ChartData("Mon", .6, 1),
      ChartData("Tue", .8, 1),
      ChartData("Wed", 1.5, 1),
      ChartData("Thu", 1.5, 0),
      ChartData("Fri", 1, 0),
      ChartData("Sat", .3, 2),
    ];
    final List<Color> color = <Color>[];
    color.add(const Color(0xff0D7CBB));
    color.add(const Color(0xff3A0DBB));

    // stops.add(1.0);

    final LinearGradient gradientColors = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: color,
    );
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
              Container(
                padding: const EdgeInsets.only(right: 5),
                color: const Color(0xffDDE0FF),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: SizedBox(
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
                  ),
                ),
              ),
              Stack(
                children: [
                  Container(
                    height: 250,
                    margin: const EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment(-0.3, 1),
                          end: Alignment(0.8, -1.5),
                          colors: [
                            Color(0xff0F0AA4),
                            Color(0xff2992E3),
                          ]),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        const Positioned(
                          top: 15,
                          left: 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹ 400k",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Total Sales",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ),
                        SfCartesianChart(
                          margin: const EdgeInsets.only(bottom: 10),
                          borderWidth: 0,
                          plotAreaBorderWidth: 0,
                          primaryYAxis: NumericAxis(
                            isVisible: false,
                            // placeLabelsNearAxisLine: true,
                          ),
                          tooltipBehavior: TooltipBehavior(
                            enable: true,
                          ),
                          primaryXAxis: CategoryAxis(
                            // placeLabelsNearAxisLine: true,
                            edgeLabelPlacement: EdgeLabelPlacement.shift,
                            rangePadding: ChartRangePadding.none,
                            tickPosition: TickPosition.outside,
                            minorTicksPerInterval: 0,
                            majorTickLines: const MajorTickLines(
                                size: 5, color: Colors.transparent),
                            axisLine: const AxisLine(width: 0),
                            maximumLabels: 7,
                            labelStyle: const TextStyle(color: Colors.white),
                            majorGridLines: const MajorGridLines(width: 0),
                          ),
                          // palette: [Color(0xff0D7CBB)],
                          series: <ChartSeries>[
                            SplineAreaSeries<ChartData, String>(
                                borderColor: const Color(0xff1DADFF),
                                borderWidth: 2.5,

                                // color: Colors.red,
                                gradient: gradientColors,
                                dataSource: chartData,
                                splineType: SplineType.natural,
                                // cardinalSplineTension: .5,
                                xValueMapper: (ChartData data, _) => data.x,
                                yValueMapper: (ChartData data, _) => data.y),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              GridView.builder(
                  itemCount: gridData.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2),
                  itemBuilder: (ctx, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: selectedIndex == index
                                ? null
                                : Border.all(
                                    color: const Color(0xff9A9A9A), width: 1.5),
                            image: selectedIndex == index
                                ? const DecorationImage(
                                    image: AssetImage(
                                        "assets/png/profile_grid.png"),
                                    fit: BoxFit.cover)
                                : null),
                        height: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FormHeadingText(
                              headings: gridData[index]['title'],
                              fontSize: 29,
                              fontWeight: FontWeight.w700,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : toggleInactive,
                            ),
                            FormHeadingText(
                              headings: gridData[index]['body'],
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: selectedIndex == index
                                  ? Colors.white
                                  : toggleInactive,
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.y1);
  final String x;
  final double y;
  final double y1;
}

List<Map> gridData = [
  {"title": "120k", "body": "Persona reached"},
  {"title": "12k", "body": "Influence"},
  {"title": "12k", "body": "Persona Views"},
  {"title": "12k", "body": "Total Love"}
];
