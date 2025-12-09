import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/item_controller.dart';
import '../../models/item.dart';

/// -------------------------
/// PAGE D'ACCUEIL (HomePage)
/// -------------------------
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // ✅ constructeur const

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<ItemController>();
    final items = controller.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes objets'),
      ),
      body: controller.isLoading
          ? const Center(child: CircularProgressIndicator())
          : items.isEmpty
              ? const Center(
                  child: Text('Aucun objet.\nAjoute un objet avec le +'),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.description),
                        trailing: Text('${item.pricePerDay} €/jour'),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const AddItemPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

/// -------------------------
/// PAGE D'AJOUT (AddItemPage)
/// -------------------------
class AddItemPage extends StatefulWidget {
  const AddItemPage({super.key});

  @override
  State<AddItemPage> createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = context.read<ItemController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Ajouter un objet')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Champ obligatoire' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                decoration:
                    const InputDecoration(labelText: 'Prix journalier (€)'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final price =
                        double.tryParse(_priceController.text.trim()) ?? 0;

                    final item = Item(
                      id: DateTime.now().millisecondsSinceEpoch.toString(),
                      ownerId: 'demo',
                      title: _titleController.text.trim(),
                      description: _descriptionController.text.trim(),
                      pricePerDay: price,
                    );

                    controller.addItem(item);
                    Navigator.of(context).pop();
                  },
                  child: const Text('Enregistrer'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
