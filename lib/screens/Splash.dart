import 'package:flutter/material.dart';
import 'package:my_note/screens/Home.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<Offset> offset;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );
    offset = Tween<Offset>(
      begin: Offset(0.0, 0.05),
      end: Offset(0.0, 0.0),
    ).animate(controller);
    controller.forward();

    Future.delayed(
      Duration(milliseconds: 900),
      () {
        setState(() => visible = true);
        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyHomePage();
              },
            ),
          );
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: FadeTransition(
          opacity: controller,
          child: SlideTransition(
            position: offset,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 5),
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset(
                    'images/notes_icon.png',
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                SizedBox(height: 10),
                Text.rich(
                  TextSpan(
                    text: "My",
                    style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).primaryColor),
                    children: [
                      TextSpan(
                        text: "Note",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
