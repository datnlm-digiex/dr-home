import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/category.dart';
import 'package:telemedicine_mobile/Screens/detail_screen.dart';
import 'package:telemedicine_mobile/Screens/notification_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_detail_history_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/overViewSurvey_screen.dart';
import 'package:telemedicine_mobile/Screens/survey_screen/survey_history_screen.dart';
import 'package:telemedicine_mobile/Screens/introduction_slider_screen.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/exercise_controller.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/history_survey_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/overViewSurvey_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';
import 'package:telemedicine_mobile/models/News.dart';
import 'package:telemedicine_mobile/widget/survey_history.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../widget/discover_card.dart';
import '../widget/discover_smaill_card.dart';
import '../widget/icons.dart';
import '../widget/svg_asset.dart';
import 'video_player/video_player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ExerciseController _exerciseController = Get.put(ExerciseController());
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final contentDAS =
      "Bài test (trắc nghiệm) DAS 21 (gồm 21 câu hỏi) là thang đo chẩn đoán khá phổ biến, chính xác và nhanh chống về mức độ rối loạn lo âu - tầm cảm - stress mà bạn đọc có thể tự làm trong vài phút.";

  final storage = new FlutterSecureStorage();
  final accountController = Get.put(AccountController());
  List<News>? listNews;
  var statisticCovid;
  NumberFormat formatter = NumberFormat('###,000');
  final overViewSurveyController = Get.put(OverViewSurveyController());
  @override
  void initState() {
    super.initState();
    getNews();
    getStatisticCovid();
    PatientProfileController patientProfileController =
        Get.put(PatientProfileController());
    patientProfileController.getNearestHealthCheck();
    _fireBaseConfig();
    overViewSurveyController.getSuverOverViewListRespone();
  }

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
    _firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    _firebaseMessaging.subscribeToTopic('all');
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event);
      print(event.notification!.title);
      print(event.notification!.body);
      print(accountController.countNotificationUnread.value);
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

  final patientProfileController = Get.put(PatientProfileController());
  final historySurveyController = Get.put(HistorySurveyController());

  final listDoctorController = Get.put(ListDoctorController());

  final RefreshController refreshController =
      RefreshController(initialRefresh: true);

  final patientHistoryController = Get.put(PatientHistoryController());

  final bottomNavbarController = Get.put(BottomNavbarController());
  final filterController = Get.put(FilterController());
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
        // appBar: AppBar(
        //   title: Text("Trang chủ"),
        //   centerTitle: true,
        //   automaticallyImplyLeading: false,
        //   backgroundColor: kBlueColor,
        //   actions: [notification()],
        // ),
        backgroundColor: kBackgroundColor,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 25,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Xin chào!",
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0).withOpacity(0.7),
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Hero(
                tag: "patientName",
                child: Material(
                  color: Colors.transparent,
                  child: Text(patientProfileController.patient.value.name,
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 24,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: exerciseProcess(),
            ),
            SizedBox(
              height: 26,
            ),
            Container(
              child: InkWell(child: Text("testtttttt"),onTap: () => {Get.to(IntroductionScreenSliderState())}),
            ),
            Container(
                // width: 200,
                padding: EdgeInsets.only(left: 28, right: 28),
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
                    OutlinedButton.icon(
                      icon: Icon(
                        // <-- Icon
                        Icons.history,
                        size: 14.0,
                        // color: Colors.green,
                      ),
                      label: Text('Lịch sử',
                          style: TextStyle(
                              // color: Color(0xff515979),
                              // fontWeight: FontWeight.bold,
                              fontSize: 14)),
                      onPressed: () {
                        historySurveyController.getListSurveyHistory(3);
                        Get.to(SurveyHistoryScreen());
                        // showAlertDialog(context);
                      },
                      style: OutlinedButton.styleFrom(
                          primary: Colors.green, // background
                          // foregroundColor: Colors.green,
                          side: BorderSide(color: Colors.green),
                          textStyle:
                              TextStyle(fontSize: 14, color: Colors.green)),
                    )
                  ],
                )),
            SizedBox(
                height: 240,
                child: GetBuilder<OverViewSurveyController>(
                  builder: (controller) => (controller.isLoading)
                      ? const Center(child: CircularProgressIndicator())
                      : controller.surveyOverViewListResponeObject.content!
                                  .isEmpty &&
                              !controller.isLoading
                          ? Container(
                              child: Text("Không có bài tập"),
                            )
                          : ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller
                                  .surveyOverViewListResponeObject
                                  .content!
                                  .length,
                              itemBuilder: ((context, index) {
                                return SizedBox(
                                  height: 240,
                                  child: DiscoverCard(
                                    tag: "$index",
                                    onTap: () {
                                      overViewSurveyController
                                          .getSurveyOverView(controller
                                              .surveyOverViewListResponeObject
                                              .content![index]
                                              .id);
                                    },
                                    title:
                                        "${controller.surveyOverViewListResponeObject.content![index].title}",
                                    subtitle:
                                        "${controller.surveyOverViewListResponeObject.content![index].description}",
                                  ),
                                );
                              }),
                            ),
                )),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Loại bài tập",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
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
                      _exerciseController.fetchExercise(1),
                      Get.to(VideoPlayerScreen())
                    },
                    title: "Bài tập phổi",
                    subtitle: "1 Bài tập",
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
                      _exerciseController.fetchExercise(2),
                      Get.to(VideoPlayerScreen())
                    },
                    title: "Bài tập tim",
                    subtitle: "11 Bài tập",
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
                      _exerciseController.fetchExercise(3),
                      Get.to(VideoPlayerScreen())
                    },
                    title: "Bài tập tim",
                    subtitle: "8 Bài tập",
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
                      _exerciseController.fetchExercise(4),
                      Get.to(VideoPlayerScreen())
                    },
                    title: "Bài tập não",
                    subtitle: "19 Bài tập",
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
                      _exerciseController.fetchExercise(5),
                      Get.to(VideoPlayerScreen())
                    },
                    title: "Bài tập vật lý trị liệu",
                    subtitle: "11 Bài tập",
                    icon: SvgAsset(
                      assetName: AssetName.tape,
                      height: 24,
                      width: 24,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Row(
                children: [
                  Text(
                    "Cuộc hẹn sắp tới",
                    style: TextStyle(
                        color: Color(0xff515979),
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () =>
                        {bottomNavbarController.currentIndex.value = 2},
                    child: Text(
                      'Xem tất cả',
                      style: TextStyle(
                        color: kBlueColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            patientProfileController.nearestHealthCheck.value.id == 0
                ? Center(
                    child: Text(
                    "Bạn chưa có lịch hẹn",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
                  ))
                : schedule(),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.only(left: 28),
              child: Text(
                "Bác sĩ hàng đầu",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            patientHistoryController.listTopDoctor.length > 0
                ? doctor()
                : Container(),
            SizedBox(
              height: 20,
            ),
            patientHistoryController.listTopDoctor.length > 1
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: InkWell(
                      onTap: () => {
                        listDoctorController.getListDoctorSlot(
                            patientHistoryController.listTopDoctor[1].id),
                        patientProfileController.getMyPatient(),
                        Get.to(DetailScreen(
                          patientHistoryController.listTopDoctor[1].name,
                          patientHistoryController
                              .listTopDoctor[1].scopeOfPractice,
                          patientHistoryController.listTopDoctor[1].description,
                          patientHistoryController.listTopDoctor[1].avatar,
                          patientHistoryController
                              .listTopDoctor[1].majorDoctors,
                          patientHistoryController
                              .listTopDoctor[1].hospitalDoctors,
                          patientHistoryController
                              .listTopDoctor[1].certificationDoctors,
                          patientHistoryController.listTopDoctor[1].rating,
                          patientHistoryController
                              .listTopDoctor[1].numberOfConsultants,
                          patientHistoryController
                              .listTopDoctor[1].dateOfCertificate,
                        )),
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kWhiteColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 5,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(7, 8)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 90,
                              child: Image.network(
                                patientHistoryController
                                    .listTopDoctor[1].avatar,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                        "assets/images/default_avatar.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: Text(
                                "Bs. " +
                                    patientHistoryController
                                        .listTopDoctor[1].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(90, 30, 0, 0),
                              child: Text(
                                patientHistoryController.listTopDoctor[1]
                                            .majorDoctors.length >
                                        0
                                    ? patientHistoryController.listTopDoctor[1]
                                        .majorDoctors[0].major.name
                                    : "",
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.75),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(90, 60, 0, 0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      patientHistoryController
                                          .listTopDoctor[1].rating
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      ".",
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(
                                      patientHistoryController.listTopDoctor[1]
                                              .numberOfConsultants
                                              .toString() +
                                          " đánh giá",
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 20,
            ),
            patientHistoryController.listTopDoctor.length > 2
                ? Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: InkWell(
                      onTap: () => {
                        listDoctorController.getListDoctorSlot(
                            patientHistoryController.listTopDoctor[2].id),
                        patientProfileController.getMyPatient(),
                        Get.to(DetailScreen(
                          patientHistoryController.listTopDoctor[2].name,
                          patientHistoryController
                              .listTopDoctor[2].scopeOfPractice,
                          patientHistoryController.listTopDoctor[2].description,
                          patientHistoryController.listTopDoctor[2].avatar,
                          patientHistoryController
                              .listTopDoctor[2].majorDoctors,
                          patientHistoryController
                              .listTopDoctor[2].hospitalDoctors,
                          patientHistoryController
                              .listTopDoctor[2].certificationDoctors,
                          patientHistoryController.listTopDoctor[2].rating,
                          patientHistoryController
                              .listTopDoctor[2].numberOfConsultants,
                          patientHistoryController
                              .listTopDoctor[2].dateOfCertificate,
                        )),
                      },
                      child: Container(
                        padding: EdgeInsets.all(15),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: kWhiteColor,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 7,
                                spreadRadius: 5,
                                color: Colors.grey.withOpacity(0.5),
                                offset: Offset(7, 8)),
                          ],
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 90,
                              child: Image.network(
                                patientHistoryController
                                    .listTopDoctor[2].avatar,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image.asset(
                                        "assets/images/default_avatar.png"),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 90),
                              child: Text(
                                "Bs. " +
                                    patientHistoryController
                                        .listTopDoctor[2].name,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(90, 30, 0, 0),
                              child: Text(
                                patientHistoryController.listTopDoctor[2]
                                            .majorDoctors.length >
                                        0
                                    ? patientHistoryController.listTopDoctor[2]
                                        .majorDoctors[0].major.name
                                    : "",
                                maxLines: 1,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.75),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(90, 60, 0, 0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 5, 0, 0),
                                    child: Text(
                                      patientHistoryController
                                          .listTopDoctor[2].rating
                                          .toString(),
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    child: Text(
                                      ".",
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Text(
                                      patientHistoryController.listTopDoctor[0]
                                              .numberOfConsultants
                                              .toString() +
                                          " đánh giá",
                                      style: TextStyle(
                                          color: Colors.grey.withOpacity(0.75),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Thống kê Covid-19",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
              child: Container(
                width: double.infinity,
                height: 60,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Color(0xfff6f6f6),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          patientProfileController.statusCovid.value =
                              "VietNam",
                        },
                        child: Container(
                          width: 104,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: patientProfileController.statusCovid.value ==
                                    "VietNam"
                                ? kBlueColor
                                : Color(0xfff6f6f6),
                          ),
                          child: Center(
                              child: Text(
                            "Việt Nam",
                            style: TextStyle(
                              color:
                                  patientProfileController.statusCovid.value ==
                                          "VietNam"
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 18,
                            ),
                          )),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () => {
                          patientProfileController.statusCovid.value = "World"
                        },
                        child: Container(
                          width: 104,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: patientProfileController.statusCovid.value ==
                                    "World"
                                ? kBlueColor
                                : Color(0xfff6f6f6),
                          ),
                          child: Center(
                              child: Text(
                            "Thế giới",
                            style: TextStyle(
                              color:
                                  patientProfileController.statusCovid.value ==
                                          "World"
                                      ? Colors.white
                                      : Colors.black,
                              fontSize: 18,
                            ),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            statisticCovid != null ? syncData() : Container(),
            SizedBox(
              height: 30,
            ),
            news(),
            listNews != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Column(
                      children: [
                        ...listNews!.take(5).map((e) => BuildNewsList(
                            title: e.title,
                            desc: e.description,
                            url: e.url,
                            urlImage: e.urlToImage))
                      ],
                    ),
                  )
                : Container(),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 28),
              child: Text(
                "Bình luận phổ biến",
                style: TextStyle(
                    color: Color(0xff515979),
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildTopComment(),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  Padding doctor() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
      child: InkWell(
        onTap: () => {
          listDoctorController
              .getListDoctorSlot(patientHistoryController.listTopDoctor[0].id),
          patientProfileController.getMyPatient(),
          Get.to(DetailScreen(
            patientHistoryController.listTopDoctor[0].name,
            patientHistoryController.listTopDoctor[0].scopeOfPractice,
            patientHistoryController.listTopDoctor[0].description,
            patientHistoryController.listTopDoctor[0].avatar,
            patientHistoryController.listTopDoctor[0].majorDoctors,
            patientHistoryController.listTopDoctor[0].hospitalDoctors,
            patientHistoryController.listTopDoctor[0].certificationDoctors,
            patientHistoryController.listTopDoctor[0].rating,
            patientHistoryController.listTopDoctor[0].numberOfConsultants,
            patientHistoryController.listTopDoctor[0].dateOfCertificate,
          )),
        },
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: kWhiteColor,
            boxShadow: [
              BoxShadow(
                  blurRadius: 7,
                  spreadRadius: 5,
                  color: Colors.grey.withOpacity(0.5),
                  offset: Offset(7, 8)),
            ],
          ),
          child: Stack(
            children: [
              Container(
                width: 80,
                height: 90,
                child: Image.network(
                  patientHistoryController.listTopDoctor[0].avatar,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/images/default_avatar.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 90),
                child: Text(
                  "Bs. " + patientHistoryController.listTopDoctor[0].name,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 30, 0, 0),
                child: Text(
                  patientHistoryController
                              .listTopDoctor[0].majorDoctors.length >
                          0
                      ? patientHistoryController
                          .listTopDoctor[0].majorDoctors[0].major.name
                      : "",
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.withOpacity(0.75),
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(90, 60, 0, 0),
                child: Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                      child: Text(
                        patientHistoryController.listTopDoctor[0].rating
                            .toString(),
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.75),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.75),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                      child: Text(
                        patientHistoryController
                                .listTopDoctor[0].numberOfConsultants
                                .toString() +
                            " đánh giá",
                        style: TextStyle(
                            color: Colors.grey.withOpacity(0.75),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding schedule() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: InkWell(
        onTap: () => {
          patientHistoryController.index.value = 0,
          Get.to(() => PatientDetailHistoryScreen(),
              transition: Transition.rightToLeftWithFade,
              duration: Duration(microseconds: 600)),
        },
        child: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: kBlueColor,
          ),
          child: Stack(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  patientProfileController
                      .nearestHealthCheck.value.slots[0].doctor.avatar,
                  errorBuilder: (context, error, stackTrace) =>
                      Image.asset("assets/images/default_avatar.png"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 80),
                child: Text(
                  "Bs. " +
                      patientProfileController
                          .nearestHealthCheck.value.slots[0].doctor.name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(80, 30, 0, 0),
                child: Text(
                  "Chuyên khoa",
                  style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 16,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(250, 0, 0, 0),
                child: InkWell(
                  onTap: () => {
                    listDoctorController.getTokenHealthCheck(
                        patientProfileController.nearestHealthCheck.value.id),
                    if (DateTime.now().compareTo(DateTime.parse(
                            DateFormat("yyyy-MM-dd").format(DateTime.parse(
                                    patientProfileController.nearestHealthCheck
                                        .value.slots[0].assignedDate)) +
                                " " +
                                patientProfileController.nearestHealthCheck
                                    .value.slots[0].startTime)) ==
                        1)
                      {
                        // listDoctorController
                        //     .getTokenHealthCheck(
                        //         patientProfileController
                        //             .nearestHealthCheck
                        //             .value
                        //             .id),
                      }
                    else
                      {
                        // showDialog(
                        //     context: context,
                        //     builder: (context) {
                        //       return AlertDialog(
                        //         title: Text("Thông báo"),
                        //         content: Text(
                        //             "Chưa tới giờ tư vấn"),
                        //         actions: [
                        //           OutlinedButton(
                        //             onPressed: () =>
                        //                 Navigator.of(
                        //                         context)
                        //                     .pop(),
                        //             child: Text("Đóng"),
                        //           )
                        //         ],
                        //       );
                        //     })
                      }
                  },
                  child: Icon(
                    Icons.phone,
                    size: 40,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 80),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff85a7fa),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.date_range,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          DateFormat.E(Locale("vi", "VN").languageCode).format(
                                  DateTime.parse(patientProfileController
                                      .nearestHealthCheck
                                      .value
                                      .slots[0]
                                      .assignedDate)) +
                              ", " +
                              DateFormat('dd').format(DateTime.parse(
                                  patientProfileController.nearestHealthCheck
                                      .value.slots[0].assignedDate)) +
                              " tháng" +
                              DateFormat('MM').format(DateTime.parse(
                                  patientProfileController.nearestHealthCheck.value.slots[0].assignedDate)),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                      Icon(
                        Icons.watch_later_outlined,
                        color: Colors.white,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          patientProfileController
                                  .nearestHealthCheck.value.slots[0].startTime
                                  .toString()
                                  .replaceRange(5, 8, "") +
                              " - " +
                              patientProfileController
                                  .nearestHealthCheck.value.slots[0].endTime
                                  .toString()
                                  .replaceRange(5, 8, ""),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: SvgAsset(
                        height: 150,
                        width: 250,
                        assetName: AssetName.vectorBottom),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: SvgAsset(
                        height: 150,
                        width: 250,
                        assetName: AssetName.vectorTop),
                  ),
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
                                    '1/23 Bài tập',
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
                                percent: 0.90,
                                center: new Text(
                                  "90%",
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

  Padding news() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: [
          Text(
            "Tin tức",
            style: TextStyle(
                color: Color(0xff515979),
                fontWeight: FontWeight.bold,
                fontSize: 14),
          ),
          Expanded(child: Container()),
          InkWell(
            onTap: () {},
            child: Text(
              "Xem tất cả",
              style: TextStyle(
                fontSize: 14,
                color: kBlueColor,
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding syncData() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                color: Color(0xffed1c24).withOpacity(0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Center(
                    child: Text(
                      "Số ca nhiễm".toUpperCase(),
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    patientProfileController.statusCovid.value == "VietNam"
                        ? formatter
                            .format(statisticCovid['total'].internal.cases)
                            .replaceAll(",", ".")
                        : NumberFormat.compact()
                            .format(statisticCovid['total'].world.cases)
                            .toString(),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w800,
                      color: Color(0xffED1C24),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.cases > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.cases > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.cases > 0
                      ? Text(
                          "+${statisticCovid['today'].internal.cases > 100 ? formatter.format(statisticCovid['today'].internal.cases).replaceAll(",", ".") : statisticCovid['today'].internal.cases}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.cases > 0
                      ? Text(
                          "+${statisticCovid['today'].world.cases > 100 ? formatter.format(statisticCovid['today'].world.cases).replaceAll(",", ".") : statisticCovid['today'].world.cases}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                color: Color(0xff3ca745).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Khỏi".toUpperCase(),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    patientProfileController.statusCovid.value == "VietNam"
                        ? formatter
                            .format(statisticCovid['total'].internal.recovered)
                            .replaceAll(",", ".")
                        : NumberFormat.compact()
                            .format(statisticCovid['total'].world.recovered)
                            .replaceAll(",", "."),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff28A745),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.recovered > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.recovered > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.recovered > 0
                      ? Text(
                          "+${statisticCovid['today'].internal.recovered > 100 ? formatter.format(statisticCovid['today'].internal.recovered).replaceAll(",", ".") : statisticCovid['today'].internal.recovered}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.cases > 0
                      ? Text(
                          "+${statisticCovid['today'].world.cases > 100 ? formatter.format(statisticCovid['today'].world.cases).replaceAll(",", ".") : statisticCovid['today'].world.cases}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Container(
              width: 115,
              height: 115,
              decoration: BoxDecoration(
                color: Color(0xffF0EFF4),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Tử vong".toUpperCase(),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    patientProfileController.statusCovid.value == "VietNam"
                        ? formatter
                            .format(statisticCovid['total'].internal.death)
                            .replaceAll(",", ".")
                        : NumberFormat.compact()
                            .format(statisticCovid['total'].world.death)
                            .replaceAll(",", "."),
                    softWrap: false,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xff333333),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.death > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.death > 0
                      ? Text(
                          "Hôm nay",
                          style: TextStyle(color: Colors.black54),
                        )
                      : Container(),
                  SizedBox(
                    height: 4,
                  ),
                  patientProfileController.statusCovid.value == "VietNam" &&
                          statisticCovid['today'].internal.death > 0
                      ? Text(
                          "+${statisticCovid['today'].internal.death > 100 ? formatter.format(statisticCovid['today'].internal.death).replaceAll(",", ".") : statisticCovid['today'].internal.death}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                  patientProfileController.statusCovid.value == "World" &&
                          statisticCovid['today'].world.death > 0
                      ? Text(
                          "+${statisticCovid['today'].world.death > 100 ? formatter.format(statisticCovid['today'].world.death).replaceAll(",", ".") : statisticCovid['today'].world.death}",
                          softWrap: false,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87.withOpacity(0.7),
                            fontWeight: FontWeight.w700,
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container notification() {
    return Container(
      width: 60,
      child: Stack(
        children: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none_outlined,
              size: 34,
            ),
            onPressed: () {
              Get.to(NotificationScreen());
            },
          ),
          accountController.countNotificationUnread.value == 0
              ? Container()
              : Positioned(
                  top: 8,
                  right: 9,
                  child: Container(
                    width: 23,
                    height: 23,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1),
                      color: Colors.redAccent,
                    ),
                    child: Center(
                      child: Text(
                        accountController.countNotificationUnread.value > 10
                            ? "+10"
                            : accountController.countNotificationUnread.value
                                .toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Center search() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 20, 18, 20),
        child: InkWell(
          onTap: () {
            filterController.getListMajor();
            bottomNavbarController.currentIndex.value = 1;
            listDoctorController.condition.value = "";
          },
          child: Container(
            width: double.infinity,
            height: 46,
            padding: EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Row(children: [
              Icon(
                Icons.search,
                size: 30,
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Tìm kiếm bác sĩ",
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
    );
  }

  Padding welcome() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18),
      child: Text(
        'Xin chào!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: kTitleTextColor,
        ),
      ),
    );
  }

  buildExerciseList() {
    return SizedBox(
      height: 80,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: 28),
          DiscoverCard(
            tag: "sleepMeditation",
            onTap: () {},
            title: "Sleep Meditation",
            subtitle: "7 Day Audio and Video Series",
          ),
          SizedBox(width: 20),
          DiscoverCard(
            onTap: () {},
            title: "Depression Healing",
            subtitle: "10 Days Audio and Video Series",
            gradientStartColor: Color(0xffFC67A7),
            gradientEndColor: Color(0xffF6815B),
          ),
        ],
      ),
    );
  }

  buildCategoryList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          SizedBox(
            width: 12,
          ),
          CategoryCard(
            'Danh sách\nbác sĩ',
            'assets/icons/list_doctor.png',
            kYellowColor,
            1,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Lịch sử\ncủa bạn',
            'assets/icons/history_icon.png',
            kOrangeColor,
            2,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Covid-19\nSymptoms',
            'assets/icons/covid19.png',
            kOrangeColor,
            5,
          ),
          SizedBox(
            width: 10,
          ),
          CategoryCard(
            'Bệnh viện\nGần đây',
            'assets/icons/hospital.png',
            kBlueColor,
            4,
          ),
        ],
      ),
    );
  }

  buildTopComment() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://static.tuoitre.vn/tto/i/s1280/2017/08/13/65b5ee46-1-1502592668.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Trần Cảnh",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Người dùng",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://tophinhanhdep.com/wp-content/uploads/2021/03/anh-avatar-girl-xinh-200x300.jpeg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Trúc Quỳnh",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Người dùng",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://radiologyhanoi.com/uploads/2021/03/rsz_2150215_nguyen_thi_huong_thsbsnt.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Lê Thị Tuyết",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Bác sĩ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Container(
            alignment: Alignment.center,
            width: 350,
            height: 350,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 350,
                  height: 280,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: kWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 7,
                          spreadRadius: 5,
                          color: Colors.grey.withOpacity(0.5),
                          offset: Offset(7, 8)),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          "https://newsmd1fr.keeng.net/tiin/archive/images/2016/09/06/144209_12.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Đặng Hữu Nhân",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Bác sĩ",
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        "Ứng dụng rất hay giúp đỡ. Is a simple but neat comments system solution for your website that allows you to completely control over its style and behavior with many ...",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 24,
          ),
        ],
      ),
    );
  }
}

class BuildNewsList extends StatelessWidget {
  const BuildNewsList({
    Key? key,
    required this.title,
    required this.desc,
    required this.url,
    required this.urlImage,
  }) : super(key: key);
  final String title, desc, url, urlImage;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 90,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    urlImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Image.asset("assets/images/default_avatar.png"),
                  )),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  children: [
                    Text(
                      title,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: kTitleTextColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      desc,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        wordSpacing: 1,
                        color: kTitleTextColor.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
