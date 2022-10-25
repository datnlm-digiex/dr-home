import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/history_survey_controller.dart';
import 'package:telemedicine_mobile/widget/survey_history.dart';

class SurveyHistoryScreen extends StatefulWidget {
  const SurveyHistoryScreen({Key? key}) : super(key: key);

  @override
  State<SurveyHistoryScreen> createState() => _SurveyHistoryScreenState();
}

class _SurveyHistoryScreenState extends State<SurveyHistoryScreen> {
  final historySurveyController = Get.put(HistorySurveyController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Lịch sử khảo sát"),
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
              color: Color.fromARGB(9, 255, 255, 255),
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
                  height: height * 0.80,
                  width: width,
                  // height: 400,
                  // width: 400,
                  child: Container(
                      // height: 200,
                      child: GetBuilder<HistorySurveyController>(
                    builder: (controller) => (controller.isLoading)
                        ? const Center(child: CircularProgressIndicator())
                        : controller.historySurveyResponse.content!.isEmpty &&
                                !controller.isLoading
                            ? Container(
                                child: Text("Không có khảo sát "),
                              )
                            : ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: controller
                                    .historySurveyResponse.content!.length,
                                itemBuilder: ((context, index) {
                                  return Container(
                                      // height: 100,
                                      child: Column(
                                    children: [
                                      Container(
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0,
                                            vertical: 3.0,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(
                                                82, 225, 223, 223),
                                            border: Border.all(
                                                color: Color.fromARGB(
                                                    82, 225, 223, 223)),
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                          ),
                                          child: CellCard(
                                              surveyResult:
                                                  historySurveyController
                                                      .historySurveyResponse
                                                      .content![index])),
                                      Divider(
                                          color:
                                              Color.fromARGB(82, 44, 44, 44))
                                    ],
                                  ));
                                }),
                              ),
                  )),
                ),
                // Survey info
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
