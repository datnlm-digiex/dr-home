// To parse this JSON data, do
//
//     final surveyOverViewListRespone = surveyOverViewListResponeFromJson(jsonString);

import 'dart:convert';

import 'package:telemedicine_mobile/models/Survey.dart';

SurveyOverViewListRespone surveyOverViewListResponeFromJson(String str) =>
    SurveyOverViewListRespone.fromJson(json.decode(str));

String surveyOverViewListResponeToJson(SurveyOverViewListRespone data) =>
    json.encode(data.toJson());

class SurveyOverViewListRespone {
  SurveyOverViewListRespone({
     this.totalCount,
     this.pageSize,
     this.totalPage,
     this.currentPage,
     this.nextPage,
     this.previousPage,
     this.content,
  });

  int? totalCount;
  int? pageSize;
  int? totalPage;
  int? currentPage;
  int? nextPage;
  dynamic previousPage;
  List<Survey>? content;

  factory SurveyOverViewListRespone.fromJson(Map<String, dynamic> json) =>
      SurveyOverViewListRespone(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        content:
            List<Survey>.from(json["content"].map((x) => Survey.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "pageSize": pageSize,
        "totalPage": totalPage,
        "currentPage": currentPage,
        "nextPage": nextPage,
        "previousPage": previousPage,
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
}

// class Content {
//   Content({
//     this.id,
//     this.numberquestion,
//     this.title,
//     this.description,
//     this.resultimage,
//     this.status,
//   });

//   int id;
//   int numberquestion;
//   String title;
//   String description;
//   String resultimage;
//   bool status;

//   factory Content.fromJson(Map<String, dynamic> json) => Content(
//         id: json["id"],
//         numberquestion: json["numberquestion"],
//         title: json["title"],
//         description: json["description"],
//         resultimage: json["resultimage"],
//         status: json["status"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "numberquestion": numberquestion,
//         "title": title,
//         "description": description,
//         "resultimage": resultimage,
//         "status": status,
//       };
// }
