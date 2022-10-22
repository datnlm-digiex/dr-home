import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:get/get.dart' as GetX;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/models/ExercisePaging.dart';

class ExerciseController extends GetxController {
  ExercisePaging exercise = new ExercisePaging();
  ExerciseModel exerciseModel = new ExerciseModel();
  DateTime startTime = new DateTime.now();
  RxInt patientId = 0.obs;
  var isLoading = false.obs;

  Future<void> fetchExercise(int type) async {
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
          'exercise-group': type.toString(),
        };
        final response = await http.get(
            Uri.parse('https://13.232.213.53:8189/api/v1/exercises')
                .replace(queryParameters: queryParams),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
              "page_number": '1',
              "page_size": '-1'
            });

        if (response.statusCode == 200) {
          var exerciseResponse = exercisePagingFromJson(response.body);
          if (exerciseResponse.content != null) {
            exercise = exerciseResponse;
          }
        }
        print(exercise.totalCount);
      }
    } catch (e) {
      e.toString();
      //  log(e.toString());
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> getById(int id) async {
    try {
      print('call get exersise');
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      // final accountController = GetX.Get.put(AccountController());
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      // String email = accountController.account.value.email;
      if (tokenFcm != "" && token != "") {
        final Map<String, String> data = new Map<String, String>();
        data['token'] = tokenFcm;

        final response = await http.get(
            Uri.parse('https://13.232.213.53:8189/api/v1/exercises/$id'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
              "page_number": '1',
              "page_size": '-1'
            });
        print(response.statusCode);
        if (response.statusCode == 200) {
          var exerciseResponse = exerciseModelFromJson(response.body);
          if (exerciseResponse.id != null) {
            exerciseModel = exerciseResponse;
            Get.to(ExerciseScreen());
          }
        }
      }
    } catch (e) {
      e.toString();
      //  log(e.toString());
    } finally {
      isLoading(false);
      update();
    }
  }

  Future<void> submitExercise() async {
    try {
      DateTime endTime = new DateTime.now();
      isLoading(true);
      final storage = new Storage.FlutterSecureStorage();
      // final accountController = GetX.Get.put(AccountController());
      String tokenFcm = await storage.read(key: "tokenFCM") ?? "";
      String token = await storage.read(key: "accessToken") ?? "";
      print('if');
      if (tokenFcm != "" && token != "") {
        print('chay do if');
        String body = json.encode({
          "patientid": patientId.value,
          "exerciseid": exerciseModel.id,
          "starttime": startTime.toIso8601String(),
          "endtime": endTime.toIso8601String(),
        });
        print(body);

        final response = await http.post(
            Uri.parse('https://13.232.213.53:8189/api/v1/patientexercises'),
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
      print('end if');
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
