import 'dart:convert';

import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/models/Answer.dart';
import 'package:telemedicine_mobile/models/Question.dart';
import 'package:telemedicine_mobile/models/Survey.dart';

class QuestionController extends GetxController {
  RxList<dynamic> listQuestion = [].obs;
  RxMap<int, int> answerMap = Map<int, int>().obs;
  // var answerMap = new Map();
  RxInt totalQuestion = 0.obs;
  RxInt state = 4.obs;
  RxInt numberCurrentQuestion = 1.obs;
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
    print('value ${value}');
    print('questionId ${questionId}');
    answerMap[questionId] = value;
  }

  tangNumber() {
    if (numberCurrentQuestion.value < totalQuestion.value)
      numberCurrentQuestion++;
  }

  changeQuestion() {
    currenQuestion.value =
        listQuestion[numberCurrentQuestion.value - 1] as Question;
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

  Future<bool> submitSurvey({bool isRefresh = false}) async {
    List<Surveypatientan> surveypatientans = [];
    answerMap.forEach((key, value) {
      surveypatientans.add(new Surveypatientan(questionid: key, rate: value));
    });
    Answer answer = new Answer(
        surveyid: 1,
        patientid: 1,
        createdate: DateTime.now(),
        surveypatientans: surveypatientans);
    print(jsonEncode(answer));

    await FetchAPI.submitSurvey(answer).then((dataFromServer) {
      print(dataFromServer);
    });
    return false;
  }

  Future<bool> getListQuestion({bool isRefresh = false}) async {
    await FetchAPI.fetchListQuestion(1).then((dataFromServer) {
      listQuestion.value = dataFromServer;
      totalQuestion.value = dataFromServer.length;
    });
    changeQuestion();
    initListAnswer();
    return false;
  }
}