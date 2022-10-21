import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/overViewSurvey_screen.dart';
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
            backgroundColor: kBlueColor,
          ),
          backgroundColor: kBackgroundColor,
          body: Column(children: [
            Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                padding: EdgeInsets.only(top: 10),
                // margin: EdgeInsets.only(top: 10),
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
                                      fontSize: 14,
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
                    // Survey info
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 5),
                          width: width * 0.35, // <-- match_parent
                          height: 40, // <-- match-parent
                          child: OutlinedButton.icon(
                            icon: Icon(
                              // <-- Icon
                              Icons.arrow_circle_left_outlined,
                              size: 24.0,
                            ),
                            label: Text('Quit'),
                            onPressed: () {
                              // Navigator.of(context)
                              //     .pushReplacementNamed(HomeScreen.routeName);
                            },
                            style: OutlinedButton.styleFrom(
                                primary: Colors.black, // background
                                // foregroundColor: Colors.green,
                                textStyle: TextStyle(fontSize: 20)),
                          ),
                        ),
                        questionController.numberCurrentQuestion ==
                                questionController.listQuestion.length
                            ? Container(
                                padding: EdgeInsets.only(top: 5),
                                width: width * 0.45, // <-- match_parent
                                height: 40, // <-- match-parent
                                child: ElevatedButton.icon(
                                  icon: Icon(
                                    // <-- Icon
                                    Icons.done_sharp,
                                    size: 24.0,
                                  ),
                                  label: const Text("Hoàn thành"),
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed(HomeScreen.routeName);
                                    questionController.submitSurvey();
                                    Get.offAll(OverViewSurveyScreen());
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green, // background
                                      onPrimary: Colors.white, // foreground
                                      textStyle: TextStyle(fontSize: 20)),
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.only(top: 5),
                                width: width * 0.35, // <-- match_parent
                                height: 40, // <-- match-parent
                                child: ElevatedButton(
                                  child: const Text("Câu kế tiếp"),
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pushReplacementNamed(HomeScreen.routeName);

                                    questionController.tangNumber();
                                    questionController.changeQuestion();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.green, // background
                                      onPrimary: Colors.white, // foreground
                                      textStyle: TextStyle(fontSize: 20)),
                                ),
                              )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}