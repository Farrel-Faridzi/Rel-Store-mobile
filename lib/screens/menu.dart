import 'package:flutter/material.dart';
import 'package:relstore/screens/productlist_form.dart';
// <-- 1. TAMBAHKAN IMPOR INI
import 'package:relstore/widgets/left_drawer.dart'; 

class MyHomePage extends StatelessWidget {
    MyHomePage({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Rel Store',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),

        // <-- 2. TAMBAHKAN PROPERTI DRAWER DI SINI
        drawer: const LeftDrawer(),

        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // ... (sisa kode Anda tetap sama)
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Selamat datang di Rel Store',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
              GridView.count(
                primary: true,
                padding: const EdgeInsets.all(20),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                shrinkWrap: true,
                children: items.map((ItemHomepage item) {
                  return ItemCard(item);
                }).toList(),
              )
            ],
          ),
        ),
      );
    }

    final List<ItemHomepage> items = [
      ItemHomepage("All Products", Icons.storefront, Colors.blue),
      ItemHomepage("My Products", Icons.inventory, Colors.green),
      ItemHomepage("Create Product", Icons.add_circle, Colors.red),
    ];
}


class ItemHomepage {
  // ... (sisa kode ItemHomepage tetap sama)
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  // ... (sisa kode ItemCard tetap sama)
  final ItemHomepage item; 

  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          if (item.name != "Create Product") {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text("Kamu telah menekan tombol ${item.name}!"),
                ),
              );
          }

          if (item.name == "Create Product") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductFormPage()),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}