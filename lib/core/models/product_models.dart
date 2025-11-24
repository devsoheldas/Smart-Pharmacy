import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  bool? success;
  dynamic message;
  List<Datum>? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  String? nextPageUrl;
  dynamic prevPageUrl;

  Product({
    this.success,
    this.message,
    this.data,
    this.currentPage,
    this.lastPage,
    this.perPage,
    this.total,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    currentPage: json["current_page"],
    lastPage: json["last_page"],
    perPage: json["per_page"],
    total: json["total"],
    nextPageUrl: json["next_page_url"],
    prevPageUrl: json["prev_page_url"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class Datum {
  int? id;
  String? name;
  String? slug;
  int? proCatId;
  dynamic proSubCatId;
  int? companyId;
  int? genericId;
  int? strengthId;
  int? doseId;
  double? price;
  String? description;
  String? image;
  dynamic prescriptionRequired;
  dynamic kycRequired;
  dynamic maxQuantity;
  DateTime? createdAt;
  int? status;
  int? isBestSelling;
  String? modifiedImage;
  int? discountAmount;
  int? discountPercentage;
  double? discountedPrice;
  String? strengthInfo;
  CompanyInfo? companyInfo;
  String? genericInfo;
  String? attrTitle;
  String? formattedName;
  String? formattedSubCat;
  bool? isTba;
  bool? isOrderable;
  Company? company;
  Company? generic;
  Company? proCat;
  dynamic proSubCat;
  List<Discount>? discounts;
  List<Unit>? units;
  Company? strength;
  Company? dosage;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.proCatId,
    this.proSubCatId,
    this.companyId,
    this.genericId,
    this.strengthId,
    this.doseId,
    this.price,
    this.description,
    this.image,
    this.prescriptionRequired,
    this.kycRequired,
    this.maxQuantity,
    this.createdAt,
    this.status,
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
    this.company,
    this.generic,
    this.proCat,
    this.proSubCat,
    this.discounts,
    this.units,
    this.strength,
    this.dosage,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    proCatId: json["pro_cat_id"],
    proSubCatId: json["pro_sub_cat_id"],
    companyId: json["company_id"],
    genericId: json["generic_id"],
    strengthId: json["strength_id"],
    doseId: json["dose_id"],
    price: json["price"]?.toDouble(),
    description: json["description"],
    image: json["image"],
    prescriptionRequired: json["prescription_required"],
    kycRequired: json["kyc_required"],
    maxQuantity: json["max_quantity"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    status: json["status"],
    isBestSelling: json["is_best_selling"],
    modifiedImage: json["modified_image"],
    discountAmount: json["discount_amount"],
    discountPercentage: json["discount_percentage"],
    discountedPrice: json["discounted_price"]?.toDouble(),
    strengthInfo: json["strength_info"],
    companyInfo: companyInfoValues.map[json["company_info"]]!,
    genericInfo: json["generic_info"],
    attrTitle: json["attr_title"],
    formattedName: json["formatted_name"],
    formattedSubCat: json["formatted_sub_cat"],
    isTba: json["is_tba"],
    isOrderable: json["is_orderable"],
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    generic: json["generic"] == null ? null : Company.fromJson(json["generic"]),
    proCat: json["pro_cat"] == null ? null : Company.fromJson(json["pro_cat"]),
    proSubCat: json["pro_sub_cat"],
    discounts: json["discounts"] == null ? [] : List<Discount>.from(json["discounts"]!.map((x) => Discount.fromJson(x))),
    units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
    strength: json["strength"] == null ? null : Company.fromJson(json["strength"]),
    dosage: json["dosage"] == null ? null : Company.fromJson(json["dosage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "pro_cat_id": proCatId,
    "pro_sub_cat_id": proSubCatId,
    "company_id": companyId,
    "generic_id": genericId,
    "strength_id": strengthId,
    "dose_id": doseId,
    "price": price,
    "description": description,
    "image": image,
    "prescription_required": prescriptionRequired,
    "kyc_required": kycRequired,
    "max_quantity": maxQuantity,
    "created_at": createdAt?.toIso8601String(),
    "status": status,
    "is_best_selling": isBestSelling,
    "modified_image": modifiedImage,
    "discount_amount": discountAmount,
    "discount_percentage": discountPercentage,
    "discounted_price": discountedPrice,
    "strength_info": strengthInfo,
    "company_info": companyInfoValues.reverse[companyInfo],
    "generic_info": genericInfo,
    "attr_title": attrTitle,
    "formatted_name": formattedName,
    "formatted_sub_cat": formattedSubCat,
    "is_tba": isTba,
    "is_orderable": isOrderable,
    "company": company?.toJson(),
    "generic": generic?.toJson(),
    "pro_cat": proCat?.toJson(),
    "pro_sub_cat": proSubCat,
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
    "strength": strength?.toJson(),
    "dosage": dosage?.toJson(),
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

enum CompanyInfo {
  ACTIVE_FINE_CHEMICAL,
  AD_DIN_PHARMACEUTICA,
  SOMATEC_PHARMACEUTIC
}

final companyInfoValues = EnumValues({
  "Active Fine Chemical..": CompanyInfo.ACTIVE_FINE_CHEMICAL,
  "Ad-din Pharmaceutica..": CompanyInfo.AD_DIN_PHARMACEUTICA,
  "Somatec Pharmaceutic..": CompanyInfo.SOMATEC_PHARMACEUTIC
});

class Discount {
  int? id;
  int? proId;
  dynamic unitId;
  dynamic discountAmount;
  dynamic discountPercentage;
  int? status;

  Discount({
    this.id,
    this.proId,
    this.unitId,
    this.discountAmount,
    this.discountPercentage,
    this.status,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    proId: json["pro_id"],
    unitId: json["unit_id"],
    discountAmount: json["discount_amount"],
    discountPercentage: json["discount_percentage"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pro_id": proId,
    "unit_id": unitId,
    "discount_amount": discountAmount,
    "discount_percentage": discountPercentage,
    "status": status,
  };
}

class Unit {
  int? id;
  String? name;
  String? quantity;
  String? image;
  int? status;
  String? formattedName;
  Pivot? pivot;

  Unit({
    this.id,
    this.name,
    this.quantity,
    this.image,
    this.status,
    this.formattedName,
    this.pivot,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    image: json["image"],
    status: json["status"],
    formattedName: json["formatted_name"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "image": image,
    "status": status,
    "formatted_name": formattedName,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? medicineId;
  int? unitId;
  String? price;

  Pivot({
    this.medicineId,
    this.unitId,
    this.price,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    medicineId: json["medicine_id"],
    unitId: json["unit_id"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "medicine_id": medicineId,
    "unit_id": unitId,
    "price": price,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
