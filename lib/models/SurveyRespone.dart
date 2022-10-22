// To parse this JSON data, do
//
//     final surveyResponse = surveyResponseFromJson(jsonString);

import 'dart:convert';

SurveyResponse surveyResponseFromJson(String str) =>
    SurveyResponse.fromJson(json.decode(str));

String surveyResponseToJson(SurveyResponse data) => json.encode(data.toJson());

class SurveyResponse {
  SurveyResponse({
    required this.id,
    required this.surveyid,
    required this.surveyTitle,
    required this.patientid,
    required this.rate,
    required this.resulttext,
    required this.resultimage,
    required this.createdate,
  });

  int id;
  int surveyid;
  String surveyTitle;
  int patientid;
  int rate;
  String resulttext;
  String resultimage;
  DateTime createdate;

  factory SurveyResponse.fromJson(Map<String, dynamic> json) => SurveyResponse(
        id: json["id"],
        surveyid: json["surveyid"],
        surveyTitle: json["surveyTitle"],
        patientid: json["patientid"],
        rate: json["rate"],
        resulttext: json["resulttext"],
        resultimage: json["resultimage"],
        createdate: DateTime.parse(json["createdate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surveyid": surveyid,
        "surveyTitle": surveyTitle,
        "patientid": patientid,
        "rate": rate,
        "resulttext": resulttext,
        "resultimage": resultimage,
        "createdate": createdate.toIso8601String(),
      };
}
