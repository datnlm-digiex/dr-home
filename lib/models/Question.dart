// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Question> welcomeFromJson(String str) =>
    List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String welcomeToJson(List<Question> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    this.id,
    this.questiontitle,
    this.ans1,
    this.ans2,
    this.ans3,
    this.ans4,
    this.status,
  });

  int? id;
  String? questiontitle;
  String? ans1;
  String? ans2;
  String? ans3;
  String? ans4;
  bool? status;

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questiontitle: json["questiontitle"],
        ans1: json["ans1"],
        ans2: json["ans2"],
        ans3: json["ans3"],
        ans4: json["ans4"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "questiontitle": questiontitle,
        "ans1": ans1,
        "ans2": ans2,
        "ans3": ans3,
        "ans4": ans4,
        "status": status,
      };
}
