import 'package:flutter/material.dart';
import '../../core/models/cart_model.dart';
import '../../core/services/network/api_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final ApiService _api = ApiService();

  List<CartItem> items = [];
  bool isLoading = true;
  double delivery = 5.0;

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  Future<void> loadCart() async {
    setState(() => isLoading = true);

    final res = await _api.getCartProducts();

    if (res.success && res.data != null) {
      items = (res.data as List).map((e) {
        final p = e['product'];
        return CartItem(
          cartItemId: e['id'],
          productId: p['id'],
          title: p['name'],
          thumbnail: p['image'] ?? "",
          price: (p['discounted_price'] ?? p['price']).toDouble(),
          regularPrice: (p['price']).toDouble(),
          discountPercentage: (p['discount_percentage'] ?? 0).toDouble(),
          quantity: e['quantity'],
          unitName: e['unit']['name'],
        );
      }).toList();
    }

    setState(() => isLoading = false);
  }


  Future<void> updateQty(int index, int qty) async {
    if (qty <= 0) return removeItem(index);


    setState(() => items[index] = items[index].copyWith(quantity: qty));


    _api.updateCartItem(cartItemId: items[index].cartItemId!, quantity: qty);
  }

  Future<void> removeItem(int index) async {
    final id = items[index].cartItemId;

    setState(() => items.removeAt(index));

    if (id != null) _api.removeFromCart(cartItemId: id);
  }

  double get subtotal =>
      items.fold(0, (sum, e) => sum + e.price * e.quantity);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Cart"),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: BackButton(color: Color(0xff9775FA)),
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator(color: Color(0xff9775FA)))
          : items.isEmpty
          ? _empty()
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (_, i) => cartItem(items[i], i),
            ),
          ),
          summary(),
        ],
      ),
    );
  }

  Widget cartItem(CartItem item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.thumbnail,
              height: 75,
              width: 75,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(height: 75, width: 75, color: Colors.grey[300]),
            ),
          ),
          const SizedBox(width: 12),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    maxLines: 2, overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text('\$${item.price}',
                    style: const TextStyle(
                        fontSize: 18, color: Color(0xff9775FA))),
                if (item.unitName != null)
                  Text("Pack: ${item.unitName}",
                      style: TextStyle(color: Colors.grey[600])),
              ],
            ),
          ),

          // Qty Buttons
          Column(
            children: [
              Row(
                children: [
                  btn(Icons.remove, () => updateQty(index, item.quantity - 1)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text("${item.quantity}",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                  btn(Icons.add, () => updateQty(index, item.quantity + 1)),
                ],
              ),

              // Delete
              GestureDetector(
                onTap: () => removeItem(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Icon(Icons.delete, color: Colors.red[400], size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget btn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 26,
        width: 26,
        decoration: BoxDecoration(
          color: Color(0xff9775FA),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget summary() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          row("Subtotal", "\$${subtotal.toStringAsFixed(2)}"),
          row("Delivery", "\$${delivery.toStringAsFixed(2)}"),
          const Divider(),
          row("Total", "\$${(subtotal + delivery).toStringAsFixed(2)}",
              isBig: true),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xff9775FA),
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: () {},
            child: const Text("Checkout"),
          )
        ],
      ),
    );
  }

  Widget row(String t, String v, {bool isBig = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(v,
              style: TextStyle(
                  color: Color(0xff9775FA),
                  fontSize: isBig ? 20 : 16,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _empty() => const Center(
    child: Text("Your cart is empty",
        style: TextStyle(fontSize: 18, color: Colors.grey)),
  );
}
