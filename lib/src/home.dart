import 'package:covid19_app/src/graph.dart';
import 'package:flutter/material.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  /// Background color
  final int backgroundColor;

  /// Card Background color
  final int cardBackgroundColor;

  /// Primary color (text)
  final int primaryColor;

  /// Secondary color (headings)
  final int secondaryColor;

  /// Title textstyle
  final TextStyle titleStyle;

  /// Heading textstyle
  final TextStyle headingStyle;

  /// Data textstyle
  final TextStyle dataStyle;

  /// Text textstyle
  final TextStyle textStyle;

  /// Error textstyle
  final TextStyle errorStyle;

  HomePage({
    this.backgroundColor,
    this.cardBackgroundColor,
    this.primaryColor,
    this.secondaryColor,
    this.titleStyle,
    this.headingStyle,
    this.dataStyle,
    this.textStyle,
    this.errorStyle,
  });

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Used for the animations
  AnimationController ac;
  Animation a;

  // The data we are using
  DataByPostcode data;

  // Used to restrict the graph data
  String dropdownValue1;
  String dropdownValue2;

  @override
  void initState() {
    super.initState();

    // TODO: Make these not hard coded. AKA the current month
    dropdownValue1 = 'Mar';
    dropdownValue2 = 'Jan';

    ac = AnimationController(duration: Duration(seconds: 3), vsync: this);
    a = CurvedAnimation(parent: ac, curve: Curves.easeOutQuart)
      ..addListener(() {
        setState(() {});
      });
    ac.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    // Get data from previous page
    data = ModalRoute.of(context).settings.arguments;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get height and width of page
        double height = constraints.biggest.height;
        double width = constraints.biggest.width;
        return ListView(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
          children: [
            Center(
              child: Container(
                child: Text('Covid-19 Data', style: widget.titleStyle),
              ),
            ),
            Container(height: 10),
            Center(
              child: Container(
                child: Text(
                  'Latest Data in ${data.areaName}\n${data.date.day}/${data.date.month}/${data.date.year}',
                  style: widget.textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(height: 15),
            // New and Overall Cases
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color(widget.cardBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    createDataBox(
                        data.newLocalCases, 'New Cases', width / 3, width / 3),
                    createDataBox(data.overallLocalCases, 'Overall Cases',
                        width / 3, width / 3),
                  ],
                ),
              ),
            ),
            // New and Overall Deaths
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color(widget.cardBackgroundColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    createDataBox(data.newLocalDeaths, 'New Deaths', width / 3,
                        width / 3),
                    createDataBox(data.overallLocalDeaths, 'Overall Deaths',
                        width / 3, width / 3),
                  ],
                ),
              ),
            ),
            Container(height: 30),
            // Input for the user to change the graph data start and end
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Color(widget.cardBackgroundColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Show data on graph starting:',
                        style: widget.textStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          DropdownButton<String>(
                            value: dropdownValue1,
                            style: TextStyle(color: Color(widget.primaryColor)),
                            underline: Container(
                              height: 2,
                              color: Color(widget.secondaryColor),
                            ),
                            dropdownColor: Color(widget.backgroundColor),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue1 = newValue;
                              });
                            },
                            items: <String>[
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                          Text(
                            'to ',
                            style: widget.textStyle,
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
                            style: TextStyle(color: Color(widget.primaryColor)),
                            underline: Container(
                              height: 2,
                              color: Color(widget.secondaryColor),
                            ),
                            dropdownColor: Color(widget.backgroundColor),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue2 = newValue;
                              });
                            },
                            items: <String>[
                              'Jan',
                              'Feb',
                              'Mar',
                              'Apr',
                              'May',
                              'Jun',
                              'Jul',
                              'Aug',
                              'Sep',
                              'Oct',
                              'Nov',
                              'Dec',
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(height: 30),
            // Graph 1
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'New Cases (${data.areaName})',
                style: widget.textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    height: width * 0.5,
                    width: width * 0.9,
                    child: Center(
                        child: Graph(
                      data: data.newCasesGraphData,
                      // startMonth: dropdownValue1,
                      // endMonth: dropdownValue2,
                      textStyle: widget.textStyle,
                    ))),
              ),
            ),
            Container(height: 30),
            // Graph 2
            Container(
              alignment: Alignment.topCenter,
              child: Text(
                'Cumulative Cases per 100k (${data.areaName})',
                style: widget.textStyle,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                    height: width * 0.5,
                    width: width * 0.9,
                    child: Center(
                        child: Graph(
                      data: data.cumCasesGraphData,
                      // startMonth: dropdownValue1,
                      // endMonth: dropdownValue2,
                      textStyle: widget.textStyle,
                    ))),
              ),
            ),
            Container(height: 25),
            //Back button
            Container(
              child: Align(
                child: FlatButton(
                  color: Color(widget.secondaryColor),
                  textColor: Color(widget.primaryColor),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Color(widget.backgroundColor),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Back",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  // Just a useful function to create the databoxes (aka new/overall deaths and cases)
  Widget createDataBox(
      int field, String fieldName, double height, double width) {
    int value;
    if (field != null) {
      value = (field * a.value).round();
    }
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: height,
        width: width,
        //color: Color(0xffff000000),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$value',
                style: widget.dataStyle, textAlign: TextAlign.center),
            Text('$fieldName',
                style: widget.headingStyle, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
