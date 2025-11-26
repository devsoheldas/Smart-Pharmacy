

class WishlistUpdateModel {
  bool? success;
  String? message;


  WishlistUpdateModel({
    this.success,
    this.message,

  });

  factory WishlistUpdateModel.fromJson(Map<String, dynamic> json) => WishlistUpdateModel(
    success: json["success"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,

  };
}
