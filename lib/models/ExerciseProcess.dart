// To parse this JSON data, do
//
//     final exerciseProcess = exerciseProcessFromJson(jsonString);

import 'dart:convert';

ExerciseProcess exerciseProcessFromJson(String str) =>
    ExerciseProcess.fromJson(json.decode(str));

String exerciseProcessToJson(ExerciseProcess data) =>
    json.encode(data.toJson());

class ExerciseProcess {
  ExerciseProcess({
    required this.totalTimes,
    required this.times,
    required this.percent,
  });

  int totalTimes;
  int times;
  double percent;

  factory ExerciseProcess.fromJson(Map<String, dynamic> json) =>
      ExerciseProcess(
        totalTimes: json["totalTimes"],
        times: json["times"],
        percent: json["percent"],
      );

  Map<String, dynamic> toJson() => {
        "totalTimes": totalTimes,
        "times": times,
        "percent": percent,
      };
}
