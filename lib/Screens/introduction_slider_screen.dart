import 'dart:developer';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/introduction_screen.dart';
import 'package:telemedicine_mobile/Screens/login_screen.dart';

class IntroductionScreenSlider extends StatefulWidget {
  const IntroductionScreenSlider({Key? key}) : super(key: key);

  @override
  State<IntroductionScreenSlider> createState() =>
      IntroductionScreenSliderState();
}

class IntroductionScreenSliderState extends State<IntroductionScreenSlider> {
  List<Widget> listContentConfig = [];

  @override
  void initState() {
    super.initState();
    listContentConfig.add(IntroductionScreenDetail(
        image: 'assets/images/Hospital-Doctor.jpeg',
        title: 'Tập vật lý trị liệu',
        description:
            'Tập vật lý trị liệu giúp điều trị hậu Covid-19 hiệu quả hơn'));
    listContentConfig.add(IntroductionScreenDetail(
        image: 'assets/images/introduction_image_1.png',
        title: 'Làm khảo sát',
        description: 'Làm khảo sát để kiểm tra tình trạng sức khỏe'));

    listContentConfig.add(LoginScreen());
    // listContentConfig.add();
  }

  void onDonePress() {
    log("End of slides");
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      // pages: listPagesViewModel,
      rawPages: listContentConfig,
      onDone: () {
        // When done button is press
      },
      onSkip: () {
        // You can also override onSkip callback
      },
      nextStyle: TextButton.styleFrom(alignment: Alignment.center),
      showBackButton: false,
      showDoneButton: false,
      showSkipButton: false,
      skip: const Icon(Icons.skip_next),
      next: const Text("Tiếp tục",
          style: const TextStyle(fontSize: 16, color: Colors.green)),
      dotsDecorator: DotsDecorator(
          size: const Size.square(10.0),
          activeSize: const Size(20.0, 10.0),
          // activeColor: theme.accentColor,
          activeColor: Colors.green,
          color: Color.fromARGB(66, 0, 0, 0),
          spacing: const EdgeInsets.symmetric(horizontal: 3.0),
          activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0))),
    );
    ;
  }
}
