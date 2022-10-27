import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import '../../constant.dart';
import '../../controller/exercise_controller.dart';
import '../../widget/exercise_history_widget.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  // ExerciseController exerciseController = Get.put(ExerciseController());
  final PatientProfileController patientProfileController =
      Get.find<PatientProfileController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Lịch sử'),
        backgroundColor: kBlueColor,
      ),
      body: SizedBox(
        child: GetBuilder<ExerciseController>(
          builder: (controller) => controller.isLoading.isTrue
              ? const Center(child: CircularProgressIndicator())
              : controller.exercise.content!.length == 0
                  ? Text(
                      'Không có bài tập nào',
                      style: TextStyle(fontSize: 18),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    // Padding(
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 14.0),
                                    //   child: Padding(
                                    //     padding:
                                    //         const EdgeInsets.only(top: 8.0),
                                    //     child:
                                    //     Row(
                                    //       mainAxisAlignment:
                                    //           MainAxisAlignment.spaceBetween,
                                    //       children: [
                                    //         Text(
                                    //           '24 tháng 11 - 30 tháng 11',
                                    //           style: TextStyle(
                                    //               fontWeight: FontWeight.w300),
                                    //         ),
                                    //         Text(
                                    //           '10 lần tập, 15 phút',
                                    //           style: TextStyle(
                                    //               fontWeight: FontWeight.w300),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: controller
                                            .exerciseHistory.content!.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ExerciseHistoryScreen(
                                            exerciseHistory: controller
                                                .exerciseHistory
                                                .content![index],
                                            patientId: patientProfileController
                                                .patient.value.id,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
