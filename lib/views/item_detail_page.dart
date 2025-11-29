import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/item_controller.dart';

/// Vue détail très simple qui récupère l'objet via le Controller.
class ItemDetailPage extends StatelessWidget {
  final String itemId;
  const ItemDetailPage({super.key, required this.itemId});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ItemController>();
    final item = controller.items.firstWhere((i) => i.id == itemId);

    return Scaffold(
      appBar: AppBar(title: Text(item.title)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(item.description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 12),
            Text('Prix: ${item.pricePerDay} €/jour'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Ici tu pourras ouvrir un écran de réservation (autre View)
              },
              child: const Text('Réserver (à implémenter)'),
            ),
          ],
        ),
      ),
    );
  }
}
