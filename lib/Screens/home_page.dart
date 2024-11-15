import 'package:fakestoreapi/Screens/product_form.dart';
import 'package:fakestoreapi/Screens/product_view_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product_model.dart';
import '../provider/product_provider.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Fake Store'),
      ),
      body: productProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: productProvider.fetchProducts,
              child: Padding(
                padding: const EdgeInsets.all(100.0),
                child: GridView.builder(
                  itemCount: productProvider.products.length,
                  itemBuilder: (context, index) {
                    final product = productProvider.products[index];
                    return Container(

                        child: ProductCard(
                          product: product,
                          onDelete: () =>
                              productProvider.deleteProduct(product.id),
                        ),

                    );
                  },
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProduct = await showDialog<Product>(
            context: context,
            builder: (context) => ProductFormDialog(),
          );

          if (newProduct != null) {
            productProvider.addProduct(newProduct);
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add Product',
        //onPressed: () {  },
      ),
    );
  }
}
