import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:telemedicine_mobile/Screens/bottom_nav_screen.dart';
import 'package:telemedicine_mobile/Screens/form_after_login_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/google_login_controller.dart';
import 'package:telemedicine_mobile/controller/patient_history_controller.dart';

//button login with google

class GoogleButton extends StatelessWidget {
  GoogleButton({
    Key? key,
  }) : super(key: key);
  final patientHistoryController = Get.put(PatientHistoryController());
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          shape: StadiumBorder(),
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 40),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: kBackgroundColor,
        ),
        onPressed: () async {
          String checkLogin =
              await Provider.of<GoogleSignInController>(context, listen: false)
                  .googleLogin();
          if (checkLogin == "LoginType is incorrect!") {
            Fluttertoast.showToast(
                msg: "Tài khoản đã được dùng trong hệ thống với vai trò khác",
                fontSize: 18);
          } else if (checkLogin == "Account is ban!") {
            Fluttertoast.showToast(
                msg: "Tài khoản của bạn đã bị khóa", fontSize: 18);
          } else if (checkLogin == "Login Success") {
            // patientHistoryController.getTopDoctor();
            Get.off(checkLoginGoogle(context));
          } else if (checkLogin == "Create Account") {
            Navigator.push(
                context, MaterialPageRoute(builder: checkNewAccount));
          } else {
            Fluttertoast.showToast(msg: "Đăng nhập thất bại", fontSize: 18);
          }
        },
        icon: new Image.asset("assets/images/google.png"),
        label: Text(
          "Đăng nhập với Google",
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }

  Widget checkLoginGoogle(BuildContext context) {
    return BottomNavScreen();
  }

  Widget checkNewAccount(BuildContext context) {
    return UserInformation();
  }
}
