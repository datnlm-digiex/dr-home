import 'package:flutter/material.dart';

//background of the login Screen
class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      color: Colors.white,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: -50, // set on top of screen
            child: Image.asset(
              "assets/images/2.jpeg", //add
              width: size.width * 1.5, // size of picture
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/1.jpeg", //add
              width: size.width * 1.1, // size of picture
            ),
          ),
          child,
        ],
      ),
    );
  }
}
