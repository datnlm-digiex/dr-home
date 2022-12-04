// To parse this JSON data, do
//
//     final hospital = hospitalFromJson(jsonString);

import 'dart:convert';

Hospital hospitalFromJson(String str) => Hospital.fromJson(json.decode(str));

String hospitalToJson(Hospital data) => json.encode(data.toJson());

class Hospital {
    Hospital({
        this.id,
        this.hospitalCode,
        this.name,
        this.address,
        this.description,
        this.phone,
        this.email,
        this.lat,
        this.long,
        this.isActive,
    });

    int? id;
    String? hospitalCode;
    String? name;
    String? address;
    String? description;
    String? phone;
    String? email;
    double? lat;
    double? long;
    bool? isActive;

    factory Hospital.fromJson(Map<String, dynamic> json) => Hospital(
        id: json["id"],
        hospitalCode: json["hospitalCode"],
        name: json["name"],
        address: json["address"],
        description: json["description"],
        phone: json["phone"],
        email: json["email"],
        lat: json["lat"].toDouble(),
        long: json["long"].toDouble(),
        isActive: json["isActive"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "hospitalCode": hospitalCode,
        "name": name,
        "address": address,
        "description": description,
        "phone": phone,
        "email": email,
        "lat": lat,
        "long": long,
        "isActive": isActive,
    };
}
