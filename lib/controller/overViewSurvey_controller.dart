import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Survey.dart';

class OverViewSurveyController extends GetxController {
  Rx<Survey> surveyOverView = new Survey(
    id: 0,
    numberquestion: 0,
    title: "",
    description: "s",
    status: false,
  ).obs;

  Future<bool> getSurveyOverView({bool isRefresh = false}) async {
    await FetchAPI.fetchSurveyOverView(1).then((dataFromServer) {
      surveyOverView.value = dataFromServer;
      return true;
    });
    return false;
  }
}
