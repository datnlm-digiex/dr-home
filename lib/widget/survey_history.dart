import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/overViewSurvey_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/resultSurvey_screen.dart';
import 'package:telemedicine_mobile/controller/overViewSurvey_controller.dart';
import 'package:telemedicine_mobile/models/SurveyResult.dart';

class SurveyHistoryCard extends StatefulWidget {
  final SurveyResult surveyResult;

  const SurveyHistoryCard({Key? key, required this.surveyResult})
      : super(key: key);

  // const CellCard({Key? key, required this.cell}) : super(key: key);

  @override
  State<SurveyHistoryCard> createState() => _CellCardState();
}

class _CellCardState extends State<SurveyHistoryCard> {
  // final SurveyController _surveyController = Get.find<SurveyController>();
  final overViewSurveyController = Get.put(OverViewSurveyController());
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 500,
      // height: 100,
      padding: const EdgeInsets.all(1.0),
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: ListTile(
          onTap: () {
            Get.to(ResultSurveyScreen(surveyRespone: widget.surveyResult));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nội dung: '),
              InkWell(
                child: Text('${widget.surveyResult.surveyTitle}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green)),
                onTap: () {
                  overViewSurveyController
                      .getSurveyOverView(widget.surveyResult.surveyid);
                },
              )
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Thời gian:'),
                        Text(
                            // '${DateTime.parse('${widget.surveyResult.createdate.toString()}')}',
                            '${DateFormat("yyyy-MM-dd hh:mm").format(widget.surveyResult.createdate)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                // Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // children: [
                // Text('Kết quả:'),
                // Text('Tốt',
                // style: const TextStyle(
                // fontWeight: FontWeight.bold,
                // )),
                // ],
                // ),
              ],
            ),
          ),
          leading: _getCorrectIcon(1),
        ),
      ),
    );
  }

  SizedBox _getCorrectIcon(int status) {
    switch (status) {
      case 0:
        return const SizedBox(
          height: double.infinity,
          child:
              Icon(Icons.cancel_outlined, size: 40.0, color: Colors.redAccent),
        );
      case 1:
        return const SizedBox(
          height: double.infinity,
          child: Icon(Icons.note_alt_outlined, size: 40.0, color: Colors.black),
        );
      case 3:
        return const SizedBox(
          height: double.infinity,
          child: Icon(Icons.check, size: 40.0, color: Colors.green),
        );
      default:
        return const SizedBox(
          height: double.infinity,
          child:
              Icon(Icons.history_toggle_off, size: 40.0, color: Colors.black),
        );
    }
  }
}
