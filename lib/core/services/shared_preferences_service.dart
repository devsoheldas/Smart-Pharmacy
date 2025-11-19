import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static const String _cartKey = 'cart_items';

  // Save
  static Future<void> saveCartItems(List<Map<String, dynamic>> cartItems) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(cartItems);
    await prefs.setString(_cartKey, encodedData);
  }

  // Get
  static Future<List<Map<String, dynamic>>> getCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final String? cartData = prefs.getString(_cartKey);

    if (cartData != null) {
      final List<dynamic> decodedData = jsonDecode(cartData);
      return decodedData.map((item) => Map<String, dynamic>.from(item)).toList();
    }

    return [];
  }

  // Clear cart items
  static Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}