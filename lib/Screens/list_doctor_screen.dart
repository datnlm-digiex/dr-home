import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/Screens/components/doctor.dart';
import 'package:telemedicine_mobile/Screens/filter_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/models/Doctor.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDoctorScreen extends StatefulWidget {
  // const ListDoctorScreen({Key? key}) : super(key: key);

  @override
  _ListDoctorScreenState createState() => _ListDoctorScreenState();
}

class _ListDoctorScreenState extends State<ListDoctorScreen> {
  final listDoctorController = Get.put(ListDoctorController());
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  // FilterController filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    // filterController.majorID.value = 0;
  }

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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Column(children: [
          Container(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              // padding: EdgeInsets.only(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(
                          left: 10.0, right: 10.0, top: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        // border: Border.all(color: Colors.green),
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                      height: height * 0.50,
                      width: width,
                      // height: 400,
                      // width: 400,
                      child: (SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: (Column(
                          children: [
                            Container(
                              // height: 600,
                              width: width,
                              // color: Color.fromARGB(255, 235, 225, 225),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                // ignore: prefer_const_literals_to_create_immutables
                                children: [
                                  SizedBox(height: 30),
                                  Text(
                                    'Bạn cần được tư vấn ngay lập tức bởi chuyên gia',
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black),
                                  ),
                                  SizedBox(height: 22),
                                  Text(
                                    'Vui lòng liên hệ thông tin dưới đây để được hỗ trợ thêm',
                                    textAlign: TextAlign.center,
                                    // overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Image.asset("assets/images/need_support.png")
                                ],
                              ),
                            ),
                          ],
                        )),
                      ))),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.redAccent),
                          onPressed: () => _makePhoneCall('02838569147'),
                          child: Text(
                            'Gọi bác sĩ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.amber),
                          onPressed: () => _makeSms('02838569147'),
                          child: Text(
                            'Nhắn tin',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Color.fromARGB(255, 80, 80, 79)),
                          onPressed: () => _makeEmailLaunch(),
                          child: Text(
                            'Gửi Email',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]));
    ;
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeSms(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }
}

Future<void> _makeEmailLaunch() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'yhph.bvphcn@gmail.com',
  );
  await launchUrl(emailLaunchUri);
}
