import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/api/fetch_api.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/formafterlogin_controller.dart';

import 'form_after_login_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formAfterLoginController = Get.put(FormAfterLoginController());
  bool wrongPassword = false;
  bool emptyPassword = false;
  bool phone = false;
  bool result = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => SafeArea(
          child: formAfterLoginController.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Stack(
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
                                    "Xin chào...",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    "Đăng kí",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 40,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Số điện thoại của bạn?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextField(
                                        controller: formAfterLoginController
                                            .textPhoneController,
                                        decoration: InputDecoration(
                                          hintText: "Số điện thoại",
                                          border: OutlineInputBorder(),
                                          errorText: result
                                              ? "Số điện thoại đã được sử dụng"
                                              : phone
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Mật khẩu của bạn?",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        controller: formAfterLoginController
                                            .textPasswordController,
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
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Xác nhận mật khẩu của bạn",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      TextField(
                                        obscureText: true,
                                        controller: formAfterLoginController
                                            .textConfirmController,
                                        decoration: InputDecoration(
                                          hintText: "Mật khẩu",
                                          errorText: wrongPassword
                                              ? "Các mật khẩu đã nhập không khớp. Hãy thử lại."
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
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.black54),
                                  ),
                                  SizedBox(height: 20),
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(29),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 18,
                                                        horizontal: 20),
                                                tapTargetSize:
                                                    MaterialTapTargetSize
                                                        .shrinkWrap,
                                                backgroundColor: kBlueColor),
                                            onPressed: () => setState(() {
                                              if (formAfterLoginController
                                                          .textPasswordController
                                                          .text ==
                                                      '' ||
                                                  formAfterLoginController
                                                          .textPasswordController
                                                          .text
                                                          .length <
                                                      7) {
                                                emptyPassword = true;
                                              } else {
                                                emptyPassword = false;
                                              }

                                              if (formAfterLoginController
                                                      .textPasswordController
                                                      .text ==
                                                  formAfterLoginController
                                                      .textConfirmController
                                                      .text) {
                                                wrongPassword = false;
                                              } else {
                                                wrongPassword = true;
                                              }
                                              if (formAfterLoginController
                                                      .textPhoneController
                                                      .text ==
                                                  '') {
                                                phone = true;
                                              } else {
                                                phone = false;
                                                FetchAPI.checkPhone(
                                                        formAfterLoginController
                                                            .textPhoneController
                                                            .text)
                                                    .then((value) => setState(
                                                          () {
                                                            result = value;
                                                            if (!value &&
                                                                formAfterLoginController
                                                                        .textPhoneController
                                                                        .text !=
                                                                    '' &&
                                                                formAfterLoginController
                                                                        .textPasswordController
                                                                        .text !=
                                                                    '' &&
                                                                formAfterLoginController
                                                                        .textPasswordController
                                                                        .text ==
                                                                    formAfterLoginController
                                                                        .textConfirmController
                                                                        .text) {
                                                              Get.to(
                                                                  UserInformation());
                                                            }
                                                          },
                                                        ));
                                              }
                                            }),
                                            child: Text(
                                              "Đăng kí",
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(29),
                                            child: TextButton(
                                                onPressed: () =>
                                                    Get.to(LoginScreen()),
                                                child: Text.rich(
                                                  TextSpan(
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              'Bạn đã có tài khoản ',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontSize: 16)),
                                                      TextSpan(
                                                        text: 'Đăng nhập',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
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
      ),
    );
  }
}
