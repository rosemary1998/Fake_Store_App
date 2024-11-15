import '../models/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class FakeStoreApiService {
  static const String baseUrl = 'https://fakestoreapi.com/products';
  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      List data = json.decode(response.body);
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

 Future<void> deleteProduct(int id) async {
    final response = await http.delete(Uri.parse('${baseUrl}/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }

  Future<void> createProduct(Map<String, dynamic> productData) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      body: json.encode(productData),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.statusCode);
    print(response);
    if (response.statusCode != 200) {
      throw Exception('Failed to create product');


    }
  }
}
