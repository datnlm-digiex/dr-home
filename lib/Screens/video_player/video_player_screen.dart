import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fvideo%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh.mp4?alt=media&token=9e23d6fc-e224-4e55-a009-ce23ff468152')
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bài tập vật lý trị liệu"),
        backgroundColor: kBlueColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
            child: InkWell(
              onTap: () {},
              child: Container(
                width: double.infinity,
                height: 46,
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)),
                child: Row(children: [
                  Icon(
                    Icons.search,
                    size: 30,
                    color: Colors.black,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Tìm kiếm bài tập",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ),
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
              maxHeight: MediaQuery.of(context).size.height * 0.55,
            ),
            child: ListView(
              shrinkWrap: true,
              children: ListTile.divideTiles(context: context, tiles: [
                ListTile(
                  onTap: () => _showModalVideo(context),
                  minLeadingWidth: 65,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fimage%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20bu%CC%A3ng%20(tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh).jpg?alt=media&token=1648bd31-007f-4884-b75b-3fd30cf7c65f',
                        fit: BoxFit.cover),
                  ),
                  title: Text(
                    '2. Bài tập thở cơ hoành',
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                      _controller.value.duration.inMinutes.toString() +
                          ':' +
                          _controller.value.duration.inSeconds.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () => _showModalVideo(context),
                  ),
                ),
                ListTile(
                  onTap: () => _showModalVideo(context),
                  minLeadingWidth: 65,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fimage%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20bu%CC%A3ng%20(tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh).jpg?alt=media&token=1648bd31-007f-4884-b75b-3fd30cf7c65f',
                        fit: BoxFit.cover),
                  ),
                  title: Text(
                    '10. Bài tập Dẫn lưu tư thế thùy dưới – phân thùy giữa phổi (T)',
                    style: const TextStyle(fontSize: 14),
                  ),
                  subtitle: Text(
                      _controller.value.duration.inMinutes.toString() +
                          ':' +
                          _controller.value.duration.inSeconds.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () => _showModalVideo(context),
                  ),
                ),
                ListTile(
                  onTap: () => _showModalVideo(context),
                  minLeadingWidth: 65,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fimage%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20bu%CC%A3ng%20(tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh).jpg?alt=media&token=1648bd31-007f-4884-b75b-3fd30cf7c65f',
                        fit: BoxFit.cover),
                  ),
                  title: Text('11. Bài tập tư thế thư giãn hô hấp với bóng',
                      style: const TextStyle(fontSize: 14)),
                  subtitle: Text(
                      _controller.value.duration.inMinutes.toString() +
                          ':' +
                          _controller.value.duration.inSeconds.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () => _showModalVideo(context),
                  ),
                ),
                ListTile(
                  onTap: () => _showModalVideo(context),
                  minLeadingWidth: 65,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fimage%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20bu%CC%A3ng%20(tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh).jpg?alt=media&token=1648bd31-007f-4884-b75b-3fd30cf7c65f',
                        fit: BoxFit.cover),
                  ),
                  title: Text('11. Bài tập tư thế thư giãn hô hấp với bóng',
                      style: const TextStyle(fontSize: 14)),
                  subtitle: Text(
                      _controller.value.duration.inMinutes.toString() +
                          ':' +
                          _controller.value.duration.inSeconds.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () => _showModalVideo(context),
                  ),
                ),
                ListTile(
                  onTap: () => _showModalVideo(context),
                  minLeadingWidth: 65,
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        'https://firebasestorage.googleapis.com/v0/b/cookingbox-project.appspot.com/o/assets%2Fimage%2F2.%20Ba%CC%80i%20ta%CC%A3%CC%82p%20tho%CC%9B%CC%89%20bu%CC%A3ng%20(tho%CC%9B%CC%89%20co%CC%9B%20hoa%CC%80nh).jpg?alt=media&token=1648bd31-007f-4884-b75b-3fd30cf7c65f',
                        fit: BoxFit.cover),
                  ),
                  title: Text('11. Bài tập tư thế thư giãn hô hấp với bóng',
                      style: const TextStyle(fontSize: 14)),
                  subtitle: Text(
                      _controller.value.duration.inMinutes.toString() +
                          ':' +
                          _controller.value.duration.inSeconds.toString()),
                  trailing: IconButton(
                    icon: const Icon(Icons.play_circle),
                    onPressed: () => _showModalVideo(context),
                  ),
                ),
              ]).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 20),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
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

  Future<void> _showModalVideo(BuildContext context) {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        // backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return _showVideo(context);
        });
  }

  SizedBox _showVideo(BuildContext context) {
    return SizedBox(
      child: Wrap(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Bài tập kiểm soát nhịp thở',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    ClipPath(
                      child: _controller.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller.value.aspectRatio,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: <Widget>[
                                  VideoPlayer(_controller),
                                  GestureDetector(
                                    onTap: () {
                                      _controller.value.isPlaying
                                          ? _controller.pause()
                                          : _controller.play();
                                    },
                                  ),
                                  VideoProgressIndicator(_controller,
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          'Tư thế: BN nằm ngửa trên sàn nhà hoặc trên giường, 2 tay đan lại trên đầu, chêm gối dưới nhượng chân. Thực hiện: hai tay đan trên đầu, khuỷu tay hạ xuống và hít thở.'),
                    ),
                    SizedBox(
                      height: 64,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          onPressed: () {},
                          child: Text(
                            'Huỷ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
