import 'package:flutter/material.dart';
import 'package:swd_project/Nav_bar/check_out.dart';

import '../common_widget/color.dart';
import '../model/cartItem.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List<EventCartItem>> fetchCartItems() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? cartItemsJson = prefs.getStringList('cartItems');
  if (cartItemsJson != null) {
    List<EventCartItem> items = cartItemsJson
        .map((json) => EventCartItem.fromJson(jsonDecode(json)))
        .toList();
    return items;
  } else {
    return [];
  }
}

class CartScreen extends StatefulWidget {
  final List<EventCartItem> cartItems;
  CartScreen({required this.cartItems});
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<EventCartItem> cartItems = [];

  @override
  void initState() {
    super.initState();
    fetchCartItems().then((items) {
      setState(() {
        cartItems = items;
      });
    });
  }

  void increaseQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decreaseQuantity(int index) {
    if (cartItems[index].quantity > 1) {
      setState(() {
        cartItems[index].quantity--;
      });
    }
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainTheme,
        title: Text('Cart'),
      ),
      body: cartItems != null && cartItems.isNotEmpty
          ? ListView.builder(
              itemCount: cartItems.length * 2 - 1,
              itemBuilder: (context, index) {
                if (index.isOdd) {
                  return Divider(
                    color: Colors.grey,
                  );
                }

                final itemIndex = index ~/ 2;
                final item = cartItems[itemIndex];

                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(item.eventName),
                      Text(
                        '\$${item.eventPoint.toStringAsFixed(2)}',
                        style: TextStyle(color: Color(0xFF27AE60)),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          decreaseQuantity(itemIndex);
                        },
                      ),
                      Text(item.quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          increaseQuantity(itemIndex);
                        },
                      ),
                    ],
                  ),
                );
              },
            )
          : Center(
              child: Text('No items in the cart.'),
            ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: \$${calculateTotal().toStringAsFixed(2)}',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF27AE60)),
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromRGBO(183, 147, 219, 1),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          CheckoutScreen(total: calculateTotal()),
                    ),
                  );
                },
                child: Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double calculateTotal() {
    double total = 0;
    for (var item in cartItems) {
      total += item.eventPoint * item.quantity;
    }
    return total;
  }
}
