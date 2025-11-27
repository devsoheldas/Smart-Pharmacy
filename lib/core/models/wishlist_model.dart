

import 'dart:convert';

WishlistModel wishlistFromJson(String str) => WishlistModel.fromJson(json.decode(str));

String wishlistToJson(WishlistModel data) => json.encode(data.toJson());

class WishlistModel {
  bool? success;
  String? message;
  Data? data;

  WishlistModel({
    this.success,
    this.message,
    this.data,
  });

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  List<Wish>? wishes;

  Data({
    this.wishes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    wishes: json["wishes"] == null ? [] : List<Wish>.from(json["wishes"]!.map((x) => Wish.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "wishes": wishes == null ? [] : List<dynamic>.from(wishes!.map((x) => x.toJson())),
  };
}

class Wish {
  int? id;
  int? userId;
  int? productId;
  int? status;
  Product? product;

  Wish({
    this.id,
    this.userId,
    this.productId,
    this.status,
    this.product,
  });

  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
    id: json["id"],
    userId: json["user_id"],
    productId: json["product_id"],
    status: json["status"],
    product: json["product"] == null ? null : Product.fromJson(json["product"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "product_id": productId,
    "status": status,
    "product": product?.toJson(),
  };
}

class Product {
  int? id;
  String? name;
  String? image;
  String? slug;
  int? status;
  int? proCatId;
  dynamic proSubCatId;
  int? companyId;
  int? genericId;
  int? strengthId;
  int? doseId;
  double? price;
  dynamic description;
  dynamic prescriptionRequired;
  dynamic kycRequired;
  dynamic maxQuantity;
  DateTime? createdAt;
  int? isBestSelling;
  String? modifiedImage;
  double? discountAmount;
  double? discountPercentage;
  double? discountedPrice;
  String? strengthInfo;
  String? companyInfo;
  String? genericInfo;
  String? attrTitle;
  String? formattedName;
  String? formattedSubCat;
  bool? isTba;
  bool? isOrderable;
  Company? proCat;
  dynamic proSubCat;
  Company? generic;
  Company? company;
  Company? strength;
  List<dynamic>? discounts;
  Company? dosage;
  List<dynamic>? units;

  Product({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.status,
    this.proCatId,
    this.proSubCatId,
    this.companyId,
    this.genericId,
    this.strengthId,
    this.doseId,
    this.price,
    this.description,
    this.prescriptionRequired,
    this.kycRequired,
    this.maxQuantity,
    this.createdAt,
    this.isBestSelling,
    this.modifiedImage,
    this.discountAmount,
    this.discountPercentage,
    this.discountedPrice,
    this.strengthInfo,
    this.companyInfo,
    this.genericInfo,
    this.attrTitle,
    this.formattedName,
    this.formattedSubCat,
    this.isTba,
    this.isOrderable,
    this.proCat,
    this.proSubCat,
    this.generic,
    this.company,
    this.strength,
    this.discounts,
    this.dosage,
    this.units,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
    status: json["status"],
    proCatId: json["pro_cat_id"],
    proSubCatId: json["pro_sub_cat_id"],
    companyId: json["company_id"],
    genericId: json["generic_id"],
    strengthId: json["strength_id"],
    doseId: json["dose_id"],
    price: (json["price"] as num?)?.toDouble() ?? 0.0,
    description: json["description"],
    prescriptionRequired: json["prescription_required"],
    kycRequired: json["kyc_required"],
    maxQuantity: json["max_quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    isBestSelling: json["is_best_selling"],
    modifiedImage: json["modified_image"],
    discountAmount: (json["discount_amount"] as num?)?.toDouble() ?? 0.0,
    discountPercentage: (json["discount_percentage"] as num?)?.toDouble() ?? 0.0,
    discountedPrice: (json["discounted_price"] as num?)?.toDouble() ?? 0.0,
    strengthInfo: json["strength_info"],
    companyInfo: json["company_info"],
    genericInfo: json["generic_info"],
    attrTitle: json["attr_title"],
    formattedName: json["formatted_name"],
    formattedSubCat: json["formatted_sub_cat"],
    isTba: json["is_tba"],
    isOrderable: json["is_orderable"],
    proCat: json["pro_cat"] == null ? null : Company.fromJson(json["pro_cat"]),
    proSubCat: json["pro_sub_cat"],
    generic: json["generic"] == null ? null : Company.fromJson(json["generic"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    strength: json["strength"] == null ? null : Company.fromJson(json["strength"]),
    discounts: json["discounts"] == null ? [] : List<dynamic>.from(json["discounts"]!.map((x) => x)),
    dosage: json["dosage"] == null ? null : Company.fromJson(json["dosage"]),
    units: json["units"] == null ? [] : List<dynamic>.from(json["units"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "status": status,
    "pro_cat_id": proCatId,
    "pro_sub_cat_id": proSubCatId,
    "company_id": companyId,
    "generic_id": genericId,
    "strength_id": strengthId,
    "dose_id": doseId,
    "price": price,
    "description": description,
    "prescription_required": prescriptionRequired,
    "kyc_required": kycRequired,
    "max_quantity": maxQuantity,
    "created_at": createdAt?.toIso8601String(),
    "is_best_selling": isBestSelling,
    "modified_image": modifiedImage,
    "discount_amount": discountAmount,
    "discount_percentage": discountPercentage,
    "discounted_price": discountedPrice,
    "strength_info": strengthInfo,
    "company_info": companyInfo,
    "generic_info": genericInfo,
    "attr_title": attrTitle,
    "formatted_name": formattedName,
    "formatted_sub_cat": formattedSubCat,
    "is_tba": isTba,
    "is_orderable": isOrderable,
    "pro_cat": proCat?.toJson(),
    "pro_sub_cat": proSubCat,
    "generic": generic?.toJson(),
    "company": company?.toJson(),
    "strength": strength?.toJson(),
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x)),
    "dosage": dosage?.toJson(),
    "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x)),
  };
}

class Company {
  int? id;
  String? name;
  String? slug;
  int? status;
  String? formattedName;

  Company({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.formattedName,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    formattedName: json["formatted_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "status": status,
    "formatted_name": formattedName,
  };
}
