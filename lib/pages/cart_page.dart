import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>().cart;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
        ),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index){
          final cartItem = cart[index];

          return 
          /* GestureDetector(
            onTap: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context){
                    return ProductDetailsPage(product: cartItem);
                  },
                ),
              );
            },
            child: */
          ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage(cartItem['imgUrl'] as String),
                radius: 25,
              ),
              title: Text(
                cartItem['name'].toString(),
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text('Size: ${cartItem['size']}'),
              trailing: IconButton(
                onPressed: (){
                  showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: Text(
                          'Delete Product',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        content: SizedBox(
                          height: 200,
                          child: Column(
                            children: [
                              Image.asset(
                                cartItem['imgUrl'],
                                height: 100,
                              ),
                              Text('Size ${cartItem['size']}'),
                              const SizedBox(height: 30,),
                              const Text(
                                'Are you sure you want to remove this item from your cart?',
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: (){
                              context.read<CartProvider>().removeProduct(cartItem);
                              Navigator.of(context).pop();
                            }, 
                            child: const Text(
                              'Yes',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  );
                }, 
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                )
              ),            
            );
          // );
        }
      ),
    );
  }
}