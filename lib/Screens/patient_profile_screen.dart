import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/edit_healthcheck_info_screen.dart';
import 'package:telemedicine_mobile/Screens/edit_patient_profile_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class PatientProfile extends StatefulWidget {
  const PatientProfile({Key? key}) : super(key: key);

  @override
  _PatientProfileState createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  Widget textfield({@required hintText, @required icon, onTap}) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0),
        child: TextField(
          readOnly: true,
          onTap: onTap,
          decoration: InputDecoration(
              hintText: hintText,
              icon: Icon(
                icon,
                color: Colors.black,
              ),
              hintStyle: TextStyle(
                letterSpacing: 2,
                color: Colors.black54,
                fontWeight: FontWeight.bold,
              ),
              fillColor: Colors.white30,
              filled: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none)),
        ),
      ),
    );
  }

  final patientProfileController = Get.put(PatientProfileController());
  final bottomNavbarController = Get.put(BottomNavbarController());

  @override
  void initState() {
    super.initState();
    patientProfileController.getMyPatient();
    patientProfileController.getMyAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   elevation: 8,
      //   title: Text("Thông tin của tôi"),
      //   centerTitle: true,
      //   backgroundColor: kBlueColor,
      //   automaticallyImplyLeading: false,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(10.0),
                      width: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 5),
                        shape: BoxShape.circle,
                        color: kBackgroundColor,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(patientProfileController
                                      .account.value.avatar ==
                                  ""
                              ? 'https://t3.ftcdn.net/jpg/03/46/83/96/360_F_346839683_6nAPzbhpSkIpb8pmAwufkC7c5eD7wYws.jpg'
                              : patientProfileController.account.value.avatar),
                        ),
                      ),
                    ),
                    Text(
                      patientProfileController.account.value.firstName +
                          " " +
                          patientProfileController.account.value.lastName,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 22,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 0, 14, 0),
                                  child: Icon(
                                    Icons.person,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "Tài khoản của tôi",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                RawMaterialButton(
                                  onPressed: () => {
                                    patientProfileController.getMyAccount(),
                                    Get.to(() => EditPatientProfile(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 600))
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textfield(
                            hintText:
                                patientProfileController.patient.value.email,
                            icon: Icons.email_outlined,
                          ),
                          textfield(
                            hintText: patientProfileController.dob.value,
                            icon: Icons.date_range,
                          ),
                          textfield(
                            hintText:
                                patientProfileController.account.value.phone,
                            icon: Icons.phone,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(14, 0, 14, 0),
                                  child: Icon(
                                    Icons.person,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "Thông tin sức khỏe",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Expanded(child: Container()),
                                RawMaterialButton(
                                  onPressed: () => {
                                    Get.to(() => EditHealthCheckInfoScreen(),
                                        transition:
                                            Transition.rightToLeftWithFade,
                                        duration: Duration(milliseconds: 600))
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textfield(
                            hintText: patientProfileController
                                            .patient.value.allergy ==
                                        null ||
                                    patientProfileController
                                        .patient.value.allergy.isEmpty
                                ? "Không bị dị ứng"
                                : patientProfileController
                                    .patient.value.allergy,
                            icon: Icons.api,
                          ),
                          textfield(
                            hintText: patientProfileController
                                            .patient.value.bloodGroup ==
                                        null ||
                                    patientProfileController
                                        .patient.value.bloodGroup.isEmpty
                                ? "Chưa xác định"
                                : patientProfileController
                                    .patient.value.bloodGroup,
                            icon: Icons.bloodtype_outlined,
                          ),
                          textfield(
                            hintText: patientProfileController
                                            .patient.value.backgroundDisease ==
                                        null ||
                                    patientProfileController
                                        .patient.value.backgroundDisease.isEmpty
                                ? "Không có bệnh nền"
                                : patientProfileController
                                    .patient.value.backgroundDisease,
                            icon: Icons.ac_unit_outlined,
                          ),
                          Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: kBlueColor,
                              //Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Icon(
                                    Icons.contact_support,
                                    color: kWhiteColor,
                                  ),
                                ),
                                Text(
                                  "Chung",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: kWhiteColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          textfield(
                            hintText: 'Đăng xuất',
                            icon: Icons.logout,
                            onTap: () => showConfirmAlertDialog(context),
                            // {

                            // patientProfileController.logout(),
                            // },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  showConfirmAlertDialog(BuildContext context) {
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return Dialog(
          elevation: 0,
          backgroundColor: const Color(0xffffffff),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 15),
              Text(
                "Đăng xuất",
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Text("Bạn có muốn đăng xuất"),
              const SizedBox(height: 20),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  highlightColor: Colors.grey[200],
                  onTap: () => {
                    Navigator.pop(contextDialog),
                    patientProfileController.logout()
                  },
                  child: Center(
                    child: Text(
                      'Xác nhận',
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: InkWell(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(15.0),
                    bottomRight: Radius.circular(15.0),
                  ),
                  highlightColor: Colors.grey[200],
                  onTap: () => Navigator.pop(contextDialog),
                  child: Center(
                    child: Text(
                      "Huỷ",
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
