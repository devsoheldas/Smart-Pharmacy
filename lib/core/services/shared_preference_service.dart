import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  // Keys for SharedPreferences
  static const _keyToken = 'token';
  static const _keyUserData = 'user_data';
  static const _keySalonData = 'salon_data';
  static const _keyDeliveryManData = 'delivery_man_data';
  static const _keyCart = 'cart';
  static const _keyFcmToken = 'fcm_token';
  static const _keyIsFirstRun = 'is_first_run';

  // Save Token with null safety
  static Future<bool> saveToken(String? token) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (token != null) {
        await prefs.setString(_keyToken, token);
        return true;
      } else {
        await prefs.remove(_keyToken);
        return false;
      }
    } catch (e) {
      log('Error saving token: $e');
      return false;
    }
  }

  // Get Token with null safety
  static Future<String?> getToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_keyToken);
    } catch (e) {
      log('Error getting token: $e');
      return null;
    }
  }

  // Check if token exists
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  // Clear token (for logout)
  static Future<bool> clearToken() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyToken);
      return true;
    } catch (e) {
      log('Error clearing token: $e');
      return false;
    }
  }

  // // Save User Data as JSON
  // static Future<bool> saveUserData(User? user) async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     if (user != null) {
  //       final userJson = jsonEncode(user.toJson());
  //       await prefs.setString(_keyUserData, userJson);
  //       return true;
  //     } else {
  //       await prefs.remove(_keyUserData);
  //       return false;
  //     }
  //   } catch (e) {
  //     log('Error saving user data: $e');
  //     return false;
  //   }
  // }
  //
  // // Get User Data
  // static Future<User?> getUserData() async {
  //   try {
  //     final SharedPreferences prefs = await SharedPreferences.getInstance();
  //     final userJson = prefs.getString(_keyUserData);
  //     if (userJson != null) {
  //       return User.fromJson(jsonDecode(userJson));
  //     }
  //     return null;
  //   } catch (e) {
  //     log('Error getting user data: $e');
  //     return null;
  //   }
  // }
  //

  // Clear all auth related data
  static Future<bool> clearAuthData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Clear specific keys
      await Future.wait([
        prefs.remove(_keyToken),
        prefs.remove(_keyUserData),
        prefs.remove(_keyDeliveryManData),
        prefs.remove(_keyCart),
        prefs.remove(_keyFcmToken),
        // Add any other keys that need to be cleared
      ]);
      return true;
    } catch (e) {
      log('Error clearing auth data: $e');
      return false;
    }
  }

  // Utility methods to get specific user information
  // static Future<int?> getUserId() async {
  //   final user = await getUserData();
  //   return user?.id;
  // }
  //
  // static Future<String?> getUserName() async {
  //   final user = await getUserData();
  //   return user?.name;
  // }
  //
  // static Future<String?> getUserEmail() async {
  //   final user = await getUserData();
  //   return user?.email;
  // }
  //
  // static Future<String?> getUserPhone() async {
  //   final user = await getUserData();
  //   return user?.mobile;
  // }

  static Future<void> saveFcmToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFcmToken, token);
  }

  static Future<String?> getSavedFcmToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFcmToken);
  }

  static Future<bool> isFirstRun() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFirstRun) ?? true;
  }

  static Future<void> markFirstRunComplete() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsFirstRun, false);
  }

}
