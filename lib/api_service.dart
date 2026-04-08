import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 for Android Emulator to access localhost on the host machine.
  // Use localhost for Web, iOS Simulator, and Desktop.
  // Replace with your machine's IP address (e.g. 192.168.1.5) for real devices.
  static String get baseUrl {
    if (kIsWeb) {
      return "http://localhost/php_login_app";
    } else {
      // Use 10.0.2.2 for Android Emulator to access localhost on the host machine.
      // Use localhost for iOS Simulator or Desktop.
      // For real devices, replace with your machine's IP address (e.g., 192.168.1.5).
      bool isAndroid = defaultTargetPlatform == TargetPlatform.android;
      return isAndroid 
          ? "http://10.0.2.2/php_login_app" 
          : "http://localhost/php_login_app";
    }
  }

  static Future<Map<String, dynamic>> login(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api_login.php"),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        try {
          final body = json.decode(response.body);
          return {
            "status": "error",
            "message":
                body["message"] ?? "Server error: ${response.statusCode}",
          };
        } catch (_) {
          return {
            "status": "error",
            "message": "Server error: ${response.statusCode}",
          };
        }
      }
    } catch (e) {
      return {"status": "error", "message": "Connection failed: $e"};
    }
  }

  static Future<Map<String, dynamic>> register(
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api_register.php"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(userData),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        try {
          final body = json.decode(response.body);
          return {
            "status": "error",
            "message":
                body["message"] ?? "Server error: ${response.statusCode}",
          };
        } catch (_) {
          return {
            "status": "error",
            "message": "Server error: ${response.statusCode}",
          };
        }
      }
    } catch (e) {
      return {"status": "error", "message": "Connection failed: $e"};
    }
  }

  static Future<Map<String, dynamic>> submitAbstract(
    Map<String, dynamic> abstractData,
  ) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/api_submit_abstract.php"),
        headers: {"Content-Type": "application/json"},
        body: json.encode(abstractData),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        try {
          final body = json.decode(response.body);
          return {
            "status": "error",
            "message": body["message"] ?? "Server error: ${response.statusCode}",
          };
        } catch (_) {
          return {
            "status": "error",
            "message": "Server error: ${response.statusCode}",
          };
        }
      }
    } catch (e) {
      return {"status": "error", "message": "Connection failed: $e"};
    }
  }
}
