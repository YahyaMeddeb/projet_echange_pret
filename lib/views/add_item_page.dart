import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/item_controller.dart';
import '../../models/item.dart';

/// Vue pour ajouter un objet : elle utilise les Widgets (formulaire)
/// et appelle le Controller pour la logique.
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
