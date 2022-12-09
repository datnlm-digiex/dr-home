import 'package:flutter_secure_storage/flutter_secure_storage.dart' as Storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/components/background.dart';
import 'package:telemedicine_mobile/Screens/login_form_screen.dart';
import 'package:telemedicine_mobile/Screens/register_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/account_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final accountController = Get.put(AccountController());
  final storage = new Storage.FlutterSecureStorage();

  @override
  void initState() {
    clearStorage();
    super.initState();
  }

  clearStorage() async {
    await storage.deleteAll();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Chào mừng đến với ứng dụng Dr.Home - Bác sĩ của mọi nhà",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.green),
                ),
                Image(
                    image: AssetImage("assets/images/login_doctor_image.png")),
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
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              backgroundColor: kBlueColor),
                          onPressed: () => Get.to(RegisterScreen()),
                          child: Text(
                            'Tạo tài khoản',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
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
                        borderRadius: BorderRadius.circular(30),
                        child: ElevatedButton(
                          onPressed: () => Get.to(LoginFormScreen()),
                          child: Text(
                            'Đăng nhập',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: kBlueColor),
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
          ],
        ),
      ),
    );
  }
}
