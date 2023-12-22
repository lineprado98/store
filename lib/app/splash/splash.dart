import 'package:flutter/material.dart';
import 'package:store/app/commons/services/database/i_database_service.dart';
import 'package:store/app/commons/utils/collections/i_collection.dart';

class Splash extends StatefulWidget {
  final IDatabaseService db;
  const Splash({super.key, required this.db});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Product product = Product(name: 'proo', price: 50.8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('MyApp'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            OutlinedButton(
                onPressed: () async {
                  await widget.db.create(collection: product);
                },
                child: const Text('new product ')),
            OutlinedButton(
                onPressed: () async {
                  await widget.db.getAll(collectionName: 'products', filters: [FilterParams(column: 'name', value: 'product24')]);
                  //      await widget.db.update(colletion: product2);
                },
                child: const Text('uodate product ')),
            OutlinedButton(
                onPressed: () async {
                  await widget.db.delete(collectionName: 'products', hashDoc: 'fr5HCozy7n327CZSSVmX');
                },
                child: const Text('delete product ')),
          ],
        ),
      ),
    );
  }
}

class Product implements ICollection {
  final String name;
  final double price;

  Product({required this.name, required this.price});

  @override
  Map<String, dynamic> toJson() {
    return {'name': name, 'price': price};
  }

  @override
  // TODO: implement collectionName
  String get collectionName => 'products';
}
