import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/over_view_survey_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/question_controller.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final questionController = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    dynamic argumentData = Get.arguments;
    String test = argumentData[0]['first'];
    @override
    void initState() {
      super.initState();
      print(argumentData[0]['first']);
      print(argumentData[1]['second']);
    }

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("$test"),
          automaticallyImplyLeading: false,
          backgroundColor: kBlueColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => showAlertDialog(context),
          ),
        ),
        backgroundColor: kBackgroundColor,
        body: Column(
          children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green),
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        height: height * 0.7,
                        width: width,
                        // height: 400,
                        // width: 400,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                                color: Color.fromARGB(255, 209, 253, 211)),
                            color: Colors.green.shade50,
                          ),
                          height: height * 0.6,
                          width: width,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Câu hỏi ${questionController.numberCurrentQuestion}/${questionController.totalQuestion}',
                                  textAlign: TextAlign.left,
                                  // overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.green),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${questionController.currenQuestion.value.questiontitle}',
                                  textAlign: TextAlign.left,
                                  // overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                                SizedBox(height: 30),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 209, 253, 211)),
                                    color: Color.fromARGB(255, 243, 251, 243),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      '${questionController.currenQuestion.value.ans1}',
                                    ),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      value: 0,
                                      groupValue: questionController.answerMap[
                                          questionController
                                              .currenQuestion.value.id],
                                      onChanged: (value) {
                                        questionController.setState(
                                            int.parse(value.toString()),
                                            questionController
                                                .currenQuestion.value.id!);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 209, 253, 211)),
                                    color: Color.fromARGB(255, 243, 251, 243),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                        '${questionController.currenQuestion.value.ans2}'),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      value: 1,
                                      groupValue: questionController.answerMap[
                                          questionController
                                              .currenQuestion.value.id],
                                      onChanged: (value) {
                                        questionController.setState(
                                            int.parse(value.toString()),
                                            questionController
                                                .currenQuestion.value.id!);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 209, 253, 211)),
                                    color: Color.fromARGB(255, 243, 251, 243),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                        '${questionController.currenQuestion.value.ans3}'),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      value: 2,
                                      groupValue: questionController.answerMap[
                                          questionController
                                              .currenQuestion.value.id],
                                      onChanged: (value) {
                                        questionController.setState(
                                            int.parse(value.toString()),
                                            questionController
                                                .currenQuestion.value.id!);
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color:
                                            Color.fromARGB(255, 209, 253, 211)),
                                    color: Color.fromARGB(255, 243, 251, 243),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                        '${questionController.currenQuestion.value.ans4}'),
                                    leading: Radio(
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => Colors.green),
                                      value: 3,
                                      groupValue: questionController.answerMap[
                                          questionController
                                              .currenQuestion.value.id],
                                      onChanged: (value) {
                                        questionController.setState(
                                            int.parse(value.toString()),
                                            questionController
                                                .currenQuestion.value.id!);
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: kBlueColor),
                            onPressed: () {
                              if (questionController.answerMap[
                                      questionController
                                          .currenQuestion.value.id] ==
                                  999) {
                                Get.snackbar(
                                  "Thông báo",
                                  "Vui lòng chọn câu trả lời",
                                  icon: Icon(Icons.notification_important,
                                      color: Colors.white),
                                  snackPosition: SnackPosition.TOP,
                                  // backgroundColor: Colors.green,
                                );
                              } else if (questionController
                                      .numberCurrentQuestion ==
                                  questionController.listQuestion.length) {
                                questionController
                                    .submitSurvey(argumentData[2]['surveyId']);
                              } else {
                                questionController.tangNumber();
                                questionController.changeQuestion();
                              }
                            },
                            // onPressed: () => Get.to(ExerciseScreen()),
                            child: Text(
                              questionController.numberCurrentQuestion !=
                                      questionController.listQuestion.length
                                  ? 'Tiếp theo'
                                  : 'Hoàn thành',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return Dialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                "Khảo sát chưa hoàn thành!",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              //Would you like to delete this image?
              Text("Bạn có muốn ngừng làm khảo sát"),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () {
                    questionController.numberCurrentQuestion = 1;
                    Navigator.pop(contextDialog);
                    Get.off(BottomNavScreen());
                  },
                  child: Center(
                    child: Text(
                      "Thoát",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(this.context).size.width,
                height: 50,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () => Navigator.pop(contextDialog),
                  child: Center(
                    child: Text(
                      "Tiếp tục làm khảo sát",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
