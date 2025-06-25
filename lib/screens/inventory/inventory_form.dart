import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/inventory_model.dart';
import '../../providers/category_provider.dart';
import '../../providers/inventory_provider.dart';

class InventoryForm extends StatefulWidget {
  final Inventory? inventory;

  const InventoryForm({super.key, this.inventory});

  @override
  State<InventoryForm> createState() => _InventoryFormState();
}

class _InventoryFormState extends State<InventoryForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _quantityController = TextEditingController();
  int? _selectedCategoryId;

  @override
  void initState() {
    super.initState();
    final inv = widget.inventory;
    if (inv != null) {
      _nameController.text = inv.name;
      _quantityController.text = inv.quantity.toString();
      _selectedCategoryId = inv.categoryId;
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate() && _selectedCategoryId != null) {
      final newItem = Inventory(
        id: widget.inventory?.id ?? 0,
        name: _nameController.text,
        quantity: int.tryParse(_quantityController.text) ?? 0,
        categoryId: _selectedCategoryId!, category: null,
      );

      final provider = Provider.of<InventoryProvider>(context, listen: false);
      if (widget.inventory == null) {
        provider.addInventory(newItem);
      } else {
        provider.updateInventory(newItem);
      }

      Navigator.pop(context);
    } else if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Category must be selected')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).categories;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.inventory == null ? 'Add Inventory' : 'Edit Inventory',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Item Name'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name must be fill' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Total Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Total Quantity must be fill';
                  if (int.tryParse(value) == null) return 'Total Quantity must be a number';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<int>(
                value: _selectedCategoryId,
                decoration: const InputDecoration(labelText: 'Category'),
                items: categories.map((cat) {
                  return DropdownMenuItem<int>(
                    value: cat.id,
                    child: Text(cat.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategoryId = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Choose only one category' : null,
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child:SizedBox(
                  width: 200,
                    child: ElevatedButton(
                    onPressed: _saveForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple, // Warna ungu
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), // kurangin dari default (20)
                      ),
                    ),
                    child: Text(widget.inventory == null ? 'Add Inventory' : 'Save Changes'),
                  )
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
}
