import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/models/SurveyResult.dart';

import '../Screens/survey_screen/result_survey_screen.dart';
import '../controller/over_view_survey_controller.dart';
import 'package:intl/date_symbol_data_local.dart';

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
            // Get.to(ResultSurveyScreen(surveyRespone: widget.surveyResult));
          },
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Nội dung: '),
              InkWell(
                child: Container(
                  constraints: BoxConstraints(
                      minWidth: 100,
                      maxWidth: MediaQuery.of(context).size.width / 2),
                  child: Text('${widget.surveyResult.surveyTitle}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.green,
                        overflow: TextOverflow.ellipsis,
                      )),
                ),
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
                            '${DateFormat("hh:mm dd-MM-yyyy ").format(widget.surveyResult.createdate)}',
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
