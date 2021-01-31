import 'package:covid19_app/export.dart';
import 'package:flutter/material.dart';

/*
  The page which the user will use to input their postcode.
  Consists of a text input and a search button.
*/
class PostcodeInput extends StatefulWidget {
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

  PostcodeInput({
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
  _PostcodeInputState createState() => _PostcodeInputState();
}

class _PostcodeInputState extends State<PostcodeInput>
    with SingleTickerProviderStateMixin {
  TextEditingController textController;

  ///Animation stuff
  AnimationController animationController;
  Animation<double> animation;
  double opacity;

  @override
  void initState() {
    super.initState();
    // Used to grab whatever the user enters into the textbox
    textController = TextEditingController();

    // Used to controll the animation
    animationController =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = Tween<double>(begin: 0, end: 1).animate(animationController)
      ..addListener(() {
        setState(() {
          opacity = 1.0 - animation.value;
        });
      });
    opacity = 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Get height and width constraints
        double height = constraints.biggest.height;
        double width = constraints.biggest.width;
        return ListView(
          children: [
            Container(height: height * 0.25),
            Center(
              child: Container(
                child: Text('Covid-19 Data', style: widget.titleStyle),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Enter Postcode:',
                  style: widget.textStyle,
                ),
              ),
            ),
            // The text input
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  height: 25,
                  width: width / 2,
                  color: Color(widget.primaryColor),
                  child: TextField(
                    controller: textController,
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
            Container(height: height * 0.025),
            // Search button
            Container(
              child: Align(
                child: RaisedButton(
                  color: Color(widget.secondaryColor),
                  textColor: Color(widget.primaryColor),
                  disabledColor: Colors.grey,
                  disabledTextColor: Colors.black,
                  padding: EdgeInsets.all(8.0),
                  splashColor: Color(widget.backgroundColor),
                  onPressed: () async {
                    // Lookup the areacode using the given postcode
                    String areacode =
                        await processPostcode(textController.text);
                    // If not null, then we can grab the data and proceed.
                    if (areacode != null) {
                      DataByPostcode data = DataByPostcode(areacode);
                      await data.updateData();
                      textController.clear();
                      Navigator.pushNamed(context, '/home', arguments: data);
                    } // Otherwise animate in an 'invalid postcode' message
                    else {
                      print('Not valid');
                      opacity = 1.0;
                      animationController.forward(from: 0.0);
                    }
                  },
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ),
            Container(height: height * 0.025),
            // Invalid message
            Center(
              child: Opacity(
                opacity: opacity,
                child: Container(
                  child: Text(
                    'Not a valid postcode',
                    style: widget.errorStyle,
                  ),
                ),
              ),
            ),
            Container(height: height * 0.35),
            // Takes user to misc page
            Container(
              child: FlatButton(
                //color: Color(widget.secondaryColor),
                textColor: Color(widget.primaryColor),
                disabledColor: Colors.grey,
                disabledTextColor: Colors.black,
                padding: EdgeInsets.all(8.0),
                splashColor: Color(widget.backgroundColor),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/misc',
                  );
                },
                child: Text(
                  "About this app",
                  style: TextStyle(fontSize: 15.0),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<String> processPostcode(String postcode) {
    PostcodeToAreacode converter = PostcodeToAreacode();
    return converter.fetchAreacode(postcode.trim());
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
}
