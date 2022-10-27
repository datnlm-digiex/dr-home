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
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(children: [
          Container(
            child: Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              // padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      // padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 28),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.green),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      width: width,
                      // height: 400,
                      // width: 400,
                      child: (SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: (Column(
                          children: [
                            Container(
                              // height: 600,
                              width: width,
                              // color: Color.fromARGB(255, 235, 225, 225),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Container(
                                    child: Container(),
                                    height: height * 0.65,
                                    width: width,
                                    decoration: BoxDecoration(
                                      // color: Colors.green,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: AssetImage("$image"),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    "$title",
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.green),
                                  ),
                                  SizedBox(height: 22),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
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
                            ),
                          ],
                        )),
                      ))),
                  SizedBox(
                    height: 10,
                  ),
                  // Survey info

                  // Center(
                  //   child: Container(
                  //     padding: EdgeInsets.only(top: 5),
                  //     // decoration: BoxDecoration(
                  //     //   borderRadius: BorderRadius.circular(60),
                  //     //   border: Border.all(
                  //     //       color: Color.fromARGB(255, 209, 253, 211)),
                  //     // ),
                  //     width: width * 0.35, // <-- match_parent
                  //     height: 40, // <-- match-parent
                  //     child: ElevatedButton(
                  //       child: const Text("Trang chủ"),
                  //       onPressed: () {
                  //         // Get.offAll(HomeScreen());
                  //       },
                  //       style: ElevatedButton.styleFrom(
                  //           primary: Colors.green, // background
                  //           onPrimary: Colors.white, // foreground
                  //           textStyle: TextStyle(fontSize: 20)),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ]));
  }
}
