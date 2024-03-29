import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/ExercisePaging.dart';
import 'package:video_player/video_player.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:skeletons/skeletons.dart';

import '../../compoment/status.dart';

class ExerciseScreen extends StatefulWidget {
  final ExerciseModel exerciseModel;

  const ExerciseScreen({Key? key, required this.exerciseModel})
      : super(key: key);

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

ExerciseController exerciseController = Get.put(ExerciseController());
PatientProfileController patientProfileController =
    Get.find<PatientProfileController>();

class _ExerciseScreenState extends State<ExerciseScreen> {
  late VideoPlayerController videoPlayerController;
  late BuildContext contextGobal;
  late DateTime startTime;
  final raw = 1000;
  var _stopWatchTimer;
  bool isCount = true;
  final value = StopWatchTimer.getMilliSecFromMinute(60);
  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onEnded: () => setState(
        () => onEnd(patientProfileController.patient.value.id),
      ),
      presetMillisecond: StopWatchTimer.getMilliSecFromMinute(
          widget.exerciseModel.practicetime == null
              ? 0
              : widget.exerciseModel.practicetime!), // millisecond => minute.
    );
    videoPlayerController =
        VideoPlayerController.network(widget.exerciseModel.linkvideo!)
          ..initialize().then((_) {
            setState(() {});
          });
    videoPlayerController.setLooping(true);
  }

  @override
  void dispose() {
    super.dispose();
    print('onDispose');
    videoPlayerController.dispose();
    _stopWatchTimer.dispose();
  }

  void markAsDone(int patientId) {
    isCount = false;
    startTime = new DateTime.now();
    exerciseController.submitExercise(
        patientId, widget.exerciseModel.id!, startTime);
  }

  void onStart() {
    startTime = new DateTime.now();
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      if (isCount) {
        _stopWatchTimer.onStopTimer();
      }
    } else {
      videoPlayerController.play();
      if (isCount) {
        _stopWatchTimer.onStartTimer();
      }
    }
  }

  void onResetTimer() {
    _stopWatchTimer.onResetTimer();
  }

  void onEnd(int patientId) {
    exerciseController.submitExercise(
        patientId, widget.exerciseModel.id!, startTime);
    showAlertDialog(contextGobal);
    videoPlayerController.pause();
    _stopWatchTimer.dispose();
    isCount = false;
  }

  @override
  Widget build(BuildContext context) {
    contextGobal = context;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${widget.exerciseModel.title}'),
        backgroundColor: kBlueColor,
        actions: [
          TextButton(
              onPressed: () {
                showConfirmAlertDialog(contextGobal);
              },
              child: isCount
                  ? Text(
                      'Hoàn thành',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : Container()),
        ],
      ),
      body: GetBuilder<ExerciseController>(
        builder: (controller) => controller.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
              child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipPath(
                        child: videoPlayerController.value.isInitialized
                            ? AspectRatio(
                                aspectRatio:
                                    videoPlayerController.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: <Widget>[
                                    VideoPlayer(videoPlayerController),
                                    GestureDetector(
                                      onTap: () => setState(
                                        () => onStart(),
                                      ),
                                    ),
                                    VideoProgressIndicator(videoPlayerController,
                                        allowScrubbing: true),
                                  ],
                                ),
                              )
                            : SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: double.infinity,
                                  minHeight:
                                      MediaQuery.of(context).size.height / 8,
                                  maxHeight:
                                      MediaQuery.of(context).size.height / 3,
                                ),
                              ),
                        clipper: ShapeBorderClipper(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                      ),
                    ),
                    isCount
                        ? StreamBuilder<int>(
                            stream: _stopWatchTimer.rawTime,
                            initialData: 0,
                            builder: (contextStream, snap) {
                              final value = snap.data;
                              return Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(
                                      StopWatchTimer.getDisplayTime(
                                          value == null ? 0 : value),
                                      style: TextStyle(
                                          fontSize: 40,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          )
                        : Container(),
                    ConstrainedBox(
                      constraints: new BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height / 4,
                        maxHeight: MediaQuery.of(context).size.height / 2.6,
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ListTile(
                              minLeadingWidth: 85,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Tên bài tập:',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              title: Text(
                                '${widget.exerciseModel.title == null ? '' : widget.exerciseModel.title}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 85,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Thời gian:',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              title: Text(
                                '${widget.exerciseModel.practicetime == null ? 0 : widget.exerciseModel.practicetime} phút',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 85,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Mức độ:',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              title: Text(
                                '${AppStatus.levelExercises[widget.exerciseModel.levelexercises == null ? 0 : widget.exerciseModel.levelexercises]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 85,
                              leading: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Lịch tập:',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ],
                              ),
                              title: Text(
                                '${widget.exerciseModel.practiceSchedule == null ? '' : widget.exerciseModel.practiceSchedule}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 14),
                              child: Text(
                                '${widget.exerciseModel.description}',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    videoPlayerController.value.isInitialized
                        ? Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(29),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 18, horizontal: 20),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      backgroundColor: kBlueColor),
                                  onPressed: () => setState(
                                    () => onStart(),
                                  ),
                                  child: Text(
                                    videoPlayerController.value.isPlaying
                                        ? 'Dừng lại'
                                        : 'Tập luyện',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
            ),
      ),
    );
  }

  showConfirmAlertDialog(BuildContext context) {
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
                "Hoàn thành bài tập",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              //Would you like to delete this image?
              Text("Xác nhận hoàn thành bài tập"),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () => {
                    setState(() {
                      markAsDone(patientProfileController.patient.value.id);
                      Fluttertoast.showToast(
                          msg: "Xác nhận thành công", fontSize: 18);
                    }),
                    Navigator.pop(contextDialog),
                  },
                  child: Center(
                    child: Text(
                      'Xác nhận',
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
                width: MediaQuery.of(context).size.width,
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
                      "Huỷ",
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

  showAlertDialog(BuildContext context) {
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/success.gif"),
              ),
              const SizedBox(height: 15),
              Text(
                "Chúc mừng!!!",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              //Would you like to delete this image?
              Text("Bạn đã hoàn thành bài tập"),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () => Navigator.pop(contextDialog),
                  child: Center(
                    child: Text(
                      "Tiếp tục",
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
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
