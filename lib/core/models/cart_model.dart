class CartItem {
  final int productId;
  final String title;
  final String thumbnail;
  final double price;
  final double regularPrice;
  final double discountPercentage;
  int quantity;
  final String? productSlug;
  final int? unitId;
  final String? unitName;
  final int? cartItemId;
  final int? cartId; // Add this field

  CartItem({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.regularPrice,
    required this.discountPercentage,
    required this.quantity,
    this.productSlug,
    this.unitId,
    this.unitName,
    this.cartItemId,
    this.cartId, // Add to constructor
  });

  // Update fromMap method to include cartId
  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'] ?? 0,
      title: map['title'] ?? 'Unknown Product',
      thumbnail: map['thumbnail'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      regularPrice: (map['regularPrice'] ?? 0).toDouble(),
      discountPercentage: (map['discountPercentage'] ?? 0).toDouble(),
      quantity: map['quantity'] ?? 1,
      productSlug: map['productSlug'],
      unitId: map['unitId'],
      unitName: map['unitName'],
      cartItemId: map['cartItemId'],
      cartId: map['cartId'], // Add this
    );
  }

  // Update toMap method to include cartId
  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'regularPrice': regularPrice,
      'discountPercentage': discountPercentage,
      'quantity': quantity,
      'productSlug': productSlug,
      'unitId': unitId,
      'unitName': unitName,
      'cartItemId': cartItemId,
      'cartId': cartId, // Add this
    };
  }

  double get totalPrice => price * quantity;

  double get totalDiscount => (regularPrice - price) * quantity;

  CartItem copyWith({
    int? productId,
    String? title,
    String? thumbnail,
    double? price,
    double? regularPrice,
    double? discountPercentage,
    int? quantity,
    String? productSlug,
    int? unitId,
    String? unitName,
    int? cartItemId,
    int? cartId,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      title: title ?? this.title,
      thumbnail: thumbnail ?? this.thumbnail,
      price: price ?? this.price,
      regularPrice: regularPrice ?? this.regularPrice,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      quantity: quantity ?? this.quantity,
      productSlug: productSlug ?? this.productSlug,
      unitId: unitId ?? this.unitId,
      unitName: unitName ?? this.unitName,
      cartItemId: cartItemId ?? this.cartItemId,
      cartId: cartId ?? this.cartId,
    );
  }
}