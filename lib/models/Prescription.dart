import 'package:telemedicine_mobile/models/Drug.dart';
import 'package:telemedicine_mobile/models/DrugType.dart';

class Prescription {
  late int id;
  late int healthCheckId;
  late String startDate;
  late String endDate;
  late int drugId;
  late int morningQuantity;
  late int afternoonQuantity;
  late int eveningQuantity;
  late String description;
  late bool isActive;
  late Drug drug;

  Prescription(
      {required this.id,
      required this.healthCheckId,
      required this.startDate,
      required this.endDate,
      required this.drugId,
      required this.morningQuantity,
      required this.afternoonQuantity,
      required this.eveningQuantity,
      required this.description,
      required this.isActive,
      required this.drug});

  Prescription.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    healthCheckId = json['healthCheckId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    drugId = json['drugId'];
    morningQuantity = json['morningQuantity'];
    afternoonQuantity = json['afternoonQuantity'];
    eveningQuantity = json['eveningQuantity'];
    description = json['description'];
    isActive = json['isActive'];
    if (json['drug'] != null) {
      drug = new Drug.fromJson(json['drug']);
    } else {
      drug = new Drug(
          id: 0,
          name: "",
          producer: "",
          drugOrigin: "",
          drugForm: "",
          isActive: true,
          drugType:
              new DrugType(id: 0, name: "", description: "", isActive: true),
          drugTypeId: 0);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['healthCheckId'] = this.healthCheckId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['drugId'] = this.drugId;
    data['morningQuantity'] = this.morningQuantity;
    data['afternoonQuantity'] = this.afternoonQuantity;
    data['eveningQuantity'] = this.eveningQuantity;
    data['description'] = this.description;
    data['isActive'] = this.isActive;
    if (this.drug != null) {
      data['drug'] = this.drug.toJson();
    }
    return data;
  }
}
