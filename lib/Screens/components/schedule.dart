import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/chatbot_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:flutter/material.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class ScheduleCard extends StatelessWidget {
  var _title;
  var _description;
  var _date;
  var _month;
  var _bgColor;
  var healthCheckID;
  var emailPatient;
  var slot;
  var bookAllow;

  ScheduleCard(
      this._title,
      this._description,
      this._date,
      this._month,
      this._bgColor,
      this.healthCheckID,
      this.emailPatient,
      this.slot,
      this.bookAllow);

  final patientProfileController = Get.put(PatientProfileController());
  final listDoctorController = Get.put(ListDoctorController());
  final accountController = Get.put(AccountController());

  void chatBot(BuildContext context) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            content: Text(
              'Để hoàn thành đăng ký. Bạn có đồng ý trả lời một số câu hỏi để cung cấp thông tin cho bác sĩ không?',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                  listDoctorController.slot.value = slot;
                  // Get.to(ChatBotScreen());
                },
                child: Text('Đồng ý'),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                child: Text('Từ chối'),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (bookAllow) {
          healthCheckID > 0 ? null : chatBot(context);
        }
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _bgColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Stack(
            children: [
              ListTile(
                leading: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: _bgColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        _date,
                        style: TextStyle(
                          color: _bgColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _month,
                        style: TextStyle(
                          color: _bgColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                title: Text(
                  _title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: kTitleTextColor,
                  ),
                ),
                subtitle: bookAllow
                    ? Text(_description)
                    : RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: _description + '\n',
                              style: TextStyle(
                                color: kTitleTextColor.withOpacity(0.7),
                              ),
                            ),
                            TextSpan(
                                text: healthCheckID < 1
                                    ? "Buổi tư vấn sẵn sàng"
                                    : emailPatient ==
                                            accountController
                                                .account.value.email
                                        ? "Bạn đã đăng ký buổi này"
                                        : "Đã có người đăng ký",
                                style: TextStyle(
                                    color: healthCheckID < 1
                                        ? Colors.green
                                        : emailPatient ==
                                                accountController
                                                    .account.value.email
                                            ? Colors.blue
                                            : Colors.red)),
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
}
