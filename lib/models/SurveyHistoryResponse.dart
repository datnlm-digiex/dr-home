// To parse this JSON data, do
//
//     final surveyHistoryResponse = surveyHistoryResponseFromJson(jsonString);

import 'dart:convert';

import 'package:telemedicine_mobile/models/SurveyResult.dart';

SurveyHistoryResponse surveyHistoryResponseFromJson(String str) =>
    SurveyHistoryResponse.fromJson(json.decode(str));

String surveyHistoryResponseToJson(SurveyHistoryResponse data) =>
    json.encode(data.toJson());

class SurveyHistoryResponse {
  SurveyHistoryResponse({
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
  dynamic? previousPage;
  List<SurveyResult>? content;

  factory SurveyHistoryResponse.fromJson(Map<String, dynamic> json) =>
      SurveyHistoryResponse(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        content: List<SurveyResult>.from(
            json["content"].map((x) => SurveyResult.fromJson(x))),
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
