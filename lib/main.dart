import 'package:covid19_app/src/misc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'export.dart';

void main() async {
  runApp(Main());
}

class Main extends StatefulWidget {
  Main({Key key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  /// Background color
  final int backgroundColor = 0xFF0D1317;

  /// Card Background color
  final int cardBackgroundColor = 0xFF162027;

  /// Primary color (text)
  final int primaryColor = 0xFFFAFFFD;

  /// Secondary color (headings)
  final int secondaryColor = 0xFFF57600;

  /// Title textstyle
  final TextStyle titleStyle = TextStyle(
    color: Color(0xFFF57600),
    fontSize: 40,
  );

  /// Heading textstyle
  final TextStyle headingStyle = TextStyle(
    color: Color(0xFFF57600),
    fontSize: 20,
  );

  /// Data textstyle
  final TextStyle dataStyle = TextStyle(
    color: Color(0xFFFAFFFD),
    fontSize: 40,
  );

  /// Plain text textstyle
  final TextStyle textStyle = TextStyle(
    color: Color(0xFFFAFFFD),
    fontSize: 15,
  );

  /// Plain text textstyle
  final TextStyle errorStyle = TextStyle(
    color: Color(0xFFFF0000),
    fontSize: 15,
  );

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
    ]);
  }

  // Fetches and returns a new batch of data.
  DataByPostcode fetchData(String postcode) {
    return DataByPostcode(postcode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the PostcodeInput.
        '/': (context) => Scaffold(
              backgroundColor: Color(backgroundColor),
              body: PostcodeInput(
                backgroundColor: backgroundColor,
                cardBackgroundColor: cardBackgroundColor,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                titleStyle: titleStyle,
                headingStyle: headingStyle,
                dataStyle: dataStyle,
                textStyle: textStyle,
                errorStyle: errorStyle,
              ),
            ),

        // When navigating to the "/home" route, build the Data page.
        '/home': (context) => Scaffold(
              backgroundColor: Color(backgroundColor),
              body: HomePage(
                backgroundColor: backgroundColor,
                cardBackgroundColor: cardBackgroundColor,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                titleStyle: titleStyle,
                headingStyle: headingStyle,
                dataStyle: dataStyle,
                textStyle: textStyle,
                errorStyle: errorStyle,
              ),
            ),

        // When navigating to the "/misc" route, build the Misc page.
        '/misc': (context) => Scaffold(
              backgroundColor: Color(backgroundColor),
              body: MiscPage(
                backgroundColor: backgroundColor,
                cardBackgroundColor: cardBackgroundColor,
                primaryColor: primaryColor,
                secondaryColor: secondaryColor,
                titleStyle: titleStyle,
                headingStyle: headingStyle,
                dataStyle: dataStyle,
                textStyle: textStyle,
                errorStyle: errorStyle,
              ),
            ),
      },
    );
  }
}
