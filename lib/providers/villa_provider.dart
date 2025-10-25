import 'package:flutter/foundation.dart';
import '../models/villa.dart';
import '../services/api_service.dart';

class VillaProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Villa> _villas = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Villa> get villas => _villas;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadVillas() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    final response = await _apiService.getClaimedVillas();

    _isLoading = false;
    if (response.success && response.data != null) {
      _villas = response.data!.villa ?? [];
      _errorMessage = null;
    } else {
      _errorMessage = response.message ?? response.error ?? 'Failed to load villas';
      _villas = [];
    }
    notifyListeners();
  }
}

