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
        minLeadingWidth: 65,
        leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: CachedNetworkImage(
              imageUrl: widget.exerciseHistory.thumbnail ?? '',
              fit: BoxFit.cover,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  CircularProgressIndicator(value: downloadProgress.progress),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )),
        title: Text(
          '${widget.exerciseHistory.exerciseName}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat.yMMMMEEEEd('vi_VN').format(widget.exerciseHistory.practiceday!)}',
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          icon: widget.exerciseHistory.iscomplete != null &&
                  widget.exerciseHistory.iscomplete!
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
                      minLeadingWidth: 85,
                      onTap: () => {},
                      leading: Text(
                        'Bài tập',
                      ),
                      title: Text(
                        widget.exerciseHistory.exerciseName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 85,
                      onTap: () => {},
                      leading: Text(
                        'Lịch tập',
                      ),
                      title: Text(
                        '${widget.exerciseHistory.practicescheduleConvert}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 85,
                      onTap: () => {},
                      leading: Text(
                        'Thời lượng',
                      ),
                      title: Text(
                        '${widget.exerciseHistory.timepractice} phút',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    widget.exerciseHistory.morning != null
                        ? ListTile(
                            minLeadingWidth: 85,
                            onTap: () => {},
                            leading: Text(
                              'Buổi sáng',
                            ),
                            title: Text(
                              '${widget.exerciseHistory.morning!}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        : Container(),
                    widget.exerciseHistory.midday != null
                        ? ListTile(
                            minLeadingWidth: 85,
                            onTap: () => {},
                            leading: Text(
                              'Buổi trưa',
                            ),
                            title: Text(
                              '${widget.exerciseHistory.midday!}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        : Container(),
                    widget.exerciseHistory.afternoon != null
                        ? ListTile(
                            minLeadingWidth: 85,
                            onTap: () => {},
                            leading: Text(
                              'Buổi chiều',
                            ),
                            title: Text(
                              '${widget.exerciseHistory.afternoon!}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        : Container(),
                    widget.exerciseHistory.night != null
                        ? ListTile(
                            minLeadingWidth: 85,
                            onTap: () => {},
                            leading: Text(
                              'Buổi tối',
                            ),
                            title: Text(
                              '${widget.exerciseHistory.night!}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          )
                        : Container(),
                    ListTile(
                      minLeadingWidth: 85,
                      onTap: () => {},
                      leading: Text(
                        'Thời gian',
                      ),
                      title: Text(
                        '${DateFormat.yMd('vi_VN').format(widget.exerciseHistory.practiceday!)}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    ListTile(
                      minLeadingWidth: 85,
                      onTap: () => {},
                      leading: Text(
                        'Trạng thái',
                      ),
                      title: Text(
                        widget.exerciseHistory.iscomplete != null &&
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
