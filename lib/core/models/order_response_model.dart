

class OrderResponseModel {
  bool? success;
  String? message;
  Data? data;
  int? currentPage;
  int? lastPage;
  int? perPage;
  int? total;
  dynamic nextPageUrl;
  dynamic prevPageUrl;

  OrderResponseModel({
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

  factory OrderResponseModel.fromJson(Map<String, dynamic> json) => OrderResponseModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
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
    "data": data?.toJson(),
    "current_page": currentPage,
    "last_page": lastPage,
    "per_page": perPage,
    "total": total,
    "next_page_url": nextPageUrl,
    "prev_page_url": prevPageUrl,
  };
}

class Data {
  List<OrderData>? orders;

  Data({
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: json["orders"] == null ? [] : List<OrderData>.from(json["orders"]!.map((x) => OrderData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class OrderData {
  int? id;
  String? orderId;
  int? customerId;
  String? customerType;
  int? addressId;
  dynamic voucherId;
  String? subTotal;
  String? voucherDiscount;
  String? productDiscount;
  String? totalAmount;
  String? deliveryFee;
  String? deliveryType;
  int? status;
  String? statusString;
  Customer? customer;
  List<OrderProduct>? products;
  Address? address;
  dynamic voucher;
  List<Timeline>? timelines;
  List<Payment>? payments;

  OrderData({
    this.id,
    this.orderId,
    this.customerId,
    this.customerType,
    this.addressId,
    this.voucherId,
    this.subTotal,
    this.voucherDiscount,
    this.productDiscount,
    this.totalAmount,
    this.deliveryFee,
    this.deliveryType,
    this.status,
    this.statusString,
    this.customer,
    this.products,
    this.address,
    this.voucher,
    this.timelines,
    this.payments,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) => OrderData(
    id: json["id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    customerType: json["customer_type"],
    addressId: json["address_id"],
    voucherId: json["voucher_id"],
    subTotal: json["sub_total"],
    voucherDiscount: json["voucher_discount"],
    productDiscount: json["product_discount"],
    totalAmount: json["total_amount"],
    deliveryFee: json["delivery_fee"],
    deliveryType: json["delivery_type"],
    status: json["status"],
    statusString: json["status_string"],
    customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
    products: json["products"] == null ? [] : List<OrderProduct>.from(json["products"]!.map((x) => OrderProduct.fromJson(x))),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    voucher: json["voucher"],
    timelines: json["timelines"] == null ? [] : List<Timeline>.from(json["timelines"]!.map((x) => Timeline.fromJson(x))),
    payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "customer_id": customerId,
    "customer_type": customerType,
    "address_id": addressId,
    "voucher_id": voucherId,
    "sub_total": subTotal,
    "voucher_discount": voucherDiscount,
    "product_discount": productDiscount,
    "total_amount": totalAmount,
    "delivery_fee": deliveryFee,
    "delivery_type": deliveryType,
    "status": status,
    "status_string": statusString,
    "customer": customer?.toJson(),
    "products": products == null ? [] : List<dynamic>.from(products!.map((x) => x.toJson())),
    "address": address?.toJson(),
    "voucher": voucher,
    "timelines": timelines == null ? [] : List<dynamic>.from(timelines!.map((x) => x.toJson())),
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
  };
}

class Address {
  int? id;
  dynamic name;
  dynamic phone;
  String? city;
  String? streetAddress;
  String? latitude;
  String? longitude;
  String? apartment;
  String? floor;
  String? deliveryInstruction;
  String? address;

  Address({
    this.id,
    this.name,
    this.phone,
    this.city,
    this.streetAddress,
    this.latitude,
    this.longitude,
    this.apartment,
    this.floor,
    this.deliveryInstruction,
    this.address,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    city: json["city"],
    streetAddress: json["street_address"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    apartment: json["apartment"],
    floor: json["floor"],
    deliveryInstruction: json["delivery_instruction"],
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "city": city,
    "street_address": streetAddress,
    "latitude": latitude,
    "longitude": longitude,
    "apartment": apartment,
    "floor": floor,
    "delivery_instruction": deliveryInstruction,
    "address": address,
  };
}

class Customer {
  int? id;
  String? name;
  String? phone;

  Customer({
    this.id,
    this.name,
    this.phone,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
  };
}

class Payment {
  int? id;
  int? orderId;
  int? customerId;
  String? customerType;
  int? amount;
  int? status;
  String? paymentMethod;
  String? transactionId;
  dynamic createrId;
  dynamic createrType;
  String? statusString;

  Payment({
    this.id,
    this.orderId,
    this.customerId,
    this.customerType,
    this.amount,
    this.status,
    this.paymentMethod,
    this.transactionId,
    this.createrId,
    this.createrType,
    this.statusString,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    orderId: json["order_id"],
    customerId: json["customer_id"],
    customerType: json["customer_type"],
    amount: json["amount"],
    status: json["status"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    createrId: json["creater_id"],
    createrType: json["creater_type"],
    statusString: json["status_string"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "customer_id": customerId,
    "customer_type": customerType,
    "amount": amount,
    "status": status,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "creater_id": createrId,
    "creater_type": createrType,
    "status_string": statusString,
  };
}

class OrderProduct {
  int? id;
  String? name;
  String? slug;
  int? status;
  int? proCatId;
  dynamic proSubCatId;
  int? companyId;
  int? genericId;
  int? strengthId;
  int? doseId;
  num? price;
  String? image;
  String? modifiedImage;
  num? discountAmount;
  num? discountPercentage;
  num? discountedPrice;
  String? strengthInfo;
  String? companyInfo;
  String? genericInfo;
  String? attrTitle;
  String? formattedName;
  String? formattedSubCat;
  bool? isTba;
  bool? isOrderable;
  ProductPivot? pivot;
  Company? proCat;
  Company? generic;
  dynamic proSubCat;
  Company? company;
  List<Discount>? discounts;
  Strength? strength;
  List<Unit>? units;

  OrderProduct({
    this.id,
    this.name,
    this.slug,
    this.status,
    this.proCatId,
    this.proSubCatId,
    this.companyId,
    this.genericId,
    this.strengthId,
    this.doseId,
    this.price,
    this.image,
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
    this.pivot,
    this.proCat,
    this.generic,
    this.proSubCat,
    this.company,
    this.discounts,
    this.strength,
    this.units,
  });

  factory OrderProduct.fromJson(Map<String, dynamic> json) => OrderProduct(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    proCatId: json["pro_cat_id"],
    proSubCatId: json["pro_sub_cat_id"],
    companyId: json["company_id"],
    genericId: json["generic_id"],
    strengthId: json["strength_id"],
    doseId: json["dose_id"],
    price: json["price"] is num ? json["price"] : null,
    image: json["image"],
    modifiedImage: json["modified_image"],
    discountAmount: json["discount_amount"] is num ? json["discount_amount"] : null,
    discountPercentage: json["discount_percentage"] is num ? json["discount_percentage"] : null,
    discountedPrice: json["discounted_price"] is num ? json["discounted_price"] : null,
    strengthInfo: json["strength_info"],
    companyInfo: json["company_info"],
    genericInfo: json["generic_info"],
    attrTitle: json["attr_title"],
    formattedName: json["formatted_name"],
    formattedSubCat: json["formatted_sub_cat"],
    isTba: json["is_tba"],
    isOrderable: json["is_orderable"],
    pivot: json["pivot"] == null ? null : ProductPivot.fromJson(json["pivot"]),
    proCat: json["pro_cat"] == null ? null : Company.fromJson(json["pro_cat"]),
    generic: json["generic"] == null ? null : Company.fromJson(json["generic"]),
    proSubCat: json["pro_sub_cat"],
    company: json["company"] == null ? null : Company.fromJson(json["company"]),
    discounts: json["discounts"] == null ? [] : List<Discount>.from(json["discounts"]!.map((x) => Discount.fromJson(x))),
    strength: json["strength"] == null ? null : Strength.fromJson(json["strength"]),
    units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "status": status,
    "pro_cat_id": proCatId,
    "pro_sub_cat_id": proSubCatId,
    "company_id": companyId,
    "generic_id": genericId,
    "strength_id": strengthId,
    "dose_id": doseId,
    "price": price,
    "image": image,
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
    "pivot": pivot?.toJson(),
    "pro_cat": proCat?.toJson(),
    "generic": generic?.toJson(),
    "pro_sub_cat": proSubCat,
    "company": company?.toJson(),
    "discounts": discounts == null ? [] : List<dynamic>.from(discounts!.map((x) => x.toJson())),
    "strength": strength?.toJson(),
    "units": units == null ? [] : List<dynamic>.from(units!.map((x) => x.toJson())),
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

class Discount {
  int? id;
  int? proId;
  dynamic unitId;
  dynamic discountAmount;
  dynamic discountPercentage;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  int? updatedBy;
  dynamic deletedBy;

  Discount({
    this.id,
    this.proId,
    this.unitId,
    this.discountAmount,
    this.discountPercentage,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    proId: json["pro_id"],
    unitId: json["unit_id"],
    discountAmount: json["discount_amount"],
    discountPercentage: json["discount_percentage"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pro_id": proId,
    "unit_id": unitId,
    "discount_amount": discountAmount,
    "discount_percentage": discountPercentage,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}

class ProductPivot {
  int? orderId;
  int? productId;
  int? id;
  int? unitId;
  int? quantity;
  String? unitPrice;
  String? unitDiscount;
  String? totalPrice;
  int? status;
  dynamic expiryDate;
  String? unitName;
  String? unitImage;
  int? unitStatus;

  ProductPivot({
    this.orderId,
    this.productId,
    this.id,
    this.unitId,
    this.quantity,
    this.unitPrice,
    this.unitDiscount,
    this.totalPrice,
    this.status,
    this.expiryDate,
    this.unitName,
    this.unitImage,
    this.unitStatus,
  });

  factory ProductPivot.fromJson(Map<String, dynamic> json) => ProductPivot(
    orderId: json["order_id"],
    productId: json["product_id"],
    id: json["id"],
    unitId: json["unit_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"],
    unitDiscount: json["unit_discount"],
    totalPrice: json["total_price"],
    status: json["status"],
    expiryDate: json["expiry_date"],
    unitName: json["unit_name"],
    unitImage: json["unit_image"],
    unitStatus: json["unit_status"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "product_id": productId,
    "id": id,
    "unit_id": unitId,
    "quantity": quantity,
    "unit_price": unitPrice,
    "unit_discount": unitDiscount,
    "total_price": totalPrice,
    "status": status,
    "expiry_date": expiryDate,
    "unit_name": unitName,
    "unit_image": unitImage,
    "unit_status": unitStatus,
  };
}

class Strength {
  int? id;
  String? quantity;
  String? unit;
  int? status;
  String? createdAt;
  dynamic updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? name;
  String? formattedName;

  Strength({
    this.id,
    this.quantity,
    this.unit,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.name,
    this.formattedName,
  });

  factory Strength.fromJson(Map<String, dynamic> json) => Strength(
    id: json["id"],
    quantity: json["quantity"],
    unit: json["unit"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    name: json["name"],
    formattedName: json["formatted_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "quantity": quantity,
    "unit": unit,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "name": name,
    "formatted_name": formattedName,
  };
}

class Unit {
  int? id;
  String? name;
  String? quantity;
  dynamic type;
  String? image;
  int? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  int? updatedBy;
  dynamic deletedBy;
  String? formattedName;
  UnitPivot? pivot;

  Unit({
    this.id,
    this.name,
    this.quantity,
    this.type,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.formattedName,
    this.pivot,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
    quantity: json["quantity"],
    type: json["type"],
    image: json["image"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    formattedName: json["formatted_name"],
    pivot: json["pivot"] == null ? null : UnitPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "quantity": quantity,
    "type": type,
    "image": image,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "formatted_name": formattedName,
    "pivot": pivot?.toJson(),
  };
}

class UnitPivot {
  int? medicineId;
  int? unitId;
  String? price;

  UnitPivot({
    this.medicineId,
    this.unitId,
    this.price,
  });

  factory UnitPivot.fromJson(Map<String, dynamic> json) => UnitPivot(
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

class Timeline {
  int? id;
  int? orderId;
  int? status;
  dynamic expectedCompletionTime;
  String? actualCompletionTime;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;
  String? statusString;
  StatusRule? statusRule;

  Timeline({
    this.id,
    this.orderId,
    this.status,
    this.expectedCompletionTime,
    this.actualCompletionTime,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
    this.statusString,
    this.statusRule,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) => Timeline(
    id: json["id"],
    orderId: json["order_id"],
    status: json["status"],
    expectedCompletionTime: json["expected_completion_time"],
    actualCompletionTime: json["actual_completion_time"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
    statusString: json["status_string"],
    statusRule: json["status_rule"] == null ? null : StatusRule.fromJson(json["status_rule"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "status": status,
    "expected_completion_time": expectedCompletionTime,
    "actual_completion_time": actualCompletionTime,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
    "status_string": statusString,
    "status_rule": statusRule?.toJson(),
  };
}

class StatusRule {
  int? id;
  int? statusCode;
  String? statusName;
  dynamic expectedTimeInterval;
  dynamic expectedTimeUnit;
  int? visibleToUser;
  int? sortOrder;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  dynamic createdBy;
  dynamic updatedBy;
  dynamic deletedBy;

  StatusRule({
    this.id,
    this.statusCode,
    this.statusName,
    this.expectedTimeInterval,
    this.expectedTimeUnit,
    this.visibleToUser,
    this.sortOrder,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.deletedBy,
  });

  factory StatusRule.fromJson(Map<String, dynamic> json) => StatusRule(
    id: json["id"],
    statusCode: json["status_code"],
    statusName: json["status_name"],
    expectedTimeInterval: json["expected_time_interval"],
    expectedTimeUnit: json["expected_time_unit"],
    visibleToUser: json["visible_to_user"],
    sortOrder: json["sort_order"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    deletedBy: json["deleted_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status_code": statusCode,
    "status_name": statusName,
    "expected_time_interval": expectedTimeInterval,
    "expected_time_unit": expectedTimeUnit,
    "visible_to_user": visibleToUser,
    "sort_order": sortOrder,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "deleted_by": deletedBy,
  };
}
