
class LogInResponseModel {
  bool? success;
  String? message;
  String? token;

  LogInResponseModel({
    this.success,
    this.message,
    this.token,
  });

  factory LogInResponseModel.fromJson(Map<String, dynamic> json) => LogInResponseModel(
    success: json["success"],
    message: json["message"],
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "title": message,
    "token": token,
  };
}


