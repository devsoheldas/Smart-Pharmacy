class CartItem {
  final int productId;
  final String title;
  final String thumbnail;
  final double price;
  final double regularPrice;
  final double discountPercentage;
  int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.thumbnail,
    required this.price,
    required this.regularPrice,
    required this.discountPercentage,
    this.quantity = 1,
  });

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'title': title,
      'thumbnail': thumbnail,
      'price': price,
      'regularPrice': regularPrice,
      'discountPercentage': discountPercentage,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      productId: map['productId'],
      title: map['title'],
      thumbnail: map['thumbnail'],
      price: map['price'].toDouble(),
      regularPrice: map['regularPrice'].toDouble(),
      discountPercentage: map['discountPercentage'].toDouble(),
      quantity: map['quantity'],
    );
  }

  double get totalPrice => price * quantity;
  double get totalRegularPrice => regularPrice * quantity;
  double get totalDiscount => totalRegularPrice - totalPrice;
}