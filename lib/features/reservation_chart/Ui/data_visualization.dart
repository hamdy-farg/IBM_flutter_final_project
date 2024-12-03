import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:ibm_flutter_final_project/core/helpers/extensions.dart';
import 'package:ibm_flutter_final_project/features/reservation_chart/Ui/widgets/single_photo.dart';
import 'package:ibm_flutter_final_project/core/theming/colors.dart';
import 'package:ibm_flutter_final_project/core/theming/styles.dart';

class BarChartScreen extends StatelessWidget {
  BarChartScreen({super.key});

  final List<String> titles = List.generate(12, (index) {
    return '${index + 1}:00'; // Hourly labels from '1:00' to '12:00'
  });

  final List<List<int>> backendData = [
    [0, 2],
    [0, 2],
    [0, 2],
    [0, 20],
    [0, 1],
    [0, 1],
    [0, 2],
    [0, 2],
    [1, 3],
    [4, 5],
    [4, 13],
    [0, 9],
    [1, 16],
    [4, 23],
    [4, 13]
  ];

  @override
  Widget build(BuildContext context) {
    final Map<int, double> yValues = _generateYValuesFromBackend(backendData);
    final int mostPopularTimeIndex = _getMostPopularReservationTime(yValues);
    String popularTimeRange = _getTimeRangeForPopularTime(mostPopularTimeIndex);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(1),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        context.pop();
                      },
                      icon: const Icon(Icons.arrow_back_ios_rounded),
                      tooltip: 'Back',
                    ),
                    Text('Reservation Chart',
                        style: TextStyles.font18blackbold),
                  ],
                ),
              ),
              roomPhoto(),
              verticalSpace(8),
              Text("Reservation Over Time", style: TextStyles.font18blackbold),
              verticalSpace(20),
              Text(DateFormat('EEEE, MMM d').format(DateTime.now()),
                  style: TextStyles.font16BlackBold),
              verticalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "  $popularTimeRange",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    "+100%",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.green),
                  ),
                ],
              ),
              verticalSpace(70),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    CustomPaint(
                      painter: GraphPaperPainter(),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          titles.length,
                          (index) {
                            double height = yValues[index] ?? 0.0;
                            return _buildBarChart(height);
                          },
                        ),
                      ),
                    ),
                    verticalSpace(8),
                    Row(
                      children: titles.map((title) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.w400),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              verticalSpace(20),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Most popular reservation time",
                        style: TextStyle(fontSize: 14)),
                    Text(
                      "${titles[mostPopularTimeIndex]}",
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBarChart(double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 100 * (height / 7).h, // Dynamically scaled height
          width: 30.w,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: height > 0 ? ColorsManager.mainBlue : Colors.grey[200],
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
        verticalSpace(8),
      ],
    );
  }

  Map<int, double> _generateYValuesFromBackend(List<List<int>> data) {
    final Map<int, double> yValues = {};
    for (var entry in data) {
      for (int time = entry[0]; time <= entry[1]; time++) {
        yValues[time] = (yValues[time] ?? 0) + 1;
      }
    }
    return yValues;
  }

  int _getMostPopularReservationTime(Map<int, double> yValues) {
    int mostPopularTime = 0;
    double maxFrequency = 0;
    yValues.forEach((key, value) {
      if (value > maxFrequency) {
        maxFrequency = value;
        mostPopularTime = key;
      }
    });
    return mostPopularTime;
  }

  String _getTimeRangeForPopularTime(int mostPopularTimeIndex) {
    final String startTime = titles[mostPopularTimeIndex];
    final String endTime = titles[mostPopularTimeIndex + 1];
    return "$startTime - $endTime";
  }
}

class GraphPaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..strokeWidth = 0.5;

    final borderPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final verticalSpacing = size.width / 15;
    final horizontalSpacing = size.height / 10;

    for (double x = 0; x < size.width; x += verticalSpacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += horizontalSpacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    canvas.drawRect(Offset(0, 0) & size, borderPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

Widget verticalSpace(double height) {
  return SizedBox(height: height);
}
