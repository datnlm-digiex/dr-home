import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/result_survey_screen.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/models/Answer.dart';
import 'package:telemedicine_mobile/models/Question.dart';
import 'package:telemedicine_mobile/models/Survey.dart';

class QuestionController extends GetxController {
  RxList<dynamic> listQuestion = [].obs;
  RxMap<int, int> answerMap = Map<int, int>().obs;
  // var answerMap = new Map();
  RxInt totalQuestion = 0.obs;
  RxInt state = 4.obs;
  RxInt patientId = 0.obs;
  int numberCurrentQuestion = 1;
  final AccountController accountController = Get.find<AccountController>();
  Rx<Question> currenQuestion = new Question(
    id: 0,
    questiontitle: "",
    ans1: "",
    ans2: "",
    ans3: "",
    ans4: "",
    status: false,
  ).obs;

  setState(int value, int questionId) {
    // state.value = value;
    answerMap[questionId] = value;
  }

  tangNumber() {
    if (numberCurrentQuestion < totalQuestion.value) numberCurrentQuestion++;
  }

  changeQuestion() {
    currenQuestion.value = listQuestion[numberCurrentQuestion - 1] as Question;
  }

  initListAnswer() {
    for (var i = 0; i < listQuestion.length; i++) {
      Question question = listQuestion[i] as Question;
      answerMap.addAll({question.id!: 999});
      print(answerMap.keys);
      // answerMap[question.id] = 99;
    }
  }

  // compeleteSurvey() {
  //   List<Surveypatientan> surveypatientans = [];
  //   answerMap.forEach((key, value) {
  //     surveypatientans.add(new Surveypatientan(questionid: key, rate: value));
  //   });
  //   Answer answer = new Answer(
  //       surveyid: 1,
  //       patientid: 1,
  //       createdate: DateTime.now(),
  //       surveypatientans: surveypatientans);
  //   print(jsonEncode(answer));
  // }

  Future<bool> submitSurvey(int surveyId) async {
    List<Surveypatientan> surveypatientans = [];
    answerMap.forEach((key, value) {
      surveypatientans.add(new Surveypatientan(questionid: key, rate: value));
    });
    Answer answer = new Answer(
        surveyid: surveyId,
        patientid: patientProfileController.patient.value.id,
        createdate: DateTime.now(),
        surveypatientans: surveypatientans);

    await FetchAPI.submitSurvey(answer).then((dataFromServer) {
      if (dataFromServer.id > 0) {
        numberCurrentQuestion = 1;
        Get.off(ResultSurveyScreen(surveyRespone: dataFromServer));
        Fluttertoast.showToast(
            msg: "Cập nhật khảo sát thành công", fontSize: 18);
        update();
      }
    });
    return true;
  }

  Future<bool> getListQuestion(int surveyId) async {
    print(surveyId);
    await FetchAPI.fetchListQuestion(surveyId).then((dataFromServer) {
      listQuestion.value = dataFromServer;
      totalQuestion.value = dataFromServer.length;
      print(dataFromServer);
    });
    changeQuestion();
    initListAnswer();
    return false;
  }
}
