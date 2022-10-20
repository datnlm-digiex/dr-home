// To parse this JSON data, do
//
//     final exercisePaging = exercisePagingFromJson(jsonString);

import 'dart:convert';

ExerciseGroupPaging exerciseGroupPagingFromJson(String str) =>
    ExerciseGroupPaging.fromJson(json.decode(str));

String exerciseGroupPagingToJson(ExerciseGroupPaging data) =>
    json.encode(data.toJson());

class ExerciseGroupPaging {
  ExerciseGroupPaging({
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
  List<ExerciseGroupModel>? content;

  factory ExerciseGroupPaging.fromJson(Map<String, dynamic> json) =>
      ExerciseGroupPaging(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        content: List<ExerciseGroupModel>.from(
            json["content"].map((x) => ExerciseGroupModel.fromJson(x))),
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

class ExerciseGroupModel {
  ExerciseGroupModel({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.trainingtime,
  });

  int? id;
  String? title;
  String? description;
  String? thumbnail;
  int? trainingtime;

  factory ExerciseGroupModel.fromJson(Map<String, dynamic> json) =>
      ExerciseGroupModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        trainingtime: json["trainingtime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "trainingtime": trainingtime,
      };
}
