import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/models/SurveyRespone.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultSurveyScreen extends StatelessWidget {
  final SurveyResponse surveyRespone;

  const ResultSurveyScreen({Key? key, required this.surveyRespone})
      : super(key: key);

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
            onPressed: () => Get.off(BottomNavScreen()),
          ),
          centerTitle: true,
          title: Text("Kết quả: ${surveyRespone.surveyTitle}"),
        ),
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding: const EdgeInsets.all(20),
                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 20),
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
                          width: width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 52),
                              Text(
                                '${surveyRespone.resulttext}',
                                textAlign: TextAlign.center,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                    color: Colors.green),
                              ),
                              SizedBox(height: 22),
                              Text(
                                'Hy vọng bạn có sức khỏe tốt để vững bước tới thành công.',
                                textAlign: TextAlign.center,
                                // overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Image.network(
                                '${surveyRespone.resultimage}',
                                fit: BoxFit.cover,
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
                  ))),
              Center(
                child: Image.asset(
                  "assets/images/hospital_icon.png",
                  height: 100,
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
                        onPressed: () {
                          Get.off(BottomNavScreen());
                        },
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
                      margin: const EdgeInsets.only(left: 10.0, right: 20.0),
                      child: Divider(
                        color: Colors.black,
                        height: 36,
                      )),
                ),
                Text("hoặc"),
                Expanded(
                  child: new Container(
                      margin: const EdgeInsets.only(left: 20.0, right: 10.0),
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
                      child: ElevatedButton(
                        onPressed: () => _makeEmailLaunch(),
                        child: Text(
                          'yhph.bvphcn@gmail.com',
                          style: TextStyle(color: kBlueColor),
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
        ));
    ;
  }

  Future<void> _makeEmailLaunch() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'yhph.bvphcn@gmail.com',
    );
    await launchUrl(emailLaunchUri);
  }
}
