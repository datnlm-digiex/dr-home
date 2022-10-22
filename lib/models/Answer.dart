// To parse this JSON data, do
//
//     final answer = answerFromJson(jsonString);

import 'dart:convert';

Answer answerFromJson(String str) => Answer.fromJson(json.decode(str));

String answerToJson(Answer data) => json.encode(data.toJson());

class Answer {
  int surveyid;
  int patientid;
  DateTime createdate;
  List<Surveypatientan> surveypatientans;

  Answer({
    required this.surveyid,
    required this.patientid,
    required this.createdate,
    required this.surveypatientans,
  });

  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        surveyid: json["surveyid"],
        patientid: json["patientid"],
        createdate: DateTime.parse(json["createdate"]),
        surveypatientans: List<Surveypatientan>.from(
            json["surveypatientans"].map((x) => Surveypatientan.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "surveyid": surveyid,
        "patientid": patientid,
        "createdate": createdate.toIso8601String(),
        "surveypatientans":
            List<dynamic>.from(surveypatientans.map((x) => x.toJson())),
      };
}

class Surveypatientan {
  int questionid;
  int rate;

  Surveypatientan({
    required this.questionid,
    required this.rate,
  });

  factory Surveypatientan.fromJson(Map<String, dynamic> json) =>
      Surveypatientan(
        questionid: json["questionid"],
        rate: json["rate"],
      );

  Map<String, dynamic> toJson() => {
        "questionid": questionid,
        "rate": rate,
      };
}
