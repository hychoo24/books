import 'package:flutter/material.dart';
import '../models/stat_model.dart';
import '../services/stat_service.dart';

class StatProvider with ChangeNotifier {
  StatsAll? _stats;
  bool _isLoading = false;
  String? _error;

  StatsAll? get stats => _stats;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchStats() async {
    _isLoading = true;
    notifyListeners();

    try {
      final result = await StatService.fetchStats();
      _stats = result;
      _error = null;
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }
}
