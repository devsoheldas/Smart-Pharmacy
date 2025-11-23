
class SingupResponseModel {
  bool? success;
  String? message;


  SingupResponseModel({
    this.success,
    this.message,

  });

  factory SingupResponseModel.fromJson(Map<String, dynamic> json) => SingupResponseModel(
    success: json["success"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "title": message,

  };
}


