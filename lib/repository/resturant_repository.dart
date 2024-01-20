import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:requeue/constants/api_constant.dart';

class RestaurantRepository {
  final String userToken;

  RestaurantRepository({required this.userToken});

  Future<List<RestaurantInfo>> fetchRestaurantData() async {


    final url = Uri.parse(
        '${AppAPI.restaurantEndpoint}?PickupAvailable=1&AreaName=Kuwait&page=1&page limit=10');
    try {
      final response = await http.get(
        url,
        headers: {'userToken': userToken},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        if (responseData.containsKey('data')) {
          final List<dynamic> restaurants = responseData['data'];

          return restaurants.map((restaurant) {
            return RestaurantInfo(
              name: restaurant['name_en'],
              logoUrl: "https://cdn.requeue.net/media/logos/${restaurant['logo']}",
            );
          }).toList();
        } else {
          debugPrint('Failed to fetch restaurant data. Missing "data" key.');
          return [];
        }
      } else {
        debugPrint(
            'Failed to fetch restaurant data. Status code: ${response.statusCode}');
        return [];
      }
    } catch (error) {
      debugPrint('Error during restaurant data fetch: $error');
      return [];
    }
  }
}

class RestaurantInfo {
  final String name;
  final String logoUrl;

  RestaurantInfo({required this.name, required this.logoUrl});
}
