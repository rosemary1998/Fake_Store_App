import 'package:flutter/material.dart';

import '../models/product_model.dart';
import '../services/fakestoreapi_services.dart';


class ProductProvider with ChangeNotifier {
  final FakeStoreApiService _apiService = FakeStoreApiService();
  List<Product> _products = [];
  bool _isLoading = false;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _products = await _apiService.fetchProducts();
    } catch (e) {
      // Handle error as needed
      print('Failed to fetch products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }



  Future<void> deleteProduct(int productId) async {
    try {
      await _apiService.deleteProduct(productId);
      _products.removeWhere((product) => product.id == productId);
      notifyListeners();
    } catch (e) {
      print('Failed to delete product: $e');
    }
  }

  Future<void> addProduct(Product newProduct) async {
    try {
      await _apiService.createProduct({
        'title': newProduct.name,
        'price': newProduct.price,
        'image': newProduct.imageUrl,
      });
      _products.add(newProduct);
      notifyListeners();
    } catch (e) {
      print('Failed to add product: $e');
    }
  }
}
