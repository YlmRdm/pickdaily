import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

import '../main.dart';

class IntroView extends StatefulWidget {
  const IntroView({Key? key}) : super(key: key);

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();
    final backgroundColor = const Color(0xFF010101);
    slides.add(
      new Slide(
        pathImage: "assets/images/pickdaily-logo-landing-dark.png",
        backgroundColor: backgroundColor,
        widthImage: 300.0,
        heightImage: 200.0,
        description: "Schedule Daily Tasks with your team.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/note-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Daily Tasks",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description: "Add tasks to your schedule, and check them out later.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/binoculars-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Quick Search",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description: "Quickly find the tasks from teammates.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/heart-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Favorites",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description:
            "Build a list with your favourite tasks to see them later.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/team-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Teams",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description:
            "Read tasks of your teammates, and get updates when something changes.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/notification-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Notifications",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description:
            "Monitor your notifications from your teammates, and get updates when something changes.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
    slides.add(
      new Slide(
        pathImage: "assets/images/theme-icon.png",
        backgroundColor: backgroundColor,
        widthImage: 72.0,
        heightImage: 72.0,
        title: "Theme Mode",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 28.0,
          fontWeight: FontWeight.w600,
          fontFamily: 'Nunito',
        ),
        description:
            "We support theme mode options as Light, Dark, and System Mode.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          fontFamily: 'Nunito Sans',
        ),
      ),
    );
  }

  void onDonePress() {
    // TODO: go to next slider pages...
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyHomePage(
          title: 'Flutter Demo Home Page',
        ),
      ),
    );
  }

  Widget renderNextBtn() {
    return Text(
      "NEXT",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "DONE",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      "SKIP",
      style: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontFamily: 'Nunito Sans',
        fontWeight: FontWeight.w600,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: new IntroSlider(
            slides: this.slides,
            //
            renderSkipBtn: this.renderSkipBtn(),
            colorSkipBtn: Color(0x33000000),
            highlightColorSkipBtn: Color(0xff000000),
            //
            renderNextBtn: this.renderNextBtn(),
            //
            renderDoneBtn: this.renderDoneBtn(),
            colorDoneBtn: Color(0x33000000),
            highlightColorDoneBtn: Color(0xff000000),
            //
            onDonePress: this.onDonePress,
            colorDot: Color(0xFF979797),
            colorActiveDot: Colors.white,
            scrollPhysics: BouncingScrollPhysics(),
            // hideStatusBar: true,
          ),
        ),
      ],
    );
  }
}
