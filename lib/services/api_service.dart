import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/villa.dart';
import '../models/property.dart';
import '../models/property_detail.dart';
import 'auth_service.dart';
import 'location_service.dart';

class ApiService {
  static const String baseUrl = 'https://dev-villamanager.skills201.com/VM/mobile-api';
  static final AuthService _authService = AuthService();
  static final LocationService _locationService = LocationService();


  static Future<Map<String, String>> _getHeaders({Map<String, String>? extraHeaders}) async {
    final headers = <String, String>{
      'Content-Type': 'application/json',
    };

    final token = await _authService.getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    if (extraHeaders != null) {
      headers.addAll(extraHeaders);
    }

    return headers;
  }

  static Future<Map<String, dynamic>> _postApi({
    required String url,
    required Map<String, dynamic> body,
    Map<String, String>? headers,
  }) async {
    final finalHeaders = await _getHeaders(extraHeaders: headers);
    
    debugPrint('POST Request: $url');
    debugPrint('Body: $body');
    debugPrint('Headers: $finalHeaders');

    final response = await http.post(
      Uri.parse(url),
      headers: finalHeaders,
      body: jsonEncode(body),
    );

    debugPrint('Response Status: ${response.statusCode}');
    debugPrint('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 401) {
      await _authService.logout();
      throw Exception('Session expired. Please login again.');
    } else {
      final errorData = jsonDecode(response.body);
      throw Exception(errorData['message'] ?? errorData['error'] ?? 'Request failed');
    }
  }

  Future<LoginModel> login(String username, String password) async {
    try {
      final response = await _postApi(
        url: '$baseUrl/login.json',
        body: {
          'username': username,
          'password': password,
        },
      );

      return LoginModel.fromJson(response);
    } catch (e) {
      return LoginModel(
        status: 'error',
        message: e.toString(),
      );
    }
  }

  Future<ClaimedVillaModel> getClaimedVillas() async {
    try {
      final position = await _locationService.getCurrentLocation() ??
          await _locationService.getDefaultLocation();

      if (position == null) {
        return ClaimedVillaModel(
          status: 'error',
          message: 'Unable to get location',
        );
      }

      final response = await _postApi(
        url: '$baseUrl/getClaimedVilla.json',
        body: {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      );

      return ClaimedVillaModel.fromJson(response);
    } catch (e) {
      return ClaimedVillaModel(
        status: 'error',
        message: e.toString(),
      );
    }
  }

  Future<BusinessUnitPropertiesResponse> getBusinessUnitProperties({
    String? businessUnitId,
  }) async {
    try {
      final position = await _locationService.getCurrentLocation() ??
          await _locationService.getDefaultLocation();

      if (position == null) {
        return BusinessUnitPropertiesResponse(
          success: false,
          message: 'Unable to get location',
          properties: [],
        );
      }

      final response = await _postApi(
        url: '$baseUrl/getBuPropertyNew.json',
        body: {
          'latitude': position.latitude,
          'longitude': position.longitude,
          'business_unit_id': businessUnitId != null && businessUnitId.isNotEmpty 
              ? int.tryParse(businessUnitId) ?? 0 
              : 0,
        },
      );

      return BusinessUnitPropertiesResponse.fromJson(response);
    } catch (e) {
      return BusinessUnitPropertiesResponse(
        success: false,
        message: e.toString(),
        properties: [],
      );
    }
  }

  Future<PropertyDetailResponse> getPropertyDetail(String villaId) async {
    try {
      final response = await _postApi(
        url: '$baseUrl/getPropertyDetail.json',
        body: {
          'villa_id': villaId,
        },
      );

      return PropertyDetailResponse.fromJson(response);
    } catch (e) {
      return PropertyDetailResponse(
        error: 'Error message here',
        message: 'Failed to load',
        status: 'error',
      );
    }
  }
}
