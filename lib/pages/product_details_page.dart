import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String, Object> product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize = 0;

  void onTap() {
    if (selectedSize != 0) {
      context.read<CartProvider>().addProduct({
        'id': widget.product['id'],
        'name': widget.product['name'],
        'price': widget.product['price'],
        'size': selectedSize,
        'imgUrl': widget.product['imgUrl'],
        'company': widget.product['company'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product added successfully.'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a size.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Details')),
      ),
      body: Column(
        children: [
          Text(
            widget.product['name'] as String,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(
              widget.product['imgUrl'] as String,
              height: 250,
            ),
          ),
          const Spacer(flex: 2,),
          Container(
            height: 210,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40)
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Php ${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 10,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: (widget.product['sizes'] as List<int>).length,
                    itemBuilder: (context, index){
                      final sizes = (widget.product['sizes'] as List<int>)[index];
                  
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = sizes;
                            });
                          },
                          child: Chip(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            label: Text(sizes.toString()),
                            backgroundColor: selectedSize == sizes ? Theme.of(context).colorScheme.primary  : null,
                          ),
                        ),
                      );
                    }
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton.icon(
                    onPressed: (){
                      onTap();
                    }, 
                    icon: const Icon(Icons.shopping_cart),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.black,
                      // minimumSize: const Size(double.infinity, 50),
                      fixedSize: const Size(350, 50)
                    ),
                    label: const Text(
                      'Add to cart',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}