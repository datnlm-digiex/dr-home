import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

import '../../controller/exercise_controller.dart';
import '../../widget/exercise_widget.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

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
        title: Text("Bài tập"),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
          //   child: InkWell(
          //     onTap: () {},
          //     child: Container(
          //       width: double.infinity,
          //       height: 46,
          //       padding: EdgeInsets.only(left: 20),
          //       decoration: BoxDecoration(
          //           color: Colors.white,
          //           borderRadius: BorderRadius.circular(50)),
          //       child: Row(children: [
          //         Icon(
          //           Icons.search,
          //           size: 30,
          //           color: Colors.black,
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(left: 20),
          //           child: Text(
          //             "Tìm kiếm bài tập",
          //             style: TextStyle(
          //               fontSize: 18,
          //               color: Colors.black,
          //             ),
          //           ),
          //         ),
          //       ]),
          //     ),
          //   ),
          // ),
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
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ConstrainedBox(
              constraints: new BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.60,
              ),
              child: GetBuilder<ExerciseController>(
                builder: (controller) => controller.isLoading.isTrue
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemCount: exerciseController.exercise.content!.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            const Divider(),
                        itemBuilder: (BuildContext context, int index) {
                          return Exercise(
                              exerciseModel:
                                  exerciseController.exercise.content![index]);
                        },
                      ),
              )),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      backgroundColor: kBlueColor),
                  onPressed: () {},
                  // onPressed: () => Get.to(ExerciseScreen()),
                  child: Text(
                    'Xem tất cả',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
