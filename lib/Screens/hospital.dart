import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/hospital_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDoctorScreen extends StatefulWidget {
  // const ListDoctorScreen({Key? key}) : super(key: key);

  @override
  _ListDoctorScreenState createState() => _ListDoctorScreenState();
}

class _ListDoctorScreenState extends State<ListDoctorScreen> {
  final HospitalController hospitalController = Get.find<HospitalController>();
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  // FilterController filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    // filterController.majorID.value = 0;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: GetBuilder<HospitalController>(
          builder: (controller) => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 14),
                  child: Text(
                    'Bạn cần được tư vấn ngay lập tức bởi chuyên gia',
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.black),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 14),
                  child: Text(
                    'Vui lòng liên hệ thông tin dưới đây để được hỗ trợ thêm',
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/need_support.png",
                    height: MediaQuery.of(context).size.height / 3,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.redAccent),
                          onPressed: () => _makePhoneCall(
                              controller.hospital.phone == null
                                  ? '0869055115'
                                  : controller.hospital.phone!),
                          icon: Icon(Icons.phone),
                          label: Text(
                            'Gọi bác sĩ',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(29),
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.sms),
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 18, horizontal: 20),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: Colors.amber),
                          onPressed: () => _makeSms(
                              controller.hospital.phone == null
                                  ? '0869055115'
                                  : controller.hospital.phone!),
                          label: Text(
                            'Nhắn tin',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton.icon(
                          onPressed: () => _makeEmailLaunch(
                              controller.hospital.email == null
                                  ? 'yhph.bvphcn@gmail.com'
                                  : controller.hospital.email!),
                          icon: Icon(
                            Icons.email_outlined,
                          ),
                          label: Text(
                            '${hospitalController.hospital.email == null ? 'yhph.bvphcn@gmail.com' : hospitalController.hospital.email}',
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: StadiumBorder(),
                            padding: const EdgeInsets.symmetric(
                                vertical: 18, horizontal: 20),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            backgroundColor: Color.fromARGB(255, 80, 80, 79),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
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

Future<void> _makeEmailLaunch(String email) async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: email,
  );
  await launchUrl(emailLaunchUri);
}
