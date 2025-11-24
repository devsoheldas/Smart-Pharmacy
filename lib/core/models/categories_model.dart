// To parse this JSON data, do
//
//     final categories = categoriesFromJson(jsonString);

import 'dart:convert';

Categories categoriesFromJson(String str) => Categories.fromJson(json.decode(str));

String categoriesToJson(Categories data) => json.encode(data.toJson());

class Categories {
  bool? success;
  dynamic message;
  List<Datum>? data;

  Categories({
    this.success,
    this.message,
    this.data,
  });

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? slug;
  String? image;
  int? status;
  int? isFeatured;
  int? isMenu;
  String? formattedName;
  List<dynamic>? proSubCats;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.status,
    this.isFeatured,
    this.isMenu,
    this.formattedName,
    this.proSubCats,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    image: json["image"],
    status: json["status"],
    isFeatured: json["is_featured"],
    isMenu: json["is_menu"],
    formattedName: json["formatted_name"],
    proSubCats: json["pro_sub_cats"] == null ? [] : List<dynamic>.from(json["pro_sub_cats"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "image": image,
    "status": status,
    "is_featured": isFeatured,
    "is_menu": isMenu,
    "formatted_name": formattedName,
    "pro_sub_cats": proSubCats == null ? [] : List<dynamic>.from(proSubCats!.map((x) => x)),
  };
}
