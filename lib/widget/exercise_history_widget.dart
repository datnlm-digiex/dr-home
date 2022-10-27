import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:telemedicine_mobile/models/ExerciseHistoryPaging.dart';
import 'package:video_player/video_player.dart';
import '../models/ExercisePaging.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ExerciseHistoryScreen extends StatefulWidget {
  final ExerciseHistory exerciseHistory;
  final int patientId;

  const ExerciseHistoryScreen(
      {Key? key, required this.exerciseHistory, required this.patientId})
      : super(key: key);

  @override
  State<ExerciseHistoryScreen> createState() => _ExerciseHistoryScreenState();
}

class _ExerciseHistoryScreenState extends State<ExerciseHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ExerciseController>(
      builder: (controller) => ListTile(
        onTap: () => {},
        // Get.to(ExerciseScreen(exerciseModel: widget.exerciseHistory)),
        // controller.getById(widget.exerciseModel.id!, widget.patientId),
        minLeadingWidth: 65,
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.exerciseHistory.thumbnail ?? '',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
            // Image.network(widget.exerciseModel.thumbnail!, fit: BoxFit.cover),
            ),
        title: Text(
          '${widget.exerciseHistory.exerciseName}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat.yMMMMEEEEd('vi_VN').format(widget.exerciseHistory.practiceday!)}',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: widget.exerciseHistory.iscomplete!
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.cancel,
                  color: Colors.redAccent,
                ),
          onPressed: () => {},
        ),
      ),
    );
  }
}
