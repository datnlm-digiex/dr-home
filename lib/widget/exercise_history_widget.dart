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
        onTap: () => showModalBottomSheet<void>(
            isScrollControlled: true,
            // backgroundColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            context: context,
            builder: (BuildContext context) {
              return _pickupImage(context);
            }),
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

  SizedBox _pickupImage(BuildContext context) {
    String session = '';
    String time = '';
    if (widget.exerciseHistory.morning != null) {
      session = 'sáng';
      time = widget.exerciseHistory.morning!;
    }
    if (widget.exerciseHistory.afternoon != null) {
      time = widget.exerciseHistory.afternoon!;
      if (session.trim().length != 0) {
        session += ', ';
      }
      session += 'chiều';
    }
    if (widget.exerciseHistory.midday != null) {
      time = widget.exerciseHistory.midday!;
      if (session.trim().length != 0) {
        session += ', ';
      }
      session += 'trưa';
    }
    if (widget.exerciseHistory.night != null) {
      time = widget.exerciseHistory.night!;
      if (session.trim().length != 0) {
        session += ', ';
      }
      session += 'tối';
    }
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.90,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CachedNetworkImage(
                    imageUrl: widget.exerciseHistory.thumbnail ?? '',
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: ListTile.divideTiles(context: context, tiles: [
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Bài tập',
                      ),
                      trailing: Text(
                        widget.exerciseHistory.exerciseName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Lịch tập',
                      ),
                      trailing: Text(
                        '${widget.exerciseHistory.practicescheduleConvert}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Thời lượng',
                      ),
                      trailing: Text(
                        '${widget.exerciseHistory.timepractice} phút',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Buổi $session',
                      ),
                      trailing: Text(
                        '$time',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Thời gian',
                      ),
                      trailing: Text(
                        '${DateFormat.yMd('vi_VN').format(widget.exerciseHistory.practiceday!)}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      onTap: () => {},
                      title: Text(
                        'Trạng thái',
                      ),
                      trailing: Text(
                        widget.exerciseHistory.iscomplete!
                            ? 'Hoàn thành'
                            : 'Chưa hoàn thành',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
