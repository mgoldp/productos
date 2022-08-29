import 'package:flutter/material.dart';
import 'package:productos_app/models/models.dart';

class ProductService extends ChangeNotifier {
  final String _baseUrl = 'productos-4eac5-default-rtdb.firebaseio.com';
  final List<Product> products = [];

  // TODO: Hscer fetch de productos.
}
