import 'package:telemedicine_mobile/models/CertificationDoctors.dart';
import 'package:telemedicine_mobile/models/HospitalDoctors.dart';
import 'package:telemedicine_mobile/models/MajorDoctors.dart';

class Survey {
  late int id;
  late int numberquestion;
  late String title;
  late String description;
  late bool status;

  Survey({
    required this.id,
    required this.numberquestion,
    required this.title,
    required this.description,
    required this.status,
  });

  Survey.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    numberquestion = json['numberquestion'];
    title = json['title'];
    description = json['description'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['numberquestion'] = this.numberquestion;
    data['title'] = this.title;
    data['description'] = this.description;
    data['status'] = this.status;
    return data;
  }
}
