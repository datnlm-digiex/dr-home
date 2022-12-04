import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/SurveyHistoryResponse.dart';

class HistorySurveyController extends GetxController {
  bool isLoading = false;
  SurveyHistoryResponse historySurveyResponse =
      SurveyHistoryResponse();

  Future<bool> getListSurveyHistory(int patientId) async {
    isLoading = true;
    await FetchAPI.fetchListHistorySurvey(patientId).then((dataFromServer) {
      historySurveyResponse = dataFromServer;
      update();
      return true;
    });
    isLoading = false;
    update();
    return false;
  }
}