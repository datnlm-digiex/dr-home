// To parse this JSON data, do
//
//     final exerciseHistoryPaging = exerciseHistoryPagingFromJson(jsonString);

import 'dart:convert';

ExerciseHistoryPaging exerciseHistoryPagingFromJson(String str) =>
    ExerciseHistoryPaging.fromJson(json.decode(str));

String exerciseHistoryPagingToJson(ExerciseHistoryPaging data) =>
    json.encode(data.toJson());

class ExerciseHistoryPaging {
  ExerciseHistoryPaging({
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
  List<ExerciseHistory>? content;

  factory ExerciseHistoryPaging.fromJson(Map<String, dynamic> json) =>
      ExerciseHistoryPaging(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        content:
            List<ExerciseHistory>.from(json["content"].map((x) => ExerciseHistory.fromJson(x))),
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

class ExerciseHistory {
  ExerciseHistory({
    this.id,
    this.patientid,
    this.thumbnail,
    this.exerciseid,
    this.exerciseName,
    this.iscomplete,
    this.doctorid,
    this.timepractice,
    this.morning,
    this.midday,
    this.afternoon,
    this.night,
    this.practiceschedule,
    this.practicescheduleConvert,
    this.practiceday,
  });

  int? id;
  int? patientid;
  String? thumbnail;
  int? exerciseid;
  String? exerciseName;
  bool? iscomplete;
  int? doctorid;
  int? timepractice;
  String? morning;
  String? midday;
  String? afternoon;
  String? night;
  String? practiceschedule;
  String? practicescheduleConvert;
  DateTime? practiceday;

  factory ExerciseHistory.fromJson(Map<String, dynamic> json) => ExerciseHistory(
        id: json["id"],
        patientid: json["patientid"],
        thumbnail: json["thumbnail"],
        exerciseid: json["exerciseid"],
        exerciseName: json["exerciseName"],
        iscomplete: json["iscomplete"],
        doctorid: json["doctorid"],
        timepractice: json["timepractice"],
        morning: json["morning"],
        midday: json["midday"],
        afternoon: json["afternoon"],
        night: json["night"],
        practiceschedule: json["practiceschedule"],
        practicescheduleConvert: json["practicescheduleConvert"],
        practiceday: DateTime.parse(json["practiceday"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "patientid": patientid,
        "thumbnail": thumbnail,
        "exerciseid": exerciseid,
        "exerciseName": exerciseName,
        "iscomplete": iscomplete,
        "doctorid": doctorid,
        "timepractice": timepractice,
        "morning": morning,
        "midday": midday,
        "afternoon": afternoon,
        "night": night,
        "practiceschedule": practiceschedule,
        "practicescheduleConvert": practicescheduleConvert,
        "practiceday": practiceday!.toIso8601String(),
      };
}
