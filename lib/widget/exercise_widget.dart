import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:video_player/video_player.dart';
import '../models/ExercisePaging.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Exercise extends StatefulWidget {
  final ExerciseModel exerciseModel;
  final int patientId;

  const Exercise(
      {Key? key, required this.exerciseModel, required this.patientId})
      : super(key: key);

  @override
  State<Exercise> createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  // late VideoPlayerController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = VideoPlayerController.network(widget.exerciseModel.linkvideo!)
  //     ..initialize().then((_) {
  //       // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
  //       setState(() {});
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(
      builder: (controller) => ListTile(
        onTap: () => Get.to(ExerciseScreen(exerciseModel: widget.exerciseModel)),
        // controller.getById(widget.exerciseModel.id!, widget.patientId),
        minLeadingWidth: 65,
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.exerciseModel.thumbnail ?? '',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
            // Image.network(widget.exerciseModel.thumbnail!, fit: BoxFit.cover),
            ),
        title: Text(
          '${widget.exerciseModel.title}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${widget.exerciseModel.durationvideo! ~/ 60}:${widget.exerciseModel.durationvideo! % 60}',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle),
          onPressed: () =>
              Get.to(ExerciseScreen(exerciseModel: widget.exerciseModel)),
        ),
      ),
    );
  }
}
