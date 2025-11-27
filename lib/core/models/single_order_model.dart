
class SingleOrderModel {
  bool? success;
  String? message;
  Data? data;

  SingleOrderModel({
    this.success,
    this.message,
    this.data,
  });

  factory SingleOrderModel.fromJson(Map<String, dynamic> json) => SingleOrderModel(
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
  String? orderId;

  Data({
    this.orderId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}


class OrderConfirmResponse {
  final bool success;
  final String message;
  final OrderConfirmData? data;

  OrderConfirmResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory OrderConfirmResponse.fromJson(Map<String, dynamic> json) {
    return OrderConfirmResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? OrderConfirmData.fromJson(json['data']) : null,
    );
  }
}

class OrderConfirmData {
  final String transactionId;
  final String amount;
  final String paymentMethod;

  OrderConfirmData({
    required this.transactionId,
    required this.amount,
    required this.paymentMethod,
  });

  factory OrderConfirmData.fromJson(Map<String, dynamic> json) {
    return OrderConfirmData(
      transactionId: json['transaction_id'] ?? '',
      amount: json['amount'] ?? '0',
      paymentMethod: json['payment_method'] ?? '',
    );
  }
}