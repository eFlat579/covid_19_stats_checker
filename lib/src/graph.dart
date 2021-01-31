import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/*
  A class which builds a graph given a set of data.
*/
class Graph extends StatefulWidget {
  final String startMonth;
  final String endMonth;
  final Map<String, double> data;
  final TextStyle textStyle;

  Graph({
    this.startMonth,
    this.endMonth,
    this.data,
    this.textStyle,
  });

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> with TickerProviderStateMixin {
  AnimationController ac;
  Animation a;

  static const Map<String, int> months = {
    'Jan': 01,
    'Feb': 02,
    'Mar': 03,
    'Apr': 04,
    'May': 05,
    'Jun': 06,
    'Jul': 07,
    'Aug': 08,
    'Sep': 09,
    'Oct': 10,
    'Nov': 11,
    'Dec': 12
  };

  static const Map<int, String> monthsRev = {
    01: 'Jan',
    02: 'Feb',
    03: 'Mar',
    04: 'Apr',
    05: 'May',
    06: 'Jun',
    07: 'Jul',
    08: 'Aug',
    09: 'Sep',
    10: 'Oct',
    11: 'Nov',
    12: 'Dec'
  };

  @override
  void initState() {
    super.initState();
    ac = AnimationController(duration: Duration(seconds: 3), vsync: this);
    a = CurvedAnimation(parent: ac, curve: Curves.easeOutQuart)
      ..addListener(() {
        setState(() {});
      });
    ac.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    /* Map<String, double> newData =
        restrictData(widget.startMonth, widget.endMonth, widget.data); */

    Map<String, double> newData = widget.data;

    String lastEntryDay = newData.keys.last.substring(8);
    String lastEntryMonth =
        monthsRev[int.parse(newData.keys.last.substring(5, 7)) - 1];

    double maxY = 0;
    newData.forEach((key, value) {
      //print('Date: $key, Cases: $value');
      if (value > maxY) {
        maxY = value;
      }
    });

    return LayoutBuilder(builder: (context, constraints) {
      double height = constraints.biggest.height;
      double width = constraints.biggest.width;
      return CustomPaint(
        painter: GraphPainter(
            data: newData,
            maxY: maxY,
            // TODO: Fix the start and end months
            startMonth: /*widget.startMonth*/ "start",
            startDate: "01",
            endMonth: /*lastEntryMonth*/ "end",
            endDate: /*lastEntryDay*/ "31",
            animationVal: a.value),
        size: Size(width, height),
      );
    });
  }

  Map<String, double> restrictData(
      String startMonth, String endMonth, Map<String, double> data) {
    Map<String, double> newData = Map<String, double>();
    int startX = months[startMonth];
    int endX = months[endMonth];
    data.forEach((key, value) {
      int entryMonth = int.parse(key.substring(5, 7));
      if (entryMonth >= startX && entryMonth < endX) {
        newData[key] = value;
      }
    });
    return newData;
  }
}

class GraphPainter extends CustomPainter {
  final Map<String, double> data;
  final double maxY;
  final String startMonth;
  final String startDate;
  final String endMonth;
  final String endDate;
  final double animationVal;

  // The width of each bar
  double barWidth;
  // The width of the gap between each bar
  double barGap;

  GraphPainter({
    this.data,
    this.maxY,
    this.startMonth,
    this.startDate,
    this.endMonth,
    this.endDate,
    this.animationVal,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double graphHeight = size.height * 0.9;
    double graphWidth = size.width * 0.9;
    // The number of entries in the dataset
    int entryCount = data.length;
    // For each datapoint in the map, draw a bar of height: cases/maxHeight and width: size.width
    barWidth = graphWidth / entryCount;

    Paint paint = Paint()..color = Color(0xFF162027);
    Paint paint3 = Paint()..color = Color(0xFF66999B);

    canvas.drawRect(
        Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            height: graphHeight,
            width: graphWidth),
        paint);

    double prevEnd = -size.width * 0.05;
    for (int i = 0; i < data.length; i++) {
      double value = data.values.elementAt(i);
      double barHeight = (value / maxY) * graphHeight;

      if (value > 0) {
        canvas.drawRect(
            Rect.fromLTWH(graphWidth - prevEnd, size.height * 0.95, -barWidth,
                (1 - barHeight) * animationVal),
            paint3);
      }
      prevEnd += barWidth;
    }

    // TODO: Fix the start and end date text below

    TextSpan span = TextSpan(
        style: TextStyle(color: Color(0xFFF57600), fontSize: 10),
        text: '$maxY');
    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(0, 0));

    TextSpan span2 = TextSpan(
        style: TextStyle(color: Color(0xFFF57600), fontSize: 10),
        text: '$startMonth $startDate');
    TextPainter tp2 = TextPainter(
        text: span2,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp2.layout();
    tp2.paint(canvas, Offset(0, size.height * 0.95));

    TextSpan span3 = TextSpan(
        style: TextStyle(color: Color(0xFFF57600), fontSize: 10),
        text: '$endMonth $endDate');
    TextPainter tp3 = TextPainter(
        text: span3,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr);
    tp3.layout();
    tp3.paint(canvas, Offset(size.width * 0.92, size.height * 0.95));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
