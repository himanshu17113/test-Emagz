// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

// class ChartScreen extends StatelessWidget {
//   const ChartScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final List<ChartData> chartData = [
//       ChartData('David', 60),
//       ChartData('Steve', 70),
//       ChartData('Jack', 80),
//       ChartData('Others', 90)
//     ];
//     return Scaffold(
//       body: Center(
//         child: SfCircularChart(
//           series: <CircularSeries>[
//             // Renders radial bar chart
//             RadialBarSeries<ChartData, String>(
//                 maximumValue: 100,
//                 dataSource: chartData,
//                 innerRadius: '50%',
//                 dataLabelSettings: const DataLabelSettings(
//                     // Renders the data label
//                     isVisible: true),
//                 xValueMapper: (ChartData data, _) => data.x,
//                 cornerStyle: CornerStyle.bothCurve,
//                 yValueMapper: (ChartData data, _) => data.y)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ChartData {
//   ChartData(this.x, this.y);
//   final String x;
//   final double y;
// }
