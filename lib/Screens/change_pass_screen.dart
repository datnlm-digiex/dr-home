import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/formafterlogin_controller.dart';

import 'form_after_login_screen.dart';
import 'login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textNewPasswordController = TextEditingController();
  TextEditingController textConfirmPasswordController = TextEditingController();

  bool wrongPassword = false;
  bool emptyPassword = false;
  bool oldPassword = false;
  bool newPassword = false;
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Đổi mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kBlueColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Mật khẩu hiện tại",
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
                                  hintText: "Mật khẩu hiện tại",
                                  border: OutlineInputBorder(),
                                  errorText: oldPassword
                                      ? "Vui lòng nhập số mật khẩu (Sử dụng 8 kí tự trở lên)"
                                      : null,
                                  errorStyle: TextStyle(fontSize: 14),
                                ),
                                keyboardType: TextInputType.name,
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
                                "Mật khẩu mới",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextField(
                                obscureText: true,
                                controller: textNewPasswordController,
                                decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  errorText: newPassword
                                      ? "Vui lòng nhập mật khẩu (Sử dụng 8 kí tự trở lên)"
                                      : null,
                                  errorStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.name,
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
                                "Xác nhận mật khẩu của bạn",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextField(
                                obscureText: true,
                                controller: textConfirmPasswordController,
                                decoration: InputDecoration(
                                  hintText: "Mật khẩu",
                                  errorText: wrongPassword
                                      ? "Các mật khẩu đã nhập không khớp. Hãy thử lại."
                                      : newPassword
                                          ? "Vui lòng nhập mật khẩu (Sử dụng 8 kí tự trở lên)"
                                          : null,
                                  errorStyle: TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.name,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
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
                                    onPressed: () => setState(() {
                                      textPasswordController.text == '' ||
                                              textPasswordController
                                                      .text.length <
                                                  7
                                          ? oldPassword = true
                                          : oldPassword = false;

                                      textNewPasswordController.text == '' ||
                                              textNewPasswordController
                                                      .text.length <
                                                  7
                                          ? newPassword = true
                                          : newPassword = false;
                                      if (!oldPassword &&
                                          !newPassword &&
                                          textNewPasswordController.text ==
                                              textConfirmPasswordController
                                                  .text) {
                                        FetchAPI.changePassowrd(
                                                textPasswordController.text,
                                                textNewPasswordController.text)
                                            .then((value) => {
                                                  Fluttertoast.showToast(
                                                      msg: value, fontSize: 18),
                                                  Get.back()
                                                });
                                      } else {
                                        wrongPassword = true;
                                      }
                                    }),
                                    child: Text(
                                      "Xác nhận",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
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
}
