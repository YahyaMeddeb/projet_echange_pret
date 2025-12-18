import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/item.dart';
import 'package:echange_pret_biens/views/add_item_page.dart';

class ItemController extends ChangeNotifier {
  final add_item_page _service = add_item_page();
  final List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      final uid = _uid;
      // إذا تريد فقط Items متاع المستخدم:
      final data = await _service.fetchItems(ownerId: uid);

      _items
        ..clear()
        ..addAll(data);
    } catch (e) {
      debugPrint('loadItems error: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addItemFromForm({
    required String title,
    required String description,
    required double pricePerDay,
  }) async {
    final uid = _uid;
    if (uid == null) {
      throw Exception('Utilisateur non connecté');
    }

    final item = Item(
      id: '', // Firestore va générer l'id
      ownerId: uid,
      title: title,
      description: description,
      pricePerDay: pricePerDay,
    );

    final newId = await _service.addItem(item);

    // Option 1: ajouter localement
    _items.insert(
      0,
      Item(
        id: newId,
        ownerId: uid,
        title: title,
        description: description,
        pricePerDay: pricePerDay,
      ),
    );
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    await _service.deleteItem(id);
    _items.removeWhere((x) => x.id == id);
    notifyListeners();
  }
}
