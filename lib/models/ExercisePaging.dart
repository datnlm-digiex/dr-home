// To parse this JSON data, do
//
//     final exercisePaging = exercisePagingFromJson(jsonString);

import 'dart:convert';

ExercisePaging exercisePagingFromJson(String str) => ExercisePaging.fromJson(json.decode(str));

String exercisePagingToJson(ExercisePaging data) => json.encode(data.toJson());

ExerciseModel exerciseModelFromJson(String str) => ExerciseModel.fromJson(json.decode(str));
String exerciseModelToJson(ExerciseModel data) => json.encode(data.toJson());

class ExercisePaging {
    ExercisePaging({
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
    List<ExerciseModel>? content;

    factory ExercisePaging.fromJson(Map<String, dynamic> json) => ExercisePaging(
        totalCount: json["totalCount"],
        pageSize: json["pageSize"],
        totalPage: json["totalPage"],
        currentPage: json["currentPage"],
        nextPage: json["nextPage"],
        previousPage: json["previousPage"],
        content: List<ExerciseModel>.from(json["content"].map((x) => ExerciseModel.fromJson(x))),
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

class ExerciseModel {
    ExerciseModel({
        this.id,
        this.title,
        this.description,
        this.thumbnail,
        this.linkvideo,
        this.bodyposition,
        this.practiceSchedule,
        this.practicetime,
        this.levelexercises,
        this.durationvideo,
    });

    int? id;
    String? title;
    String? description;
    String? thumbnail;
    String? linkvideo;
    String? bodyposition;
    String? practiceSchedule;
    int? practicetime;
    int? levelexercises;
    int? durationvideo;

    factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        linkvideo: json["linkvideo"],
        bodyposition: json["bodyposition"],
        practiceSchedule: json["practiceSchedule"],
        practicetime: json["practicetime"],
        levelexercises: json["levelexercises"],
        durationvideo: json["durationvideo"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "linkvideo": linkvideo,
        "bodyposition": bodyposition,
        "practiceSchedule": practiceSchedule,
        "practicetime": practicetime,
        "levelexercises": levelexercises,
        "durationvideo": durationvideo,
    };
}
