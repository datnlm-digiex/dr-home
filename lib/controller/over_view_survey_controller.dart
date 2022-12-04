import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Survey.dart';
import 'package:telemedicine_mobile/models/SurveyOverViewListResponse.dart';

class OverViewSurveyController extends GetxController {
  Rx<Survey> surveyOverView = new Survey(
    id: 0,
    numberquestion: 0,
    title: "",
    description: "",
    status: false,
  ).obs;
  bool isLoading = false;
  SurveyOverViewListRespone surveyOverViewListResponeObject =
      SurveyOverViewListRespone();

  Future<bool> getSuverOverViewListRespone({bool isRefresh = false}) async {
    isLoading = true;
    await FetchAPI.fetchListSurveyOverView().then((dataFromServer) {
      surveyOverViewListResponeObject = dataFromServer;
      update();
      return true;
    });
    isLoading = false;
    update();
    return false;
  }

  Future<bool> getSurveyOverView(int surveyID) async {
    isLoading = true;
    await FetchAPI.fetchSurveyOverView(surveyID).then((dataFromServer) {
      surveyOverView.value = dataFromServer;
      update();
      return true;
    });
    isLoading = false;
    return false;
  }
}
