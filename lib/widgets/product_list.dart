import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_app/global_variables.dart';
import 'package:shop_app/widgets/product_card.dart';
import 'package:shop_app/pages/product_details_page.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  final List<String> filters = const ['All', 'Adidas', 'Nike', 'Under Armour'];
  late String selectedFilter;

  @override
  void initState() {
    super.initState();
    selectedFilter = filters[0];
  }

  @override
  Widget build(BuildContext context) {
    // final deviceSize = MediaQuery.sizeOf(context);
    const searchBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Color.fromRGBO(225, 225, 225, 1),
      ),
      borderRadius: BorderRadius.horizontal(left: Radius.circular(50)),
    );
    
    return SafeArea(
        child: Column(
          children:[ 
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Shoes\nCollection',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Search',
                      border: searchBorder,
                      enabledBorder: searchBorder,
                      focusedBorder: searchBorder,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final filter = filters[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedFilter = filter;
                        });
                      },
                      child: Chip(
                        label: Text(filter),
                        labelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 15, 
                          horizontal: 20
                        ),
                        backgroundColor: selectedFilter == filter ? Theme.of(context).colorScheme.primary : const Color.fromRGBO(245, 247, 249, 1),
                      ),
                    ),
                  );
                },
              ),
            ),
            //uses LayoutBuilder for responsiveness
            //takes constraints imposed by parent widget
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints){
                  if(constraints.maxWidth > 1080){
                    return GridView.builder(
                      itemCount: products.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.75,
                      ),
                      itemBuilder: (context, index){
                        final product = products[index];
              
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return ProductDetailsPage(product: product);
                                }
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['name'] as String, 
                            price: product['price'] as double,
                            img: product['imgUrl'] as String,
                            bgColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      }
                    );
                  }
                  else{
                    return ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (context, index){
                        final product = products[index];
                        
                        return GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context){
                                  return ProductDetailsPage(product: product);
                                }
                              ),
                            );
                          },
                          child: ProductCard(
                            title: product['name'] as String, 
                            price: product['price'] as double,
                            img: product['imgUrl'] as String,
                            bgColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                          ),
                        );
                      },
                    );
                  }
                }            
              ),
            ),
            //uses media query for responsiveness
            //takes whole device size
            /*Expanded(
              child: deviceSize.width > 650 ? 
              GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index){
                  final product = products[index];

                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context){
                            return ProductDetailsPage(product: product);
                          }
                        ),
                      );
                    },
                    child: ProductCard(
                      title: product['name'] as String, 
                      price: product['price'] as double,
                      img: product['imgUrl'] as String,
                      bgColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                }
              )
              :
              ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index){
                  final product = products[index];
                  
                  return GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context){
                            return ProductDetailsPage(product: product);
                          }
                        ),
                      );
                    },
                    child: ProductCard(
                      title: product['name'] as String, 
                      price: product['price'] as double,
                      img: product['imgUrl'] as String,
                      bgColor: index.isEven ? const Color.fromRGBO(216, 240, 253, 1) : const Color.fromRGBO(245, 247, 249, 1),
                    ),
                  );
                },
              ),
            ), */
          ],
        ),
      );
  }
}