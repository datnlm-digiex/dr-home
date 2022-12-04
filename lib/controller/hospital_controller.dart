import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:telemedicine_mobile/models/Hospital.dart';

class HospitalController extends GetxController {
  Hospital hospital = Hospital();
  var isLoading = false.obs;

  Future<void> fetchHospital() async {
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

        final response = await http.get(
            Uri.parse('https://13.232.213.53:8189/api/v1/hospitals/1'),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $token",
            });

        if (response.statusCode == 200) {
          var hospitalResponse = hospitalFromJson(response.body);
          if (hospitalResponse.id != null) {
            hospital = hospitalResponse;
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
}
