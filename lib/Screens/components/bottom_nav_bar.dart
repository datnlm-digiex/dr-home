import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telemedicine_mobile/Screens/home_screen.dart';
import 'package:telemedicine_mobile/Screens/hospital.dart';
import 'package:telemedicine_mobile/Screens/patient_history_screen.dart';
import 'package:telemedicine_mobile/Screens/patient_profile_screen.dart';
import 'package:telemedicine_mobile/constant.dart';
import 'package:telemedicine_mobile/controller/bottom_navbar_controller.dart';
import 'package:telemedicine_mobile/controller/filter_controller.dart';
import 'package:telemedicine_mobile/controller/list_doctor_controller.dart';
import 'package:telemedicine_mobile/controller/patient_profile_controller.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final patientProfileController = Get.put(PatientProfileController());
  final listDoctorController = Get.put(ListDoctorController());
  final bottomNavbarController = Get.put(BottomNavbarController());
  // final filterController = Get.put(FilterController());

  @override
  void initState() {
    super.initState();
    patientProfileController.getMyPatient();
  }

  final screenLabel = ["Trang chủ", "Tư vấn", "Lịch sử", "Thông tin của tôi"];

  final screens = [
    HomeScreen(),
    ListDoctorScreen(),
    // PatientHistoryScreen(),
    PatientProfile(),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Obx(() => Text(
              "${screenLabel[bottomNavbarController.currentIndex.value]}")),
          automaticallyImplyLeading: false,
          centerTitle: false,
          backgroundColor: kBlueColor,

          // actions: [notification()],
        ),
        body: Obx(() => SafeArea(
            child: screens[bottomNavbarController.currentIndex.value])),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: kBackgroundColor,
            selectedItemColor: kBlueColor,
            // showUnselectedLabels: false,
            iconSize: 25,
            selectedFontSize: 14,
            currentIndex: bottomNavbarController.currentIndex.value,
            onTap: (index) => {
              bottomNavbarController.currentIndex.value = index,
              // patientProfileController.getNearestHealthCheck(),
              if (index == 1)
                {
                  // filterController.getListMajor(),
                  listDoctorController.condition.value = "",
                },
              if (bottomNavbarController.currentIndex.value == 3)
                {
                  patientProfileController.getMyPatient(),
                  patientProfileController.getMyAccount(),
                }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Trang chủ",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_hospital),
                label: "Tư vấn",
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.history),
              //   label: "Lịch sử",
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Cá nhân",
              ),
            ],
          ),
        ),
      );
}
