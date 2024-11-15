import 'package:flutter/material.dart';

import '../models/product_model.dart';


class ProductFormDialog extends StatefulWidget {
  @override
  _ProductFormDialogState createState() => _ProductFormDialogState();
}

class _ProductFormDialogState extends State<ProductFormDialog> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _imageUrl = '';
  double _price = 0.0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Product'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Product Name'),
              validator: (value) => value == null || value.isEmpty ? 'Enter a name' : null,
              onSaved: (value) => _name = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Image URL'),
              validator: (value) => value == null || value.isEmpty ? 'Enter an image URL' : null,
              onSaved: (value) => _imageUrl = value!,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              validator: (value) => value == null || double.tryParse(value) == null ? 'Enter a valid price' : null,
              onSaved: (value) => _price = double.parse(value!),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: _submitForm,
          child: Text('Add'),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch, // Temporary ID
        name: _name,
        imageUrl: _imageUrl,
        price: _price,
      );

      Navigator.of(context).pop(newProduct);  // Return the new product
    }
  }
}
