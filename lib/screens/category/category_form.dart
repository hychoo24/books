import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/category_model.dart';
import '../../providers/category_provider.dart';

class CategoryForm extends StatefulWidget {
  final Category? category;

  const CategoryForm({super.key, this.category});

  @override
  State<CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category?.name ?? '');
    _descController = TextEditingController(text: widget.category?.description ?? '');
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final category = Category(
        id: widget.category?.id ?? 0,
        name: _nameController.text,
        description: _descController.text,
      );

      final provider = Provider.of<CategoryProvider>(context, listen: false);
      if (widget.category != null) {
        await provider.updateCategory(category.id, category);
      } else {
        await provider.addCategory(category);
      }

        await provider.fetchCategories();
        if (!mounted) return;
        Navigator.pop(context, true);
        
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.category == null ? 'Add Category' : 'Edit Category',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Required field' : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple, // Warna ungu
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6), // kurangin dari default (20)
                  ),
                ),
                child: Text(widget.category != null ? 'Save Changes' : 'Add Category'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
