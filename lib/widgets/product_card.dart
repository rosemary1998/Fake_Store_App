import 'package:flutter/material.dart';

import '../models/product_model.dart';


class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onDelete;

  ProductCard({required this.product, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(product.imageUrl,
          width: 300,
            height: 300,
          ),
          Text(product.name),
          Text('\$${product.price.toStringAsFixed(2)}'),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
