import 'package:flutter/material.dart';
import 'package:productos_app/screens/loading.dart';
import 'package:productos_app/services/product_service.dart';
import 'package:productos_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsServices = Provider.of<ProductService>(context);

    if (productsServices.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Productos')),
      ),
      body: ListView.builder(
        itemCount: productsServices.products.length,
        itemBuilder: ((context, index) => GestureDetector(
              onTap: () => Navigator.pushNamed(context, 'product'),
              child: ProductCard(
                product: productsServices.products[index],
              ),
            )),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
