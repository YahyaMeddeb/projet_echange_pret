import 'package:flutter/material.dart';
import '../models/item.dart';

/// C = Controller dans le pattern MVC
/// - gère la liste d'objets
/// - contient la logique (ajout, suppression, filtre...)
class ItemController extends ChangeNotifier {
  final List<Item> _items = [];
  bool _isLoading = false;

  List<Item> get items => List.unmodifiable(_items);
  bool get isLoading => _isLoading;

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    // Ici on simule une source de données (Firebase, API...)
    await Future.delayed(const Duration(milliseconds: 500));
    _items.clear();
    _items.addAll([
      Item(
        id: '1',
        ownerId: 'u1',
        title: 'Perceuse',
        description: 'Perceuse électrique 500W',
        pricePerDay: 10,
      ),
      Item(
        id: '2',
        ownerId: 'u2',
        title: 'Vélo',
        description: 'Vélo de route taille M',
        pricePerDay: 5,
      ),
    ]);

    _isLoading = false;
    notifyListeners();
  }

  void addItem(Item item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
}
