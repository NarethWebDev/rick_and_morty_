import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character_model.dart';

class FavoriteCharacters extends ChangeNotifier {
  static const _prefsKey = 'favorite_characters';

  final List<Character> _items = [];

  List<Character> get items => List.unmodifiable(_items);

  bool isFavorite(Character character) {
    return _items.any((c) => c.id == character.id);
  }

  FavoriteCharacters() {
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getString(_prefsKey);

      if (stored == null || stored.isEmpty) return;

      final jsonList = json.decode(stored) as List<dynamic>;
      _items
        ..clear()
        ..addAll(
          jsonList
              .map((e) => Character.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

      notifyListeners();
    } catch (e) {
      debugPrint('Error al cargar favoritos: $e');
    }
  }

  Future<void> _saveFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = _items.map((c) => c.toJson()).toList();
      await prefs.setString(_prefsKey, json.encode(jsonList));
    } catch (e) {
      debugPrint('Error al guardar favoritos: $e');
    }
  }

  Future<void> add(Character character) async {
    if (isFavorite(character)) return;
    _items.add(character);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> remove(Character character) async {
    _items.removeWhere((c) => c.id == character.id);
    await _saveFavorites();
    notifyListeners();
  }

  Future<void> toggle(Character character) async {
    if (isFavorite(character)) {
      await remove(character);
    } else {
      await add(character);
    }
  }
}
