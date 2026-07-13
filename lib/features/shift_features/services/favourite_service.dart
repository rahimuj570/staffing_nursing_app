import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:staffing/features/shift_features/models/shift_detail_response.dart';

class FavoriteShiftService {
  FavoriteShiftService._();

  static const String _key = "favorite_shifts";

  /// Get all favorite shifts
  static Future<List<ShiftDetailResponse>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_key) ?? [];

    return jsonList
        .map((e) => ShiftDetailResponse.fromJson(jsonDecode(e)))
        .toList();
  }

  /// Save shift
  static Future<void> addFavorite(ShiftDetailResponse shift) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(_key) ?? [];

    /// Prevent duplicate
    final alreadyExists = favorites.any((element) {
      final item = ShiftDetailResponse.fromJson(jsonDecode(element));

      return item.id == shift.id;
    });

    if (alreadyExists) return;

    favorites.add(jsonEncode(shift.toJson()));

    await prefs.setStringList(_key, favorites);
  }

  /// Remove shift
  static Future<void> removeFavorite(int shiftId) async {
    final prefs = await SharedPreferences.getInstance();

    final favorites = prefs.getStringList(_key) ?? [];

    favorites.removeWhere((element) {
      final item = ShiftDetailResponse.fromJson(jsonDecode(element));

      return item.id == shiftId;
    });

    await prefs.setStringList(_key, favorites);
  }

  /// Check favorite
  static Future<bool> isFavorite(int shiftId) async {
    final favorites = await getFavorites();

    return favorites.any((e) => e.id == shiftId);
  }

  /// Toggle favorite
  static Future<bool> toggleFavorite(ShiftDetailResponse shift) async {
    final id = shift.id!;

    final isFav = await isFavorite(id);

    if (isFav) {
      await removeFavorite(id);
      return false;
    } else {
      await addFavorite(shift);
      return true;
    }
  }
}
