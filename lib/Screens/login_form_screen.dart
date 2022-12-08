import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/register_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:provider/provider.dart';
import '../controller/google_login_controller.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'bottom_nav_screen.dart';
import 'form_after_login_screen.dart';

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({Key? key}) : super(key: key);

  @override
  _LoginFormScreenState createState() => _LoginFormScreenState();
}

class _LoginFormScreenState extends State<LoginFormScreen> {
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  bool emptyPassword = false;
  bool phone = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: SingleChildScrollView(
                  child: Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Chào mừng bạn quay trở lại",
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Đăng nhập",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Số điện thoại của bạn?",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextField(
                                controller: textPhoneController,
                                decoration: InputDecoration(
                                  hintText: "Số điện thoại",
                                  border: OutlineInputBorder(),
                                  errorText: phone
                                      ? "Vui lòng nhập số điện thoại"
                                      : null,
                                  errorStyle: TextStyle(fontSize: 14),
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mật khẩu của bạn?",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextField(
                                obscureText: true,
                                controller: textPasswordController,
                                decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  errorText: emptyPassword
                                      ? "Vui lòng nhập mật khẩu (Sử dụng 8 kí tự trở lên)"
                                      : null,
                                  errorStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ],
                          ),
                          Text(
                            "Sử dụng 8 kí tự trở lên",
                            style:
                                TextStyle(fontSize: 14, color: Colors.black54),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.9,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(29),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 18, horizontal: 20),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                        backgroundColor: kBlueColor),
                                    onPressed: () async {
                                      setState(() {
                                        textPasswordController.text == ''
                                            ? emptyPassword = true
                                            : emptyPassword = false;
                                        textPhoneController.text == ''
                                            ? phone = true
                                            : phone = false;
                                      });

                                      if (!emptyPassword && !phone) {
                                        String checkLogin = await Provider.of<
                                                    GoogleSignInController>(
                                                context,
                                                listen: false)
                                            .login(textPhoneController.text,
                                                textPasswordController.text);
                                        if (checkLogin ==
                                            "LoginType is incorrect!") {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Tài khoản đã được dùng trong hệ thống với vai trò khác",
                                              fontSize: 18);
                                        } else if (checkLogin ==
                                            "Account is ban!") {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Tài khoản của bạn đã bị khóa",
                                              fontSize: 18);
                                        } else if (checkLogin ==
                                            "Login Success") {
                                          // patientHistoryController.getTopDoctor();
                                          Get.off(checkLoginGoogle(context));
                                          // } else if (checkLogin ==
                                          //     "Create Account") {
                                          //   Navigator.push(
                                          //       context,
                                          //       MaterialPageRoute(
                                          //           builder: checkNewAccount));
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "Đăng nhập thất bại",
                                              fontSize: 18);
                                        }
                                      }
                                    },
                                    child: Text(
                                      "Đăng nhập",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
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
                                    borderRadius: BorderRadius.circular(29),
                                    child: TextButton(
                                        onPressed: () =>
                                            Get.to(RegisterScreen()),
                                        child: Text.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                  text:
                                                      'Bạn chưa có tài khoản ',
                                                  style: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16)),
                                              TextSpan(
                                                text: 'Đăng kí',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: kBlueColor,
                                                    fontSize: 16),
                                              ),
                                            ],
                                          ),
                                        ))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget checkLoginGoogle(BuildContext context) {
    return BottomNavScreen();
  }

  Widget checkNewAccount(BuildContext context) {
    return UserInformation();
  }
}
