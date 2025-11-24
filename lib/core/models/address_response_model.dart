

class AddressModel {
  bool? success;
  String? message;
  List<AddressData>? data;

  AddressModel({
    this.success,
    this.message,
    this.data,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<AddressData>.from(json["data"]!.map((x) => AddressData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class AddressData {
  int? id;
  int? zoneId;
  String? latitude;
  String? longitude;
  String? address;
  String? city;
  String? streetAddress;
  String? apartment;
  String? floor;
  String? deliveryInstruction;
  int? isDefault;
  Zone? zone;
  List<DeliveryOption>? deliveryOptions;

  AddressData({
    this.id,
    this.zoneId,
    this.latitude,
    this.longitude,
    this.address,
    this.city,
    this.streetAddress,
    this.apartment,
    this.floor,
    this.deliveryInstruction,
    this.isDefault,
    this.zone,
    this.deliveryOptions,
  });

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
    id: json["id"],
    zoneId: json["zone_id"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    address: json["address"],
    city: json["city"],
    streetAddress: json["street_address"],
    apartment: json["apartment"],
    floor: json["floor"],
    deliveryInstruction: json["delivery_instruction"],
    isDefault: json["is_default"],
    zone: json["zone"] == null ? null : Zone.fromJson(json["zone"]),
    deliveryOptions: json["delivery_options"] == null ? [] : List<DeliveryOption>.from(json["delivery_options"]!.map((x) => DeliveryOption.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "zone_id": zoneId,
    "latitude": latitude,
    "longitude": longitude,
    "address": address,
    "city": city,
    "street_address": streetAddress,
    "apartment": apartment,
    "floor": floor,
    "delivery_instruction": deliveryInstruction,
    "is_default": isDefault,
    "zone": zone?.toJson(),
    "delivery_options": deliveryOptions == null ? [] : List<dynamic>.from(deliveryOptions!.map((x) => x.toJson())),
  };
}

class DeliveryOption {
  String? name;
  String? type;
  int? charge;
  int? deliveryTimeHours;
  String? expectedDeliveryDate;

  DeliveryOption({
    this.name,
    this.type,
    this.charge,
    this.deliveryTimeHours,
    this.expectedDeliveryDate,
  });

  factory DeliveryOption.fromJson(Map<String, dynamic> json) => DeliveryOption(
    name: json["name"],
    type: json["type"],
    charge: json["charge"],
    deliveryTimeHours: json["delivery_time_hours"],
    expectedDeliveryDate: json["expected_delivery_date"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "type": type,
    "charge": charge,
    "delivery_time_hours": deliveryTimeHours,
    "expected_delivery_date": expectedDeliveryDate,
  };
}

class Zone {
  int? id;
  String? name;
  String? charge;
  int? allowsExpress;
  String? expressCharge;
  int? deliveryTimeHours;
  int? expressDeliveryTimeHours;
  int? status;
  String? statusString;

  Zone({
    this.id,
    this.name,
    this.charge,
    this.allowsExpress,
    this.expressCharge,
    this.deliveryTimeHours,
    this.expressDeliveryTimeHours,
    this.status,
    this.statusString,
  });

  factory Zone.fromJson(Map<String, dynamic> json) => Zone(
    id: json["id"],
    name: json["name"],
    charge: json["charge"],
    allowsExpress: json["allows_express"],
    expressCharge: json["express_charge"],
    deliveryTimeHours: json["delivery_time_hours"],
    expressDeliveryTimeHours: json["express_delivery_time_hours"],
    status: json["status"],
    statusString: json["status_string"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "charge": charge,
    "allows_express": allowsExpress,
    "express_charge": expressCharge,
    "delivery_time_hours": deliveryTimeHours,
    "express_delivery_time_hours": expressDeliveryTimeHours,
    "status": status,
    "status_string": statusString,
  };
}
