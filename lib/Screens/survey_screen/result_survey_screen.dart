import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/hospital_controller.dart';
import 'package:telemedicine_mobile/models/SurveyRespone.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';

class ResultSurveyScreen extends StatelessWidget {
  final SurveyResponse surveyRespone;

  ResultSurveyScreen({Key? key, required this.surveyRespone}) : super(key: key);

  final HospitalController hospitalController = Get.find<HospitalController>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kBlueColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.offAll(BottomNavScreen()),
          ),
          centerTitle: true,
          title: Text("Kết quả: ${surveyRespone.surveyTitle}"),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: GetBuilder<HospitalController>(
            builder: (controller) => Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Colors.green),
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              width: width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${surveyRespone.resulttext}',
                    textAlign: TextAlign.center,
                    // overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: surveyRespone.rate > 0
                            ? Colors.black
                            : Colors.green),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'Hy vọng bạn có sức khỏe tốt để vững bước tới thành công.',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(
                      '${surveyRespone.resultimage}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Vui lòng liên hệ các thông tin dưới đây để được hỗ trợ thêm.',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Center(
                      child: Image.asset(
                        "assets/images/hospital_icon.png",
                        height: 100,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    child: Text(
                      controller.hospital.name == null
                          ? 'BỆNH VIỆN PHỤC HỒI CHỨC NĂNG - ĐIỀU TRỊ BỆNH NGHỀ NGHIỆP'
                          : controller.hospital.name!,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade600),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1, vertical: 10),
                    child: Text(
                      'HCMC HOSPITAL FOR REHABILITATION - PROFESSIONAL DISEASES',
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.red.shade900),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      controller.hospital.address == null
                          ? '313 Âu Dương Lân, phường 2, quận 8, TP.HCM'
                          : controller.hospital.address!,
                      textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(29),
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: kBlueColor),
                            onPressed: () => _makePhoneCall(
                                controller.hospital.phone == null
                                    ? '0869055115'
                                    : controller.hospital.phone!),
                            icon: Icon(Icons.phone),
                            label: Text(
                              'Bấm gọi ngay',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(children: <Widget>[
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 10.0, right: 20.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                    Text("hoặc"),
                    Expanded(
                      child: new Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 10.0),
                          child: Divider(
                            color: Colors.black,
                            height: 36,
                          )),
                    ),
                  ]),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.email_outlined,
                              color: kBlueColor,
                            ),
                            onPressed: () => _makeEmailLaunch(
                                controller.hospital.email == null
                                    ? 'yhph.bvphcn@gmail.com'
                                    : controller.hospital.email!),
                            label: Text(
                              controller.hospital.email == null
                                  ? 'yhph.bvphcn@gmail.com'
                                  : controller.hospital.email!,
                              style: TextStyle(
                                  color: kBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: kBackgroundColor,
                                side: BorderSide(
                                  color: kBlueColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: ElevatedButton.icon(
                            icon: Icon(
                              Icons.map_outlined,
                              color: kBlueColor,
                            ),
                            onPressed: () => MapsLauncher.launchCoordinates(
                                controller.hospital.lat == null
                                    ? 10.74277
                                    : controller.hospital.lat!,
                                controller.hospital.long == null
                                    ? 106.68357
                                    : controller.hospital.long!),
                            label: Text(
                              'Chỉ đường tới bệnh viện',
                              style: TextStyle(
                                  color: kBlueColor,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 20),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                backgroundColor: kBackgroundColor,
                                side: BorderSide(
                                  color: kBlueColor,
                                )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _makeEmailLaunch(String email) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    await launchUrl(emailLaunchUri);
  }
}