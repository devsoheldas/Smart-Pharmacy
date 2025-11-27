import 'dart:convert';

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

class ProductDetails {
  final bool? success;
  final String? message;
  final ProductDetailsData? data;

  ProductDetails({this.success, this.message, this.data});

  factory ProductDetails.fromJson(Map<String, dynamic> json) => ProductDetails(
    success: json["success"],
    message: json["message"]?.toString(),
    data: json["data"] == null
        ? null
        : ProductDetailsData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
  };
}

class ProductDetailsData {
  final ProductDetailsInfo? productDetails;
  final List<SimilarProduct> similarProducts;

  ProductDetailsData({this.productDetails, this.similarProducts = const []});

  factory ProductDetailsData.fromJson(Map<String, dynamic> json) =>
      ProductDetailsData(
        productDetails: json["product_details"] == null
            ? null
            : ProductDetailsInfo.fromJson(json["product_details"]),
        similarProducts: json["similar_products"] == null
            ? []
            : List<SimilarProduct>.from(
                json["similar_products"].map((x) => SimilarProduct.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
    "product_details": productDetails?.toJson(),
    "similar_products": List<dynamic>.from(
      similarProducts.map((x) => x.toJson()),
    ),
  };
}

class ProductDetailsInfo {
  final int? id;
  final String? name;
  final String? slug;
  final int? proCatId;
  final int? companyId;
  final int? genericId;
  final int? strengthId;
  final int? doseId;
  final double? price;
  final String? description;
  final String? image;
  final bool? prescriptionRequired;
  final bool? kycRequired;
  final int? maxQuantity;
  final DateTime? createdAt;
  final int? status;
  final int? isBestSelling;
  final String? modifiedImage;
  final num? discountAmount;
  final num? discountPercentage;
  final double? discountedPrice;
  final String? attrTitle;
  final String? formattedName;
  final String? formattedSubCat;
  final bool? isTba;
  final bool? isOrderable;
  final Company? proCat;
  final Company? generic;
  final Company? company;
  final Company? strength;
  final Company? dosage;
  final List<Discount> discounts;
  final List<ProductDetailsUnit> units;

  ProductDetailsInfo({
    this.id,
    this.name,
    this.slug,
    this.proCatId,
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
    this.attrTitle,
    this.formattedName,
    this.formattedSubCat,
    this.isTba,
    this.isOrderable,
    this.proCat,
    this.generic,
    this.company,
    this.strength,
    this.dosage,
    this.discounts = const [],
    this.units = const [],
  });

  factory ProductDetailsInfo.fromJson(
    Map<String, dynamic> json,
  ) => ProductDetailsInfo(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    proCatId: json["pro_cat_id"],
    companyId: json["company_id"],
    genericId: json["generic_id"],
    strengthId: json["strength_id"],
    doseId: json["dose_id"],
    price: json["price"] == null
        ? null
        : double.tryParse(json["price"].toString()),
    description: json["description"],
    image: json["image"],
    prescriptionRequired: _parseBool(json["prescription_required"]),
    kycRequired: _parseBool(json["kyc_required"]),
    maxQuantity: json["max_quantity"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.tryParse(json["created_at"]),
    status: json["status"],
    isBestSelling: json["is_best_selling"],
    modifiedImage: json["modified_image"],
    discountAmount: json["discount_amount"],
    discountPercentage: json["discount_percentage"],
    discountedPrice: json["discounted_price"] == null
        ? null
        : double.tryParse(json["discounted_price"].toString()),
    attrTitle: json["attr_title"],
    formattedName: json["formatted_name"],
    formattedSubCat: json["formatted_sub_cat"],
    isTba: json["is_tba"],
    isOrderable: json["is_orderable"],
    proCat: json["pro_cat"] == null ? null : Company.fromJson(json["pro_cat"]),
    generic: json["generic"] == null ? null : Company.fromJson(json["generic"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    strength: json["strength"] == null
        ? null
        : Company.fromJson(json["strength"]),
    dosage: json["dosage"] == null ? null : Company.fromJson(json["dosage"]),
    discounts: json["discounts"] == null
        ? []
        : List<Discount>.from(
            json["discounts"].map((x) => Discount.fromJson(x)),
          ),
    units: json["units"] == null
        ? []
        : List<ProductDetailsUnit>.from(
            json["units"].map((x) => ProductDetailsUnit.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "pro_cat_id": proCatId,
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
    "attr_title": attrTitle,
    "formatted_name": formattedName,
    "formatted_sub_cat": formattedSubCat,
    "is_tba": isTba,
    "is_orderable": isOrderable,
    "pro_cat": proCat?.toJson(),
    "generic": generic?.toJson(),
    "company": company?.toJson(),
    "strength": strength?.toJson(),
    "dosage": dosage?.toJson(),
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
  };
}

class Company {
  final int? id;
  final String? name;
  final String? slug;
  final int? status;
  final String? formattedName;

  Company({this.id, this.name, this.slug, this.status, this.formattedName});

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

class Discount {
  final int? id;
  final int? proId;
  final int? unitId;
  final num? discountAmount;
  final num? discountPercentage;
  final int? status;

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

class ProductDetailsUnit {
  final int? id;
  final String? name;
  final String? quantity;
  final String? image;
  final int? status;
  final String? formattedName;
  final Pivot? pivot;

  ProductDetailsUnit({
    this.id,
    this.name,
    this.quantity,
    this.image,
    this.status,
    this.formattedName,
    this.pivot,
  });

  factory ProductDetailsUnit.fromJson(Map<String, dynamic> json) =>
      ProductDetailsUnit(
        id: json["id"],
        name: json["name"]?.toString(),
        quantity: json["quantity"]?.toString(),
        image: json["image"],
        status: json["status"],
        formattedName: json["formatted_name"]?.toString(),
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
  final int? medicineId;
  final int? unitId;
  final String? price;

  Pivot({this.medicineId, this.unitId, this.price});

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    medicineId: json["medicine_id"],
    unitId: json["unit_id"],
    price: json["price"]?.toString(),
  );

  Map<String, dynamic> toJson() => {
    "medicine_id": medicineId,
    "unit_id": unitId,
    "price": price,
  };
}

class SimilarProduct {
  final int? id;
  final String? name;
  final String? slug;
  final int? proCatId;
  final int? companyId;
  final int? genericId;
  final int? strengthId;
  final int? doseId;
  final double? price;
  final String? description;
  final String? image;
  final String? modifiedImage;
  final num? discountAmount;
  final num? discountPercentage;
  final double? discountedPrice;
  final Company? proCat;
  final Company? company;
  final Company? generic;
  final List<Discount> discounts;
  final List<SimilarProductUnit> units;

  SimilarProduct({
    this.id,
    this.name,
    this.slug,
    this.proCatId,
    this.companyId,
    this.genericId,
    this.strengthId,
    this.doseId,
    this.price,
    this.description,
    this.image,
    this.modifiedImage,
    this.discountAmount,
    this.discountPercentage,
    this.discountedPrice,
    this.proCat,
    this.company,
    this.generic,
    this.discounts = const [],
    this.units = const [],
  });

  factory SimilarProduct.fromJson(Map<String, dynamic> json) => SimilarProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    proCatId: json["pro_cat_id"],
    companyId: json["company_id"],
    genericId: json["generic_id"],
    strengthId: json["strength_id"],
    doseId: json["dose_id"],
    price: json["price"] == null
        ? null
        : double.tryParse(json["price"].toString()),
    description: json["description"],
    image: json["image"],
    modifiedImage: json["modified_image"],
    discountAmount: json["discount_amount"],
    discountPercentage: json["discount_percentage"],
    discountedPrice: json["discounted_price"] == null
        ? null
        : double.tryParse(json["discounted_price"].toString()),
    proCat: json["pro_cat"] == null ? null : Company.fromJson(json["pro_cat"]),
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    generic: json["generic"] == null ? null : Company.fromJson(json["generic"]),
    discounts: json["discounts"] == null
        ? []
        : List<Discount>.from(
            json["discounts"].map((x) => Discount.fromJson(x)),
          ),
    units: json["units"] == null
        ? []
        : List<SimilarProductUnit>.from(
            json["units"].map((x) => SimilarProductUnit.fromJson(x)),
          ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "pro_cat_id": proCatId,
    "company_id": companyId,
    "generic_id": genericId,
    "strength_id": strengthId,
    "dose_id": doseId,
    "price": price,
    "description": description,
    "image": image,
    "modified_image": modifiedImage,
    "discount_amount": discountAmount,
    "discount_percentage": discountPercentage,
    "discounted_price": discountedPrice,
    "pro_cat": proCat?.toJson(),
    "company": company?.toJson(),
    "generic": generic?.toJson(),
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
    "units": List<dynamic>.from(units.map((x) => x.toJson())),
  };
}

class SimilarProductUnit {
  final int? id;
  final String? name;
  final String? quantity;
  final String? image;
  final int? status;
  final String? formattedName;
  final Pivot? pivot;

  SimilarProductUnit({
    this.id,
    this.name,
    this.quantity,
    this.image,
    this.status,
    this.formattedName,
    this.pivot,
  });

  factory SimilarProductUnit.fromJson(Map<String, dynamic> json) =>
      SimilarProductUnit(
        id: json["id"],
        name: json["name"]?.toString(),
        quantity: json["quantity"]?.toString(),
        image: json["image"],
        status: json["status"],
        formattedName: json["formatted_name"]?.toString(),
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

bool? _parseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is num) return value != 0;
  if (value is String) {
    final lower = value.toLowerCase();
    if (lower == "true" || lower == "1") return true;
    if (lower == "false" || lower == "0") return false;
  }
  return null;
}
