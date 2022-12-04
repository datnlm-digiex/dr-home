import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:telemedicine_mobile/constant.dart';

class IntroductionScreenDetail extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  const IntroductionScreenDetail(
      {Key? key,
      required this.image,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Image.asset("$image"),
          SizedBox(
            height: 15,
          ),
          Text(
            "$title",
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold, fontSize: 24, color: Colors.green),
          ),
          SizedBox(height: 22),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Text(
              '$description',
              textAlign: TextAlign.center,
              // overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
