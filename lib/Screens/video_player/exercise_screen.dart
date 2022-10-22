import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:skeletons/skeletons.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:lottie/lottie.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

ExerciseController exerciseController = Get.put(ExerciseController());

class _ExerciseScreenState extends State<ExerciseScreen> {
  late VideoPlayerController videoPlayerController;
  late BuildContext contextGobal;
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
        () => onEnd(),
      ),
      presetMillisecond: StopWatchTimer.getMilliSecFromMinute(
          exerciseController.exerciseModel.practicetime == null
              ? 0
              : exerciseController
                  .exerciseModel.practicetime!), // millisecond => minute.
    );
    videoPlayerController = VideoPlayerController.network(
        exerciseController.exerciseModel.linkvideo!)
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

  void onStart() {
    print('onStart');
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

  void onEnd() {
    print('abcc');
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
        title: Text("Bài tập"),
        backgroundColor: kBlueColor,
      ),
      body: GetBuilder<ExerciseController>(
        builder: (controller) => controller.isLoading.isTrue
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${controller.exerciseModel.title}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  SizedBox(height: 12),
                  SizedBox(height: 12),
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
                  SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Vừa',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Mực độ'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${exerciseController.exerciseModel.bodyposition!}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Nhóm'),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            '${exerciseController.exerciseModel.practicetime!}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Icon(
                            Icons.access_time,
                            semanticLabel: 'Thời gian',
                          ),
                        ],
                      ),
                    ],
                  ),
                  StreamBuilder<int>(
                    stream: _stopWatchTimer.rawTime,
                    initialData: 0,
                    builder: (contextStream, snap) {
                      final value = snap.data;
                      return Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text(
                              StopWatchTimer.getDisplayTime(value!),
                              style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: 'Helvetica',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28),
                    child: Text(
                      '${controller.exerciseModel.description}',
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new FloatingActionButton(
        elevation: 0.0,
        child: videoPlayerController.value.isPlaying
            ? Icon(Icons.pause, size: 36)
            : Icon(Icons.play_arrow, size: 36),
        backgroundColor: kBlueColor,
        onPressed: () => setState(
          () => onStart(),
        ),
      ),
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
