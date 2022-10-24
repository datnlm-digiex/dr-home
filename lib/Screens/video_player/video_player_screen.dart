import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:get/get.dart';
import '../../controller/exercise_controller.dart';
import '../../widget/exercise_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String type;

  const VideoPlayerScreen({Key? key, required this.type}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 7;
  ExerciseController exerciseController = Get.put(ExerciseController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Danh sách bài tập ${widget.type}"),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ListTile(
            title: Text(
              'Bài tập vật lý trị liệu',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              'Bài tập này được lựa chọn bởi bác sĩ, tập những bài tập này giúp bạn phục hồi nhanh hơn',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    'Vừa',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('Mực độ'),
                ],
              ),
              Column(
                children: [
                  Text(
                    '15',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('Tổng thời gian (phút)'),
                ],
              ),
              Column(
                children: [
                  Text(
                    widget.type,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text('Nhóm'),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Số lượng bài tập',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '(18)',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            child: GetBuilder<ExerciseController>(
              builder: (controller) => controller.isLoading.isTrue
                  ? const Center(child: CircularProgressIndicator())
                  : controller.exercise.content!.length == 0
                      ? Text(
                          'Không có bài tập nào',
                          style: TextStyle(fontSize: 18),
                        )
                      : Column(
                          children: [
                            ConstrainedBox(
                              constraints: new BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.60,
                              ),
                              child: ListView.separated(
                                itemCount:
                                    exerciseController.exercise.content!.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      Exercise(
                                          exerciseModel: exerciseController
                                              .exercise.content![index]),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(29),
                                          child: TextButton.icon(
                                            style: TextButton.styleFrom(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 18,
                                                      horizontal: 20),
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                            ),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down_sharp,
                                              size: 32,
                                            ),
                                            onPressed: () {},
                                            // onPressed: () => Get.to(ExerciseScreen()),
                                            label: Text(
                                              'Xem tất cả',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
            ),
          ),
        ],
      ),
    );
  }
}
