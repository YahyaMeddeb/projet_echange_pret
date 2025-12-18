import 'package:echange_pret_biens/views/add_item_page.dart';
import 'package:echange_pret_biens/views/item_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/item_controller.dart';
import '../items/add_item_page.dart';
import '../items/item_detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ItemController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        actions: [
          IconButton(
            onPressed: () => controller.loadItems(),
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const AddItemPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : controller.items.isEmpty
              ? const Center(child: Text('Aucun objet pour le moment'))
              : ListView.builder(
                  itemCount: controller.items.length,
                  itemBuilder: (context, index) {
                    final item = controller.items[index];
                    return ListTile(
                      title: Text(item.title),
                      subtitle: Text('${item.pricePerDay} €'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => ItemDetailPage(itemId: item.id),
                          ),
                        );
                      },
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () => controller.removeItem(item.id),
                      ),
                    );
                  },
                ),
    );
  }
}
