import 'package:flutter/foundation.dart';
import '../models/property_detail.dart';
import '../services/api_service.dart';

class PropertyDetailProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  PropertyDetail? _propertyDetail;
  bool _isLoading = false;
  String? _errorMessage;

  PropertyDetail? get propertyDetail => _propertyDetail;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadPropertyDetail(String villaId) async {
    if (villaId.isEmpty) {
      _errorMessage = 'Villa ID is required';
      _isLoading = false;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _apiService.getPropertyDetail(villaId);

    _isLoading = false;
    if (response.success) {
      _propertyDetail = response.propertyDetail;
      _errorMessage = null;
    } else {
      _errorMessage = response.message ?? 'Failed to load property details';
      _propertyDetail = null;
    }
    notifyListeners();
  }

  void clearPropertyDetail() {
    _propertyDetail = null;
    _errorMessage = null;
    notifyListeners();
  }
}
