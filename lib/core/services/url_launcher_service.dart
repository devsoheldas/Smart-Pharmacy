import 'dart:developer';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchExternalURL(String url) async {
    if (!await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
}

Future<void> makePhoneCall(String phoneNumber) async {
  try {
    // Clean phone number (remove spaces, dashes, etc.)
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: cleanNumber,
    );

    log('Attempting to call: $cleanNumber');

    // Check if the device can handle tel: URLs
    if (await canLaunchUrl(launchUri)) {
      final launched = await launchUrl(
        launchUri,
        mode: LaunchMode.externalApplication, // Force external app
      );

      if (!launched) {
        log('❌ Failed to launch phone dialer');
      } else {
        log('✅ Phone dialer opened successfully');
      }
    } else {
      log('❌ Device cannot handle tel: URLs');
    }
  } catch (e) {
    log('❌ Phone call error: $e');
  }
}


