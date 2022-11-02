import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/category.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:telemedicine_mobile/Screens/notification_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/over_view_survey_screen.dart';
import 'package:telemedicine_mobile/Screens/video_player/exercise_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/over_view_survey_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/News.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../controller/history_survery_controller.dart';
import '../widget/discover_card.dart';
import '../widget/discover_smaill_card.dart';
import '../widget/icons.dart';
import '../widget/svg_asset.dart';
import 'survey_screen/survey_history_screen.dart';
import 'video_player/video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PatientProfileController patientProfileController =
      Get.put(PatientProfileController());
  final ExerciseController _exerciseController = Get.put(ExerciseController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final storage = new FlutterSecureStorage();
  final accountController = Get.put(AccountController());
  List<News>? listNews;
  var statisticCovid;
  NumberFormat formatter = NumberFormat('###,000');
  final overViewSurveyController = Get.put(OverViewSurveyController());

  @override
  void initState() {
    super.initState();
    // getNews();
    // getStatisticCovid();
    patientProfileController.getMyPatient();
    _fireBaseConfig();
    overViewSurveyController.getSuverOverViewListRespone();
  }

  final Color start = Color(0xffFC67A7);
  final Color end = Color(0xffF6815B);

  void getNews() async {
    var newsList = await FetchAPI.fetchContentNews();
    setState(() {
      listNews = newsList;
    });
  }

  void getStatisticCovid() async {
    statisticCovid = await FetchAPI.fetchContentStaticCovid();
  }

  void _fireBaseConfig() {
    print('firebasessssss');
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.subscribeToTopic('all');
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      accountController.countNotificationUnread.value =
          accountController.countNotificationUnread.value + 1;
      showNotification(
          event.notification!.title ?? "", event.notification!.body ?? "");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.data['page'] != null) {
        listDoctorController.getTokenHealthCheck(
            patientProfileController.nearestHealthCheck.value.id);
      }
    });
    _firebaseMessaging
        .getToken()
        .then((token) {
          storage.write(key: "tokenFCM", value: token);
          print("firebase token");
          print(token);
        })
        .then((value) => {FetchAPI.makeConnection()})
        .then((value) => {FetchAPI.getCountUnreadNotification()});
  }

  void showNotification(String title, String body) async {
    print("kkkkkkkkk");
    await _demoNotification(title, body);
  }

  Future<void> _demoNotification(String title, String body) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel_ID', 'channel name',
        importance: Importance.max,
        playSound: true,
        showProgress: true,
        priority: Priority.high,
        ticker: 'test ticker');
    var iOSChannelSpecifics = DarwinNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSChannelSpecifics);
    print("mm");
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: 'test');
    print("nn");
  }

  final historySurveyController = Get.put(HistorySurveyController());
  final listDoctorController = Get.put(ListDoctorController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  // final patientHistoryController = Get.put(PatientHistoryController());
  final bottomNavbarController = Get.put(BottomNavbarController());
  // final filterController = Get.put(FilterController());

  Future<bool> getDoctorData({bool isRefresh = false}) async {
    if (!isRefresh) {
      if (listDoctorController.currentPage.value >=
          listDoctorController.totalPage.value) {
        refreshController.loadNoData();
        return true;
      } else {
        listDoctorController.currentPage.value += 1;
      }
    }
    bool isSuccess =
        await listDoctorController.getListDoctor(isRefresh: isRefresh);
    return isSuccess;
  }

  late int rating = 3;
  TextEditingController comment = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: kBackgroundColor,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Text(
                "Xin chào!",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Hero(
                tag: "patientName",
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    '${accountController.account.value.firstName + " " + accountController.account.value.lastName}',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            GetBuilder<ExerciseController>(
              builder: (controller) => Padding(
                padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                child: exerciseProcess(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Làm khảo sát trực tuyến",
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  TextButton(
                      onPressed: () => {
                            historySurveyController.getListSurveyHistory(
                                patientProfileController.patient.value.id),
                            Get.to(SurveyHistoryScreen())
                          },
                      child: Text('Xem lịch sử'))
                ],
              ),
            ),
            SizedBox(
              height: 175,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: GetBuilder<OverViewSurveyController>(
                  builder: (controller) => (controller.isLoading)
                      ? Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: double.infinity,
                              minHeight: MediaQuery.of(context).size.height / 8,
                              maxHeight: MediaQuery.of(context).size.height / 6,
                            ),
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller
                              .surveyOverViewListResponeObject.content!.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 15.0),
                              child: DiscoverCard(
                                tag: index.toString(),
                                onTap: () {
                                  overViewSurveyController.getSurveyOverView(
                                      controller.surveyOverViewListResponeObject
                                          .content![index].id);
                                  Get.to(OverViewSurveyScreen(
                                      survey: controller
                                          .surveyOverViewListResponeObject
                                          .content![index]));
                                },
                                gradientStartColor: index % 2 != 0 ? start : null,
                                gradientEndColor: index % 2 != 0 ? end : null,
                                title:
                                    "${controller.surveyOverViewListResponeObject.content![index].title}",
                                subtitle:
                                    "${controller.surveyOverViewListResponeObject.content![index].description}",
                              ),
                            );
                          }),
                        ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Loại bài tập",
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 19,
                          mainAxisExtent: 125,
                          mainAxisSpacing: 19),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        DiscoverSmallCard(
                          onTap: () => {
                            _exerciseController.fetchExercise(
                                2, patientProfileController.patient.value.id),
                            Get.to(VideoPlayerScreen(
                              type: "Phổi",
                              groupId: 2,
                            ))
                          },
                          title: "Bài tập phổi",
                          gradientStartColor: Color(0xff13DEA0),
                          gradientEndColor: Color(0xff06B782),
                          icon: SvgAsset(
                            assetName: AssetName.lungs,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        DiscoverSmallCard(
                          onTap: () => {
                            _exerciseController.fetchExercise(
                                4, patientProfileController.patient.value.id),
                            Get.to(VideoPlayerScreen(
                              type: "Tim",
                              groupId: 4,
                            ))
                          },
                          title: "Bài tập tim",
                          gradientStartColor: Color(0xffFC67A7),
                          gradientEndColor: Color(0xffF6815B),
                          icon: SvgAsset(
                            assetName: AssetName.heart,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        DiscoverSmallCard(
                          onTap: () => {
                            _exerciseController.fetchExercise(
                                3, patientProfileController.patient.value.id),
                            Get.to(VideoPlayerScreen(
                              type: "Não",
                              groupId: 3,
                            ))
                          },
                          title: "Bài tập não",
                          gradientStartColor: Color(0xffFFD541),
                          gradientEndColor: Color(0xffF0B31A),
                          icon: SvgAsset(
                            assetName: AssetName.brain,
                            height: 24,
                            width: 24,
                          ),
                        ),
                        DiscoverSmallCard(
                          onTap: () => {
                            _exerciseController.fetchExercise(
                                1, patientProfileController.patient.value.id),
                            Get.to(VideoPlayerScreen(
                              type: "Vật lý trị liệu",
                              groupId: 1,
                            ))
                          },
                          title: "Bài tập vật lý trị liệu",
                          icon: SvgAsset(
                            assetName: AssetName.tape,
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material exerciseProcess() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => {},
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          height: 150,
          width: 250,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(184, 43, 167, 51),
                Color.fromARGB(255, 8, 160, 8),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 24, top: 16),
            child: Container(
              height: 150,
              width: 250,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 180,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Hero(
                                    tag: '',
                                    child: Material(
                                      color: Colors.transparent,
                                      child: Text(
                                        'TIẾN ĐỘ TẬP LUYỆN HÔM NAY',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            overflow: TextOverflow.clip),
                                      ),
                                    ),
                                  ),
                                  Divider(
                                    height: 10,
                                  ),
                                  Text(
                                    "${exerciseController.exerciseProcess.times}/${exerciseController.exerciseProcess.totalTimes} Lần tập",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w300,
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 5, left: 25.0),
                              child: new CircularPercentIndicator(
                                radius: 55.0,
                                lineWidth: 4.0,
                                percent:
                                    exerciseController.exerciseProcess.percent /
                                        100,
                                center: new Text(
                                  "${exerciseController.exerciseProcess.percent}%",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                progressColor: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
