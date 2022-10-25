import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/overViewSurvey_screen.dart';
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
  // new SurveyOverViewListRespone(
  //     totalCount: 0,
  //     pageSize: 0,
  //     totalPage: 0,
  //     currentPage: 0,
  //     nextPage: 0,
  //     previousPage: 0,
  //     content: []).obs;

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
    print(surveyID);
    await FetchAPI.fetchSurveyOverView(surveyID).then((dataFromServer) {
      surveyOverView.value = dataFromServer;

      Get.to(OverViewSurveyScreen());
      return true;
    });
    return false;
  }
}
