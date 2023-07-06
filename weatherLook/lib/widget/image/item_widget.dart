import 'package:flutter/material.dart';
import 'package:weather_summary/item_model.dart';

class ClothingItemsSection extends StatelessWidget {
  final List<ClothingItem> topsList;
  final List<ClothingItem> outersList;
  final List<ClothingItem> bottomList;
  final List<ClothingItem> otherList;

  const ClothingItemsSection({
    super.key,
    required this.topsList,
    required this.outersList,
    required this.bottomList,
    required this.otherList,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clothing Items',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          // Tops row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              for (final topItem in topsList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        topItem.url,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(topItem.itemName),
                    ],
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),

          // Outers and bottoms row
          Row(
            children: [
              for (final outerItem in outersList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        outerItem.url,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(outerItem.itemName),
                    ],
                  ),
                ),
              for (final bottomItem in bottomList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        bottomItem.url,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(bottomItem.itemName),
                    ],
                  ),
                ),
            ],
          ),

          const SizedBox(height: 16),

          // Accessories row
          Row(
            children: [
              for (final otherItem in otherList)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Image.network(
                        otherItem.url,
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Text(otherItem.itemName),
                    ],
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
