import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/constants.dart';
import '../utils/request_origin.dart';

class EmailService {
  static Future<bool> sendEmail({
    required String name,
    required String email,
    required String message,
  }) async {
    if (!AppConstants.isEmailJsConfigured) {
      return false;
    }

    try {
      final response = await http.post(
        Uri.parse(AppConstants.emailJsUrl),
        headers: {
          'Content-Type': 'application/json',
          'origin': requestOriginHeader(),
        },
        body: jsonEncode({
          'service_id': AppConstants.emailJsServiceId,
          'template_id': AppConstants.emailJsTemplateId,
          'user_id': AppConstants.emailJsPublicKey,
          'template_params': {
            'from_name': name,
            'from_email': email,
            'message': message,
            'to_email': AppConstants.email,
          },
        }),
      );

      return response.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
