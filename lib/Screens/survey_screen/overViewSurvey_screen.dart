import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/question_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/overViewSurvey_controller.dart';
import 'package:telemedicine_mobile/controller/question_controller.dart';

class OverViewSurveyScreen extends StatefulWidget {
  const OverViewSurveyScreen({Key? key}) : super(key: key);

  @override
  State<OverViewSurveyScreen> createState() => _OverViewSurveyScreenState();
}

class _OverViewSurveyScreenState extends State<OverViewSurveyScreen> {
  final overViewSurveyController = Get.put(OverViewSurveyController());
  final questionController = Get.put(QuestionController());
  String _value = '0';
  @override
  Widget build(BuildContext context) {
    const ratingList = [
      'Không đúng với tôi chút nào cả.',
      'Đúng với tôi phần nào, hoặc thỉnh thoảng mới đúng.',
      'Đúng với tôi phần nhiều hoặc phần lới thời gian là đúng.',
      'Hoàn toàn đúng với tôi hoặc hầu hết thời gian là đúng.'
    ];
    const heading =
        'Hãy đọc mỗi câu và chọn các số 0 1 2 và 3 ứng với tình trạng mà bạn cảm thấy trong suốt một tuần qua. Không có câu trả lời đúng hay sai và đừng dừng lại quá lâu ở bất kì câu hỏi nào.';

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Khảo sát D.A.S"),
          backgroundColor: kBlueColor,
        ),
        backgroundColor: kBackgroundColor,
        body: Column(children: [
          Container(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: height * 0.450,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  Text('*$heading',
                                      textAlign: TextAlign.left,
                                      // overflow: TextOverflow.ellipsis,
                                      // style: const TextStyle(
                                      //     fontWeight: FontWeight.bold),
                                      style: const TextStyle(fontSize: 16)),
                                  SizedBox(height: 15),
                                  Text(
                                    'Mức độ đánh giá: ',
                                    textAlign: TextAlign.left,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                  ),
                                  SizedBox(height: 10),
                                  Container(
                                      padding: EdgeInsets.zero,
                                      child: MediaQuery.removePadding(
                                        context: context,
                                        removeTop: true,
                                        child: ListView.builder(
                                          // scrollDirection: Axis.vertical,
                                          itemCount: ratingList.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              margin: EdgeInsets.only(top: 7),
                                              child: Text(
                                                "$index, " +
                                                    "${ratingList[index]}",
                                                textAlign: TextAlign.left,
                                                style: const TextStyle(
                                                    fontSize: 16),
                                              ),
                                            );
                                          },
                                        ),
                                      )),
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
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            color: Color.fromARGB(255, 209, 253, 211)),
                        color: Colors.green.shade50,
                      ),
                      height: height * 0.3,
                      width: width,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Thông tin khảo sát',
                              textAlign: TextAlign.left,
                              // overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.green),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Tên khảo sát:  ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                      text:
                                          '${overViewSurveyController.surveyOverView.value.title}'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Số lượng câu hỏi:  ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                      text:
                                          '${overViewSurveyController.surveyOverView.value.numberquestion}'),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Mô tả:  ',
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[
                                  TextSpan(
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                      text:
                                          '${overViewSurveyController.surveyOverView.value.description}'),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: EdgeInsets.only(top: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        border: Border.all(
                            color: Color.fromARGB(255, 209, 253, 211)),
                      ),
                      width: width * 0.95, // <-- match_parent
                      height: 40, // <-- match-parent
                      child: ElevatedButton(
                        child: const Text("Bắt đầu"),
                        onPressed: () {
                          questionController.getListQuestion();
                          Get.to(QuestionScreen(), arguments: [
                            {"first": 'First data'},
                            {"second": 'Second data'}
                          ]);
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.green, // background
                            onPrimary: Colors.white, // foreground
                            textStyle: TextStyle(fontSize: 20)),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ]));
  }
}
