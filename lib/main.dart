import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:flutter_bloc_app/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light(),
        home: const ShoppingListPage());
  }
}

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // wrap ListItemView by Bloc Provider
    return BlocProvider(
      create: (_) => ListItemBloc(),
      child: const ListItemView(),
    );
  }
}

class ListItemView extends StatelessWidget {
  const ListItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 154, 160, 1),
        title: const Text("Shopping list",
            style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'GloriaHallelujah-Regular')),
        centerTitle: true,
        actions: <Widget>[
          //wrap ui by BlocConsumer
          BlocConsumer<ListItemBloc, ListItemState>(
              listenWhen: (ListItemState previous, ListItemState current) {
            if (current.message == true) {
              return true;
            } else {
              return false;
            }
          }, listener: (context, ListItemState liststate) {
            final snackBar = SnackBar(
                backgroundColor: const Color.fromRGBO(255, 117, 58, 1),
                content: Text(liststate.snackBarMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 18, fontFamily: 'GloriaHallelujah-Regular')),
                duration: const Duration(milliseconds: 700));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, builder: (context, ListItemState liststate) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  onPressed: () {},
                  icon: shoppingCartBadge(context, liststate.itemCounter)),
            );
          }),
        ],
      ),
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 20),
              itemCount: fruitsList.length,
              itemBuilder: (BuildContext context, int index) {
                // wrap ui by BlocBuilder
                return BlocBuilder<ListItemBloc, ListItemState>(
                    builder: (context, ListItemState listState) {
                  return SizedBox(
                    height: 70,
                    child: ListTile(
                      leading: SizedBox(
                        height: 60,
                        width: 60,
                        child: Image.asset(
                          'assets/images/fruits.png',
                        ),
                      ),
                      title: Text(fruitsList[index],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontFamily: 'GloriaHallelujah-Regular',
                              fontSize: 20,
                              color: Color.fromRGBO(35, 33, 34, 1))),
                      trailing: GestureDetector(
                        child: Icon(
                          (listState.itemList)[index]
                              ? Icons.shopping_cart
                              : Icons.shopping_cart_outlined,
                          color: Colors.black,
                        ),
                        // send events for Bloc
                        onTap: () {
                          if ((listState.itemList)[index]) {
                            context
                                .read<ListItemBloc>()
                                .add(ListItemRemoved(count: index));
                          } else {
                            context
                                .read<ListItemBloc>()
                                .add(ListItemAdded(count: index));
                          }
                        },
                      ),
                    ),
                  );
                });
              })),
    );
  }
}

//list for shopping items
final List fruitsList = [
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

//bagge for count all items in busket
Widget shoppingCartBadge(BuildContext context, int _sum) {
  return Badge(
    badgeColor: const Color.fromRGBO(255, 117, 58, 1),
    position: BadgePosition.topEnd(top: -5, end: -6),
    animationDuration: const Duration(milliseconds: 100),
    animationType: BadgeAnimationType.scale,
    badgeContent: Text(
      '$_sum'.toString(),
      style: const TextStyle(color: Colors.white),
    ),
    child: IconButton(
        icon: const Icon(
          Icons.shopping_cart,
          color: Colors.black,
          size: 25,
        ),
        onPressed: () {}),
  );
}
