import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:video_player/video_player.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:get/get.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class ExerciseScreen extends StatefulWidget {
  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

ExerciseController exerciseController = Get.put(ExerciseController());

class _ExerciseScreenState extends State<ExerciseScreen> {
  late VideoPlayerController videoPlayerController;
  final raw = 1000;
  var _stopWatchTimer;
  final value = StopWatchTimer.getMilliSecFromMinute(60);
  @override
  void initState() {
    super.initState();
    _stopWatchTimer = StopWatchTimer(
      mode: StopWatchMode.countDown,
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
      _stopWatchTimer.onStopTimer();
    } else {
      videoPlayerController.play();
      _stopWatchTimer.onStartTimer();
    }
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  Widget build(BuildContext context) {
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
                  ClipPath(
                    child: videoPlayerController.value.isInitialized
                        ? AspectRatio(
                            aspectRatio:
                                videoPlayerController.value.aspectRatio,
                            child: Stack(
                              alignment: Alignment.bottomCenter,
                              children: <Widget>[
                                VideoPlayer(videoPlayerController),
                                GestureDetector(onTap: () => onStart()),
                                VideoProgressIndicator(videoPlayerController,
                                    allowScrubbing: true),
                              ],
                            ),
                          )
                        : Container(),
                    clipper: ShapeBorderClipper(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
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
                            '${exerciseController.exerciseModel.bodyposition!}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text('Nhóm'),
                        ],
                      ),
                      IconButton(
                        onPressed: () => onStart(),
                        icon: videoPlayerController.value.isPlaying
                            ? Icon(Icons.pause, size: 36)
                            : Icon(Icons.play_arrow, size: 36),
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
                    builder: (context, snap) {
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${controller.exerciseModel.description}'),
                  ),
                ],
              ),
      ),
    );
  }
}
