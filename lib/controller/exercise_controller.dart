import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/models/ExercisePaging.dart';

import '../models/ExerciseHistoryPaging.dart';
import '../models/ExerciseProcess.dart';

class ExerciseController extends GetxController {
  int duration = 0;
  ExercisePaging exercise = new ExercisePaging();
  ExerciseHistoryPaging exerciseHistory = new ExerciseHistoryPaging();
  ExerciseModel exerciseModel = new ExerciseModel();
  ExerciseProcess exerciseProcess =
      new ExerciseProcess(percent: 0, times: 0, totalTimes: 1);
  var isLoading = false.obs;

  Future<void> fetchExercise(int type, int patientId) async {
    try {
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      // final accountController = GetX.Get.put(AccountController());
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      // String email = accountController.account.value.email;
      if (tokenFcm != "" && token != "") {
        final Map<String, String> data = new Map<String, String>();
        data['token'] = tokenFcm;

        Map<String, String> queryParams = {
          'patient': patientId.toString(),
          'date': new DateFormat('yyyy-MM-dd').format(DateTime.now()),
          "page-offset": '1',
          "limit": '999',
          'exercise-group': type.toString(),
        };
        final response = await http.get(
            Uri.parse('https://13.232.213.53:8189/api/v1/exercises/byPatient')
                .replace(queryParameters: queryParams),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            });

        if (response.statusCode == 200) {
          var exerciseResponse = exercisePagingFromJson(response.body);
          if (exerciseResponse.content != null) {
            exercise = exerciseResponse;
          }
        }
        duration = 0;
        exercise.content!.forEach((element) {
          duration += element.practicetime!;
        });
      }
    } catch (e) {
      e.toString();
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> getExerciesProcess(int patientId) async {
    try {
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      // final accountController = GetX.Get.put(AccountController());
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      // String email = accountController.account.value.email;
      if (tokenFcm != "" && token != "") {
        final Map<String, String> data = new Map<String, String>();
        data['token'] = tokenFcm;

        Map<String, String> queryParams = {
          'patient': patientId.toString(),
          'date': new DateFormat('yyyy-MM-dd').format(DateTime.now()),
        };

        final response = await http.get(
            Uri.parse(
                    'https://13.232.213.53:8189/api/v1/patientexercises/get-percent')
                .replace(queryParameters: queryParams),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            });
        if (response.statusCode == 200) {
          var exerciseProcessResponse = exerciseProcessFromJson(response.body);

          exerciseProcess = exerciseProcessResponse;
        }
      }
    } catch (e) {
      e.toString();
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> getHistory(int groupId, int patientId) async {
    try {
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      if (tokenFcm != "" && token != "") {
        final Map<String, String> data = new Map<String, String>();
        data['token'] = tokenFcm;

        Map<String, String> queryParams = {
          'patientid': patientId.toString(),
          'order-by': 'Endtime',
          'order-type': 'desc',
          'exercisegroupid': groupId.toString(),
          "page-offset": '1',
          "limit": '9999',
        };

        final response = await http.get(
            Uri.parse('https://13.232.213.53:8189/api/v1/patientexercises')
                .replace(queryParameters: queryParams),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
              "page-offset": '1',
              "limit": '9999',
            });
        print(response.statusCode);
        if (response.statusCode == 200) {
          var exerciseResponse = exerciseHistoryPagingFromJson(response.body);
          if (exerciseResponse.content != null) {
            exerciseHistory = exerciseResponse;
            print(exerciseHistory.content!.length);
          }
        }
      }
    } catch (e) {
      e.toString();
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> submitExercise(
      int patientId, int exerciseId, DateTime startTime) async {
    try {
      DateTime endTime = new DateTime.now();
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      // final accountController = GetX.Get.put(AccountController());
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";

      if (tokenFcm != "" && token != "") {
        String body = json.encode({
          "patientid": patientId.toString(),
          "exerciseid": exerciseId.toString(),
          "starttime": startTime.toIso8601String(),
          "endtime": endTime.toIso8601String(),
        });
        print(body);

        final response = await http.put(
            Uri.parse(
                'https://13.232.213.53:8189/api/v1/patientexercises/updateTime'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            },
            body: body);

        print(response.statusCode);
        if (response.statusCode == 200) {
          print("submit sucess");
        }
      }
    } catch (e) {
      print("nhay catch");
      // e.toString();
      //  log(e.toString());
    } finally {
      isLoading(false);
      update();
    }
  }
}
