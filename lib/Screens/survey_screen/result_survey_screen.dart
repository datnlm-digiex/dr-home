import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/models/SurveyRespone.dart';

class ResultSurveyScreen extends StatelessWidget {
  final SurveyResponse surveyRespone;

  const ResultSurveyScreen({Key? key, required this.surveyRespone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Kết quả: ${surveyRespone.surveyTitle}"),
          backgroundColor: kBlueColor,
        ),
        backgroundColor: kBackgroundColor,
        body: Column(children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              // padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.green),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: height * 0.65,
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
                                  SizedBox(height: 52),
                                  Text(
                                    '${surveyRespone.resulttext}',
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.green),
                                  ),
                                  SizedBox(height: 22),
                                  Text(
                                    'Hy vọng bạn có sức khỏe tốt để vững bước tới thành công.',
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Image.network(
                                    '${surveyRespone.resultimage}',
                                    fit: BoxFit.cover,
                                  ),
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: kBlueColor),
                            onPressed: () {
                              Get.back();
                              Get.back();
                            },
                            child: Text(
                              'Trang chủ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
        ]));
    ;
  }
}
