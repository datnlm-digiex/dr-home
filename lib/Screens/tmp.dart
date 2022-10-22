 // home screeen
 // SafeArea(
        //   bottom: false,
        //   child: SingleChildScrollView(
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: <Widget>[
        //         SizedBox(
        //           height: 20,
        //         ),
        //         welcome(),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Text(
        //             patientProfileController.patient.value.name,
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               fontSize: 24,
        //               color: kTitleTextColor,
        //             ),
        //           ),
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: DiscoverCard(
        //             tag: "",
        //             onTap: () {},
        //             title: "TIẾN ĐỘ TẬP LUYỆN",
        //             subtitle: "1/23 Bài tập",
        //           ),
        //         ),
        //         search(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         buildCategoryList(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Row(
        //             children: [
        //               Text(
        //                 'Bài tập',
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: kTitleTextColor,
        //                   fontSize: 18,
        //                 ),
        //               ),
        //               Expanded(child: Container()),
        //               InkWell(
        //                 onTap: () => Get.to(VideoPlayerScreen()),
        //                 child: Text(
        //                   'Xem tất cả',
        //                   style: TextStyle(
        //                     color: kBlueColor,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Row(
        //             children: [
        //               Text(
        //                 'Cuộc hẹn sắp tới',
        //                 style: TextStyle(
        //                   fontWeight: FontWeight.bold,
        //                   color: kTitleTextColor,
        //                   fontSize: 18,
        //                 ),
        //               ),
        //               Expanded(child: Container()),
        //               InkWell(
        //                 onTap: () =>
        //                     {bottomNavbarController.currentIndex.value = 2},
        //                 child: Text(
        //                   'Xem tất cả',
        //                   style: TextStyle(
        //                     color: kBlueColor,
        //                     fontSize: 16,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         patientProfileController.nearestHealthCheck.value.id == 0
        //             ? Center(
        //                 child: Text(
        //                 "Bạn chưa có lịch hẹn",
        //                 style: TextStyle(
        //                     fontSize: 18, fontWeight: FontWeight.w300),
        //               ))
        //             : Padding(
        //                 padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        //                 child: InkWell(
        //                   onTap: () => {
        //                     patientHistoryController.index.value = 0,
        //                     Get.to(() => PatientDetailHistoryScreen(),
        //                         transition: Transition.rightToLeftWithFade,
        //                         duration: Duration(microseconds: 600)),
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(15),
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(20),
        //                       color: kBlueColor,
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Container(
        //                           width: 60,
        //                           height: 60,
        //                           decoration: BoxDecoration(
        //                             shape: BoxShape.circle,
        //                           ),
        //                           child: Image.network(
        //                             patientProfileController
        //                                 .nearestHealthCheck
        //                                 .value
        //                                 .slots[0]
        //                                 .doctor
        //                                 .avatar,
        //                             errorBuilder: (context, error,
        //                                     stackTrace) =>
        //                                 Image.asset(
        //                                     "assets/images/default_avatar.png"),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(left: 80),
        //                           child: Text(
        //                             "Bs. " +
        //                                 patientProfileController
        //                                     .nearestHealthCheck
        //                                     .value
        //                                     .slots[0]
        //                                     .doctor
        //                                     .name,
        //                             style: TextStyle(
        //                                 color: Colors.white,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(80, 30, 0, 0),
        //                           child: Text(
        //                             "Chuyên khoa",
        //                             style: TextStyle(
        //                                 color: Colors.grey[300],
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w400),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(250, 0, 0, 0),
        //                           child: InkWell(
        //                             onTap: () => {
        //                               listDoctorController
        //                                   .getTokenHealthCheck(
        //                                       patientProfileController
        //                                           .nearestHealthCheck
        //                                           .value
        //                                           .id),
        //                               if (DateTime.now().compareTo(DateTime
        //                                       .parse(DateFormat("yyyy-MM-dd")
        //                                               .format(DateTime.parse(
        //                                                   patientProfileController
        //                                                       .nearestHealthCheck
        //                                                       .value
        //                                                       .slots[0]
        //                                                       .assignedDate)) +
        //                                           " " +
        //                                           patientProfileController
        //                                               .nearestHealthCheck
        //                                               .value
        //                                               .slots[0]
        //                                               .startTime)) ==
        //                                   1)
        //                                 {
        //                                   // listDoctorController
        //                                   //     .getTokenHealthCheck(
        //                                   //         patientProfileController
        //                                   //             .nearestHealthCheck
        //                                   //             .value
        //                                   //             .id),
        //                                 }
        //                               else
        //                                 {
        //                                   // showDialog(
        //                                   //     context: context,
        //                                   //     builder: (context) {
        //                                   //       return AlertDialog(
        //                                   //         title: Text("Thông báo"),
        //                                   //         content: Text(
        //                                   //             "Chưa tới giờ tư vấn"),
        //                                   //         actions: [
        //                                   //           OutlinedButton(
        //                                   //             onPressed: () =>
        //                                   //                 Navigator.of(
        //                                   //                         context)
        //                                   //                     .pop(),
        //                                   //             child: Text("Đóng"),
        //                                   //           )
        //                                   //         ],
        //                                   //       );
        //                                   //     })
        //                                 }
        //                             },
        //                             child: Icon(
        //                               Icons.phone,
        //                               size: 40,
        //                               color: Colors.greenAccent,
        //                             ),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(top: 80),
        //                           child: Container(
        //                             width: double.infinity,
        //                             height: 60,
        //                             padding: EdgeInsets.all(20),
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(20),
        //                               color: Color(0xff85a7fa),
        //                             ),
        //                             child: Row(
        //                               children: [
        //                                 Icon(
        //                                   Icons.date_range,
        //                                   color: Colors.white,
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       const EdgeInsets.only(top: 5.0),
        //                                   child: Text(
        //                                     DateFormat.E(Locale("vi", "VN").languageCode).format(
        //                                             DateTime.parse(patientProfileController
        //                                                 .nearestHealthCheck
        //                                                 .value
        //                                                 .slots[0]
        //                                                 .assignedDate)) +
        //                                         ", " +
        //                                         DateFormat('dd').format(DateTime.parse(
        //                                             patientProfileController
        //                                                 .nearestHealthCheck
        //                                                 .value
        //                                                 .slots[0]
        //                                                 .assignedDate)) +
        //                                         " tháng" +
        //                                         DateFormat('MM').format(DateTime.parse(
        //                                             patientProfileController
        //                                                 .nearestHealthCheck
        //                                                 .value
        //                                                 .slots[0]
        //                                                 .assignedDate)),
        //                                     style: TextStyle(
        //                                       color: Colors.white,
        //                                       fontSize: 14,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),
        //                                   ),
        //                                 ),
        //                                 Expanded(child: Container()),
        //                                 Icon(
        //                                   Icons.watch_later_outlined,
        //                                   color: Colors.white,
        //                                 ),
        //                                 Padding(
        //                                   padding:
        //                                       const EdgeInsets.only(top: 5.0),
        //                                   child: Text(
        //                                     patientProfileController
        //                                             .nearestHealthCheck
        //                                             .value
        //                                             .slots[0]
        //                                             .startTime
        //                                             .toString()
        //                                             .replaceRange(5, 8, "") +
        //                                         " - " +
        //                                         patientProfileController
        //                                             .nearestHealthCheck
        //                                             .value
        //                                             .slots[0]
        //                                             .endTime
        //                                             .toString()
        //                                             .replaceRange(5, 8, ""),
        //                                     style: TextStyle(
        //                                       color: Colors.white,
        //                                       fontSize: 14,
        //                                       fontWeight: FontWeight.bold,
        //                                     ),
        //                                   ),
        //                                 ),
        //                               ],
        //                             ),
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Text(
        //             'Bác sĩ hàng đầu',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: kTitleTextColor,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         patientHistoryController.listTopDoctor.length > 0
        //             ? Padding(
        //                 padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        //                 child: InkWell(
        //                   onTap: () => {
        //                     listDoctorController.getListDoctorSlot(
        //                         patientHistoryController.listTopDoctor[0].id),
        //                     patientProfileController.getMyPatient(),
        //                     Get.to(DetailScreen(
        //                       patientHistoryController.listTopDoctor[0].name,
        //                       patientHistoryController
        //                           .listTopDoctor[0].scopeOfPractice,
        //                       patientHistoryController
        //                           .listTopDoctor[0].description,
        //                       patientHistoryController
        //                           .listTopDoctor[0].avatar,
        //                       patientHistoryController
        //                           .listTopDoctor[0].majorDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[0].hospitalDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[0].certificationDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[0].rating,
        //                       patientHistoryController
        //                           .listTopDoctor[0].numberOfConsultants,
        //                       patientHistoryController
        //                           .listTopDoctor[0].dateOfCertificate,
        //                     )),
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(15),
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(8),
        //                       color: kWhiteColor,
        //                       boxShadow: [
        //                         BoxShadow(
        //                             blurRadius: 7,
        //                             spreadRadius: 5,
        //                             color: Colors.grey.withOpacity(0.5),
        //                             offset: Offset(7, 8)),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Container(
        //                           width: 80,
        //                           height: 90,
        //                           child: Image.network(
        //                             patientHistoryController
        //                                 .listTopDoctor[0].avatar,
        //                             errorBuilder: (context, error,
        //                                     stackTrace) =>
        //                                 Image.asset(
        //                                     "assets/images/default_avatar.png"),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(left: 90),
        //                           child: Text(
        //                             "Bs. " +
        //                                 patientHistoryController
        //                                     .listTopDoctor[0].name,
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 30, 0, 0),
        //                           child: Text(
        //                             patientHistoryController.listTopDoctor[0]
        //                                         .majorDoctors.length >
        //                                     0
        //                                 ? patientHistoryController
        //                                     .listTopDoctor[0]
        //                                     .majorDoctors[0]
        //                                     .major
        //                                     .name
        //                                 : "",
        //                             maxLines: 1,
        //                             softWrap: true,
        //                             overflow: TextOverflow.ellipsis,
        //                             style: TextStyle(
        //                                 color: Colors.grey.withOpacity(0.75),
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w400),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 60, 0, 0),
        //                           child: Row(
        //                             children: [
        //                               Icon(
        //                                 Icons.star,
        //                                 color: Colors.amber,
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     5, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                       .listTopDoctor[0].rating
        //                                       .toString(),
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     10, 0, 10, 0),
        //                                 child: Text(
        //                                   ".",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 20,
        //                                       fontWeight: FontWeight.bold),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     0, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                           .listTopDoctor[0]
        //                                           .numberOfConsultants
        //                                           .toString() +
        //                                       " đánh giá",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             : Container(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         patientHistoryController.listTopDoctor.length > 1
        //             ? Padding(
        //                 padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        //                 child: InkWell(
        //                   onTap: () => {
        //                     listDoctorController.getListDoctorSlot(
        //                         patientHistoryController.listTopDoctor[1].id),
        //                     patientProfileController.getMyPatient(),
        //                     Get.to(DetailScreen(
        //                       patientHistoryController.listTopDoctor[1].name,
        //                       patientHistoryController
        //                           .listTopDoctor[1].scopeOfPractice,
        //                       patientHistoryController
        //                           .listTopDoctor[1].description,
        //                       patientHistoryController
        //                           .listTopDoctor[1].avatar,
        //                       patientHistoryController
        //                           .listTopDoctor[1].majorDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[1].hospitalDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[1].certificationDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[1].rating,
        //                       patientHistoryController
        //                           .listTopDoctor[1].numberOfConsultants,
        //                       patientHistoryController
        //                           .listTopDoctor[1].dateOfCertificate,
        //                     )),
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(15),
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(8),
        //                       color: kWhiteColor,
        //                       boxShadow: [
        //                         BoxShadow(
        //                             blurRadius: 7,
        //                             spreadRadius: 5,
        //                             color: Colors.grey.withOpacity(0.5),
        //                             offset: Offset(7, 8)),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Container(
        //                           width: 80,
        //                           height: 90,
        //                           child: Image.network(
        //                             patientHistoryController
        //                                 .listTopDoctor[1].avatar,
        //                             errorBuilder: (context, error,
        //                                     stackTrace) =>
        //                                 Image.asset(
        //                                     "assets/images/default_avatar.png"),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(left: 90),
        //                           child: Text(
        //                             "Bs. " +
        //                                 patientHistoryController
        //                                     .listTopDoctor[1].name,
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 30, 0, 0),
        //                           child: Text(
        //                             patientHistoryController.listTopDoctor[1]
        //                                         .majorDoctors.length >
        //                                     0
        //                                 ? patientHistoryController
        //                                     .listTopDoctor[1]
        //                                     .majorDoctors[0]
        //                                     .major
        //                                     .name
        //                                 : "",
        //                             maxLines: 1,
        //                             softWrap: true,
        //                             overflow: TextOverflow.ellipsis,
        //                             style: TextStyle(
        //                                 color: Colors.grey.withOpacity(0.75),
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w400),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 60, 0, 0),
        //                           child: Row(
        //                             children: [
        //                               Icon(
        //                                 Icons.star,
        //                                 color: Colors.amber,
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     5, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                       .listTopDoctor[1].rating
        //                                       .toString(),
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     10, 0, 10, 0),
        //                                 child: Text(
        //                                   ".",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 20,
        //                                       fontWeight: FontWeight.bold),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     0, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                           .listTopDoctor[1]
        //                                           .numberOfConsultants
        //                                           .toString() +
        //                                       " đánh giá",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             : Container(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         patientHistoryController.listTopDoctor.length > 2
        //             ? Padding(
        //                 padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        //                 child: InkWell(
        //                   onTap: () => {
        //                     listDoctorController.getListDoctorSlot(
        //                         patientHistoryController.listTopDoctor[2].id),
        //                     patientProfileController.getMyPatient(),
        //                     Get.to(DetailScreen(
        //                       patientHistoryController.listTopDoctor[2].name,
        //                       patientHistoryController
        //                           .listTopDoctor[2].scopeOfPractice,
        //                       patientHistoryController
        //                           .listTopDoctor[2].description,
        //                       patientHistoryController
        //                           .listTopDoctor[2].avatar,
        //                       patientHistoryController
        //                           .listTopDoctor[2].majorDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[2].hospitalDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[2].certificationDoctors,
        //                       patientHistoryController
        //                           .listTopDoctor[2].rating,
        //                       patientHistoryController
        //                           .listTopDoctor[2].numberOfConsultants,
        //                       patientHistoryController
        //                           .listTopDoctor[2].dateOfCertificate,
        //                     )),
        //                   },
        //                   child: Container(
        //                     padding: EdgeInsets.all(15),
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                       borderRadius: BorderRadius.circular(8),
        //                       color: kWhiteColor,
        //                       boxShadow: [
        //                         BoxShadow(
        //                             blurRadius: 7,
        //                             spreadRadius: 5,
        //                             color: Colors.grey.withOpacity(0.5),
        //                             offset: Offset(7, 8)),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Container(
        //                           width: 80,
        //                           height: 90,
        //                           child: Image.network(
        //                             patientHistoryController
        //                                 .listTopDoctor[2].avatar,
        //                             errorBuilder: (context, error,
        //                                     stackTrace) =>
        //                                 Image.asset(
        //                                     "assets/images/default_avatar.png"),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.only(left: 90),
        //                           child: Text(
        //                             "Bs. " +
        //                                 patientHistoryController
        //                                     .listTopDoctor[2].name,
        //                             style: TextStyle(
        //                                 color: Colors.black,
        //                                 fontSize: 18,
        //                                 fontWeight: FontWeight.w500),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 30, 0, 0),
        //                           child: Text(
        //                             patientHistoryController.listTopDoctor[2]
        //                                         .majorDoctors.length >
        //                                     0
        //                                 ? patientHistoryController
        //                                     .listTopDoctor[2]
        //                                     .majorDoctors[0]
        //                                     .major
        //                                     .name
        //                                 : "",
        //                             maxLines: 1,
        //                             softWrap: true,
        //                             overflow: TextOverflow.ellipsis,
        //                             style: TextStyle(
        //                                 color: Colors.grey.withOpacity(0.75),
        //                                 fontSize: 16,
        //                                 fontWeight: FontWeight.w400),
        //                           ),
        //                         ),
        //                         Padding(
        //                           padding:
        //                               const EdgeInsets.fromLTRB(90, 60, 0, 0),
        //                           child: Row(
        //                             children: [
        //                               Icon(
        //                                 Icons.star,
        //                                 color: Colors.amber,
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     5, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                       .listTopDoctor[2].rating
        //                                       .toString(),
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     10, 0, 10, 0),
        //                                 child: Text(
        //                                   ".",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 20,
        //                                       fontWeight: FontWeight.bold),
        //                                 ),
        //                               ),
        //                               Padding(
        //                                 padding: const EdgeInsets.fromLTRB(
        //                                     0, 5, 0, 0),
        //                                 child: Text(
        //                                   patientHistoryController
        //                                           .listTopDoctor[0]
        //                                           .numberOfConsultants
        //                                           .toString() +
        //                                       " đánh giá",
        //                                   style: TextStyle(
        //                                       color: Colors.grey
        //                                           .withOpacity(0.75),
        //                                       fontSize: 16,
        //                                       fontWeight: FontWeight.w400),
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ),
        //               )
        //             : Container(),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Text(
        //             'Thống kê Covid-19',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: kTitleTextColor,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         Padding(
        //           padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
        //           child: Container(
        //             width: double.infinity,
        //             height: 60,
        //             padding: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(20),
        //               color: Color(0xfff6f6f6),
        //             ),
        //             child: Row(
        //               children: [
        //                 Expanded(
        //                   child: InkWell(
        //                     onTap: () => {
        //                       patientProfileController.statusCovid.value =
        //                           "VietNam",
        //                     },
        //                     child: Container(
        //                       width: 104,
        //                       height: double.infinity,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(20),
        //                         color: patientProfileController
        //                                     .statusCovid.value ==
        //                                 "VietNam"
        //                             ? kBlueColor
        //                             : Color(0xfff6f6f6),
        //                       ),
        //                       child: Center(
        //                           child: Text(
        //                         "Việt Nam",
        //                         style: TextStyle(
        //                           color: patientProfileController
        //                                       .statusCovid.value ==
        //                                   "VietNam"
        //                               ? Colors.white
        //                               : Colors.black,
        //                           fontSize: 18,
        //                         ),
        //                       )),
        //                     ),
        //                   ),
        //                 ),
        //                 Expanded(
        //                   child: InkWell(
        //                     onTap: () => {
        //                       patientProfileController.statusCovid.value =
        //                           "World"
        //                     },
        //                     child: Container(
        //                       width: 104,
        //                       height: double.infinity,
        //                       decoration: BoxDecoration(
        //                         borderRadius: BorderRadius.circular(20),
        //                         color: patientProfileController
        //                                     .statusCovid.value ==
        //                                 "World"
        //                             ? kBlueColor
        //                             : Color(0xfff6f6f6),
        //                       ),
        //                       child: Center(
        //                           child: Text(
        //                         "Thế giới",
        //                         style: TextStyle(
        //                           color: patientProfileController
        //                                       .statusCovid.value ==
        //                                   "World"
        //                               ? Colors.white
        //                               : Colors.black,
        //                           fontSize: 18,
        //                         ),
        //                       )),
        //                     ),
        //                   ),
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         statisticCovid != null ? syncData() : Container(),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         news(),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         listNews != null
        //             ? Column(
        //                 children: [
        //                   ...listNews!.take(5).map((e) => BuildNewsList(
        //                       title: e.title,
        //                       desc: e.description,
        //                       url: e.url,
        //                       urlImage: e.urlToImage))
        //                 ],
        //               )
        //             : Container(),
        //         SizedBox(
        //           height: 30,
        //         ),
        //         Padding(
        //           padding: EdgeInsets.symmetric(horizontal: 18),
        //           child: Text(
        //             'Bình luận phổ biến',
        //             style: TextStyle(
        //               fontWeight: FontWeight.bold,
        //               color: kTitleTextColor,
        //               fontSize: 18,
        //             ),
        //           ),
        //         ),
        //         SizedBox(
        //           height: 20,
        //         ),
        //         buildTopComment(),
        //         SizedBox(
        //           height: 30,
        //         ),
        //       ],
        //     ),
        //   ),
        // ),