// import 'package:fl_chart_app/presentation/resources/app_resources.dart';
import 'package:LifeLines/components/reaction.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:flutter_svg/flutter_svg.dart';

Color getColor(String val) {
  Color ret = val == 'love' ? const Color(0xFF4D54E2) : 
              val == 'sad' ? const Color(0xFF9B9FF9) :
              val == 'angry' ?  const Color(0xFF5865F2) :
              const Color(0xFF7F8CF4);
  return ret;
}

class PieChartSample3 extends StatefulWidget {
  final Map<String, int> notes;
  const PieChartSample3({super.key, required this.notes});

  @override
  State<StatefulWidget> createState() => PieChartSample3State();
}

class PieChartSample3State extends State<PieChartSample3> {
  int touchedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: AspectRatio(
        aspectRatio: 1,
        child: PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 0,
            centerSpaceRadius: 0,
            sections: showingSectionss(widget.notes),
          ),
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionss(notes) {
    final isTouched = 1 == touchedIndex;
    final fontSize = isTouched ? 20.0 : 16.0;
    final radius = isTouched ? 110.0 : 100.0;
    final widgetSize = isTouched ? 55.0 : 40.0;
    const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
    return reactionsList.entries
        .map((e) => PieChartSectionData(
              color: getColor(e.key),
              // color: const Color(0xFF4D54E2),
              // value: (notes[e.key]??0) * 100 / notes.values.fold(0.0, (sum, value) => sum + value),
              // title: '${((notes[e.key]??0) * 100 / notes.values.fold(0.0, (sum, value) => sum + value))}%',
              // value: notes[e.key]??0,
              value: ((notes[e.key] ?? 0) + 0.0),
              title: '${notes[e.key] ?? 0}%',
              radius: radius,
              titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                // color: Color.fromARGB(255, 233, 198, 198),
                color: const Color(0xFFFFFFFF),
                shadows: shadows,
              ),
              badgeWidget: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: getColor(e.key),
                    width: 2,
                  ),
                ),
                // child: const Icon(Icons.favorite, color: Colors.red)),
                child: e.value,
              ),
              badgePositionPercentageOffset: .98,
            ))
        .toList();
    // return List.generate(4, (i) {
    //   final isTouched = i == touchedIndex;
    //   final fontSize = isTouched ? 20.0 : 16.0;
    //   final radius = isTouched ? 110.0 : 100.0;
    //   final widgetSize = isTouched ? 55.0 : 40.0;
    //   const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

    //       return PieChartSectionData(
    //         color: const Color(0xFF4D54E2),
    //         value: 40,
    //         title: '40%',
    //         radius: radius,
    //         titleStyle: TextStyle(
    //           fontSize: fontSize,
    //           fontWeight: FontWeight.bold,
    //           color: Color.fromARGB(255, 233, 198, 198),
    //           shadows: shadows,
    //         ),
    //         badgeWidget: Container(
    //           width: 35,
    //           height: 35,
    //           decoration: BoxDecoration(
    //           color: const Color(0xFFFFFFFF),
    //             borderRadius: BorderRadius.circular(100)
    //           ),
    //           child: const Icon(Icons.favorite, color: Colors.red)),
    //         badgePositionPercentageOffset: .98,
    //       );
    //       });
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 16.0;
      final radius = isTouched ? 110.0 : 100.0;
      final widgetSize = isTouched ? 55.0 : 40.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xFF4D54E2),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 233, 198, 198),
              shadows: shadows,
            ),
            badgeWidget: Container(
                width: 35,
                height: 35,
                decoration: BoxDecoration(
                    color: const Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(100)),
                child: const Icon(Icons.favorite, color: Colors.red)),
            badgePositionPercentageOffset: .98,
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xFF9B9FF9),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'lib/trist.png',
              size: widgetSize,
              borderColor: Colors.orange,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xFF7F8CF4),
            value: 16,
            title: '16%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/fitness-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.blue,
            ),
            badgePositionPercentageOffset: .98,
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xFF5865F2),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
              shadows: shadows,
            ),
            badgeWidget: _Badge(
              'assets/icons/worker-svgrepo-com.svg',
              size: widgetSize,
              borderColor: Colors.red,
            ),
            badgePositionPercentageOffset: .98,
          );
        default:
          throw Exception('Oh no');
      }
    });
  }
}

class _Badge extends StatelessWidget {
  const _Badge(
    this.svgAsset, {
    required this.size,
    required this.borderColor,
  });
  final String svgAsset;
  final double size;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: PieChart.defaultDuration,
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(.5),
            offset: const Offset(3, 3),
            blurRadius: 3,
          ),
        ],
      ),
      padding: EdgeInsets.all(size * .15),
      child: const Center(
          // child: SvgPicture.asset(
          //   svgAsset,
          // ),
          ),
    );
  }
}
