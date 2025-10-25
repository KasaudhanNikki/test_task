import 'package:flutter/foundation.dart';
import '../models/property.dart';
import '../services/api_service.dart';

class PropertyProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Property> _properties = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadProperties({String? businessUnitId}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _apiService.getBusinessUnitProperties(
      businessUnitId: businessUnitId,
    );

    _isLoading = false;
    if (response.success) {
      _properties = response.properties;
      _errorMessage = null;
    } else {
      _errorMessage = response.message ?? 'Failed to load properties';
      _properties = [];
    }
    notifyListeners();
  }
}

