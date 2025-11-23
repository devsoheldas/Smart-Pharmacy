
import 'dart:convert';

ProfileDetailsScreenModel profileDetailsScreenModelFromJson(String str) => ProfileDetailsScreenModel.fromJson(json.decode(str));

String profileDetailsScreenModelToJson(ProfileDetailsScreenModel data) => json.encode(data.toJson());

class ProfileDetailsScreenModel {
  bool? success;
  String? message;
  ProfileDetailsData? data;

  ProfileDetailsScreenModel({
    this.success,
    this.message,
    this.data,
  });

  factory ProfileDetailsScreenModel.fromJson(Map<String, dynamic> json) => ProfileDetailsScreenModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : ProfileDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProfileDetailsData {
  int? id;
  String? name;
  String? email;
  String? phone;
  dynamic image;
  String? bio;
  int? status;
  String? kycStatus;
  String? age;
  DateTime? dob;
  int? gender;
  int? isVerify;

  ProfileDetailsData({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.image,
    this.bio,
    this.status,
    this.kycStatus,
    this.age,
    this.dob,
    this.gender,
    this.isVerify,
  });

  factory ProfileDetailsData.fromJson(Map<String, dynamic> json) => ProfileDetailsData(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    image: json["image"],
    bio: json["bio"],
    status: json["status"],
    kycStatus: json["kyc_status"],
    age: json["age"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    gender: json["gender"],
    isVerify: json["is_verify"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "image": image,
    "bio": bio,
    "status": status,
    "kyc_status": kycStatus,
    "age": age,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "is_verify": isVerify,
  };
}
