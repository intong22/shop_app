import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final String title;
  final double price;
  final String img;
  final Color bgColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.img,
    required this.bgColor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.all(20),
      color: bgColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'Php ${price.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Center(
              child: Image.asset(
                img,
                height: 190,
              ),
            ),
          ],
        ),
      ),
    );
}
}