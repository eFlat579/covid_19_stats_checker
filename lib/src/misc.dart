import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MiscPage extends StatelessWidget {
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

  MiscPage({
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
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get height and width constraints
        double height = constraints.biggest.height;
        double width = constraints.biggest.width;
        return ListView(
          padding: EdgeInsets.fromLTRB(10, 50, 10, 50),
          children: [
            Center(
              child: Container(
                child: Text('Covid-19 Data', style: titleStyle),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: width,
                  color: Color(cardBackgroundColor),
                  child: Text(
                    'Thanks for taking the time to use this app!\n\n' +
                        'This app works using the data on the UK Goverment Coronavirus website which can be found by clicking the link below.',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: width,
                    color: Color(cardBackgroundColor),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'https://coronavirus.data.gov.uk/',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://coronavirus.data.gov.uk/');
                          },
                        style: headingStyle,
                      ),
                    )),
              ),
            ),
            Container(height: height * 0.05),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: width,
                  color: Color(cardBackgroundColor),
                  child: Text(
                    'Your feedback is also super helpful so if you have a couple minutes to hand, please leave some feeback using the next link below.',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    width: width,
                    color: Color(cardBackgroundColor),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'https://forms.gle/yizxa8z3g5VE5QRm8',
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            launch('https://forms.gle/yizxa8z3g5VE5QRm8');
                          },
                        style: headingStyle,
                      ),
                    )),
              ),
            ),
            Container(height: height * 0.05),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  width: width,
                  color: Color(cardBackgroundColor),
                  child: Text(
                    // TODO: Insert Disclaimer
                    'DISCLAIMER: <Insert disclaimer here>',
                    style: textStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Container(height: height * 0.05),
            // Back Button
            Container(
              child: Align(
                child: FlatButton(
                  color: Color(secondaryColor),
                  textColor: Color(primaryColor),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Color(backgroundColor),
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
}
