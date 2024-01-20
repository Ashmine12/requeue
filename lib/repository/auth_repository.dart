import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requeue/constants/api_constant.dart';
import 'package:requeue/models/user_model.dart';

class AuthRepository {
  static Future<Map<String, dynamic>?> loginUser(String phoneNumber, String password) async {
    final url = Uri.parse(AppAPI.loginEndpoint);

    final requestBody = {
      "phone_number": phoneNumber,
      "password": password,
    };

    try {
      final response = await http.post(
        url,
        body: jsonEncode(requestBody),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('token') && responseData.containsKey('user')) {
          return responseData;
        } else {
          debugPrint('Login response is missing either token or user');
          return null;
        }
      } else {
        debugPrint('Login failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      debugPrint('Error during login: $error');
      return null;
    }
  }

  static Future<void> signUp({required UserModel userModel}) async {
    final url = Uri.parse(AppAPI.signUpEndpoint);

    try {
      final response = await http.post(
        url,
        body: jsonEncode(userModel.toJson()),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        debugPrint('Signup successful!');
      } else {
        debugPrint('Signup failed with status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
      }
    } catch (error) {
      debugPrint('Error during signup: $error');
    }
  }

  static Future<Map<String, dynamic>?> getUserProfile(
      String clientID, String userToken) async {
    final url = Uri.parse(
        '${AppAPI.baseUrl}/user/profiles/get-profiles?ClientID=$clientID&userid=$clientID');

    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'userToken': userToken,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      } else {
        debugPrint(
            'Get profile failed with status code: ${response.statusCode}');
        debugPrint('Response body: ${response.body}');
        return null;
      }
    } catch (error) {
      debugPrint('Error getting profile: $error');
      return null;
    }
  }
}
