import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

void main() {
  runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ShoppingListPage(),
      )));
}

class ShoppingListPage extends StatefulWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  State<ShoppingListPage> createState() => _ShoppingListPage();
}

class _ShoppingListPage extends State<ShoppingListPage> {
  var _sum = 0;

  Widget _shoppingCartBadge(BuildContext context, int _sum) {
    return Badge(
      position: BadgePosition.topEnd(top: 0, end: 3),
      animationDuration: const Duration(milliseconds: 100),
      animationType: BadgeAnimationType.scale,
      badgeContent: Text(
        '$_sum'.toString(),
        style: const TextStyle(color: Colors.white),
      ),
      child: IconButton(
          icon: const Icon(Icons.shopping_cart, color: Colors.black),
          onPressed: () {}),
    );
  }

  List fruitsList = [
    "Apples",
    "Oranges",
    "Grapes",
    "Lemons",
    "Tangerines",
    "Bananas",
    "Apricots",
    "Kiwis",
    "Mangoes",
  ];

  List iconForFruit = [
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
    Icons.shopping_cart_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Shopping List ",
            style: TextStyle(fontSize: 24, color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          _shoppingCartBadge(context, 12),
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: fruitsList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSX1TBjw4vIYl9GD1OIUhc9GOFoSPptGM1Hbw&usqp=CAU'),
                    ),
                    title: Text(fruitsList[index],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 17,
                            color: Color.fromRGBO(35, 33, 34, 1))),
                    trailing: IconButton(
                      icon: Icon(
                        iconForFruit[index],
                        color: Colors.black,
                      ),
                      onPressed: () {},
                    ));
              })),
    );
  }
}
